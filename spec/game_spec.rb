require_relative '../lib/game'
require_relative '../lib/board'
require_relative '../lib/player'
require_relative '../lib/text'

describe Game do
  subject(:game) { described_class.new }
  let(:board) { double(Board.new) }

  describe '#change_turn' do
    let(:player_one) { game.instance_variable_get(:@player_one) }
    let(:player_two) { game.instance_variable_get(:@player_two) }

    context 'turn is increased by one when change_turn is called' do

      it 'adds 1 to @turn' do
        expect { game.change_turn }.to change { game.instance_variable_get(:@turn) }.by 1
      end
    end

    context 'when @turn is equal to 2' do

      it 'adds 1 to turn' do
        expect { game.change_turn }.to change { game.instance_variable_get(:@turn) }.by 1
      end
    end
  end

  describe '#valid' do
    context 'when input is between 1 and 7' do
      it 'returns input when input = 1' do
        input = '1'
        expect(game.valid?(input)).to eq 1
      end

      it 'returns input when input = 7' do
        input = '7'
        expect(game.valid?(input)).to eq 7
      end

      it 'returns input when input = 4' do
        input = '4'
        expect(game.valid?(input)).to eq 4
      end
    end
  end

  describe '#player_turn' do
    context 'when an invalid input is selected followed by a valid one' do
      before do
        valid_input = 4
        allow(game).to receive(:valid?).and_return(false, valid_input)
        allow(game).to receive(:puts)
        allow(board).to receive(:display_board)
      end

      it 'calls valid? exactly twice' do
        expect(game).to receive(:valid?).exactly(2).times
        game.player_turn
      end
    end

    context 'when three invalid inputs are selected and the last is valid' do
      before do
        valid_input = 5
        allow(game).to receive(:valid?).and_return(false, false, false, valid_input)
        allow(game).to receive(:puts)
        allow(board).to receive(:display_board).once
      end

      it 'calls valid? exactly 4 times' do
        expect(game).to receive(:valid?).exactly(4).times
        game.player_turn
      end

      it 'displays invalid message 3 times' do
        invalid_selection_message = 'Invalid input'
        expect(game).to receive(:puts).with(invalid_selection_message).exactly(3).times
        game.player_turn
      end

      before do
        current_player = game.instance_variable_get(:@current_player)
        current_player.name = 'Matt'
      end

      it 'displays player_selection message 4 times' do
        player_selection_message = 'Matt please choose a number between 1 and 7.'
        expect(game).to receive(:puts).with(player_selection_message).exactly(4).times
        game.player_turn
      end
    end
  end

  describe '#check_board' do

    let(:player_one) { game.instance_variable_get(:@player_one) }

    context 'when there is no winner' do

      let(:board) { game.instance_variable_get(:@board) }

      before do
        allow(board).to receive(:check_win).and_return(false)
      end
      it 'returns false' do
        result = game.check_board(player_one)
        expect(result).to be false
      end
    end

    context 'when there is a winner' do
      let(:board) { game.instance_variable_get(:@board) }

      before do
        allow(board).to receive(:check_win).and_return(true)
      end

      it 'returns true' do
      result = game.check_board(player_one)
      expect(result).to be true
      end
    end
  end


end
