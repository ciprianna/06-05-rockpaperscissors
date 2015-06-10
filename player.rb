# Player Class

class Player

  attr_accessor :name, :weapon, :score

  # Takes and stores two arguments.
  # name - string
  # weapon - string
  # Creates a score attribute and sets it to 0 - integer
  def initialize(name, weapon)
    @name = name
    @weapon = weapon
    @score = 0
  end

  # Updates the score by adding one to the instance variable
  #
  # Returns the score instance variable - Integer
  def score_update
    @score += 1
  end

end
