require "gtk3"
require_relative "../puzzle1/puzzle1_1.rb"

@cleared = true
window = Gtk::Window.new('RFID')
window.set_title 'RFID'
window.set_default_size 400, 200
window.set_border_width 10

vbox = Gtk::Box.new(:vertical, 10)
window.add(vbox)

label = Gtk::Label.new("Please login with your university card\n")
vbox.pack_start(label)

button = Gtk::Button.new(label: 'Clear')

vbox.pack_start(button)

rf = Rfid.new
def handle_rfid_read(rf,label)
      @uid = "arnau"
      Thread.new do 
      @uid = rf.read_uid
      GLib::Idle.add do
	change_label(label)
	GLib::Source::REMOVE	
	end    
    end
end

def clear_label(label)
    	label.set_text("Please login with your university card\n")
end

def change_label(label)
    		label.set_text("UID: #{@uid}")
end


handle_rfid_read(rf,label)
button.signal_connect 'clicked' do
	clear_label(label)
	if @uid != "arnau"
        	handle_rfid_read(rf,label) 
	end
end

window.show_all
Gtk.main

