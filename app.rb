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

if player_one.weapon == player_two.weapon
  puts "Tie game!"
  while (player_one.score <= best_of) && (player_two.score <= best_of)
    puts "No winner yet. On to the next round!"
    puts "#{player_one.name}, make your move!"
  end
elsif (choices[player_one.weapon][0] == player_two.weapon) || choices[player_one.weapon][1] == player_two.weapon
   puts "#{player_one.name} wins this round!"
   while (player_one.score <= best_of) && (player_two.score <= best_of)
     puts "No winner yet. On to the next round!"
     puts "#{player_one.name}, make your move!"
   end
else
  puts "#{player_two.name} wins this round!"
  while (player_one.score <= best_of) && (player_two.score <= best_of)
    puts "No winner yet. On to the next round!"
    puts "#{player_one.name}, make your move!"
  end
end

if player_two.name != "Computer"
  while (player_one.score <= best_of) && (player_two.score <= best_of)
    puts "No winner yet. On to the next round!"
    puts "#{player_two.name}, your turn!"
  end
end

if game.player_one.score >= (game.best_of)
  puts "#{game.player_one.name} wins the game!"
elsif game.player_two.score >= (game.best_of)
  puts "#{game.player_two.name} wins the game!"
else
end

if spock != "spock"
  while game.traditional_choices.include?(game.player_one.weapon) == false
    puts "#{game.player_one.name}, only choose 'rock', 'paper', or 'scissors'."
  end
  while game.traditional_choices.include?(game.player_two.weapon) ==
    puts "#{game.player_two.name}, only choose 'rock', 'paper', or 'scissors'."
  end
else
  while spock_choices.include?(game.player_one.weapon) == false
    puts "#{game.player_one.name}, only choose 'rock', 'paper', 'scissors', 'lizard', or 'spock'."
  end
  while spock_choices.include?(game.player_two.weapon) == false
    puts "#{game.player_two.name}, only choose 'rock', 'paper', 'scissors', 'lizard', or 'spock'."
  end
end
