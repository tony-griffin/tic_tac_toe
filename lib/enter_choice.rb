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
         @board[@input] = "X"
        end
    end

end                                                                                                                                                                                                                                                                                                                                                                             