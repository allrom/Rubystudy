# Lesson 1 / Rectangular Triangle
#
puts "Enter triangle 1-st side (integer): "
a = gets.to_i
puts "Enter triangle 2-nd side (integer): "
b = gets.to_i
puts "Enter triangle 3-rd side (integer): "
c = gets.to_i

# compute squares
a_sqr = a**2
b_sqr = b**2
c_sqr = c**2
#  arrangement
sides_sqr = [a_sqr, b_sqr, c_sqr].sort!

case a == b && a == c
when true
  puts "Triangle has equal sides and is not rectangular"
when false
  if sides_sqr[2] == (sides_sqr[0] + sides_sqr[1])
    puts "Triangle is rectangular"
  end
  if sides_sqr[0] == sides_sqr[1]
    puts "Triangle is isosceles"
  else
    puts "Triangle sides aren't equal"
  end
end