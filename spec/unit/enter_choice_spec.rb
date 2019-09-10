# UNIT TESTS
require 'enter_choice'
require 'game'

describe EnterChoice do
    class DatabaseGateway
        def initialize
            @board = nil
        end

        def save(game)
            @board = game.board
        end

        def view_board
            @board
        end

    end

    game = Game.new() #empty board array

    it "tests user can enter an integer" do
    player_choice = EnterChoice.new("3", game)
    expect(player_choice.input).to eq(2)
    end

    it "tests user choice is valid" do
        invalid_player_choice = EnterChoice.new("10", game)
        player_choice = EnterChoice.new("3", game)
        expect(invalid_player_choice.valid_input?).to eq(false)
        expect(player_choice.valid_input?).to eq(true)
    end

    it "tests user selects empty square" do
        player_choice = EnterChoice.new("7", game)
        expect(player_choice.empty_square?).to eq(true)
    end

    it "tests board updates with valid user choice" do
        #gateway = DatabaseGateway.new
        player_choice = EnterChoice.new("3", game)
        player_choice.mark_square
        #gateway.save(game) # save this game in the database
        expect(game.board).to eq(["","","X","","","","","",""])        
    end

    it "tests invalid user choice returns error message" do
        invalid_player_choice = EnterChoice.new("10", game) 
        expect(invalid_player_choice.mark_square).to eq("Please make a valid selection")
    end

    it "tests board updates with second_player's valid choice" do
        second_player_choice = EnterChoice.new("5", game)
        second_player_choice.mark_square
        expect(game.board).to eq(["","","X","","O","","","",""])
    end

    it "tests board updates with first_player's valid choice" do
        first_player_choice = EnterChoice.new("4", game)
        first_player_choice.mark_square
        expect(game.board).to eq(["","","X","X","O","","","",""])
    end



end