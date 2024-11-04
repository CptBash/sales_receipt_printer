require_relative 'lib/receipt/receipt'

@items = []

loop do
  puts "Current items in cart:#{@items}"
  puts "Enter item (or type 'done' to finish):"
  input = gets.chomp
  @items << input
  break if input.downcase == 'done'
  @receipt = Receipt.create_receipt(@items)
end

puts @receipt