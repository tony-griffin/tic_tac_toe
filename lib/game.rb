class Game
    attr_accessor :board, :finished
    def initialize
        @board = [""]*9
        @finished = false
    end

    def display_board(board)
        puts " #{board[0]} | #{board[1]} | #{board[2]} "
        puts "-----------"
        puts " #{board[3]} | #{board[4]} | #{board[5]} "
        puts "-----------"
        puts " #{board[6]} | #{board[7]} | #{board[8]} "
    end

    # WIN_COMBINATIONS = {
    #    1 => [1,2,3],
    #    2 => [4,5,6],
    #    3 => [7,8,9],
    #    4 => [1,4,7],
    #    5 => [2,5,8],
    #    6 => [3,6,9],
    #    7 => [1,5,9],
    #    8 => [3,5,7]
    # }

end