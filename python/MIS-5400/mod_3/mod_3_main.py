'''
Module 3 Materials
'''


##################
# Exciting Stuff #
##################
# Sad News: https://www.theverge.com/2018/9/12/17848500/google-inbox-shut-down-sunset-snooze-email-march-2019


###################
# Module 2 REVIEW #
###################
"""
1)  Built-In Object Types
2)  Boolean
3)  Numbers
4)  Strings
5)  Collections
    A) Sequences - Lists
    B) Mapping - Dictionaries
6)  Mutable vs. Immutable
"""




##############
# OBJECTIVES #
##############
"""
1) Module importing / Namespaces
2) Conditional Statements
3) Loops
"""



##################################
# Importing Modules / Namespaces #
##################################
"""
1) Many modules come with the standard Python library.
2) To be efficient not all modules are loaded.
3) We load them with the import command.
4) When we import a full module, everything is "namespaced" with the module name
5) When using "from module_x import x" we can overwrite our own variables!!!
"""
a_list = [1, 2, 3]


import sys
print(sys.getrefcount(a_list))
c_list = a_list
print(sys.getrefcount(a_list))


# Import math functions into math namespace
import math
square = math.sqrt(9)
print(square)


# Import sqrt into global namespace
from math import sqrt
sqrt(9)

# Import all functions in a module into the global namespace (DANGER!)
from math import *

# Get some help on a module
import math
# help(math)

# Import with an alias
import random as r
r.randint(1,100)

# Some modules appear to be  "nested" - like datetime.
from datetime import datetime
now = datetime.now()
print(now.year)

# Example of overwriting variable
sqrt = "some local variable"
from math import *
print(sqrt)

# Some Modules are NOT included in the Standard Library and must be installed with
# pip (Pythons 3rd Party Package Manager) (e.g. matplotlib)
import random as r
random_nums = []
for x in range(99):
    print(random_nums.append(r.random()))

# matplotlib must be installed via pip
# import matplotlib.pyplot as plt
# plt.plot(random_nums)
# plt.ylabel('Random Numbers')
# plt.show()




##########################
# Conditional Statements #
##########################
"""
1) if    -> First Conditional Statement

2) elif  -> If the first if condition is not true, try another one

3) else  -> If the first if condition, and none of the elif conditions are true
"""


#########################
# Conditional Operators #
#########################
"""
Standard
x == y  # x is equal to y
x < y   # x is less than y
x > y   # x is greater than y
x >= y  # x is greater than OR equal to y
x <= y  # x is less than OR equal to y
x != y  # x is not equal to y

Reference Checking
x is y        # x references the same object as y
x is not y    # x references a different object than y

Membership Checking (where y is a container)
x in y        # x exists in the container y
x is not in y # x does not exist in the container y

Blocks
1) Statements in Python are grouped into "Blocks".
2) Where most programming languages use braces or syntax to define a block,
   Python simply uses indentation. So code that is indented on the same
   level is a block
3) This leads to more white-space and generally more readable code.
   However, it can be tricky, especially when writing multi-line statements
   in interactive mode.
"""

############
# Examples #
############
x = 1
y = 8

if x == y:
    print('Yep, x and y are equal')
    print('Same Level, Same Block...')
elif x > y:
    print('x is far superior to y')
else:
    print('x is neither equal to, nor far superior to y.... x\
     must be a bottom dweller')

# Comparing incompatible types will not throw an error, but is not reliable
if 13 == '13':
    print('The same')

# Can use type casting
if 13 == int('13'):
    print('The same')

# Combine multiple conditions with "and" and "or", use parenthesis if needed.
# NOTE: if the object being evaluated is already a boolean
# then it can be used in place of an expression.

# Setup some variables
name = 'Johnson'
age = 21
ninja_status = True

# Run some conditional checks
if name.lower() == 'johnson' and age == 21:
    print('Ni')

if (name.lower() == 'johnson' and age == 21) or ninja_status:
    print('Ni')

# Same as above, just explicitly evaluating boolean
if (name.lower() == 'johnson' and age == 21) or ninja_status is True:
    print('Ni')

# Python uses short-circuit logic,
# so expressions are evaluated from left to right

# This will not throw an error because the second expression will
# never be evaluated.
if ninja_status or 1 / 0:
    print('Weeee are the Knights who say Ni')

# Below will throw a division by zero error
# ninja_status = False
# if ninja_status or 1 / 0:
#     print('Weeee are the Knights who say Ni')

# This will also throw because it is using "and", not "or"
# ninja_status = True
# if ninja_status and 1 / 0:
#     print('Weeee are the Knights who say Ni')

# Ternary
# [action if true] if expression else [action if false]
print('Aye yi yi') if ninja_status else print('boooooo')


#################
# Nested Blocks #
#################
name = 'Leroy'
if name == 'Leroy':
    if name == 'LEROY':
        print('Non shall pass!!!')
    else:
        print('Ni')
elif name == 'Spiny':
    print('Hedgehogs!')
else:
    print('Who goes thar!')

# Note that the equality check is case sensitive,
# a common practice is to use either upper/lower case function
# for non-case sensitive expressions
name = 'Leroy'
if name.lower() == 'leroy':
    print('His name was', name)

