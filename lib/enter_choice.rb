class EnterChoice
    attr_reader :input
    def initialize(input, game) #game_gateway
        @input = input.to_i - 1
        @game = game  #game_gateway.game
        @board = game.board  #game_gateway.game.board
    end

    WIN_COMBINATIONS = {
        1 => [1,2,3],
        2 => [4,5,6],
        3 => [7,8,9],
        4 => [1,4,7],
        5 => [2,5,8],
        6 => [3,6,9],
        7 => [1,5,9],
        8 => [3,5,7]
     }
     
    # safe 
    def empty_square?
     @board[@input] == "" || @board[@input] == " " ||  @board[@input] == nil   
    end

    # safe     
    def valid_input?
        @input >= 0 && @input <= 8 && empty_square?                                                            
    end
    
    # safe / refactor    
    def mark_square
        if valid_input?
            @board[@input] = current_player
            # if has_Won?
            #     #@finished = true
            #     #@game.over?
            #     puts "YOU WON!"
            #     return "YOU WON!"
            # elsif full?
            #     #@finished = true
            #     puts "IT'S A DRAW!"
            #     return "IT'S A DRAW!" 
            # end
        else
            #puts "Please make a valid selection, 1 - 9"
           return "Please make a valid selection, 1 - 9"
        end
    end

    def turn_count
        counter = 0
        @board.each do |turn|
            if turn == "X" || turn == "O"
                counter += 1
            end
        end
            counter
    end

    def current_player
        turn_count % 2 == 0 ? 'X' : 'O'
    end

end                                                                                                                                                                                                                                                                                                                                                                             