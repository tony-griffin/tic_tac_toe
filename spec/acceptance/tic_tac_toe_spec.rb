# ACCEPTANCE TESTS
require 'game'
require 'enter_choice'
require 'display_board'
require 'check_game_status'
require 'tic_tac_toe'
require 'in_memory_game_gateway'
require 'get_cli_input'


describe "tic tac toe" do

    let(:new_game) {Game.new}
    let(:gateway) { InMemoryGameGateway.new}


    it "tests initial board set up is correct" do 
        expect(new_game.board.length).to eq(9)
        expect(new_game.board.join.empty?).to eq(true)
    end

    it "tests that board displays correctly" do
        gateway.save_game(new_game)
        displayed_board = DisplayBoard.new(gateway)
        expect(displayed_board.execute(new_game)).to eq(
            " #{new_game.board[0]} | #{new_game.board[1]} | #{new_game.board[2]} \n" +
            "-----------\n " +
            " #{new_game.board[3]} | #{new_game.board[4]} | #{new_game.board[5]} \n" +
            "-----------\n" +
            " #{new_game.board[6]} | #{new_game.board[7]} | #{new_game.board[8]} "
        )
    end
    
    it "tests player can enter their choice" do
        gateway.save_game(new_game)
        player_choice = EnterChoice.new("2", gateway)
        player_choice.mark_square
        expect(gateway.game.board).to eq(["","X","","","","","","",""])
    end

    it "tests no one has won a new game" do
        gateway.save_game(new_game)                
        game_status = CheckGameStatus.new(gateway)
        expect(game_status.has_won?).to eq(false)
    end

    it "tests that a player has won the game" do 
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

    xit "tests that user can enter input from CLI" do
        gateway.save_game(new_game)
        cli_input = GetCliInput.new(gateway) # Assuming you enter 2
        player_choice = EnterChoice.new(cli_input.execute, gateway)
        player_choice.mark_square
        expect(gateway.game.board).to eq(["","X","","","","","","",""])
    end
    # TODO - ask Craig
    # it "tests that AI can calculate a move" do
    #     expect(play_game.outcome)
    #     .to eq("YOU WON!")
    #     .or eq("IT'S A DRAW!")
    # end
    
end
