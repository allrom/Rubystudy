# Lesson 2 / Array with step 5
#
numbers_five = []

for i in 10..100
   next if i % 5 != 0
  numbers_five << i
end

puts numbers_five
