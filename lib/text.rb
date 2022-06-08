# frozen_string_literal: true

module Text
  def text(text, player = nil)
    {
      create_player: "#{player} What is your name?",
      player_selection: "#{player} please choose a number between 1 and 7.",
      invalid_selection: 'Invalid input',
      invalid_name: 'Please enter at least one charatcter',
      full: 'This column is full!',
      win: "#{player} wins!",
      tie: 'It was a tie!',
      replay: 'Would you like to play again? Type y to replay and any other key to exit.'
    }[text]
  end

  def introduction
    <<-HEREDOC
  \n
    Welcome to connect four! First to get 4 in a row wins. Verticle, horizontal,
    or diaginal rows all count. Select a number at the bottom of the board
    and your token will be placed at the lowest empty spot in that row. Good luck!
  \n
    HEREDOC
  end
end
