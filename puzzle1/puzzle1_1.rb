require 'nfc'
require 'colorize'

# Create a new context
ctx = NFC::Context.new

# Open the first available USB device
dev = ctx.open nil

puts "Passa la teva targeta".green

# Imprimir la información de la tarjeta si se detecta
loop do
  tag_info = dev.select
  puts "UID: #{tag_info}" unless tag_info == false
  break if tag_info != false 
end

