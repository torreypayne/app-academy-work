class Player
  attr_accessor :dealer, :hand
  attr_reader :name, :bankroll

  def initialize(dealer, name, bankroll)
    @dealer, @name, @bankroll = dealer, name, bankroll
    @dealer.add_player(self)
  end

  def return_cards(deck)
    deck.return_cards(@hand)
    @hand = nil
  end

  def pay_winnings(amt)
    @bankroll += amt
  end

  def make_bet(bet_amt)
    dealer.take_bet(self, bet_amt)
    @bankroll -= bet_amt
  end

  def play_turn
    if dealer.bet_made?
      puts "Do you want to call?\n"
      answer = gets.chomp.to_s
      if answer.match('call')
        dealer.call_made(self)
      else
        discard_cards
      end
    else
      puts "Do you want to make a bet?\n"
      answer = gets.chomp
      if answer.match('Y')
        puts "How much?\n"
        amount = gets.chomp.to_i
        make_bet(amount.to_i)
      end
    end
  end

  def pay(ante)
    raise "Can't pay ante!" if ante > bankroll
    @bankroll -= ante
  end

  def discard_cards
    puts "Which cards do you want to discard?"
    puts hand
    card_idxs = gets.chomp.map { |num| n.to_i }.to_a
    dealer.collect_cards(@hand.discard(card_idxs))
    return card_idxs.size
  end

  def draw(num)
    @hand.draw(dealer.deal_cards(num))
  end
end
