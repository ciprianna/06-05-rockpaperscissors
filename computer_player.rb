# Computer Player Class

class ComputerPlayer

  attr_accessor :name, :weapon, :score

  # Takes and stores two arguments.
  # name - string
  # weapon - string
  # Creates a score attribute and sets it to 0 - integer
  def initialize(spock)
    @name = "Computer"
    @score = 0
    assign_weapon(spock)
  end

  # Updates the score by adding one to the instance variable
  #
  # Returns the score instance variable - Integer
  def score_update
    @score += 1
  end

  # Samples a weapon choice and assigns it as the instance variable weapon.
  #
  # Returns the weapon attribute - String
  def sample_weapon_choice
    @weapon = ["rock", "paper", "scissors"].sample
  end

  # Samples a weapon choice and assigns it as the instance variable weapon for
  #   the Rock, Paper, Scissors, Lizard, Spock game.
  #
  # Returns the weapon attribute - String
  def lizard_spock_weapon_sample
    @weapon = ["rock", "paper", "scissors", "lizard", "spock"].sample
  end

  # Uses an if-else statement to determine if lizard-spock is being played.
  #   Assigns the weapon instance variable based on that.
  #
  # Returns the return of the method chosen (weapon - String)
  def assign_weapon(spock)
    if spock == "spock"
      lizard_spock_weapon_sample
    else
      sample_weapon_choice
    end
  end

end
