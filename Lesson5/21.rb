module Promptable
  def prompt(str)
    puts ">> #{str}"
  end
end

class Deck
  SUITS = %w(Spades Diamonds Hearts Clubs)
  RANKS = %w(2 3 4 5 6 7 8 9 10 Jack Queen King Ace)
  VALUES = { '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7,
             '8' => 8, '9' => 9, '10' => 10, 'Jack' => 10, 'Queen' => 10,
             'King' => 10, 'Ace' => 11 }

  attr_reader :cards

  def initialize
    @cards = reset
  end

  def reset
    card_arr = SUITS.each_with_object([]) do |suit, arr|
      RANKS.each { |rank| arr << Card.new(suit, rank) }
    end
    card_arr.shuffle
  end

  def deal_one
    cards.pop
  end
end

class Card
  attr_reader :rank, :suit

  FIXED_WIDTH_SPACES = 13

  def initialize(suit, rank)
    @suit = suit
    @rank = rank
  end

  def fixed_width_calc
    needed_spaces = (FIXED_WIDTH_SPACES - (rank.size + suit.size))
    l_space = needed_spaces / 2
    r_space = (needed_spaces.odd? ? (needed_spaces / 2) + 1 : needed_spaces / 2)
    return l_space, r_space
  end

  def to_s
    l_space, r_space = fixed_width_calc
    "||#{' ' * l_space}  #{rank} of #{suit}  #{' ' * r_space}||"
  end

  def value
    VALUES[rank]
  end
end

class TwentyOneGame
  include Promptable

  attr_reader :human, :dealer, :deck

  def initialize
    @deck = Deck.new
    @human = Human.new
    @dealer = Dealer.new
  end

  def play
    greeting
    loop do
      deal_hands
      human_turn
      dealer_turn unless human.hand.bust?
      result
      break unless play_again?
    end
    goodbye
  end

  def deal_hands
    reset_deck_and_hands
    2.times do |_|
      human.hand.cards << deck.deal_one
      dealer.hand.cards << deck.deal_one
    end
  end

  def reset_deck_and_hands
    human.hand.reset
    dealer.hand.reset
    deck.reset
  end

  def greeting
    prompt("Hi #{human.name}! Welcome to 21!")
    prompt("Today you are playing against the dealer, #{dealer.name}.")
    prompt("(press ENTER to continue)")
    gets
    TwentyOneGame.clear
  end

  def human_turn
    show_current_hands
    move = nil
    loop do
      prompt("Do you want to (hit) or (stay)?")
      move = gets.chomp.downcase
      break if move == 'stay'
      move == 'hit' ? send(move.to_s) : prompt(" Must enter 'hit' or 'stay'!")
      break if human.hand.bust?
    end
  end

  def hit
    human.hand.cards << deck.deal_one
    show_player_hand
  end

  def show_current_hands
    TwentyOneGame.clear
    show_player_hand
    show_dealer_hand
  end

  def show_player_hand
    prompt("Your hand:")
    human.hand.cards.each { |card| puts card }
    puts
  end

  def show_dealer_hand(all_cards: false)
    if all_cards
      prompt("The dealer's hand")
      dealer.hand.cards.each { |card| puts card }
    else
      prompt("The dealer's top card:")
      puts dealer.hand.cards[0]
    end
    puts
  end

  def dealer_turn
    while dealer.hand.value < 17
      dealer.hand.cards << deck.deal_one
    end
  end

  def result
    TwentyOneGame.clear
    puts "       __OUTCOME__"
    puts
    busted_player ? display_bust : display_high_scorer
  end

  def display_bust
    if busted_player == :human
      show_player_hand
      prompt("You busted! You lose.")
    else
      show_dealer_hand(all_cards: true)
      prompt("Dealer busted! You Win!")
    end
    puts
  end

  def display_high_scorer
    print_hands_and_scores
    case highest_scorer
    when :human
      prompt("You win! Your hand is closer to 21.")
    when :dealer
      prompt("You lose! Dealer's hand closer to 21.")
    else
      prompt("The game ends in a tie!")
    end
    puts
  end

  def print_hands_and_scores
    show_player_hand
    prompt("Your hand is worth #{human.hand.value}.")
    puts
    show_dealer_hand(all_cards: true)
    prompt("The dealer's hand is worth #{dealer.hand.value}.")
  end

  def highest_scorer
    if human.hand.value > dealer.hand.value
      :human
    elsif human.hand.value < dealer.hand.value
      :dealer
    else
      :tie
    end
  end

  def busted_player
    if human.hand.bust?
      :human
    elsif dealer.hand.bust?
      :dealer
    end
  end

  def play_again?
    ans = nil
    loop do
      puts "Do you want to play again? (y/n)"
      ans = gets.chomp.downcase
      break if %w(y n).include?(ans)
      puts "Sorry! Must answer 'y' or 'n'."
    end
    ans == 'y'
  end

  def self.clear
    system 'clear'
  end

  def goodbye
    puts "Thanks for playing Twenty-One! Goodbye."
  end
end

class Player
  include Promptable

  attr_reader :hand

  def initialize
    @hand = Hand.new
  end
end

class Human < Player
  attr_reader :name

  def initialize
    @name = choose_name
    super
  end

  def choose_name
    TwentyOneGame.clear
    prompt("What is your name?")
    ans = nil
    loop do
      ans = gets.chomp.capitalize
      break unless ans.empty?
      prompt("Sorry, your name can't be empty!")
    end
    ans
  end
end

class Dealer < Player
  DEALER_NAMES = %w(Dealio Dealdre Dr_Deal Ally_McDeal)

  attr_reader :name

  def initialize
    @name = rand_name
    super
  end

  def rand_name
    DEALER_NAMES.sample
  end
end

class Hand
  attr_reader :cards

  def initialize
    @cards = []
  end

  def value
    aces = cards.map(&:rank).count('Ace')
    sum = cards.map { |card| Deck::VALUES[card.rank] }.inject(:+)
    while sum > 21 && aces > 0
      sum -= 10
      aces -= 1
    end
    sum
  end

  def bust?
    value > 21
  end

  def reset
    @cards = []
  end
end

TwentyOneGame.new.play
