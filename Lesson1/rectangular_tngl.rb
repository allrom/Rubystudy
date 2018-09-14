# Lesson 1 / Rectangular Triangle
#
puts "Enter triangle 1-st side (integer): "
a = gets.to_f
puts "Enter triangle 2-nd side (integer): "
b = gets.to_f
puts "Enter triangle 3-rd side (integer): "
c = gets.to_f

# compute squares
a_sqr = a**2
b_sqr = b**2
c_sqr = c**2
#  arrangement
sides_sqr = [a_sqr, b_sqr, c_sqr].sort!

if (sides_sqr[0] == sides_sqr[1]) && (sides_sqr[2] == 2 * sides_sqr[0])
  puts "Triangle is rectangular and isosceles"
elsif sides_sqr[2] == (sides_sqr[0] + sides_sqr[1])
  puts "Triangle is rectangular"
elsif sides_sqr.min == sides_sqr.max
  puts "Triangle has equal sides and is not rectangular"
else
  puts "Triangle ain't rectangular or has equal sides"
end
