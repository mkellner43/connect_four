# frozen_string_literal: true

class Player
  attr_accessor :name, :symbol

  def initialize(name = nil, symbol)
    @name = name
    @symbol = symbol
  end
end
