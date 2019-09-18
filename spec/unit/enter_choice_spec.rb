# UNIT TESTS
require 'enter_choice'
require 'game'
require 'in_memory_game_gateway'

describe EnterChoice do

    let(:new_game) {game = Game.new()}
    let(:gateway) { InMemoryGameGateway.new}
     

    it "tests user can enter an integer as their choice" do
        gateway.save_game(new_game)
        player_choice = EnterChoice.new("3", gateway)
        expect(player_choice.input).to eq(2)
    end

    it "tests user choice is valid" do
        gateway.save_game(new_game)              
        invalid_player_choice = EnterChoice.new("10", gateway)
        player_choice = EnterChoice.new("3", gateway)
        expect(invalid_player_choice.valid_input?).to eq(false)
        expect(player_choice.valid_input?).to eq(true)
    end

    it "tests user selects empty square" do
        gateway.save_game(new_game)
        player_choice = EnterChoice.new("7", gateway)
        expect(player_choice.empty_square?).to eq(true)
    end

    it "tests board updates with valid user choice" do
        gateway.save_game(new_game)
        player_choice = EnterChoice.new("3", gateway)
        player_choice.mark_square
        # gateway.save_game(new_game) # save this new_game in the database
        expect(gateway.game.board).to eq(["","","X","","","","","",""])        
    end

    #  TODO - look at return value
    it "tests invalid user choice returns will not mark square" do
        gateway.save_game(new_game)
        invalid_player_choice = EnterChoice.new("10", gateway) 
        expect(invalid_player_choice.mark_square).to eq("Please make a valid selection, 1 - 9")
    end

    it "tests the correct player is selected and tests board updates with second_player's valid choice" do 
        gateway.save_game(new_game)
        player_choice = EnterChoice.new("3", gateway) 
        player_choice.mark_square       
        second_player_choice = EnterChoice.new("5", gateway)
        second_player_choice.mark_square
        expect(player_choice.current_player).to eq("X")
        expect(gateway.game.board).to eq(["","","X","","O","","","",""])
    end

    it "tests board updates with first_player's valid choice" do
        new_game.board = ["","","X","","O","","","",""]
        gateway.save_game(new_game)
        first_player_choice = EnterChoice.new("4", gateway)
        first_player_choice.mark_square
        expect(gateway.game.board).to eq(["","","X","X","O","","","",""])
    end   
end