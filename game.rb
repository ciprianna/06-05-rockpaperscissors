# Game Class
require "./player.rb"
require "./computer_player.rb"

class Game

  attr_accessor :best_of, :choices, :player_one, :player_two, :rounds, :name_two, :weapon_two, :spock, :traditional_choices, :spock_choices

  # The initialize method takes in five optional attributes from the user. It
  #   first creates an empty hash, then sets optional arguments to be passed.
  #   It then merges the options hash with the args hash, so that the user
  #   inputs can be passed.
  #
  # name_one - string
  # name_two - string
  # weapon_one - string
  # weapon_two - string
  # rounds - integer
  # spock - string
  #
  # Creates the choices hash, with a weapon selection as the key and the losing
  #   corresponding weapon as its value.
  # Creates choices for either traditional rps or lizard-spock as arrays.
  # Runs five methods when the game is started.
  def initialize(args = {})
    options = {name_one: "", name_two: "", weapon_one: "", weapon_two: "", rounds: 1, spock: ""}
    args = options.merge(args)
    @choices = {"rock" => ["scissors", "lizard"], "paper" => ["rock", "spock"], "scissors" => ["paper", "lizard"], "lizard" => ["spock", "paper"], "spock" => ["rock", "scissors"]}
    @traditional_choices = ["rock", "paper", "scissors"]
    @spock_choices = ["rock", "paper", "scissors", "lizard", "spock"]
    @rounds = args[:rounds]
    @name_two = args[:name_two]
    @weapon_two = args[:weapon_two]
    @spock = args[:spock]
    determine_best_of(args[:rounds])
    create_player_one(args[:name_one], args[:weapon_one])
    assign_player_two_robot_or_human
    use_spock_check_one
    determine_game_end
  end

  # This method creates a new player object in the Player class and stores it as
  #   an instance variable called player_one.
  def create_player_one(name, weapon)
    @player_one = Player.new(name, weapon)
  end

  # This method creates a new player object in the Player class and stores it as
  #   an instance variable for player_two
  def create_player_two(name, weapon)
    @player_two = Player.new(name, weapon)
  end

  # Determines who wins the game.
  #
  # Uses if-else statements to check if the two choices are the same. If so,
  #   the game prints results of the round.
  # Checks to see if weapon_one is a key in the
  #   choices hash that matches the value of weapon_two. If it matches the hash,
  #   then that means name_one wins the game. Puts the results.
  # Adds one to the score attribute of the winner.
  def check_who_wins
    if player_one.weapon == player_two.weapon
      puts "Tie game!"
    elsif (choices[player_one.weapon][0] == player_two.weapon) || choices[player_one.weapon][1] == player_two.weapon
  	   puts "#{player_one.name} wins this round!"
       player_one.score_update
    else
      puts "#{player_two.name} wins this round!"
      player_two.score_update
    end
  end

  # Determines how many matches a player must win.
  #
  # rounds - integer input by the user
  #
  # Creates the best_of attribute by taking rounds divided by two
  def determine_best_of(rounds)
    @best_of = rounds / 2
  end

  # Continually runs the game until a single player wins the majority of rounds.
  #
  # First runs the check_who_wins for the initial player inputs.
  # While the scores for player_one and player_two are both less than the
  #   best_of float, this method calls three other methods.
  def determine_game_end
    check_who_wins
    while (player_one.score <= best_of) && (player_two.score <= best_of)
      redefine_player_weapons
      check_who_wins
      announce_winner
    end
  end

  # This method asks each player for their new weapon choices for the next round
  #   and redefines the weapon attributes for player_one. It then runs the
  #   valid_input_check_one and the redefine_player_two_weapon methods.
  def redefine_player_weapons
    puts "No winner yet. On to the next round!"
    puts "#{player_one.name}, make your move!"
    player_one.weapon = gets.chomp.downcase
    use_spock_check_one
    redefine_player_two_weapon
  end

  # Checks if the computer is playing, and if so, redefines the computer's
  #   weapon attribute using the ComputerPlayer's sample_weapon_choice method.
  # If a human player exists, it asks the player for their choice and redefines
  #   player_two's weapon attribute.
  def redefine_player_two_weapon
    if player_two.name == "Computer"
      player_two.weapon = player_two.sample_weapon_choice
      puts "The computer chooses #{player_two.weapon}."
    else
      puts "#{player_two.name}, your turn."
      player_two.weapon = gets.chomp.downcase
      use_spock_check_two
    end
  end

  # An if statement used to check the score attributes of both players.
  #   If one of those values is greater than or equal to the best_of float, a
  #   winning statement is given and the loop ends.
  def announce_winner
    if player_one.score >= (best_of)
      puts "#{player_one.name} wins the game!"
    elsif player_two.score >= (best_of)
      puts "#{player_two.name} wins the game!"
    else
    end
  end

  # Checks to see if the weapon choice is a valid input: either rock, paper,
  #   or scissors.
  #
  # While loop runs until a valid input is given. Each time an invalid input is
  #   given, it tells the user the options and asks them to redefine their
  #   choice and reassigns the weapon_one instance variable as the new value.
  #
  def valid_input_check_one
    while traditional_choices.include?(player_one.weapon) == false
      puts "#{player_one.name}, only choose 'rock', 'paper', or 'scissors'."
      player_one.weapon = gets.chomp.downcase
    end
  end

  # Checks to see if the weapon choice is a valid input: either rock, paper,
  #   or scissors.
  #
  # While loop runs until a valid input is given. Each time an invalid input is
  #   given, it tells the user the options and asks them to redefine their
  #   choice and reassigns the weapon_two instance variable as the new value.
  #
  def valid_input_check_two
    while traditional_choices.include?(player_two.weapon) == false
      #(player_two.weapon != "rock") && (player_two.weapon != "paper") && (player_two.weapon != "scissors")
      puts "#{player_two.name}, only choose 'rock', 'paper', or 'scissors'."
      player_two.weapon = gets.chomp.downcase
    end
  end

  # Does the valid input check to include lizard-spock options for player_one
  def valid_input_check_one_spock
    while spock_choices.include?(player_one.weapon) == false
      puts "#{player_one.name}, only choose 'rock', 'paper', 'scissors', 'lizard', or 'spock'."
      player_one.weapon = gets.chomp.downcase
    end
  end

  # Does the valid input check to include lizard-spock options for player_two
  def valid_input_check_two_spock
    while spock_choices.include?(player_two.weapon) == false
      puts "#{player_two.name}, only choose 'rock', 'paper', 'scissors', 'lizard', or 'spock'."
      player_two.weapon = gets.chomp.downcase
    end
  end

  # Assigns player_two as either a computer player or a human player
  #
  # Uses an if-else statement to either create a new ComputerPlayer Class object
  #   or run the create_player_two method.
  # Puts a statement to show what the computer's weapon is in the first round.
  def assign_player_two_robot_or_human
    if name_two == "Computer"
      @player_two = ComputerPlayer.new(spock)
      puts "The computer chooses #{player_two.weapon}."
    else
      create_player_two(name_two, weapon_two)
      use_spock_check_two
    end
  end

  # Determines which validity check to use for player_one
  #
  # Uses and if-else statement to determine if the spock game is being used or
  #   not. If so, it uses the valid check method for spock. If not, it uses the
  #   traditional valid input check.
  def use_spock_check_one
    if spock == "spock"
      valid_input_check_one_spock
    else
      valid_input_check_one
    end
  end

  # Determines which validity check to use for player_two
  #
  # Uses and if-else statement to determine if the spock game is being used or
  #   not. If so, it uses the valid check method for spock. If not, it uses the
  #   traditional valid input check.
  def use_spock_check_two
    if spock == "spock"
      valid_input_check_two_spock
    else
      valid_input_check_two
    end
  end

end
