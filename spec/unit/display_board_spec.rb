require "game"
require "display_board"
require 'in_memory_game_gateway'


describe DisplayBoard do
    let(:new_game) { Game.new}
    let(:gateway) { InMemoryGameGateway.new}

    it "tests that board initial set up displays correctly" do
        gateway.save_game(Game.new)        
        displayed_board = DisplayBoard.new(gateway)
        expect(displayed_board.execute({})).to eq(
            " #{new_game.board[0]} | #{new_game.board[1]} | #{new_game.board[2]} \n" +
            "-----------\n " +
            " #{new_game.board[3]} | #{new_game.board[4]} | #{new_game.board[5]} \n" +
            "-----------\n" +
            " #{new_game.board[6]} | #{new_game.board[7]} | #{new_game.board[8]} "
        )
    end

    it "tests that board displays correctly with known board" do
        new_game.board = ["X","X","","","","","O","O",""]
        gateway.save_game(new_game)        
        displayed_board = DisplayBoard.new(gateway)  
        expect(displayed_board.execute({})).to eq(
            " X | X |  \n" +
            "-----------\n " +
            "  |  |  \n" +
            "-----------\n" +
            " O | O |  "
        )
    end
end