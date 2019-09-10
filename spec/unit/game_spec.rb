# UNIT TESTS
require 'game'

describe Game do
    game = Game.new()

    it "tests initial board set up is correct" do 
        expect(game.board.length).to eq(9)
        expect(game.board.join.empty?).to eq(true)
    end
end