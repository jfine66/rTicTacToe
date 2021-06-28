# frozen_string_literal: true

# Handles names and symbols of players
class Player
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

# Creates the 3x3 board the game is played on
class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(3) { Array.new(3, '#') }
  end

  def show_board
    @grid.each { |x| puts x.join(' ') }
  end
end

# Game logic
class TicTacToe
  attr_accessor :player_one, :player_two

  @spaces = nil
  @game_over = false
  @player_mark = ''
  @board = nil

  def initialize
    @turn_number = 0
    puts "Enter Player one's name"
    @player_one = Player.new(gets.chomp)
    puts "Enter Player two's name"
    @player_two = Player.new(gets.chomp)
    puts "#{player_one.name} is X's and #{player_two.name} is O's"
    puts 'Player one goes is first.'
  end

  def game_start
    @board = Board.new
    @board.show_board
    @spaces = ('1'..'9').to_a
    @game_over = false
    play_game
  end

  def play_game
    until @game_over
      if @turn_number.even?
        puts "#{player_one.name} it is your turn"
        @player_mark = 'X'
      else
        puts "#{player_two.name} it is your turn"
        @player_mark = 'O'
      end
      player_turn
      check_for_winner
    end
  end

  def player_turn
    choice = gets.chomp

    if @spaces.include? choice
      update_board(choice)
      @turn_number += 1
      @spaces.delete(choice)
    else
      puts 'Please enter a valid position'
    end
  end

  def update_board(choice)
    case choice
    when '7'
      @board.grid[0][0] = @player_mark
      @board.show_board
    when '8'
      @board.grid[0][1] = @player_mark
      @board.show_board
    when '9'
      @board.grid[0][2] = @player_mark
      @board.show_board
    when '4'
      @board.grid[1][0] = @player_mark
      @board.show_board
    when '5'
      @board.grid[1][1] = @player_mark
      @board.show_board
    when '6'
      @board.grid[1][2] = @player_mark
      @board.show_board
    when '1'
      @board.grid[2][0] = @player_mark
      @board.show_board
    when '2'
      @board.grid[2][1] = @player_mark
      @board.show_board
    when '3'
      @board.grid[2][2] = @player_mark
      @board.show_board
    end
  end

  def check_for_winner
    check_rows
    check_columns
    check_player_one_diagonal
    check_player_two_diagonal

    if @spaces.empty? && !@game_over
      puts "It's a draw"
      @game_over = true
      play_again
    end
  end

  def check_rows
    @board.grid.each do |array|
      if array.all? 'X'
        puts 'Player one wins'
        @game_over = true
        play_again
      elsif array.all? 'O'
        puts 'Player two wins'
        @game_over = true
        play_again
      end
    end
  end

  def check_columns
    @board.grid.transpose.each do |array|
      if array.all? 'X'
        puts 'Player one wins'
        @game_over = true
        play_again
      elsif array.all? 'O'
        puts 'Player two wins'
        @game_over = true
        play_again
      end
    end
  end

  def check_player_one_diagonal
    if @board.grid[0][0] == 'X' && @board.grid[1][1] == 'X' && @board.grid[2][2] == 'X'
      puts 'Player one wins'
      @game_over = true
      play_again
    elsif @board.grid[0][2] == 'X' && @board.grid[1][1] == 'X' && @board.grid[2][0] == 'X'
      puts 'Player one wins'
      @game_over = true
      play_again
    end
  end

  def check_player_two_diagonal
    if @board.grid[0][0] == 'O' && @board.grid[1][1] == 'O' && @board.grid[2][2] == 'O'
      puts 'Player two wins'
      @game_over = true
      play_again
    elsif @board.grid[0][2] == 'O' && @board.grid[1][1] == 'O' && @board.grid[2][0] == 'O'
      puts 'Player two wins'
      @game_over = true
      play_again
    end
  end

  def play_again
    puts 'Would you like to play again y/n'
    choice = gets.chomp
    if choice == 'y'
      game_start
    else
      puts 'Thank you for playing'
    end
  end

  # End of class
end

game = TicTacToe.new
game.game_start
