require "gtk3"
require_relative "../puzzle1/puzzle1_1.rb"

# Creamos una ventana con el titulo RFID
window = Gtk::Window.new("RFID")
# Definimos la amplitud y longitud de la ventana
window.set_size_request(400, 400)
# Definimos la anchura de los bordes de la ventana
window.set_border_width(10)

# Creamos un nuevo Label 
label = Gtk::Label.new("Please login with your university card")
window.add(label)

rf = Rfid.new

def handle_rfid_read(rf,label)
	uid = rf.read_uid
	label.set_text("UID: #{uid}")
	Gtk.main_iteration while Gtk.events_pending?

end

def check_rfid(rf,label)
	handle_rfid_read(rf,label)
	return true
end

window.signal_connect("delete-event") { |_widget| Gtk.main_quit }
window.show_all

GLib::Timeout.add_seconds(1) do
	check_rfid(rf,label)
end

Gtk.main
