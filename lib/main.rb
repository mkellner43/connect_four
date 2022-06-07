# frozen_string_literal: true

require_relative 'game'
require_relative 'board'
require_relative 'text'

def start_game
  game = Game.new
  game.player_input
  game.intro
  game.play
  replay
end

def replay
  include Text
  puts text(:replay)
  answer = gets.chomp
  answer.downcase == 'y' ? start_game : exit
end

start_game
replay
