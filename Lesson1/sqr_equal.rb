# Lesson 1 / Square Equal
#
puts "It's quadr. equation, enter its ratios (as integers)"
puts "Enter a: "
a = gets.chomp.to_f

# a should be  non-zero
if a != 0
  puts "Enter b: "
  b = gets.to_f
  puts "Enter c: "
  c = gets.to_f

  diskrim = b**2 - 4 * a * c

  if diskrim > 0
    diskrim_sqrt = Math.sqrt(diskrim)
    x1 = (-b + diskrim_sqrt) / (2 * a)
    x2 = (-b - diskrim_sqrt) / (2 * a)
    puts "D : #{diskrim}, x1 : #{x1}, x2 : #{x2}"
  elsif  diskrim == 0
    x1 = - b / (2 * a)
    puts "D : #{diskrim}, x1 (equals to x2): #{x1}"
  else
    puts "D : #{diskrim}, корней нет"
  end
else
  puts "a can't be 0, start over"
end