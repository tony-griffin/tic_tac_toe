require 'get_cli_input'
require 'in_memory_game_gateway'



describe GetCliInput do
    let(:gateway) { InMemoryGameGateway.new}
    let(:new_game) {game = Game.new()}

    xit "tests that user can enter input from CLI" do
        gateway.save_game(new_game)
        cli_input = GetCliInput.new(gateway) # Assuming you enter 2
        player_choice = EnterChoice.new(cli_input.execute, gateway)
        player_choice.mark_square
        expect(gateway.game.board).to eq(["","X","","","","","","",""])
    end

    xit "tests that user can enter input from CLI" do
        gateway.save_game(new_game)
        cli_input = GetCliInput.new(gateway) # Assuming you enter 5
        player_choice = EnterChoice.new(cli_input.execute, gateway)
        player_choice.mark_square
        expect(gateway.game.board).to eq(["","","","","X","","","",""])
    end

  xit "tests that user can enter input from CLI" do
        gateway.save_game(new_game)
        cli_input = GetCliInput.new(gateway) # Assuming you enter 9
        player_choice = EnterChoice.new(cli_input.execute, gateway)
        player_choice.mark_square
        expect(gateway.game.board).to eq(["","","","","","","","","X"])
    end

    xit "tests that user cannot enter invalid input from CLI" do
        gateway.save_game(new_game)        
        cli_input = GetCliInput.new(gateway) # Assuming you enter invalid input
        player_choice = EnterChoice.new(cli_input.execute, gateway)
        expect(player_choice.valid_input?).to eq(true)
    end

end