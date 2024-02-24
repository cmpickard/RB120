# Given the below usage of the Person class, code the class definition.

# bob = Person.new('bob')
# bob.name                  # => 'bob'
# bob.name = 'Robert'
# bob.name                  # => 'Robert'

class Person
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end
bob = Person.new('bob')
p bob.name                  # => 'bob'
p bob.name = 'Robert'
p bob.name                  # => 'Robert'
puts "END PROBLEM 1"
puts ""


# Modify the class definition from above to facilitate the following methods. 
# Note that there is no name= setter method now.
# bob = Person.new('Robert')
# bob.name                  # => 'Robert'
# bob.first_name            # => 'Robert'
# bob.last_name             # => ''
# bob.last_name = 'Smith'
# bob.name                  # => 'Robert Smith'

class Person
  attr_accessor :first_name, :last_name

  def initialize(first_name, last_name = '')
    @first_name = first_name
    @last_name = last_name
  end

  def name
    (@first_name + ' ' + @last_name).strip
  end
end

bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'
puts "END PROBLEM 2"
puts ""

# Now create a smart name= method that can take just a first name or a full name,
#  and knows how to set the first_name and last_name appropriately.
# bob = Person.new('Robert')
# bob.name                  # => 'Robert'
# bob.first_name            # => 'Robert'
# bob.last_name             # => ''
# bob.last_name = 'Smith'
# bob.name                  # => 'Robert Smith'

# bob.name = "John Adams"
# bob.first_name            # => 'John'
# bob.last_name             # => 'Adams'

class Person
  attr_accessor :first_name, :last_name

  def initialize(first_name, last_name = '')
    @first_name = first_name
    @last_name = last_name
  end

  def name
    (@first_name + ' ' + @last_name).strip
  end

  def name=(name)
    self.first_name = name.split[0]
    self.last_name = name.split[1] unless name.split.size < 2
  end
end

bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'

bob.name = "John Adams"
p bob.first_name            # => 'John'
p bob.last_name             # => 'Adams'
puts "END PROBLEM 3"
puts ""
puts "The person's name is #{bob}"

# Using the class definition from step #3, let's create a few more people -- 
# that is, Person objects.
# bob = Person.new('Robert Smith')
# rob = Person.new('Robert Smith')

# If we're trying to determine whether the two objects contain the same name, 
# how can we compare the two objects?

#ANSWER: 
# new instance method:

# def same_name_as?(other)
#   name == other.name
# end
# p bob.same_name_as?(rob)


# Continuing with our Person class definition, what does the below code print out?
# bob = Person.new("Robert Smith")
# puts "The person's name is: #{bob}"
#ANSWER: "The person's name is: #<Person:0x00007f8a1eb3ac40>"


# Let's add a to_s method to the class:
# class Person
#   # ... rest of class omitted for brevity

#   def to_s
#     name
#   end
# end

# Now, what does the below output?
# bob = Person.new("Robert Smith")
# puts "The person's name is: #{bob}"
#ANSWER: The person's name is: Robert Smith