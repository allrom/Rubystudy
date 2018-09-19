# Lesson 2 / Date sequence
#
puts "Enter the Date:"
date = gets.to_i

puts "Enter the Month:"
month = gets.to_i

puts "Enter the Year:"
year = gets.to_i

months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

if year % 400 == 0 || year % 4 == 0 && year % 100 != 0
  months[1] = 29
  sign = 'leap'
end

date_sequence = date + months.first(month-1).sum

puts "\nDate sequence in this #{sign} #{year} year is: #{date_sequence}"