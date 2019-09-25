require "./game.rb"
require "./enter_choice.rb"
require "./display_board.rb"
require "./check_game_status.rb"
require "./in_memory_game_gateway.rb"
require "./get_cli_input.rb"
require "./minimax_too.rb"

gateway = InMemoryGameGateway.new
game = Game.new
# game.board = ['O','X','X','O','O','X','X','','']
# game.board = ['X','','O','O','','X','X','','']
gateway.save_game(game)
display_board = DisplayBoard.new(gateway) 
puts display_board.execute({})
check_status = CheckGameStatus.new(gateway)


class MakeTree

    def self.make_tree_from_board(board)
        full_tree = []
        empty_square_array = get_empty_squares(board)
        empty_square_array.each do |empty_square|
            node = {position: empty_square, children: [] ,score: 0}

            fake_gateway = InMemoryGameGateway.new
            fake_game = Game.new
            fake_game.board = board.dup
            fake_gateway.save_game(fake_game)

            fake_choice = EnterChoice.new(empty_square + 1,fake_gateway)
            fake_choice.mark_square

            check_win_status = CheckGameStatus.new(fake_gateway)
            if check_win_status.has_won? && check_win_status.last_player_ai?
                node[:score] = 10
            elsif check_win_status.has_won? && !check_win_status.last_player_ai?
                node[:score] = -10
            else
                node[:children] = make_tree_from_board(fake_game.board) # Check with Craig?? :D
            end
            full_tree << node
        end
        full_tree
    end

    def self.get_empty_squares(board)
        board.each_index.select { |square| board[square] == ''}
    end

end

# tree = MakeTree.make_tree_from_board(gateway.game.board)
# pp tree
# pp Minimax.best_move(tree)

def get_ai_choice(gateway)
    tree = MakeTree.make_tree_from_board(gateway.game.board)
    Minimax.best_move(tree)
end

while check_status.over? == false do
    cli_input = GetCliInput.new(gateway)
    player_choice = EnterChoice.new(cli_input.execute, gateway)
    player_choice.mark_square
    ai_input = get_ai_choice(gateway)
    ai_choice = EnterChoice.new(ai_input + 1, gateway)
    ai_choice.mark_square
    display_board = DisplayBoard.new(gateway) 
    puts display_board.execute({})
end

if check_status.has_won?
    puts "YOU WON!"
elsif check_status.draw?
    "IT'S A DRAW!"
end