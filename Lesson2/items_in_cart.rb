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

  to_pay = { item_price: price }
  to_carry = { item_qty: quantity }

  cart[item] = to_pay.merge(to_carry)
end

puts cart
puts ""

cart_total = item_total = 0

cart.each do |item, buy|
  bvals = []

    buy.each_value do |bval|
    bvals << bval
    end

  price_t = bvals[0]
  quantity_t = bval[1]
  item_total = price_t * quantity_t
  puts "For #{item}, total: #{item_total}"
  cart_total += item_total
end

puts "Cart, total: #{cart_total}"
