# ACCEPTANCE TESTS
require 'create_board'

describe "tic tac toe" do
    game_board = CreateBoard.new()

    it "tests initial board set up is correct" do 
        expect(game_board.layout.length).to eq(9)
        expect(game_board.layout.join.empty?).to eq(true)
    end
end