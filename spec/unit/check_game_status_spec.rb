require "check_game_status"
require "game"
require 'in_memory_game_gateway'

describe CheckGameStatus do
    let(:new_game) { Game.new }
    let(:gateway) { InMemoryGameGateway.new}

    it "tests no one has won a new game" do
        gateway.save_game(new_game)                
        game_status = CheckGameStatus.new(gateway)
        expect(game_status.has_won?).to eq(false)
    end

    it "tests that it counts number of turns correctly" do
        new_game.board = ["X","O","X","O","X","X","O","","O"] 
        gateway.save_game(new_game)                
        game_status = CheckGameStatus.new(gateway)
        expect(game_status.turn_count).to eq(8)  
    end

    # xit "tests the correct player is selected" do 
    #     game_status = CheckGameStatus.new(new_game)
    #     expect(game_status.current_player).to eq("X")
    # end

    it "tests that the board is full without a winner" do
        new_game.board = ["X","O","X","O","X","X","O","X","O"]
        gateway.save_game(new_game)                
        game_status = CheckGameStatus.new(gateway)
        expect(game_status.full?).to eq(true)
    end

    it "tests that game has been won, so ended and not full" do
        new_game.board = ["X","X","X","","","","O","O",""]
        gateway.save_game(new_game)
        game_status = CheckGameStatus.new(gateway)
        expect(game_status.has_won?).to eq(true)
    end

    it "tests that the game has been drawn" do
        new_game.board = ["X","O","X","O","X","X","O","X","O"]
        gateway.save_game(new_game)        
        game_status = CheckGameStatus.new(gateway)
        expect(game_status.draw?).to eq(true)
    end

end