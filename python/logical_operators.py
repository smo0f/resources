# @ logical operators
# # operators
# ==
print('a' == 'a')
# is
a = 1
print(a == 1)
print(a is 1)
a = [1,2,3]
b = [1,2,3]
print(a == b)
print(a is b) # two different lists, false
c = b
print(c is b) # same place in memory, true
# !=
print(90 != 100)
print('a' != 'A')
print(not False)
# >
print(150 > 100)
# <
print(90 < 100)
# >=
print(100 >= 100)
# <=
print(90 <= 100)

# # if statments
# no type juggling
number = 5
if number == 5:
    print("Number is five")
else:
    print("Number is NOT five")
# elif 
number = 9
if number == 5:
    print("Number is five")
elif number == 9:
    print("Number is nine")
elif number == 1:
    print("Number is one")
elif number == 2:
    print("Number is two")
else:
    print("Number is NOT five")
number = 5
# not 
if number != "5":
    print("Number is five")
else:
    print("Number is NOT five")
Python_course = True
aliens_found = None
if not aliens_found:
    print("got here, if not aliens_found")
if not Python_course:
    print("got here, if not Python_course") # won't pass
# multiple conditions
number = 3
# and
Python_course = True
if number == 3 and Python_course:
    print("got here, if number == 3 and Python_course")
# or
if number == "3" or Python_course:
    print("got here, if number == \"3\" and Python_course")
# ex
num = 32
if num % 2 != 0:
    print('odd')
else:
    print('even')

# # ternary if statement
a = 1
b = 2
print("bigger" if a > b else "smaller")

# # truthy and falsity values 
guess = None
values = {
    'empty list': [], # falsy
    'empty dictionary': {}, # falsy
    'empty string': "", # falsy
    'False': False, # falsy
    'True': True, # truthy
    'full list': [1,2,3], # truthy
    'full dictionary': {
        'name': 'Russell',
        'age': 32
    }, # truthy
    'None': None,  # falsy
    'guess': guess, # falsy 
    'zero': 0 # falsy 
}
for x in values:
    if values[x]:
        print(f"{x}: {values[x]} - truthy.")
    else:
        print(f"{x}: {values[x]} - falsy.")

# # loops
# https://app.pluralsight.com/player?course=python-getting-started&author=bo-milanovich&name=python-getting-started-m2&clip=7&mode=live
# for loop
student_names = ["Joe", "Russell", "sam", "Gill"]
for name in student_names:
    print(f"Nice to meet you {name}.")
# rang, how many times to run
x = 0
for index in range(10):
    x += 10
    print(f"The value of x is {x}.")  

# while loop # * from teacher
account_balance = 100
while account_balance >= 0:
    print(account_balance)
    account_balance -= 5 # Equivalent to account_balance = account_balance - 5
    if account_balance % 25 == 0:
        print('Another 25 down the drain')
print('Spam for dinner again....')

# * from teacher, For Loop -> Loop through a container or any object that has __iter__ a property
bag = ['A string', 13, ['a', 'b', 'c'], {'name': 'treasure chest'}]

print(dir(bag))  # note __iter__ property # * looks like a list of methods

for stuff in bag:
    print(stuff, type(stuff))

# * from teacher, Dictionaries
fav_colors = {"bob": 'Blue', "amy": 'Red', "sue": 'Yellow', "t-dog": 'Green'}
for name in fav_colors:
    print(name + "'s", 'favorite color is', fav_colors[name])

# * from teacher, Range -> Returns a sequence of numbers, by a specified step
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

#  other types of loops

print([num ** 2 for num in range(10)])

print([type(thing) for thing in ['A String', 13, ['a', 'b', 'c'], {'name': 'paul'}]])

# List Comprehensions with conditions 
groceries = ['Spam', 'Eggs', 'Cheese', 'Ham', 'Milk']
print([item for item in groceries if 'e' in item.lower()])

groceries = ['Spam', 'Eggs', 'Cheese', 'Ham', 'Milk']
print([item.lower() for item in groceries if 'e' in item.lower()])

# from mod 3 hmwk
lines2 = [line.replace('redflag', 'greenlight') for line in lines]

lines_greenlight = [line.replace('redflag', 'greenlight') for line in lines if 'redflag' in line]

# from Udemy
# ? https://www.udemy.com/course/the-modern-python3-bootcamp/learn/quiz/4373712#overview
def statistics(file_name):
    with open(file_name) as file:
        lines = file.readlines()
    return { "lines": len(lines),
            "words": sum(len(line.split(" ")) for line in lines),
            "characters": sum(len(line) for line in lines) }