# @ variables
# # naming conventions
# variables must start with a letter or a _
# good = name = 'Russell'
# good = Name = 'Russell'
# good = _name = 'Russell'
# not good = 1name = 'Russell'
# not good = name@ = 'Russell'
# not good = name? = 'Russell'

# variables are case sensitive
# Name != name

# preference is to use snake_case not camelCase

# constant variables in ALL_CAPS

# classes are uppercase and camel case, PythonClass

# dunder double underscore, __no_touchy__

# multi-assignment of a variable
num1, num2, num3 = 1, 2, 3
print(num2)