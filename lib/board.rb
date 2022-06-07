# frozen_string_literal: true

require_relative 'board_style'
require_relative 'text'

class Board
  include BoardStyle
  include Text

  attr_reader :grid

  def initialize
    @grid = Array.new(6) { Array.new(7, empty_circle) }
  end

  def display_board
    @grid.each do |row|
      puts row.join(' ')
    end
    puts (1..7).to_a.join(' ')
  end

  def update_board(row, column, symbol)
    return if row_check(column) == false

    @grid[row][column - 1] = symbol
    display_board
  end

  def row_check(column)
    row = 5
    while row >= 0
      return row if @grid[row][column - 1] == empty_circle

      row -= 1
    end
    false
  end

  def full_board?
    @grid.each do |row|
      row.each do |column|
        return false if column == empty_circle
      end
    end
    true
  end

  def check_vertical(row, column, symbol)
    return if row < 3

    @grid[row][column] == symbol && @grid[row - 1][column] == symbol && @grid[row - 2][column] == symbol && @grid[row - 3][column] == symbol
  end

  def check_horizontal(row, column, symbol)
    return if column < 3

    @grid[row][column] == symbol && @grid[row][column - 1] == symbol && @grid[row][column - 2] == symbol && @grid[row][column - 3] == symbol
  end

  def check_diagonal(row, column, symbol)
    return if row < 3 || column > 3

    @grid[row][column] == symbol && @grid[row - 1][column + 1] == symbol && @grid[row - 2][column + 2] == symbol && @grid[row - 3][column + 3] == symbol
  end

  def check_other_diagonal(row, column, symbol)
    return if row < 3 || column < 3

    @grid[row][column] == symbol && @grid[row - 1][column - 1] == symbol && @grid[row - 2][column - 2] == symbol && @grid[row - 3][column - 3] == symbol
  end

  def check_both_diagonal(row, column, symbol)
    check_diagonal(row, column, symbol) || check_other_diagonal(row, column, symbol)
  end

  def check_win(row, column, symbol)
    check_horizontal(row, column,
                     symbol) || check_vertical(row, column, symbol) || check_both_diagonal(row, column, symbol)
  end
end
