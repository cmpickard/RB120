# Which of the following are objects in Ruby? If they are objects, how can you 
# find out what class they belong to?

# true
# "hello"
# [1, 2, 3, "happy days"]
# 142

=begin
ANSWER: all are objects, and we can call the #class method on each to return the
name of the class they are instances of.
=end


# Question 2
# If we have a Car class and a Truck class and we want to be able to go_fast, 
# how can we add the ability for them to go_fast using the module Speed? How can 
# you check if your Car or Truck can now go fast?

# module Speed
#   def go_fast
#     puts "I am a #{self.class} and going super fast!"
#   end
# end

# class Car
#   def go_slow
#     puts "I am safe and driving slow."
#   end
# end

# class Truck
#   def go_very_slow
#     puts "I am a heavy truck and like going very slow."
#   end
# end

=begin
ANSWER: add the line
  include Speed
into both classes.

to check if that worked, we can write:
  Car.new.go_fast
  Truck.new.go_fast

=end


# Question 3
# In the last question we had a module called Speed which contained a go_fast 
# method. We included this module in the Car class as shown below.

# module Speed
#   def go_fast
#     puts "I am a #{self.class} and going super fast!"
#   end
# end

# class Car
#   include Speed
#   def go_slow
#     puts "I am safe and driving slow."
#   end
# end

# When we called the go_fast method from an instance of the Car class (as shown
#  below) you might have noticed that the string printed when we go fast includes
#   the name of the type of vehicle we are using. How is this done?

# >> small_car = Car.new
# >> small_car.go_fast
# I am a Car and going super fast!

=begin
ANSWER: This is done inside the go_fast method with string interpolation.
Specifically, we make a call to self.class which returns the Class that the
calling object belongs to -- e.g. a Car if it was a Car object that called 
#go_fast -- and then the string intpolation called #to_s on the class name.
=end


# Question 4
# If we have a class AngryCat how do we create a new instance of this class?

# The AngryCat class might look something like this:

# class AngryCat
#   def hiss
#     puts "Hisssss!!!"
#   end
# end

=begin
ANSWER:

AngryCat.new

=end


# Question 5
# Which of these two classes would create objects that would have an instance 
# variable and how do you know?

# class Fruit
#   def initialize(name)
#     name = name
#   end
# end

# class Pizza
#   def initialize(name)
#     @name = name
#   end
# end

=begin
ANSWER:
Pizza instances would have a @name instance variable while Fruit instances would
Have none. When we create a new object from a class with a call to ::new, we also
implicitly end up making a call to #initialize. Both classes have their own
version of that method, so those respective methods will be called by their
respective ::new methods. However, the code inside Fruit#initialize does not
successfully create an instane variable. What it does is reassign the *local* 
variable name to the value that it already point to. 
Inside the Pizza class, on the other hand, we can see that we actually do 
successfully initialize a new instance variable named @name and assign it to 
whatever value was passed in as an argument to the Pizza::new method call.
=end


# Question 6
# What is the default return value of to_s when invoked on an object? Where 
# could you go to find out if you want to be sure?

=begin
ANSWER:
It returns whatever is returned by the version of #to_s that gets called for 
members of the object's class. Different classes implement to_s differently, though
so there's not single answer to this question. If we want to look at the implementation
details for the particular version of #to_s that will be called for a particular
object, we can call object.method(:to_s).owner to figure out which class houses the relevant
version of #to_s.
I guess, if "by default" means "assuming there has been no overriding of #to_s
anywhere up the inheritance chain", then that would be Kernel.to_s which returns
the name of the object's class and the object Id.
=end


# Question 7
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

# You can see in the make_one_year_older method we have used self. 
# What does self refer to here?

=begin
ANSWER:
since the "self" appears inside one of the class' instance methods, it will
refer to the instance of the class that has called the #make_one_year_older 
method.
=end


# Question 8
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
# In the name of the cats_count method we have used self. What does 
# self refer to in this context?

=begin
ANSWER:
Since the "self" appears in the context of a method definition inside the class,
it is actually signalling that the method is being defined ON the class rather 
than for instances of the class. In other words, 'self' here refers to the class
Cat -- and this line of code is equivalent to: def Cat.cats_count.
=end


# Question 9
# If we have the class below, what would you need to call to create a 
# new instance of this class.

# class Bag
#   def initialize(color, material)
#     @color = color
#     @material = material
#   end
# end

=begin
ANSWER:
Since the #initialize method for the Bag class takes two arguments, we would need
to call Bag.new(arg1, arg2), passing exactly two objects into our call to the
constructor
=end