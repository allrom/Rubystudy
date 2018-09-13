# Lesson 1 / Triangle square
#
puts "Enter triangle base: "
base = gets

puts "Enter triangle height: "
height = gets

puts " (Rounded) result : square is #{(base.to_f * height.to_f * 0.5).round(2)} units"
