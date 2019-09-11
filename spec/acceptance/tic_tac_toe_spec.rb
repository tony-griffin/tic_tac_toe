# ACCEPTANCE TESTS
require 'game'
require 'enter_choice'
require 'display_board'

describe "tic tac toe" do

    let(:new_game) {game = Game.new()}

    it "tests initial board set up is correct" do 
        expect(new_game.board.length).to eq(9)
        expect(new_game.board.join.empty?).to eq(true)
    end
    
    it "tests player can enter their choice" do
        player_choice = EnterChoice.new("2", new_game)
        player_choice.mark_square
        expect(new_game.board).to eq(["","X","","","","","","",""])
    end

    it "tests that a player can win the game" do
        new_game.board = ["X","X","","","","","O","O",""]
        player_choice = EnterChoice.new("3", new_game)
        expect(player_choice.mark_square).to eq("YOU WON!")
    end

    it "tests that a game can reach a draw" do
        new_game.board = ["X","O","X","O","X","X","O","","O"]
        player_choice = EnterChoice.new("8", new_game)
        expect(player_choice.mark_square).to eq("IT'S A DRAW!")
    end

    xit "tests that user can enter input from CLI" do
        puts "\nPlease choose a square"
        cli_input = gets.chomp # Assuming you enter 2
        player_choice = EnterChoice.new(cli_input, new_game)
        player_choice.mark_square
        expect(new_game.board).to eq(["","X","","","","","","",""])
    end

    xit "tests game can be played till outcome" do
        expect(play_game.outcome)
        .to eq("YOU WON!")
        .or eq("IT'S A DRAW!")
    end

    it "tests that board displays correctly" do
        displayed_board = DisplayBoard.new
        expect(displayed_board.display_board(new_game)).to eq(
            " #{new_game.board[0]} | #{new_game.board[1]} | #{new_game.board[2]} \n" +
            "-----------\n " +
            " #{new_game.board[3]} | #{new_game.board[4]} | #{new_game.board[5]} \n" +
            "-----------\n" +
            " #{new_game.board[6]} | #{new_game.board[7]} | #{new_game.board[8]} "
        )
    end
end
