require './in_memory_game_gateway'
require './display_board'
require './game'
require './check_game_status'
require './enter_choice'

gateway = InMemoryGameGateway.new
game = Game.new
game.board = ['O','','X','X','','','X','O','O']
gateway.save_game(game)

class Minimax
    attr_accessor :hash
    def initialize(gateway)
        @gateway = gateway
        @game = gateway.game
        @current_board = @game.board
        @current_status = CheckGameStatus.new(gateway)
        @possible_moves_max1 = []
        @hash = {}
    end
    # Make sure board isn't full, gets possible moves
    def get_free_squares(arr)
        unless @current_status.full?
            @current_board.each_index.select { |i| @current_board[i] == ''}
        end
    end
    def run
        do_possible_moves(get_free_squares(@possible_moves_max1),0)
    end
    # Iterate through each move? Then call minimax recursively on each move?
    def do_possible_moves(arr, count)
        count += 1 # Odd = Min, Even = Max
        arr.each do |square|
            hypothetical_game = Game.new
            hypothetical_game.board = @current_board.dup # Creating a fake game with same board
            move = EnterChoice.new((square+1).to_s, hypothetical_game)
            move.mark_square
            
            hypothetical_gateway = InMemoryGameGateway.new
            hypothetical_gateway.save_game(hypothetical_game)

            #Check for wins
            new_possible_status = CheckGameStatus.new(hypothetical_gateway)
            
            # if not
            moves_copy = arr.dup
            unless new_possible_status.has_won?
                moves_copy.delete(square)
                c = arr.length - moves_copy.length
                puts 'left:', moves_copy, 'how deep', count
                #@hash[:count] = moves_copy
                do_possible_moves(moves_copy,c)
                
            end
            #@possible_moves_max1[@possible_moves_max1.index(square)] = new_possible_status.has_won? ? 1 : -1
        
        
        end
        #puts @possible_moves_max1
    end
end

minimax = Minimax.new(gateway)
minimax.run
puts minimax.hash
