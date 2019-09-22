require './in_memory_game_gateway'
require './display_board'
require './game'
require './check_game_status'
require './enter_choice'

gateway = InMemoryGameGateway.new
game = Game.new
game.board = ['X','','','O','','','O','X','X']
# game.board = ['O','','X','X','','','X','O','O']

gateway.save_game(game)

class Minimax
    def initialize(gateway)
        @actual_gateway = gateway
        @actual_game = gateway.game
        @actual_board = gateway.game.board
    end

    def run
        scores = max(@actual_board, 0, {})
        pp something(scores)
    end

    def get_available_squares(board)
        board.each_index.select { |i| board[i] == ''}
    end

    def mark_square(square, gateway)
        choice = EnterChoice.new(square+1,gateway)
        choice.mark_square
    end

    def win?(gateway)
        check = CheckGameStatus.new(gateway)
        check.has_won?
    end

    def clear_board(game,clean_board)
        game.board = clean_board.dup
    end
    #TODO
    def create_fake_game
    end

    def max(board, depth, scores)
        depth += 1
        hyp_gateway = InMemoryGameGateway.new
        hyp_game = Game.new
        hyp_game.board = board.dup
        starting_board = board.dup
        hyp_gateway.save_game(hyp_game)
        empty_squares = get_available_squares(hyp_game.board)
        scores[depth] = {}
        empty_squares.each do |square|
            mark_square(square, hyp_gateway)
            if win?(hyp_gateway)
                if (depth % 2 == 0)
                    scores[depth][square] = -1
                else 
                    scores[depth][square] = 1
                end
            else
                scores[depth][square] = 0
                max(hyp_game.board, depth, scores)
            end
            clear_board(hyp_game, starting_board)
        end
        scores
    end

    def something(scores)
        arr = (1..scores.length).to_a.reverse
        arr.each do |i|
            # if (i % 2 == 0) 
            #     # MIN
            # else #MAX
                
            # end
            pp scores[i]
            # if scores[i].key(1)
            #     return scores[i].key(1)
            # end
        end
    end

    def something_else(hash)
        
    end
    

end

minimax = Minimax.new(gateway)
minimax.run