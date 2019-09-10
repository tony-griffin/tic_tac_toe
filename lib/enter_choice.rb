class EnterChoice
    attr_reader :input
    def initialize(input, game)
        @input = input.to_i - 1
        @board = game.board
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

    def empty_square?
     @board[@input] == "" || @board[@input] == " " ||  @board[@input] == nil   
    end

    def valid_input?
        @input >= 0 && @input <= 8 && empty_square?                                                            
    end
    

    def mark_square
        if valid_input?
            @board[@input] = current_player(@board)
            if has_Won?
                puts "YOU WON!"
                return "YOU WON!"
            elsif full?
                puts "IT'S A DRAW!"
                return "IT'S A DRAW!"
            end
        else
            puts "Please make a valid selection"
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

    def has_Won?
        WIN_COMBINATIONS.each do |key, value|
            marks = []
            value.each do |n| # n = index + 1
                marks << @board[n-1]
            end
            if marks.uniq.length == 1 && !marks.join.empty?
                return true
            end
        end
        false
    end

    def full?
       turn_count(@board) == 9
    end

end                                                                                                                                                                                                                                                                                                                                                                             