# Lesson10 (BlackJack) A Banker Class
#
class Banker
  attr_reader :gambler_credit, :dealer_credit, :bank

  def initialize
    @bank = 0
    preset!
  end

  def start_over
    preset!
  end

  def getbet
    @dealer_credit -= GameTech::BET
    @gambler_credit -= GameTech::BET
    @bank += 2 * GameTech::BET
  end

  def processing(status, player)
    case status
    when :win, :bust
      player == :gambler ? @gambler_credit += bank : @dealer_credit += bank
    when :tie
      @gambler_credit += bank / 2
      @dealer_credit += bank / 2
    end
    @bank = 0
    [gambler_credit, dealer_credit]
  end

  def money?(player)
    player.role == :gambler ? gambler_credit.positive? : dealer_credit.positive?
  end

  def lost_money?(player)
    !money?(player)
  end

  protected

  def preset!
    @gambler_credit, @dealer_credit = GameTech::START_CREDIT, GameTech::START_CREDIT
  end
end
