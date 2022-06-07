require_relative '../lib/game'
require_relative '../lib/board'
require_relative '../lib/player'
require_relative '../lib/text'

describe Board do
  subject(:board) { described_class.new }
  let(:symbol) { double(blue_circle: "\e[34m\u25cf\e[0m") }
  let(:symbol2) { double(red_circle: "\e[31m\u25cf\e[0m") }

  describe '#update_board' do
    context 'when player enters 1' do
      before do
        allow(board).to receive(:display_board)
        board.update_board(0, 1, symbol.blue_circle)
      end

      it 'updates board to have player symbol in column 1' do
        game_board = board.instance_variable_get(:@grid)
        updated_cell = game_board[0][0]
        expect(updated_cell).to eq(symbol.blue_circle)
      end
    end

    context 'when player enters 5' do
      before do
        allow(board).to receive(:display_board)
        board.update_board(0, 5, symbol.blue_circle)
      end

      it 'updates board with player symbol in column 5' do
        game_board = board.instance_variable_get(:@grid)
        update_cell = game_board[0][4]
        expect(update_cell).to eq symbol.blue_circle
      end
    end
  end

  describe '#row_check' do
    context 'when column 1 has been selected 3 times' do
      before do
        allow(board).to receive(:display_board)
        board.update_board(5, 1, symbol.blue_circle)
        board.update_board(4, 1, symbol.blue_circle)
        board.update_board(3, 1, symbol.blue_circle)
      end

      it 'returns next avalible row of 2' do
        column = 1
        result = board.row_check(column)
        expect(result).to eq 2
      end
    end

    context 'when column 1 is full' do
      before do
        allow(board).to receive(:display_board)
        board.update_board(5, 1, symbol.blue_circle)
        board.update_board(4, 1, symbol.blue_circle)
        board.update_board(3, 1, symbol.blue_circle)
        board.update_board(2, 1, symbol.blue_circle)
        board.update_board(1, 1, symbol.blue_circle)
        board.update_board(0, 1, symbol.blue_circle)
      end

      it 'returns false' do
        column = 1
        result = board.row_check(column)
        expect(result).to eq false
      end
    end
  end

  describe '#check_vertical' do
    context 'when there for 4 blue_circles in a vertical row' do
      before do
        allow(board).to receive(:display_board)
        board.update_board(5, 1, symbol.blue_circle)
        board.update_board(4, 1, symbol.blue_circle)
        board.update_board(3, 1, symbol.blue_circle)
        board.update_board(2, 1, symbol.blue_circle)
      end

      it 'returns true' do
        column = 0
        row = 5
        result = board.check_vertical(row, column, symbol.blue_circle)
        expect(result).to eq true
      end
    end

    context 'when there are 4 red_circles in a vertical row' do
      before do
        allow(board).to receive(:display_board)
        board.update_board(4, 1, symbol2.red_circle)
        board.update_board(3, 1, symbol2.red_circle)
        board.update_board(2, 1, symbol2.red_circle)
        board.update_board(1, 1, symbol2.red_circle)
      end

      it 'returns true' do
        column = 0
        row = 4
        result = board.check_vertical(row, column, symbol2.red_circle)
        expect(result).to eq true
      end
    end

    context 'when there are 3 red_circles in a row' do
      before do
        allow(board).to receive(:display_board)
        board.update_board(4, 1, symbol2.red_circle)
        board.update_board(3, 1, symbol2.red_circle)
        board.update_board(2, 1, symbol2.red_circle)
      end

      it 'returns false' do
        column = 1
        row = 4
        result = board.check_vertical(row, column, symbol2.red_circle)
        expect(result).to eq false
      end
    end
  end

  describe '#check_vertical' do
    context 'when there are 4 blue_circles horizontal row' do
      before do
        allow(board).to receive(:display_board)
        board.update_board(4, 1, symbol.blue_circle)
        board.update_board(4, 2, symbol.blue_circle)
        board.update_board(4, 3, symbol.blue_circle)
        board.update_board(4, 4, symbol.blue_circle)
      end

      it 'returns true' do
        column = 3
        row = 4
        result = board.check_horizontal(row, column, symbol.blue_circle)
        expect(result).to eq true
      end
    end

    context 'when there is not 4 in a row' do
      before do
        allow(board).to receive(:display_board)
        board.update_board(4, 1, symbol.blue_circle)
        board.update_board(4, 2, symbol.blue_circle)
        board.update_board(4, 3, symbol.blue_circle)
        board.update_board(3, 1, symbol.blue_circle)
      end

      it 'returns false' do
        row = 4
        column = 3
        result = board.check_horizontal(row, column, symbol.blue_circle)
        expect(result).to eq false
      end
    end
  end

  describe '#check_diagonal' do
    context 'when there are 4 in a row with positive slope' do
      before do
        allow(board).to receive(:display_board)
        board.update_board(3, 1, symbol.blue_circle)
        board.update_board(2, 2, symbol.blue_circle)
        board.update_board(1, 3, symbol.blue_circle)
        board.update_board(0, 4, symbol.blue_circle)
      end

      it 'returns true' do
        column = 0
        row = 3
        player_symbol = symbol.blue_circle
        result = board.check_both_diagonal(row, column, player_symbol)
        expect(result).to eq true
      end
    end

    context 'when there are 4 in a row with a negative slope' do
      before do
        allow(board).to receive(:display_board)
        board.update_board(3, 7, symbol.blue_circle)
        board.update_board(2, 6, symbol.blue_circle)
        board.update_board(1, 5, symbol.blue_circle)
        board.update_board(0, 4, symbol.blue_circle)
      end

      it 'returns true' do
        column = 6
        row = 3
        player_symbol = symbol.blue_circle
        result = board.check_both_diagonal(row, column, player_symbol)
        expect(result).to eq true
      end
    end
  end

  describe '#full_board' do
    context 'when board is full' do
      before do
        allow(board).to receive(:display_board)
        board.instance_variable_set(:@grid, Array.new(6) { Array.new(7, symbol.blue_circle) })
      end

      it 'returns true' do
        result = board.full_board?
        expect(result).to be true
      end
    end

    context 'when board is not full' do
      before do
        allow(board).to receive(:display_board)
        board.update_board(0, 1, symbol.blue_circle)
      end

      it 'returns false' do
        result = board.full_board?
        expect(result).to be false
      end
    end
  end
end
