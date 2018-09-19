# Lesson 2 / Array with vowels
#
letters = ('A'..'Z').to_a
vowels = %w(A E I O U Y)

result_index = {}

letters.each.with_index(1) do |letter, index|
  result_index[letter] = index if vowels.include?(letter)
end

puts result_index
