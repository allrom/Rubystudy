# Lesson10 (BlackJack) Cards In Player's Hand
#
class CardsInHand
  CARD_VALUE = {
    "2" => 2, "3" => 3, "4" => 4,
    "7" => 7, "5" => 5, "6" => 6,
    "8" => 8, "9" => 9, "10" => 10,
    "A" => 11, "J" => 10,
    "Q" => 10, "K" => 10
  }.freeze

  attr_accessor :cards
  attr_reader :player

  def initialize(player)
    @player = player
  end

  def tell_score
    @total, @aces = 0, 0
    cards.each do |card|
      if card.rank == "A"
        @aces += 1
        @total += 11
      else
        @total += CARD_VALUE[card.rank]
      end
    end
    while @total > GameTech::BLACKJACK && @aces.positive?
      @total -= 10
      @aces -= 1
    end
    @total
  end

  def tell_length
    cards.size
  end

  def start_over
    preset!
  end

  protected

  def preset!
    @cards, @total, @aces = [], 0, 0
  end
end
