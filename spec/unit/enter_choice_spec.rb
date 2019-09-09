# UNIT TESTS
require 'enter_choice'
require 'create_game'

describe EnterChoice do
    class Gateway
        # def initialize(game)
        #     @board = game.board
        # end

        def save(board)
            @board = board
        end

        def view_board
            @board
        end

    end
    game = CreateGame.new()

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
        gateway = Gateway.new
        player_choice = EnterChoice.new("3", game)
        player_choice.mark_square
        gateway.save(game.board)
        expect(game.board).to eq(gateway.view_board)        
    end

    it "tests invalid user choice returns false" do
        invalid_player_choice = EnterChoice.new("10", game)
        invalid_player_choice.mark_square
        expect(game.board)
    end

end