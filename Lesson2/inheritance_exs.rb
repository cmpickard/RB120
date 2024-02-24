# Given this class:

class Dog
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end
end

teddy = Dog.new
puts teddy.speak           # => "bark!"
puts teddy.swim           # => "swimming!"

# One problem is that we need to keep track of different breeds of dogs, since 
# they have slightly different behaviors. For example, bulldogs can't swim, but 
# all other dogs can.
# Create a sub-class from Dog called Bulldog overriding the swim method to 
# return "can't swim!"

class Bulldog < Dog
  def swim
    "can't swim!"
  end
end

karl = Bulldog.new
puts karl.speak           # => "bark!"
puts karl.swim            # => "can't swim!"
puts "END OF EX1"
puts ""

# Let's create a few more methods for our Dog class.

# class Dog
#   def speak
#     'bark!'
#   end

#   def swim
#     'swimming!'
#   end

#   def run
#     'running!'
#   end

#   def jump
#     'jumping!'
#   end

#   def fetch
#     'fetching!'
#   end
# end


# Create a new class called Cat, which can do everything a dog can, except swim 
#   or fetch. Assume the methods do the exact same thing. Hint: don't just copy 
#     and paste all methods in Dog into Cat; try to come up with some class 
#     hierarchy.

class Animal 
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Dog < Animal
    def speak
      'bark!'
    end
  
    def swim
      'swimming!'
    end

    def fetch
      'fetching!'
    end
  end

class Cat < Animal
  def speak
    'meow!'
  end
end
  

# Draw a class hierarchy diagram of the classes from step #2

#ANSWER:

# ANIMAL
#  /  \
#DOG  CAT

# What is the method lookup path and how is it important?
#ANSWER:

# The method lookup path is an ordered list of classes and modules that is
# specific to each class. When we call a method on an instance of class X, ruby
# tries to find that method by looking through the classes and modules in the 
# method lookup path and in the order they appear in the path. In general, the 
# order goes:
# object's class
# modules included in object's class (last listed, first checked)
# object class's superclass
# modules included in superclass (last listed, first checked)
# supersuperclass...
# ...
# Object
# Kernel
# BasicObject