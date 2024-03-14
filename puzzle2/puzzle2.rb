require "gtk3"
require_relative "../puzzle1/puzzle1_1.rb"

class ButtonWindow < Gtk::Window
  def initialize
    super
        set_title 'RFID'
        set_default_size 400,200
        set_border_width 10
        vbox = Gtk::Box.new(:vertical, 10)
        add(vbox)
        label = Gtk::Label.new("Please login with your university card\n")
        vbox.pack_start(label)
        button = Gtk::Button.new(label: 'Clear')
        vbox.pack_start(button)
end
end
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

#window.signal_connect("delete-event") { |_widget| Gtk.main_quit }
#window.show_all

GLib::Timeout.add_seconds(1) do
	check_rfid(rf,label)
end

Gtk.main
