# frozen_string_literal: true

module BoardStyle
  def empty_circle
    "\u25cb"
  end

  def red_circle
    "\e[31m\u25cf\e[0m"
  end

  def blue_circle
    "\e[34m\u25cf\e[0m"
  end
end
