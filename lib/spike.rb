require "./game.rb"
require "./enter_choice.rb"
require "./display_board.rb"
require "./check_game_status.rb"
require "./in_memory_game_gateway.rb"
require "./get_cli_input.rb"

gateway = InMemoryGameGateway.new
game = Game.new
gateway.save_game(game)
display_board = DisplayBoard.new(gateway) 
puts display_board.execute({})
check_status = CheckGameStatus.new(gateway)

while check_status.over? == false do
    cli_input = GetCliInput.new(gateway)
    player_choice = EnterChoice.new(cli_input.execute, gateway)
    player_choice.mark_square
    display_board = DisplayBoard.new(gateway) 
    puts display_board.execute({})
end

if check_status.has_won?
    puts "YOU WON!"
elsif check_status.draw?
    "IT'S A DRAW!"
end
