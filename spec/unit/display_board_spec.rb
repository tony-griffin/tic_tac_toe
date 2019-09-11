require "game"
require "display_board"

describe DisplayBoard do
    let(:new_game) {game = Game.new()}

    it "tests that board initial set up displays correctly" do
        displayed_board = DisplayBoard.new
        expect(displayed_board.display_board(new_game)).to eq(
            " #{new_game.board[0]} | #{new_game.board[1]} | #{new_game.board[2]} \n" +
            "-----------\n " +
            " #{new_game.board[3]} | #{new_game.board[4]} | #{new_game.board[5]} \n" +
            "-----------\n" +
            " #{new_game.board[6]} | #{new_game.board[7]} | #{new_game.board[8]} "
        )
    end

    it "tests that board displays correctly with known board" do
        displayed_board = DisplayBoard.new
        new_game.board = ["X","X","","","","","O","O",""]
        expect(displayed_board.display_board(new_game)).to eq(
            " X | X |  \n" +
            "-----------\n " +
            "  |  |  \n" +
            "-----------\n" +
            " O | O |  "
        )
    end
end