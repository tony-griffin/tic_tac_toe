class InMemoryGameGateway
    attr_reader :game
    
    def initialize
      @game = []
    end

    def save_game(game)
      @game = game
    end

end