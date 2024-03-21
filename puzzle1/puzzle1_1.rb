require 'nfc'
require 'colorize'

class Rfid
	def read_uid
		# Create a new context
		ctx = NFC::Context.new

		# Open the first available USB device
		dev = ctx.open nil

		puts "Passa la teva targeta".green
		tag_info = nil
		# Imprimir la información de la tarjeta si se detecta
		loop do
  			tag_info = dev.select
 			break if tag_info != false 
		end
	return tag_info
	end
end

if __FILE__ == $0
	rf = Rfid.new
	uid = rf.read_uid
	puts "UID: #{uid}" unless uid.nil?
end
