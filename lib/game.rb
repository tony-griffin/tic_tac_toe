class Game
    attr_accessor :board, :finished
    def initialize
        @board = [""]*9
    end

    def display_board(board)
        puts " #{board[0]} | #{board[1]} | #{board[2]} "
        puts "-----------"
        puts " #{board[3]} | #{board[4]} | #{board[5]} "
        puts "-----------"
        puts " #{board[6]} | #{board[7]} | #{board[8]} "
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

    def turn_count(board)
        counter = 0
        board.each do |turn|
            if turn == "X" || turn == "O"
                counter += 1
            end
        end
            counter
    end

    def full?
        turn_count(@board) == 9
    end

    def over?
        #puts 'HELLO'
        has_Won? || full?
    end

end