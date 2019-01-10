# Lesson10 (BlackJack) A Card Class
#
class Card
  attr_reader :rank, :suit, :hidden

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
    @hidden = true
  end

  def hidden?
    @hidden
  end

  def shown?
    !hidden
  end

  def show!
    @hidden = false
  end
end
