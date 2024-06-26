require "gtk3"
require "thread"
require_relative 'LCDController'
require_relative 'Rfid'
require 'json'
require 'net/http'

class MainWindow < Gtk::Window
    def initialize(lcd_controller)
        @lcd_controller = lcd_controller

        @window = Gtk::Window.new("course_manager.rb")
        @window.set_default_size(500, 200) # Configurar el tamaño de la ventana


        @thread = nil  # Inicializar el hilo como nulo al principio
        # Conectar la señal "destroy" para cerrar la aplicación cuando se cierra la ventana
        @window.signal_connect("destroy") do
            Gtk.main_quit
            @thread.kill if @thread #Detiene la ejecución del thread
            Gtk.main_quit
        end

        ventana_inicio # Crear el contenido de la ventana_inicio
    end

    def ventana_inicio
        @lcd_controller.escribir_en_lcd(" Please, login with your university card") # Mostrar el mensaje inicial en la LCD

        @window.children.each{|widget| @window.remove(widget)} #eliminar los widgets existentes

        # Crear un marco para enmarcar el mensaje
        @frame = Gtk::Frame.new
        @frame.set_border_width(10)
        @frame.override_background_color(:normal, Gdk::RGBA.new(0, 0, 1, 1)) # Color azul

        # Crear un contenedor Gtk::Box dentro del marco para organizar verticalmente
        box = Gtk::Box.new(:vertical, 5)
        @frame.add(box)

        # Mensaje antes de la autenticación
        @label = Gtk::Label.new("Please, login with your university card")
        @label.override_color(:normal, Gdk::RGBA.new(1, 1, 1, 1)) # Color blanco
        @label.set_halign(:center) # Centrar el texto horizontalmente en la etiqueta
        box.pack_start(@label, expand: true, fill: true, padding: 10)
        
        @window.add(@frame) # Agregar el marco a la ventana

        @window.show_all
        rfid #poner en marcha la lectura RFID
    end

    def rfid
        @rfid = Rfid.new
        iniciar_lectura_rfid # Iniciar lectura RFID
    end

    def iniciar_lectura_rfid
        # Crea un thread para leer el uid
        thread = Thread.new do
            @uid = @rfid.read_uid
            GLib::Idle.add do
                autenticacion(@uid)
                false # Para detener la repetición de la llamada a la función
            end
        end
    end

    def autenticacion(uid)

        uri = URI("http://172.20.10.10:9000/students?student_id=#{uid}")
        response = Net::HTTP.get(uri)
        datos = JSON.parse(response)
        student = datos["students"].first
# Tractament d'errors si es detecta un missatge d'error per part del servidor  o una query buida
        if (datos["error"] || (student== nil))
            @lcd_controller.escribir_en_lcd("Authentication error please try again.")
            @label.set_markup("Authentication error, please try again.")
            @frame.override_background_color(:normal, Gdk::RGBA.new(1, 0, 0, 1)) # Color rojo

            puts "Authentication error, please try again."
            @thread.kill if @thread
            rfid
        else
            @nombre = student["name"]
            ventana_query
            puts student["name"]
        end
    end

    def ventana_query
        iniciar_timeout # Empezar timeout
        ip = '172.20.10.10'
        @frame.destroy #eliminar los widgets existentes de la ventana anterior
    
        @lcd_controller.escribir_en_lcd_centrado("Welcome #{@nombre}") # Mostrar el mensaje en la LCD

        #crear estructura de la ventana
        @table = Gtk::Table.new(2,2,true)
        @table.set_column_spacing(300)
        @table.set_row_spacings(10)

        @nombre = Gtk::Label.new("Welcome #{@nombre}")

        # Crear el campo de entrada para el query
        @query_entry = Gtk::Entry.new
        @query_entry.set_placeholder_text("Ingrese query (timetables, tasks, marks)")

        # Crear el botón de logout
        @button = Gtk::Button.new(label: 'logout')
        @button.set_size_request(50, 50)
        @button.signal_connect('clicked') do
            ventana_inicio
            detener_timeout
        end

        #colocar los widgets en la tabla
        @table.attach(@nombre, 0,  1,  0,  1, Gtk::AttachOptions::SHRINK, Gtk::AttachOptions::SHRINK, 10 , 10)
        @table.attach(@button, 1,  2,  0,  1, Gtk::AttachOptions::SHRINK, Gtk::AttachOptions::SHRINK, 10, 10)
        @table.attach(@query_entry, 0,  2,  1,  2, Gtk::AttachOptions::FILL, Gtk::AttachOptions::EXPAND, 10, 10)
        
        # Manejar el evento 'activate' (presionar Enter)
        @query_entry.signal_connect("activate") do
            detener_timeout
            iniciar_timeout
            query = @query_entry.text.strip
            url = "http://%s:9000/" % ip + query
            mostrar_datos_json(url)
            @query_entry.text = "" # Limpiar el campo de entrada después de la consulta
        end
        @window.add(@table)
        @window.show_all    
    end

    def mostrar_datos_json(url)
        # Obtener los datos JSON desde la URL
        uri = URI(url)
	# Hacer peticion
        json_content = Net::HTTP.get(uri)
        # Parseamos el JSON, nos va a devolver el objeto con clave valor
