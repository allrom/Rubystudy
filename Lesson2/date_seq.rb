# Lesson 2 / Date sequence
#
puts "Enter the Date:"
date = gets.chomp.to_i

puts "Enter the Month:"
month = gets.chomp.to_i

puts "Enter the Year:"
year = gets.chomp.to_i

month_hash = { 0 => 0,  1 => 31, 2 => 28, 3 => 31,
               4 => 30, 5 => 31, 6 => 30, 7 => 31,
               8 => 31, 9 => 30, 10 => 31, 11 => 30,
               12 => 31 }

# check for leap year (modulus is in lower priority)
if (year % 400) == 0 || ((year % 4) == 0 && (year % 100) != 0)
  month_hash[2] = 29
  puts "*leap year*"
end

date_sequence = i = 0

while i < month
  date_sequence += month_hash[i]
  i += 1
end

date_sequence += date

puts "\nDate sequence in this year is: #{date_sequence}"
