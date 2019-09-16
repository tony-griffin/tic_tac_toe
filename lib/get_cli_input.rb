require 'enter_choice'
require 'in_memory_game_gateway'

class GetCliInput
    def initialize(gateway)
        @gateway = gateway
    end

    def execute
        input = ''
        while EnterChoice.new(input, @gateway).valid_input? == false
            puts "\nPlease choose a square (1-9)"
            input = gets.chomp
        end
        input
    end
    
end