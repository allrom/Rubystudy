# Lesson 2 / Items in cart
#
cart = {}

loop do
  puts "Enter item to buy:"
  item = gets.chomp

  break if item == "стоп"

  puts "Enter the price:"
  price = gets.to_i

  puts "Enter the quantity:"
  quantity = gets.to_f

  cart[item] = { price: price, quantity: quantity }
end

puts cart
puts ""

cart_total = 0

cart.each do |item, buy|
  item_total = buy[:price] * buy[:quantity]
  puts "For #{item}, total: #{item_total}"
  cart_total += item_total
end

puts "Cart, total: #{cart_total}"
