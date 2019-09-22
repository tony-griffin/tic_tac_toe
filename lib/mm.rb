require './in_memory_game_gateway'
require './display_board'
require './game'
require './check_game_status'
require './enter_choice'

# gateway = InMemoryGameGateway.new
# game = Game.new
# # game.board = ['X','','','O','','','O','X','X']
# #  game.board = ['O','','X','X','','','X','O','O']
#  game.board = ['X','','','','','','','','']

# gateway.save_game(game)

class Minimax
    def initialize(gateway)
        @actual_gateway = gateway
        @actual_game = gateway.game
        @actual_board = gateway.game.board
    end

    def run
        scores = max(@actual_board, 0, {}, '')
        if beginning_of_game?
            empty_squares = get_available_squares(@actual_board)
            if empty_squares.any?(4)
                return 4
            end
            return empty_squares[0]
        end
        empty_squares = get_available_squares(@actual_board)
        something(scores)
    end

    def get_available_squares(board)
        board.each_index.select { |i| board[i].class == Integer }
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

    def beginning_of_game?
        check = CheckGameStatus.new(@actual_gateway)
        check.turn_count < 3
    end

    def max(board, depth, scores, key)
        depth += 1
        hyp_gateway = InMemoryGameGateway.new
        hyp_game = Game.new
        hyp_game.board = board.dup
        starting_board = board.dup
        hyp_gateway.save_game(hyp_game)
        empty_squares = get_available_squares(hyp_game.board)
        if scores[depth] == nil
            scores[depth] = {}
        end
        empty_squares.each do |square|
            starting_key = key.dup
            mark_square(square, hyp_gateway)
            key << square.to_s
            if win?(hyp_gateway)
                if (depth % 2 == 0)
                    scores[depth][key] = -100
                else 
                    scores[depth][key] = 100
                end
            else
                scores[depth][key] = 0
                max(hyp_game.board, depth, scores, key)
            end
            clear_board(hyp_game, starting_board)
            key = starting_key
        end
        scores
    end
    
    def something(scores)
        scores[1].each do |key, value|
            if value == 100
                return key
            end
        end
        arr = (1..scores.length).to_a.reverse
        arr.each do |i|
            # Bottom layer
            if i == arr[0]
                scores[i].each do |key,value|
                    daddy_key = key[0...-1]
                    if (i % 2 ==0)
                        value -= i
                    else
                       value += i 
                    end
                    scores[i-1][daddy_key] -= value
                end
                scores.delete(i)
            elsif (i % 2 == 0) 
                #MIN
                hash = {}
                scores[i].each do |key, value|
                    daddy_key = key[0...-1]
                    if hash[daddy_key] == nil
                        hash[daddy_key] = []
                    end
                    value += i
                    hash[daddy_key] << value
                end
                
                hash.each do |key, value|
                    scores[i-1][key] = value.min
                end
                scores.delete(i)
            elsif i > 1
                #MAX
                hash = {}
                scores[i].each do |key, value|
                    daddy_key = key[0...-1]
                    if hash[daddy_key] == nil
                        hash[daddy_key] = []
                    end
                    value -= i
                    hash[daddy_key] << value
                end
                
                hash.each do |key, value|
                    scores[i-1][key] = value.max
                end
                scores.delete(i)
            else
                #TOP LEVEL - MAX
                score = -10
                pos = nil
                scores[i].each do |key,value|
                    if value > score
                        pos = key
                    end
                end
                #TODO sort out str and ints
                return pos
            end
        end
    end
end

# minimax = Minimax.new(gateway)
# pp minimax.run