datos = JSON.parse(json_content)
	# Tratado de errores
        if datos["error"]
            puts "Consulta no valida"
            return
        end
	# Cogemos de las claves de los datos el primer objeto, que acaba siendo el titulo del array
        titulo = datos.keys.first
	 # Miramos si la query veulve vacia
         if datos[titulo].empty?
            puts "Query vacia"
            return
        end

        headers = datos[titulo][0].keys # asigna headers a las claves del primer elemento de cada columna 
        headers.pop # Eliminar ultimo elemento del array ya que es students y no queremos mostrarlo por pantalla

        lista = datos[titulo] # Obtener la lista correspondiente según el título

        # Crear la ventana para mostrar los datos
        @tabla = Gtk::Window.new
        @tabla.set_title(titulo)
        @tabla.set_default_size(400, 300)

        # Crear un contenedor de tipo Grid
        grid = Gtk::Grid.new
        grid.set_row_spacing(5)
        grid.set_column_spacing(5)

        @tabla.add(grid)

        # Encabezados, cogiendo las claves del json
        headers.each_with_index do |encabezado, index|
            header_label = Gtk::Label.new(encabezado)
            header_label.override_background_color(:normal, Gdk::RGBA.new(0.95, 0.95, 0.5, 1.0)) # amarillo
            grid.attach(header_label, index, 0, 1, 1)
            header_label.hexpand = true 
        end

        # Acceder a los datos y mostrar información sobre cada uno
        lista.each_with_index do |item, row_index|
            item.each_with_index do |(key, value), column_index|

                next if column_index == item.size - 1

                tarea_label = Gtk::Label.new(value.to_s)
                grid.attach(tarea_label, column_index, row_index + 1, 1, 1)
                tarea_label.hexpand = true
                if row_index % 2 == 0
                    tarea_label.override_background_color(:normal, Gdk::RGBA.new(0.7, 0.7, 1.0, 1.0)) # Azul claro
                else
                    tarea_label.override_background_color(:normal, Gdk::RGBA.new(0.5, 0.5, 1.0, 1.0)) # Azul
                end
            end
        end
        @tabla.show_all # Mostrar todo
    end

    def iniciar_timeout
        @timeout_id = GLib::Timeout.add_seconds(15) do
            puts "Se han superado los 15 segundos."
            ventana_inicio # Llamar al método ventana_inicio si se supera el tiempo límite
            @tabla.hide
            false # para que el temporizador no se repita
        end
    end

    def detener_timeout
        GLib::Source.remove(@timeout_id) if @timeout_id
    end

end

lcd_controller = LCDController.new # Crear una instancia de LCDController

# Ejecutar la aplicación
MainWindow.new(lcd_controller)
Gtk.main
