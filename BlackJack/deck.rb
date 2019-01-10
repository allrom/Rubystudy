# Lesson10 (BlackJack) A Deck of Cards Class
#
class Deck
  RANKS = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze
  SUITS = %w[clubs hearts spades diamonds].freeze

  attr_reader :cards

  def initialize
    @cards = []
  end

  def shuffle_deck
    shuffled_deck = RANKS.product(SUITS).shuffle
    shuffled_deck.each do |card|
      rank, suit = card.first, card.last
      @cards << Card.new(rank, suit)
    end
  end
end
