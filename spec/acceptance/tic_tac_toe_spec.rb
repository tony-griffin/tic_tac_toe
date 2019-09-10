# ACCEPTANCE TESTS
require 'game'
require 'enter_choice'

describe "tic tac toe" do
    game = Game.new()

    it "tests initial board set up is correct" do 
        expect(game.board.length).to eq(9)
        expect(game.board.join.empty?).to eq(true)
    end
    
    it "tests user can enter their choice" do
        player_choice = EnterChoice.new("2", game)
        player_choice.mark_square
        expect(game.board).to eq(["","X","","","","","","",""])
    end
end