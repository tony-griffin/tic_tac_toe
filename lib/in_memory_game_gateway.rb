class InMemoryGameGateway
    attr_accessor :game
    
    def initialize
      @game = []
    end

    def save_game(game)
      @game = game
    end

    # def  retrieve_game
    #   @game
    # end
end