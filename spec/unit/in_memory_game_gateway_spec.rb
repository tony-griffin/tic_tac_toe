require 'in_memory_game_gateway'
require 'game'

describe InMemoryGameGateway do
    let(:gateway) { described_class.new }

    it "tests that it can retrieve no game" do
    expect(gateway.game).to eq([])
    end

    it "tests that it can retrieve one game" do
    gateway.save_game(Game.new)
    expect(gateway.game.board).to eq(["","","","","","","","",""])
    end

end