# BEWARE of nested blocks, it can create code that is hard to reach
# hard to test, and harder to read!
if name.lower() == 'leroy':
    if name.upper() == 'leroy':
        print(1 / 0)

# Because Python is interpreted, this divide by 0
# won't be caught until that code block is hit.
# Because it is in a nested if statement

#########
# LAB 1 #
#########
"""
Write a program to prompt a user for hours and rate per hour to compute gross pay.
Take into account that the factory gives the employee 1.5 times the hourly rate for hours worked above 40 hours.

Enter Hours: 45
Rate: 10
Pay: 475.0

"""
# * to run: python python/MIS-5400/mod_3/mod_3_main.py 

hours = float(input('Please enter in the number of hours you worked this week? ').strip())
rate = float(input('Please enter in your hourly rate. ').strip())

# check to see if hours are over 40
if hours > 40:
    # split apart hours
    hoursOver40 = hours - 40
    hours = 40
    pay = (hoursOver40 * 1.5 * rate) + (hours * rate)
else:
    pay = hours * rate

print(pay)


















# BREAK?


#########
# Loops #
#########

# While -> Continue the loop until the expression is false
account_balance = 100
while account_balance >= 0:
    account_balance -= 5 # Equivalent to account_balance = account_balance - 5
    if account_balance % 25 == 0:
        print('Another 25 down the drain')
print('Spam for dinner again....')

#  While True / Break  -> Continue the loop until break is hit
while True:
    name = input('Who goes there?\n')
    if name.lower() == 'bossman':
        print('Si Senior')
        break
    else:
        print('Spam or Eggs')

# For Loop -> Loop through a container or any object that has __iter__ a property
bag = ['A string', 13, ['a', 'b', 'c'], {'name': 'treasure chest'}]

print(dir(bag))  # note __iter__ property # * looks like a list of methods

for stuff in bag:
    print(stuff, type(stuff))



# Dictionaries
fav_colors = {"bob": 'Blue', "amy": 'Red', "sue": 'Yellow', "t-dog": 'Green'}
for name in fav_colors:
    print(name + "'s", 'favorite color is', fav_colors[name])

# Range -> Returns a sequence of numbers, by a specified step
# Default step of "1", Default start of "0"
for num in range(0, 101):
    print(num)

for num in range(0, 101, 2):
    print(num)

for num in range(101):
    print(num)

# NOTE: The last number (stop param) is NOT inclusive!



# Continue -> skips all remaining code in the block for that loop cycle
for num in range(0, 100, 2):
    if num % 10 != 0:
        print(f'{num} is not divisible by 10')
        continue
    print(num)



#######################
# List Comprehensions #
#######################

# Format [do something to each item in the collection]
# e.g. get the exponent of every number from 0 to 9
[num ** 2 for num in range(10)]

[type(thing) for thing in ['A String', 13, ['a', 'b', 'c'], {'name': 'paul'}]]

#######################################
# List Comprehensions with conditions #
#######################################
groceries = ['Spam', 'Eggs', 'Cheese', 'Ham', 'Milk']
print([item for item in groceries if 'e' in item.lower()])

groceries = ['Spam', 'Eggs', 'Cheese', 'Ham', 'Milk']
print([item.lower() for item in groceries if 'e' in item.lower()])




# LAB (Time Pending) http://www.practicepython.org/exercise/2014/04/02/09-guessing-game-one.html







###################
# FILES & STREAMS #
###################
'''
========= ===============================================================
Character Meaning
--------- ---------------------------------------------------------------
'r'       open for reading (default)
'w'       open for writing, truncating the file first
'x'       create a new file and open it for writing
'a'       open for writing, appending to the end of the file if it exists
'b'       binary mode
't'       text mode (default)
'+'       open a disk file for updating (reading and writing)
========= ===============================================================
    
'''
# First let's create a file
f = open('tester.txt', 'x')

# Where did the file go? Find working directory!
import os
print(os.getcwd())

# Change working directory?
os.chdir(r'c:/temp')

# or with full path
f1 = open(r'c:\temp\tester1.txt', 'x')

# Write-to and close the file.
f.write('Hello File')
f.close()

# Now open it for reading and writing
f = open('tester.txt', 'r+')
f.read()

# Find out where the cursor is
f.tell()
f.read()  # This will fail because the cursor is at the end of the file.

# Move the cursor
f.seek(0)
f.read()  # There we go

# Write Multiple Lines
colors = ['red', 'blue', 'green', 'purple', 'yellow', 'orange']
f.seek(0)
f.truncate()

# Write a list with each item on a separate line
f.write('\n'.join(colors))

# using 'r' before the file path turns it into a raw string literal
# this makes it easy because there is no need to comment out the '\'
logs = open(r'd:\drive\usu\fall_2018\mod_3\access.log')
logs.close()

# "with" statement (Similar to "using" in C# / .NET if you are familiar with disposables)
# When we use the with statement it will close the file for us when it is done reading...
# same as f.open and then f.close

all_404_errors = []
with open(r'd:\drive\usu\fall_2018\mod_3\access.log') as f:
    for line in f:
        if '404' in line:
            all_404_errors.append(line) # add to new list

[print(line, '\n') for line in all_404_errors]

new_file = open(r'404_errorsA.log', 'x')
new_file.write('\n'.join(all_404_errors))