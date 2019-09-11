class Game # Our Domain Object?
    attr_accessor :board
    def initialize
        @board = [""]*9
    end
end