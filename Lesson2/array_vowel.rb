# Lesson 2 / Array with vowels
#
letters = ('A'..'Z').to_a
vowels = %w(A E I O U Y)

result_index = {}

letters.each.with_index(1) { |letter, index|
  result_index[letter] = index  if vowels.include?(letter)
}

puts result_index
