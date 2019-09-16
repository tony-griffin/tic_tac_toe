require 'get_cli_input'
require 'in_memory_game_gateway'



describe GetCliInput do
    let(:gateway) { InMemoryGameGateway.new}
    let(:new_game) {game = Game.new()}

    it "tests that user can enter input from CLI" do
        gateway.save_game(new_game)
        cli_input = GetCliInput.new.execute # Assuming you enter 2
        player_choice = EnterChoice.new(cli_input, gateway)
        player_choice.mark_square
        expect(gateway.game.board).to eq(["","X","","","","","","",""])
    end
end