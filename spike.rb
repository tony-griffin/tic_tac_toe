require "./lib/game.rb"
require "./lib/enter_choice.rb"

new_game = Game.new()
puts new_game.display_board(new_game.board)

while new_game.over? == false do
    puts "Choose a square"
    move = EnterChoice.new(gets.chomp,new_game)
    move.mark_square
    puts new_game.display_board(new_game.board)
end

# puts "Choose a square"
# first_move = EnterChoice.new(gets.chomp,new_game)
# first_move.mark_square


# puts "Choose a square"
# second_move = EnterChoice.new(gets.chomp,new_game)
# second_move.mark_square


# it "tests game can be played till outcome" do
#     expect(play_game.outcome)
#     .to eq("YOU WON!")
#     .or eq("IT'S A DRAW!")
# end