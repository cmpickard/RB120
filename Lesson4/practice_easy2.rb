# Question 1
# You are given the following code:

# class Oracle
#   def predict_the_future
#     "You will " + choices.sample
#   end

#   def choices
#     ["eat a nice lunch", "take a nap soon", "stay at work late"]
#   end
# end
# What is the result of executing the following code:

# oracle = Oracle.new
# oracle.predict_the_future

=begin
ANSWER:
this will return a string, "You will ..." where the ... will be filled in with
exactly one of the elements of the array on line 10, chosen at random
=end



# Question 2
# We have an Oracle class and a RoadTrip class that inherits from the Oracle class.

# class Oracle
#   def predict_the_future
#     "You will " + choices.sample
#   end

#   def choices
#     ["eat a nice lunch", "take a nap soon", "stay at work late"]
#   end
# end

# class RoadTrip < Oracle
#   def choices
#     ["visit Vegas", "fly to Fiji", "romp in Rome"]
#   end
# end
# What is the result of the following:

# trip = RoadTrip.new
# trip.predict_the_future

=begin
ANSWER:
The return value will be the string, "You will ..." where the ... will be filled
in with exactly one of the elements from the array defined on line 41 inside
the Roadtrip#choices method.
=end



# Question 3
# How do you find where Ruby will look for a method when that method is called?
#    How can you find an object's ancestors?

# module Taste
#   def flavor(flavor)
#     puts "#{flavor}"
#   end
# end

# class Orange
#   include Taste
# end

# class HotSauce
#   include Taste
# end
# What is the lookup chain for Orange and HotSauce?


=begin
ANSWER: To find the list of classes and modules that will be checked when a 
class or class instances call a method, we need only call the #ancestors method
on the class. 
So Orange.ancestors and HotSauce.ancestors will both return an array representing
the order of classes/modules that will checked to resolve a method call made from
the class or by members of the class.
=end


# Question 4
# What could you add to this class to simplify it and remove two methods from the
#  class definition while still maintaining the same functionality?

# class BeesWax
#   def initialize(type)
#     @type = type
#   end

#   def type
#     @type
#   end

#   def type=(t)
#     @type = t
#   end

#   def describe_type
#     puts "I am a #{@type} of Bees Wax"
#   end
# end


=begin
ANSWER: delete the #type and #type= methods and replace them with a single line:
attr_accessor :type.
The other small improvement we can make is to change the string interp inside
the #describe_type method so that the getter is called rather than referencing
the @type instance variable directly. It is generally preferable to call the 
getter when we can, rather than referencing instance var directly
=end

# Question 5
# There are a number of variables listed below. What are the different 
# types and how do you know which is which?

# excited_dog = "excited dog"
# @excited_dog = "excited dog"
# @@excited_dog = "excited dog"


=begin
ANSWER:
class and instance vars are easy to discern because they start with '@@' and '@'
respectively. The first variable is a local variable, which can be a bit trickier
to recognize because they don't have any special markers, other than being
lower-cased and *not* starting with an '@' or '$'.
=end


# Question 6
# If I have the following class:
# class Television
#   def self.manufacturer
#     # method logic
#   end

#   def model
#     # method logic
#   end
# end
# Which one of these is a class method (if any) and how do you know? 
#   How would you call a class method?


=begin
ANSWER:
Television::manufacturer is a class method. We can tell because it's being 
defined on the class: notice the use of 'self' in the method definition, which
is equivlent to saying, def Television.manufacturer.
We can call a class method on the class itself:
Television.manufacturer
=end



# Question 7
# If we have a class such as the one below:

# class Cat
#   @@cats_count = 0

#   def initialize(type)
#     @type = type
#     @age  = 0
#     @@cats_count += 1
#   end

#   def self.cats_count
#     @@cats_count
#   end
# end
# Explain what the @@cats_count variable does and how it works. What code 
# would you need to write to test your theory?

=begin
ANSWER: The @@cats_count variable is a class variable that keeps track of the
number of cat objects that have been created. To check that that's true, we'd
want to write some code that creates N cats, and then call Cat.cats_count to 
verify that the method returns N.
=end

# Question 8
# If we have this class:

# class Game
#   def play
#     "Start the game!"
#   end
# end
# And another class:

# class Bingo
#   def rules_of_play
#     #rules of play
#   end
# end
# What can we add to the Bingo class to allow it to inherit
#  the play method from the Game class?


=begin
ANSWER: Since Bingo is a game, the most natural way to add the #play method
to the Bingo class is through inheritance. That can be accomplished by subclassing
the Bingo class to the Game like so:
class Bingo < Game
=end



# Question 9
# If we have this class:

# class Game
#   def play
#     "Start the game!"
#   end
# end

# class Bingo < Game
#   def rules_of_play
#     #rules of play
#   end
# end
# What would happen if we added a play method to the Bingo class, 
# keeping in mind that there is already a method of this name in the Game
#  class that the Bingo class inherits from.


=begin
ANSWER: The Bingo#play method would override the Game#play method, meaning that
Bingo objects that call #play would end up calling Bingo#play and not Game#play.
(that's because the first place that ruby looks for an instance method is inside
the class of the calling object.)
=end


# Question 10
# What are the benefits of using Object Oriented Programming in Ruby? 
# Think of as many as you can.


=begin
ANSWER:
Encapsulation -- reduce dependencies, hide data, package functionality in intuitive ways
Polymorphism -- makes code easier to write and less fussy about type, allows interface sharing and logical connections between classes
Abstraction -- allows us to think about our coding project at a higher level of abstraction, modeling the relationships between objects rather
than modeling a series of step, tasks, and methods.
=end