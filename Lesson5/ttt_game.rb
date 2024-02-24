module Promptable
  def prompt(str)
    puts ">> #{str}"
  end
end

class TTTGame
  include Promptable

  COMPUTER_MARK = 'O'

  attr_reader :human, :computer, :board
  attr_accessor :winner, :current_player

  def initialize
    @human = Human.new(Square::EMPTY_MARK)
    @computer = Computer.new(COMPUTER_MARK)
    @board = Board.new
    @winner = :tie
    @current_player = :human
  end

  def play
    greeting
    main_game
    goodbye
  end

  def main_game
    loop do
      loop do
        board.display
        current_player_turn
        break if winner? || board.full?
      end
      announce_winner
      break unless play_again?
      board.reset
    end
  end

  def current_player_turn
    if current_player == :human
      human_turn
      self.current_player = :computer
    else
      computer_turn
      self.current_player = :human
    end
  end

  def greeting
    prompt("Welcome to Tic-Tac-Toe!")
    human_name
    human_marker
    prompt("Today #{human.name} is playing against #{computer.name}")
    prompt("You're playing as the #{human.mark}'s.")
    prompt("Your opponent is playing as the #{computer.mark}'s.")
    puts
  end

  def human_name
    puts "What is your name?"
    ans = ''
    loop do
      ans = gets.chomp
      break if ans != ''
      prompt("Sorry. Your name can't be blank.")
    end
    human.name = ans
  end

  def human_marker
    ans = nil
    loop do
      prompt("What character do you want to use as your marker?")
      ans = gets.chomp
      break unless ans.size != 1 || ans == 'O'
      prompt((ans == 'O' ? "Computer's marker is O!" : "Must be 1 character!"))
    end
    human.mark = ans
  end

  def human_turn
    square = nil
    loop do
      prompt("Which square would you like to mark?")
      board.show_choices
      square = (gets.chomp.to_i - 1)
      break if valid?(square) && board.available?(square)
      prompt("Sorry! That is not a valid choice!")
    end
    board.place_mark(square, human.mark)
  end

  def computer_turn
    square = nil
    loop do
      square = (0..8).to_a.sample
      break if board.available?(square)
    end
    board.place_mark(square, computer.mark)
    prompt("#{computer.name} placed a #{computer.mark} on square #{square + 1}")
  end

  def valid?(input)
    (0..8).to_a.include?(input)
  end

  def winner?
    human_mark = human.mark
    if board.win_row?(human_mark) || board.win_col?(human_mark) ||
       board.win_diag?(human_mark)
      self.winner = :human
    elsif board.win_row?(COMPUTER_MARK) || board.win_col?(COMPUTER_MARK) ||
          board.win_diag?(COMPUTER_MARK)
      self.winner = :computer
    end
  end

  def goodbye
    prompt("Thanks for playing Tic-Tac-Toe! Goodbye!")
  end

  def announce_winner
    board.display

    case winner
    when :human
      prompt("You won! Congratulations!")
    when :computer
      prompt("You lost.")
    when :tie
      prompt("This game is a tie!")
    end
  end

  def play_again?
    ans = nil
    loop do
      prompt("Do you want to play again? (y/n)")
      ans = gets.chomp.downcase
      break if %w(y n).include?(ans)
      prompt("Must reply with 'y' or 'n'")
    end
    ans == 'y'
  end
end

class Board
  include Promptable

  attr_accessor :board

  def initialize
    @board = []
    reset
  end

  def reset
    self.board = Array.new(9) { |idx| Square.new(idx) }
  end

  def show_choices
    choices = board.map.with_index do |square, index|
      square.mark == Square::EMPTY_MARK ? index + 1 : ' '
    end
    puts "#{choices[0]}|#{choices[1]}|#{choices[2]}"
    puts "#{choices[3]}|#{choices[4]}|#{choices[5]}"
    puts "#{choices[6]}|#{choices[7]}|#{choices[8]}"
  end

  def display
    prompt("Here's the current state of the board:")
    puts
    high_row
    mid_row
    low_row
    prompt("(press ENTER to continue)")
    gets
  end

  def empty_row
    "   |   |   "
  end

  def lines
    "-----------"
  end

  def high_row
    puts empty_row
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts empty_row
    puts lines
  end

  def mid_row
    puts empty_row
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts empty_row
    puts lines
  end

  def low_row
    puts empty_row
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
    puts empty_row
    puts
  end

  def available?(idx)
    board.select { |square| square.mark == ' ' }.map(&:index).include?(idx)
  end

  def place_mark(idx, mark)
    board[idx].mark = mark
  end

  def full?
    board.all? { |square| square.mark != ' ' }
  end

  def win_row?(mark)
    marks = marks_arr
    marks[0..2].all?(mark) || marks[3..5].all?(mark) || marks[6..8].all?(mark)
  end

  def win_col?(mark)
    marks = marks_arr
    [marks[0], marks[3], marks[6]].all?(mark) ||
      [marks[1], marks[4], marks[7]].all?(mark) ||
      [marks[2], marks[5], marks[8]].all?(mark)
  end

  def win_diag?(mark)
    marks = marks_arr
    [marks[0], marks[4], marks[8]].all?(mark) ||
      [marks[2], marks[4], marks[6]].all?(mark)
  end

  def marks_arr
    board.map(&:mark)
  end
end

class Square
  attr_accessor :mark
  attr_reader :index

  EMPTY_MARK = ' '

  def initialize(index)
    @mark = EMPTY_MARK
    @index = index
  end

  def to_s
    mark
  end
end

class Player
  include Promptable

  attr_accessor :name, :mark

  def initialize(mark)
    @mark = mark
  end
end

class Human < Player
end

class Computer < Player
  COMPUTER_NAME = %w(Rob Knob Slob Blob Glen)

  def initialize(marker)
    super
    @name = COMPUTER_NAME.sample
  end
end

TTTGame.new.play
