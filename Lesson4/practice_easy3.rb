# Question 1
# If we have this code:
# class Greeting
#   def greet(message)
#     puts message
#   end
# end

# class Hello < Greeting
#   def hi
#     greet("Hello")
#   end
# end

# class Goodbye < Greeting
#   def bye
#     greet("Goodbye")
#   end
# end
# What happens in each of the following cases:

# case 1:
# hello = Hello.new
# hello.hi

# case 2:
# hello = Hello.new
# hello.bye

# case 3:
# hello = Hello.new
# hello.greet

# case 4:
# hello = Hello.new
# hello.greet("Goodbye")

# case 5:
# Hello.hi

=begin
ANSWER:
case 1: 'Hello'
case 2: error, undefined method (#bye is in the Goodbye class)
case 3: error, wrong number of arguments
case 4: 'Goodbye'
case 5: error, undefined method
=end



# Question 2
# In the last question we had the following classes:

# class Greeting
#   def greet(message)
#     puts message
#   end
# end

# class Hello < Greeting
#   def hi
#     greet("Hello")
#   end
# end

# class Goodbye < Greeting
#   def bye
#     greet("Goodbye")
#   end
# end
# If we call Hello.hi we get an error message. How would you fix this?

=begin
ANSWER:

add this to the Hello class:

  def self.hi
    puts "hi"
  end

=end



# Question 3
# When objects are created they are a separate realization of a particular class.

# Given the class below, how do we create two different instances of this 
#   class with separate names and ages?

# class AngryCat
#   def initialize(age, name)
#     @age  = age
#     @name = name
#   end

#   def age
#     puts @age
#   end

#   def name
#     puts @name
#   end

#   def hiss
#     puts "Hisssss!!!"
#   end
# end

=begin
ANSWER:
fruz = Cat.new(10, 'fruz')
fizz = Cat.new(2, 'fizz')
=end


# Question 4
# Given the class below, if we created a new instance of the class and then 
# called to_s on that instance we would get something like 
# "#<Cat:0x007ff39b356d30>"

# class Cat
#   def initialize(type)
#     @type = type
#   end
# end
# How could we go about changing the to_s output on this method to look like 
# this: I am a tabby cat? (this is assuming that "tabby" is the type we 
# passed in during initialization).

=begin
ANSWER:

add the following instance method to the Cat class definition:

def to_s
"I am a #{@type} cat"
end

=end


# Question 5
# If I have the following class:

# class Television
#   def self.manufacturer
#     # method logic
#   end

#   def model
#     # method logic
#   end
# end

# What would happen if I called the methods like shown below?
# tv = Television.new
# tv.manufacturer
# tv.model

# Television.manufacturer
# Television.model

=begin
ANSWER:
tv.manufacturer and Television.model will both throw No Method errors (b/c the
first is calling a class method with an instance and the second is calling
an instnce method with a class.)
The other two method calls should work as intended, successfully calling the 
Television methods of the supplied names
=end


# Question 6
# If we have a class such as the one below:

# class Cat
#   attr_accessor :type, :age

#   def initialize(type)
#     @type = type
#     @age  = 0
#   end

#   def make_one_year_older
#     self.age += 1
#   end
# end
# In the make_one_year_older method we have used self. What is another way
#  we could write this method so we don't have to use the self prefix?

=begin
ANSWER: we *could* simply refer to the instance variable directly rather than
call the setter. Like so:
  @age += 1

That's not really a best practice though.
=end


# Question 7
# What is used in this class but doesn't add any value?

# class Light
#   attr_accessor :brightness, :color

#   def initialize(brightness, color)
#     @brightness = brightness
#     @color = color
#   end

#   def self.information
#     return "I want to turn on the light with a brightness level of super high and a color of green"
#   end

# end

=begin
ANSWER:
 The brightness and color instance variables and their respective getters/setters
 aren't being put to any use.
 also the use of return inside the class method is unneeded.
=end