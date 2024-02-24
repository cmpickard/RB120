module Promptable
  def prompt(str)
    puts ">> #{str}"
  end
end

class RpsGame
  include Promptable

  attr_accessor :winner, :score
  attr_reader :human, :computer

  def initialize
    greeting
    @human = Human.new(human_name, human: true)
    @computer = Computer.new(comp_name, human: false)
    @winner = nil
    @score = [0, 0]
  end

  def human_name
    prompt('What is your name?')
    gets.chomp.capitalize
  end

  def comp_name
    %w(Beepboop Robochobo Gordon Triskit Brundle).sample
  end

  def play
    commence
    loop do
      [human, computer].each(&:make_choice)
      display_choices
      calc_winner
      display_winner
      match_winner? ? break : display_score
    end
    again? ? play : goodbye
  end

  def greeting
    prompt('Hi! Welcome to Rock Paper Scissors!')
    prompt("You'll be playing against a computer opponent.")
    prompt('First to win 3 game wins the match!')
    puts
  end

  def commence
    reset_score
    prompt("In this game, #{human.name} is playing against #{computer.name}.")
    puts
  end

  def reset_score
    self.score = [0, 0]
  end

  def display_choices
    prompt("#{human.name} throws a #{human.display_move}!")
    prompt("#{computer.name} throws a #{computer.display_move}!")
    gets
  end

  def calc_winner
    self.winner = case human.move
                  when 'r' then calc_rock
                  when 'p' then calc_paper
                  when 's' then calc_scissors
                  end
    update_score
  end

  def update_score
    case winner
    when human then score[0] += 1
    when computer then score[1] += 1
    end
  end

  def calc_rock
    return :tie if computer.move == 'r'

    computer.move == 'p' ? computer : human
  end

  def calc_paper
    return :tie if computer.move == 'p'

    computer.move == 's' ? computer : human
  end

  def calc_scissors
    return :tie if computer.move == 'p'

    computer.move == 'r' ? computer : human
  end

  def display_winner
    if winner == :tie
      prompt("Tie game! Everyone threw a #{human.display_move}.")
    elsif winner == human
      prompt("You won - #{human.display_move} beats #{computer.display_move}!")
    else
      prompt("You lost - #{computer.display_move} beats #{human.display_move}.")
    end
    gets
  end

  def display_score
    prompt("Current match scores:")
    prompt("#{human}: #{score[0]}")
    prompt("#{computer}: #{score[1]}")
    puts
  end

  def match_winner?
    score[0] >= 3 || score[1] >= 3
  end

  def display_match_winner
    if score[0] >= 3
      prompt('You win the match! Congratulations!')
    else
      prompt("#{computer} wins the match! You lose.")
    end
    gets
  end

  def again?
    prompt("Do you want to play again? ('y' to play / anything else to quit")
    gets.chomp.downcase == 'y'
  end

  def goodbye
    display_match_winner
    prompt('Thanks for playing Rock, Paper, Scissors!')
  end
end

class Player
  include Promptable

  attr_accessor :move, :name, :is_human

  def initialize(name, human:)
    @move = nil
    @name = name
    @is_human = human
  end

  def display_move
    if move == 'p'
      'paper'
    elsif move == 'r'
      'rock'
    else
      'scissors'
    end
  end

  def to_s
    name
  end
end

class Human < Player
  def make_choice
    ans = ''
    loop do
      prompt('Do you throw (r)ock, (p)aper, or (s)cissors?')
      ans = gets.chomp.downcase
      break if %w(r p s).include?(ans)

      prompt("Sorry! Must enter 'r' or 'p' or 's'.")
      puts
    end
    self.move = ans
    puts
  end
end

class Computer < Player
  def make_choice
    self.move = (%w(r p s).sample)
  end
end

RpsGame.new.play
