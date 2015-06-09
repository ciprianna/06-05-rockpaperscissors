# Rock, Paper, Scissors Explanation

## Purpose of the Assignment
Rock, Paper, Scissors was created to allow two players, or a single player vs. the computer, to play a game of rock, paper, scissors. Game options include being able to choose how many rounds will be played, and being able to choose Rock, Paper, Scissors, Lizard, Spock.

## Classes
To accomplish the assignment, three classes are used: Player, ComputerPlayer, and Game.

## Player Class
The Player class was created to create new players in a given game.

### Player Class Arguments
- name - String given when the Player is initialized
- weapon - String given when the Player is initialized
- score - Integer set at 0

### Player Class Methods
The *score_update* method adds one to the score attribute of a given player.
~~~ruby
def score_update
  @score += 1
end
~~~

## ComputerPlayer Class
This class was created to create a computer player that will randomly sample a weapon to play with.

### ComputerPlayer Arguments
This method requires one argument: spock. This argument is a string that determines if Rock, Paper, Scissors, Lizard, Spock is being played or not. This argument is created in the Game class.

Other arguments ComputerPlayer creates include:
- name - String set to equal "Computer"; set when initialized
- score - Integer set to equal 0 when initialized
- weapon - Array containing weapon choices for the computer to sample

### ComputerPlayer Methods
The *score_update* method works exactly the same as in the Player class by adding 1 to the score of the computer player.

The *sample_weapon_choice* method takes the Array weapon and samples it. It then stores the sample in the weapon attribute variable.
~~~ruby
def sample_weapon_choice
  @weapon = ["rock", "paper", "scissors"].sample
end
~~~

The *lizard_spock_weapon_sample* method works the same as the *sample_weapon_choice* method, but it adds in the two additional choices, "lizard" and "spock", to the Array to sample.

The final method of the ComputerPlayer class is the *assign_weapon* method.
~~~ruby
def assign_weapon(spock)
  if spock == "spock"
    lizard_spock_weapon_sample
  else
    sample_weapon_choice
  end
end
~~~
This method takes one argument, spock, which is a String created in the Game class. If spock is equal to "spock", then the *lizard_spock_weapon_sample* method is run. If it's not, then the *sample_weapon_choice* method is run.

## Game Class
The Game class is what runs everything together. 
