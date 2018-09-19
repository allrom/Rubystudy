# Lesson 2 / Items in cart
#
hash_cart = Hash.new

loop do
  puts "Enter item to buy:"
  item = gets.chomp
  break if item == "стоп"

  puts "Enter the price:"
  price = gets.chomp.to_i

  puts "Enter the quantity:"
  quantity = gets.chomp.to_f

  hash_cart[item] = {price => quantity}

end

puts hash_cart
puts ""

cart_total = item_total = 0

hash_cart.each do |item, price|
  item_quantity = 0
  price.each do |item_price, quantity|
    item_total = item_price * quantity
    puts "For #{item}, total: #{item_total}"
  end
  cart_total += item_total
end

puts "Cart, total: #{cart_total}"
