# Lesson 2 / Array with Fibonacci
#
array_fb = [1, 1]
idx = 0

array_fb.each do
  if array_fb[idx] + array_fb[idx + 1] <= 100
    array_fb << array_fb[idx] + array_fb[idx + 1]
    idx += 1
  end
end

puts array_fb
