# Lesson 1 / Triangle square
#
puts "Enter triangle base: "
base = gets.to_f

puts "Enter triangle height: "
height = gets.to_f

square = (base * height * 0.5).round(2)

puts "(Rounded) result: square is #{square} units"
