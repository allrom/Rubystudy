# Lesson 1 / Ideal weight
#
puts "Enter your name: "
name = gets.chomp

puts "Enter your height: "
height = gets.to_i

weight = height - 110

if weight >= 0
	puts "#{name}, Ваш идеальный вес -> #{weight} кг."
else
	puts "#{name}, Ваш вес уже оптимальный ."
end