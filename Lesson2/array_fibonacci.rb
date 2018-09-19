# Lesson 2 / Array with Fibonacci
#
array_fb = [1, 1]

while array_fb.last(2).sum <= 100
  fb_sum = array_fb.last(2).sum
  array_fb << fb_sum
end

puts array_fb
