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

  # Assigns player_two as either a computer player or a human player
  #
  # Returns player_two ComputerPlayer or Player object. If player object, also
  #   returns player_two.weapon
  def assign_player_two_robot_or_human
    if name_two == "Computer"
      @player_two = ComputerPlayer.new(spock)
    else
      create_player_two(name_two, weapon_two)
    end
  end

  # Determines who wins the game.
  #
  # Uses if-else statements to check if the two choices are the same. If so,
  #   the game prints results of the round.
  # Checks to see if weapon_one is a key in the
  #   choices hash that matches the value of weapon_two. If it matches the hash,
  #   then that means name_one wins the game.
  # Adds one to the score attribute of the winner.
  def check_who_wins
    if (choices[player_one.weapon][0] == player_two.weapon) || choices[player_one.weapon][1] == player_two.weapon
       player_one.score_update
    else
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

  # Checks if the computer is playing, and if so, redefines the computer's
  #   weapon attribute using the ComputerPlayer's sample_weapon_choice method.
  #
  # Returns player_two.weapon - String.
  def redefine_computer_weapon
    if player_two.name == "Computer"
      player_two.weapon = player_two.sample_weapon_choice
    end
  end

end
