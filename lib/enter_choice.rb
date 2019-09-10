class EnterChoice
    attr_reader :input
    def initialize(input, game)
        @input = input.to_i - 1
        @board = game.board
    end

    def empty_square?
     @board[@input] == "" || @board[@input] == " " ||  @board[@input] == nil   
    end

    def valid_input?
        @input >= 0 && @input <= 8 && empty_square?                                                            
    end
    

    def mark_square
        if valid_input?
            @board[@input] = current_player(@board)
        else
           return "Please make a valid selection"
        end
    end

    def turn_count(board)
        counter = 0
        board.each do |turn|
            if turn == "X" || turn == "O"
                counter += 1
            end
        end
            counter
    end

    def current_player(board)
        turn_count(board) % 2 == 0 ? 'X' : 'O'
    end

end                                                                                                                                                                                                                                                                                                                                                                             