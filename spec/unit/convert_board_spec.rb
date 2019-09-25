require "game"
require "convert_board"
require 'in_memory_game_gateway'

# describe ConvertBoard do
#     let(:new_game) { Game.new}
#     let(:gateway) { InMemoryGameGateway.new}

#     it "returns empty array when given full board" do
#         new_game.board = ['O','X','X','O','O','X','X','O','X']
#         gateway.save_game(new_game)        
#         expect(ConvertBoard.execute(gateway)).to eq([])
#     end

#     it "converts board with one empty space to tree structure" do
#         new_game.board = ['O','X','X','O','O','X','X','O','']
#         gateway.save_game(new_game)        
#         expect(ConvertBoard.execute(gateway)).to eq([{position: 8, children: [] ,score: -10}])
#     end

#     it "converts board with one empty space to tree structure" do
#         new_game.board = ['X','X','O','O','O','X','X','','O']
#         gateway.save_game(new_game)        
#         expect(ConvertBoard.execute(gateway)).to eq([{position: 7, children: [] ,score: 0}])
#     end

# end