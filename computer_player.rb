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
  def score_update
    @score += 1
  end

  # Samples a weapon choice and assigns it as the instance variable weapon.
  def sample_weapon_choice
    @weapon = ["rock", "paper", "scissors"].sample
  end

  # Samples a weapon choice and assigns it as the instance variable weapon for
  #   the Rock, Paper, Scissors, Lizard, Spock game.
  def lizard_spock_weapon_sample
    @weapon = ["rock", "paper", "scissors", "lizard", "spock"].sample
  end

  # Uses an if-else statement to determine if lizard-spock is being played.
  #   Assigns the weapon instance variable based on that.
  def assign_weapon(spock)
    if spock == "spock"
      lizard_spock_weapon_sample
    else
      sample_weapon_choice
    end
  end

end
