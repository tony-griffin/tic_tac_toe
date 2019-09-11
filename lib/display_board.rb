# UI CLASS ?

class DisplayBoard
    def initialize(game_gateway)
        @game_gateway = game_gateway
    end

    def execute(_request)
        board = @game_gateway.game.board

        display =   " #{board[0]} | #{board[1]} | #{board[2]} \n" +
                    "-----------\n " +
                    " #{board[3]} | #{board[4]} | #{board[5]} \n" +
                    "-----------\n" +
                    " #{board[6]} | #{board[7]} | #{board[8]} "
        
        #{ display: display}
    end
end
