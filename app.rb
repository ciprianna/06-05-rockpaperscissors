# Rock Paper Scissors
require './game.rb'


# This section gets inputs from the user and stores them as player1 and player2.
puts "Let's play Rock-Paper-Scissors."
puts "\n"
puts "Who's player 1?"
name_one = gets.chomp.capitalize
puts "And who is #{name_one} playing against? Or type 'computer' if you'd like to play against the machine."
name_two = gets.chomp.capitalize

# Gets the number of rounds the users wish to play.
puts "How many rounds would you like to play?"
rounds = gets.to_f

puts "Note that you can either play traditional Rock, Paper, Scissors, or you can play Rock, Paper, Scissors, Lizard, Spock!"
puts " Type 'spock' to play, or type anything else to play the traditional game."
spock = gets.chomp.downcase

puts "#{name_one}, make your move!"
weapon_one = gets.chomp.downcase

# Uses an if-else statement to determine if the game is being played against the
#   computer or not. If so, all arguments are passed except weapon_two.
# If against a second player, it gets the second player's weapon and creates the
#   new game object passing all arguments.
if name_two == "Computer"
  game = Game.new(name_one: name_one, name_two: name_two, weapon_one: weapon_one, rounds: rounds, spock: spock)
else
  puts "#{name_two}, your turn."
  weapon_two = gets.chomp.downcase
  game = Game.new(name_one: name_one, name_two: name_two, weapon_one: weapon_one, weapon_two: weapon_two, rounds: rounds, spock: spock)
end
