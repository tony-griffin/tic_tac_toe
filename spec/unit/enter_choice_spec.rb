# UNIT TESTS
require 'enter_choice'
require 'game'

describe EnterChoice do
    class DatabaseGateway
        def initialize
            @board = nil
        end

        def save(game)
            @game = game
        end

        def retrieve_game
            @game
        end
    end

    gateway = DatabaseGateway.new
    let(:new_game) {game = Game.new()}

    it "tests user can enter an integer" do
        player_choice = EnterChoice.new("3", new_game)
        expect(player_choice.input).to eq(2)
    end

    it "tests user choice is valid" do
        invalid_player_choice = EnterChoice.new("10", new_game)
        player_choice = EnterChoice.new("3", new_game)
        expect(invalid_player_choice.valid_input?).to eq(false)
        expect(player_choice.valid_input?).to eq(true)
    end

    it "tests user selects empty square" do
        player_choice = EnterChoice.new("7", new_game)
        expect(player_choice.empty_square?).to eq(true)
    end

    it "tests board updates with valid user choice" do
        player_choice = EnterChoice.new("3", new_game)
        player_choice.mark_square
        gateway.save(new_game) # save this new_game in the database
        expect(gateway.retrieve_game.board).to eq(["","","X","","","","","",""])        
    end

    it "tests invalid user choice returns error message" do
        invalid_player_choice = EnterChoice.new("10", new_game) 
        expect(invalid_player_choice.mark_square).to eq("Please make a valid selection")
    end

    it "tests board updates with second_player's valid choice" do
        second_player_choice = EnterChoice.new("5", gateway.retrieve_game)
        second_player_choice.mark_square
        expect(gateway.retrieve_game.board).to eq(["","","X","","O","","","",""])
    end

    it "tests board updates with first_player's valid choice" do
        first_player_choice = EnterChoice.new("4", gateway.retrieve_game)
        first_player_choice.mark_square
        expect(gateway.retrieve_game.board).to eq(["","","X","X","O","","","",""])
    end

    it "tests that a player can win the game" do
        new_game.board = ["X","X","","","","","O","O",""]
        player_choice = EnterChoice.new("3", new_game)
        #player_choice.mark_square
        #expect(new_game.board).to eq(["X","X","X","","","","O","O",""])
        expect(player_choice.mark_square).to eq("YOU WON!")
        #puts new_game.board, new_game.finished
        #expect(new_game.finished).to eq(true)
    end

    it "tests that a game can reach a draw" do
        new_game.board = ["X","O","X","O","X","X","O","","O"]
        player_choice = EnterChoice.new("8", new_game)
        expect(player_choice.mark_square).to eq("IT'S A DRAW!")
    end

    xit "tests that user can enter valid input from CLI" do
        puts "Please choose a square"
        cli_input = gets.chomp # Assuming you enter 2
        player_choice = EnterChoice.new(cli_input, new_game)
        player_choice.mark_square
        expect(new_game.board).to eq(["","X","","","","","","",""])
    end

    xit "tests that user can enter other valid input from CLI" do
        puts "Please choose a square"
        cli_input = gets.chomp # Assuming you enter 5
        player_choice = EnterChoice.new(cli_input, new_game)
        player_choice.mark_square
        expect(new_game.board).to eq(["","","","","X","","","",""])
    end

    xit "tests that user can enter other valid input from CLI" do
        puts "Please choose a square"
        cli_input = gets.chomp # Assuming you enter 9
        player_choice = EnterChoice.new(cli_input, new_game)
        player_choice.mark_square
        expect(new_game.board).to eq(["","","","","","","","","X"])
    end

    xit "tests that user can enter invalid input from CLI" do
        puts "Please choose a square"
        cli_input = gets.chomp # Assuming you enter invalid input
        player_choice = EnterChoice.new(cli_input, new_game)
        expect(player_choice.mark_square).to eq("Please make a valid selection")
    end
end