class Game # Our Domain Object?
    attr_accessor :board
    def initialize
        @board = (1..9).to_a
    end
end