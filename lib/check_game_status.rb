class CheckGameStatus
    def initialize(game)
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
     
    def has_won?
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
        turn_count == 9
    end

    def over?
        has_won? || full?
    end

    def draw?
        !has_won? && full?
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

    # def current_player
    #     turn_count % 2 == 0 ? 'X' : 'O'
    # end

end