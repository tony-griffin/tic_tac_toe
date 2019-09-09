# UNIT TESTS
require 'create_game'

describe CreateGame do
    game = CreateGame.new()

    it "tests initial board set up is correct" do 
        expect(game.board.length).to eq(9)
        expect(game.board.join.empty?).to eq(true)
    end
end