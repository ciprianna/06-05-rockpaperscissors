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
The Game class is what runs the game itself. It was created to hold the rules for the game and lets players use the best-of-n games logic.

### Game Class Arguments
When the Game class is initialized, it creates an options Hash, with a default value of 1 round played. The options Hash is merged with the user inputs when a new Game class object is created. Arguments that can be input include:
- name_one - String input when initialized
- name_two - String input when initialized
- weapon_one - String input when initialized
- weapon_two - String input when initialized
- rounds - Integer created when initialized
- spock - String input when initialized

When a new object is created, two Arrays are also created: the traditional_choices Array and the spock_choices Array. Each of these Arrays contains the possible weapon choices a player can choose.

In addition, a choices Hash is created and stored as an instance variable.
~~~ruby
@choices = {"rock" => ["scissors", "lizard"], "paper" => ["rock", "spock"], "scissors" => ["paper", "lizard"], "lizard" => ["spock", "paper"], "spock" => ["rock", "scissors"]}
~~~
Each key of the Hash is a potential weapon choice. The value of the key is an Array containing the losing weapon counterparts to the key.

### Game Class Methods
The *create_player_one* method is ran when a Game class object is initialized. It takes two arguments: name_one and weapon_one. This method creates a new Player class object.
~~~ruby
def create_player_one(name, weapon)
  @player_one = Player.new(name, weapon)
end
~~~

Just like the previous method, the Game class has a *create_player_two* method creates another Player class object and stores it as an instance variable called player_two.

The *check_who_wins* method determines who wins any given round of rock, paper, scissors.
~~~ruby
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
~~~
It uses an if-elsif-else statement to check the weapon attribute of player_one and player_two. If the two are equal, it displays the result. If player_one's weapon attribute key matches the value for player_two's weapon attribute, then player_one wins. If it does not match the value of player_two's weapon attribute, then player_two wins the game.

The *best_of* method determines how many rounds a given player needs to win in order to win the entire game.
~~~ruby
def determine_best_of(rounds)
  @best_of = rounds / 2
end
~~~

The *determine_game_end* method is ran when the Game object is initialized. It runs several utility methods to figure out when the game should end. The first of these is check_who_wins, and that's run before the while loop begins. This is to test who won the first round with the initial weapon choices. The while loop runs if the score attribute for either player_one or player_two is less than or equal to the best_of Integer.
~~~ruby
def determine_game_end
  check_who_wins
  while (player_one.score <= best_of) && (player_two.score <= best_of)
    redefine_player_weapons
    check_who_wins
    announce_winner
  end
end
~~~

The *redefine_player_weapons* method allows players to re-choose what weapon they would like if they're playing more than one round.
~~~ruby
def redefine_player_weapons
  puts "No winner yet. On to the next round!"
  puts "#{player_one.name}, make your move!"
  player_one.weapon = gets.chomp.downcase
  use_spock_check_one
  redefine_player_two_weapon
end
~~~
This method asks for a new input from player_one and then redefines player_one's weapon attribute. It then uses two utility methods to test the validity of player_one's weapon input and redefine player_two's weapon.

The *announce_winner* method simply puts a statement of who wins the game if a player's score is greater than or equal to the best of number.

The *valid_input_check_one* method is used for a traditional game of rock, paper, scissors. It uses a while loop that asks if player_one's weapon choice is included in the traditional_choices Array. If it is not, it asks player_one for a new choice and redefines the weapon attribute for player_one. This continually runs until a weapon choice is included in the traditional_choices Array.
~~~ruby
def valid_input_check_one
  while traditional_choices.include?(player_one.weapon) == false
    puts "#{player_one.name}, only choose 'rock', 'paper', or 'scissors'."
    player_one.weapon = gets.chomp.downcase
  end
end
~~~

The *valid_input_check_two* method works exactly the same as the above method, but asks player_two instead and redefines player_two's weapon attribute.

Two other utility methods the Game class uses are the *valid_input_check_one_spock* and *valid_input_check_two_spock* methods. These two methods work the same as the first two validity methods, but instead check the spock_choices Array to see if the weapon attribute is included.

The *define_player_two_robot_or_human* method checks the name_two argument. If it's equal to "Computer", then player_two is assigned by creating a new ComputerPlayer class object. It then outputs the Computer's choice of weapon.
If name_two is not "Computer", then it runs the create_player_two method and the use_spock_check_two method.
~~~ruby
def assign_player_two_robot_or_human
  if name_two == "Computer"
    @player_two = ComputerPlayer.new(spock)
    puts "The computer chooses #{player_two.weapon}."
  else
    create_player_two(name_two, weapon_two)
    use_spock_check_two
  end
end
~~~

The *use_spock_check_one* method determines which weapon input validity check to use.
~~~ruby
def use_spock_check_one
  if spock == "spock"
    valid_input_check_one_spock
  else
    valid_input_check_one
  end
end
~~~
A *use_spock_check_two* method also exists and works the same, but calls validity input methods for player_two.
