# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative 'text'

class Game
  include Text
  include BoardStyle

  def initialize
    @player_one = Player.new(blue_circle)
    @player_two = Player.new(red_circle)
    @board = Board.new
    @turn = 1
    @current_player = @player_one
  end

  def player_input
    puts text(:create_player, 'Player 1')
    @player_one.name = valid_name(gets.chomp)
    puts text(:create_player, 'Player 2')
    @player_two.name = valid_name(gets.chomp)
  end

  def valid_name(input)
    return input if input.match(/\w+/)

    puts text(:invalid_name)
    valid_name(gets.chomp)
  end

  def intro
    puts introduction
  end

  def change_turn
    if @turn.even?
      @turn += 1
      @current_player = @player_one
    else
      @turn += 1
      @current_player = @player_two
    end
  end

  def player_turn
    loop do
      puts text(:player_selection, @current_player.name)
      selection = valid?(gets.chomp)
      return selection if selection && @board.row_check(selection)

      puts text(:invalid_selection)
    end
  end

  def play
    @board.display_board
    loop do
      column = player_turn
      row = @board.row_check(column)
      @board.update_board(row, column, @current_player.symbol)
      return win(@current_player) if check_board(@current_player)
      return tie if @board.full_board?

      change_turn
    end
  end

  def valid?(input)
    ('1'..'7').include?(input) ? input.to_i : false
  end

  def check_board(player)
    6.times do |row|
      7.times do |column|
        return true if @board.check_win(row, column, player.symbol)
      end
    end
    false
  end

  def win(player)
    @board.display_board
    puts text(:win, player.name)
  end

  def tie
    @board.display_board
    puts text(:tie)
  end
end
