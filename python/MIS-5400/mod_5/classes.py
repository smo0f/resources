from datetime import datetime

##################################
# INTRODUCTION TO PYTHON CLASSES #
##################################


#
# 1. Python is an Object Oriented Language.
# 2. Classes are another level of abstraction (besides functions and modules).
# 3. Classes can be more powerful than functions at encapsulating actions and properties of an object.
# 4. Classes allow us to use Polymorphism
#


############################################
# Run away functions in some gaming logic  #
############################################
# Example: This would require constant updating....For every new type of vehicle you program had
def move_vehicle_forward(vehicle):
    """
    Moves the specified vehicle forward, based on the vehicle type.
    Returns how many miles the vehicle moved
    """
    if vehicle.lower() == 'tank':
        # Move treads on the tank
        print('Moving treads slowly but surely')
        return 10
    if vehicle.lower() == 'rocket':
        # Burn rocket fuel
        print('Burning rocket fuel.')
        return 1500
    if vehicle.lower() == 'truck':
        print('Engaging 4 x 4, Burning Diesel')
        return 75
    if vehicle.lower() == 'tesla':
        print('Engaging auto-pilot on Tesla')
        return 100
    if vehicle.lower() == 'mustang':
        print('Moving mustang quickly!!!')
        return 500

    print(f'Sorry, implementation of {vehicle} move_vechicle_forward is not complete.')
    return 0


# A much better way than using the function to implement each vehicle type is to let the "thing" (vehicle in this case)
# move on it's own
def move_vehicle_forward(vehicle):
    """
    Moves the vechicle forward by invoking .move_forward() method.
    Returns how many miles the vehicle moved.
    """
    return vehicle.move_forward()


# But.. This requires classes because now "vehicle" cannot just be a string, but must actually
# be a type that is able to .move_forward()


#################################
# How to make a class in Python #
#################################
# NOTE: By convention classes begin with upper-case letters
# See the full Python recommended style-guide here: https://www.python.org/dev/peps/pep-0008/
from datetime import datetime
class Vehicle:
    # Method Declaration (__init__ is constructor)
    def __init__(self, type='unknown', max_mph_speed=0):
        self.type = type
        self.year_produced = datetime.now().year
        self.max_mph_speed = max_mph_speed

        print('Vehicle Created...')

    def get_summary(self):
        return f'{self.type} produced in the year {self.year_produced}, reaching a max speed of {self.max_mph_speed} mph'

    def move_forward(self):
        raise NotImplementedError('Not enough information to know how to move')

    def __del__(self):  # Destructor
        print('Vehicle destroyed...')

# Create a vehicle
some_vehicle = Vehicle()
vehicle_description = some_vehicle.get_summary()
print(vehicle_description)

################################
# Class vs. Instance Variables #
################################
# Read More Here: https://www.bogotobogo.com/python/python_classes_instances.php
# A class is a blueprint for creating an instance of the class -
# An instance is an actual creation of the object from the class (like a house).
# So in our case we can create multiple instances of vehicles and keep them separate
# Any variable pre-fixed with "self" belongs to each instance
# Any "class-level" variable will not be prefixed.
from datetime import datetime
class Vehicle:
    # A class variable (belongs to class not instance)
    total_vehicles_produced = 0

    def __init__(self, vtype='unknown', max_mph_speed=0):
        self.type = vtype
        self.year_produced = datetime.now().year
        self.max_mph_speed = max_mph_speed

        # Note that to access class variable it must be pre-fixed by class name
        Vehicle.total_vehicles_produced += 1
        print('Vehicle Created...')

    def get_summary(self):
        return f'{self.type} produced in the year {self.year_produced}, reaching a max speed of {self.max_mph_speed} mph'

    def move_forward(self):
        raise NotImplementedError

    def __del__(self):  # Destructor
        print('Vehicle destroyed...')

# total_vehicles_produced is a "class variable" - It belongs to the class itself, not the instance.
vehicle_1 = Vehicle(vtype='Generic', max_mph_speed=80)
print(f'Total vehicles produced: {Vehicle.total_vehicles_produced}')

vehicle_2 = Vehicle(vtype='Car', max_mph_speed=100)

# class variables can be referenced from the instance
print(f'Total vehicles produced: {vehicle_2.total_vehicles_produced}')

# But all instance variables stay the same
print(vehicle_1.get_summary())
print(vehicle_1.type)

print(vehicle_2.get_summary())
print(vehicle_2.type)


####################################################
# Inheritance / Polymorphism
# Polymorphism is possible because of inheritance
####################################################

# Tank inherits all functionality of "Vehicle", but can add it's own properties and actions
# NOTE: "Actions", or functions that belong to a class are referred to as methods instead of functions
# This is why it is known as string methods, those actions belong to the string type.
class Tank(Vehicle):
    def __init__(self, tread_width=10):
        self.tread_width = tread_width

    def move_forward(self):
        print('Moving treads slowly but surely')
        return 10

    def fire_gun(self):
        print('Firing Weapon')



class Mustang(Vehicle):
    def __init__(self, color):
        self.color = color

    def move_forward(self):
        print('Moving mustang quickly!!!')
        return 500


red_mustang = Mustang(color='red')
red_mustang.move_forward()

big_tank = Tank(tread_width=100)
big_tank.move_forward()
big_tank.fire_gun()


def move_vehicle_forward(vehicle):
    return vehicle.move_forward()

move_vehicle_forward(big_tank)
move_vehicle_forward(red_mustang)

# NOTE: If something other than a vechicle, or somnething that does not implement the move_forward() method
# is passed to the function it will fail

some_string = 'Only a string'
move_vehicle_forward(some_string)




# Example using built in type
# A list and a string, both have a count method, but are implemented differently
a_string = 'Muwaahaahahahh'
print(a_string.count('a'))

a_list = [1, 2, 3, 1, 2, 1, 5, 'a', 32, 1, 3, 5]
print(a_list.count('a'))
