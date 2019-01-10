# Lesson10 (BlackJack) Game Control Class
#
class GameTable
  include GameTech

  attr_reader :interface, :gambler, :dealer, :banker,
              :gamblers_hand, :dealers_hand, :deck

  def initialize(interface)
    @interface = interface
    name = interface.greeting
    @gambler = Gambler.new(name)
    @dealer = Dealer.new
    @gamblers_hand = CardsInHand.new(gambler)
    @dealers_hand = CardsInHand.new(dealer)
    @banker = Banker.new
  end

  def play
    start_over if credit_check
    while interface.go_on?
      if gamblers_hand.tell_length == 2
        gambler_play(:start_menu)
      else
        round_end
        start_over if interface.again?
      end
    end
  end

  def new_deck
    @deck = Deck.new
    deck.shuffle_deck
  end

  def new_deal
    deal(2, gambler, gamblers_hand, deck)
    deal(2, dealer, dealers_hand, deck)
  end

  def start
    new_deck
    new_deal
    interface.display_credit(gambler.name, banker.gambler_credit)
    gambler_your_cards
    dealer_your_cards

    gamblers_score = gamblers_hand.tell_score
    interface.display_score(gambler.name, gamblers_score)
    interface.blackjack(gambler.name) if blackjack?(gamblers_score)
  end

  def round_end
    interface.showdown
    showdown(dealers_hand)
    gambler_your_cards
    dealer_your_cards
    final_score

    status, winner = who_won(gamblers_hand, dealers_hand)
    gambler_credit, dealer_credit = banker.processing(status, winner)
    win_name = winner == :gambler ? gambler.name : :dealer
    interface.display_fin(status, win_name, gambler.name, gambler_credit, dealer_credit)
  end

  def final_score
    gamblers_score, dealers_score = gamblers_hand.tell_score, dealers_hand.tell_score
    if blackjack?(gamblers_score)
      interface.blackjack(gambler.name)
    else
      interface.display_score(gambler.name, gamblers_score)
    end
    if blackjack?(dealers_score)
      interface.blackjack(:dealer)
    else
      interface.display_score(:dealer, dealers_score)
    end
  end

  def start_over
    gamblers_hand.start_over
    dealers_hand.start_over
    banker.getbet
    start
  end

  def gambler_your_cards
    gamblers_cards = display(gamblers_hand)
    interface.display_card(gambler.name, gamblers_cards)
  end

  def dealer_your_cards
    dealers_cards = display(dealers_hand)
    interface.display_card(:dealer, dealers_cards)
  end

  def credit_check
    if banker.lost_money?(gambler)
      banker.start_over if interface.question_credit(gambler.name)
    elsif banker.lost_money?(dealer)
      banker.start_over if interface.question_credit(:dealer)
    else
      true
    end
  end

  def gambler_play(menu_items)
    select = interface.gambler_select(gambler.name, menu_items)
    case select
    when :pass then dealer_play
    when :take_a_card
      if blackjack?(gamblers_hand.tell_score)
        interface.blackjack(gambler.name)
      else
        deal(1, gambler, gamblers_hand, deck)
      end
      gambler_your_cards
      dealer_play
    when :showdown
      round_end
      play if interface.again?
    end
  end

  def dealer_play
    interface.player_hit(:dealer)
    if decide?(dealers_hand) && dealers_hand.tell_length == 2
      deal(1, dealer, dealers_hand, deck)
    end
    dealer_your_cards

    gambler_play_next
  end

  def gambler_play_next
    if gamblers_hand.tell_length == 2 && !blackjack?(gamblers_hand.tell_score)
      gambler_your_cards
      gambler_play(:next_menu)
    else
      round_end
      play if interface.again?
    end
  end
end
