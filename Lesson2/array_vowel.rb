# Lesson 2 / Array with vowels
#
letters = ('A'..'Z').to_a
vowels = ['A', 'E', 'I', 'O', 'U', 'Y']
hash_vowels = Hash.new

vowels.each do |vowel|

  letters.each do |letter|
# shift index by 1 to make it "human"
  hash_vowels[vowel] = letters.index(letter).to_i + 1 if letter == vowel
  end

end

puts hash_vowels
