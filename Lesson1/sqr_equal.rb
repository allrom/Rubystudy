# Lesson 1 / Quadr. Equation
#
puts "It's quadr. equation, enter its ratios (as integers)"

puts "Enter (non-zero) a: "
a = gets.to_f

# a should be  non-zero
if   a !=0
  puts "Enter b: "
  b = gets.to_f
  puts "Enter c: "
  c = gets.to_f 
  
# compute D
  diskrim = b**2 - 4*a*c
  
  if   diskrim > 0
    puts "D is : #{diskrim},  x1 is : #{(-b+Math.sqrt(diskrim))*0.5*a}, x2 is : #{(-b-Math.sqrt(diskrim))*0.5*a}"
  elsif  diskrim == 0
    puts "D is : #{diskrim},  x1 (is equal x2) : #{(-b)*0.5*a}"
  else 
    puts "D is : #{diskrim},  корней нет"
  end  
 
else puts "a can't be 0, start over"
end  
