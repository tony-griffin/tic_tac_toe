class ConvertBoard

    def self.execute(gateway)
        board = gateway.game.board
       if board.any?("")
        return [{position: 8, children: [] ,score: -10}]
       end
        []
    end
end