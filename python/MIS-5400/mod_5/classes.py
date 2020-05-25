'''
    INTRODUCTION TO PYTHON CLASSES

    1. Python is an Object Oriented Language.
    2. Classes are another level of abstraction (besides functions and modules).
    3. Classes can be more powerful than functions.
    4. Classes allow us to use Polymorphism

'''


################
# Duck Typing  #
################
# Using methods on objects is better than using functions
# Example say_something() - This would require constant updating....For every new animal sound.
def say_something(thing):
    if thing == 'Duck':
        return 'Quake'
    if thing == 'Dog':
        return 'Woof'
    if thing == 'Horse':
        return 'Neeeeiigh'


# A much better way is expect that the thing can actually "talk", meaning it has a talk method which can be invoked.
def say_something(thing):
    thing.talk()

# But.. This requires classes (shown below)

#################################
# How to make a class in Python #
#################################
class Person:
    def __init__(self, name='unknown', age=0): # Method Declaration (__init__ is constructor)
        self.name = name
        self.age = age

    def say_hello(self):
        print('Hello, my name is', self.name)

    def __del__(self): # Destructor
        print('Person deleted.')




# NOTE: Usually classes begin with upper-case letters
# How to instantiate an instance of the class.
bob = Person(name='Bob')
bob.name
bob.age
bob.say_hello()


# Deleting will call the destructor
del bob

################################
# Class vs. Instance Variables #
################################
# A class is like a blueprint for creating an instance
# An instance is an actual creation of the object from the class (like a house).
class Person:
    population = 0

    def __init__(self, name='', age=0):
        Person.population += 1
        self.name = name
        self.age = age

    def say_hello(self):
        print('Hello, my name is', self.name)


# population is a "class variable" - It belongs to the class itself, not the instance.
bobby = Person(name='Bobby')
Person.say_hello(bobby)
Person.population

sue = Person(name='SuzyQ', age=23)

# Access class variable to get information about the class itself
Person.population

# Access instance variable to get information about that instance
print(sue.name)



####################################################
# Inheritance / Polymorphism
# Polymorphism is possible because of inheritance
####################################################

class Animal:
    def talk(self):
        raise NotImplementedError( "Tell us how to talk!" )
        

class Cat(Animal):
    def talk(self):
        return "Meow!"    


class Dog(Animal): 
    def talk(self):
        return "Woof!"


kitty_kat = Cat()
doggy_dog = Dog()

kitty_kat.talk()
doggy_dog.talk()

# Example
# A list and a string, both have a count method, but are implemented differently
a_string = 'Muwaahaahahahh'
print(a_string.count('a'))

a_list = [1, 2, 3, 1, 2, 1, 5, 56, 32, 1, 3, 5]
print(a_list.count(1))

# Polymorphism, similar expectations
# all vehicle move