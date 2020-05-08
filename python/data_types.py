# @ data types

# Built-In Python Object Types
# Numbers
# bullion
# Strings
# Lists
# Dictionaries
# Tuples
# Sets

# Sequences (Lists, Strings, Tuples)
# Mappings (Dictionaries)

# # bullion and none
# must be capitalized
# True, False
Python_course = True
Java_course = False
print(int(Python_course))
print(int(Java_course))
print(str(Python_course)) # string interpretation
# None is like NULL
aliens_found = None

# # integers and floats
# decimals more accurate then floats
# ? also see numbers.py
answer = 42
answer += 42
print(answer)
answer -= 42
print(answer)
answer *= 2
print(answer)
answer /= 2
print(answer)
pi = 3.14159
print(answer + pi)
print(pi)
print(int(pi))
print(int(answer + pi))
print(float(answer + pi))

# # strings
# strings can be used like 'hello world' = "hello world" = """hello world""" 
print('hello world')
print("hello World")
print("""hello world""")
print("\"\"hello world\"\"")
# string functions
print('hello world'.capitalize())
print('hello world'.replace("o", "*"))
print('hello world'.isalpha())
print('123'.isdigit())
print('some,csv,values'.split(",")) # turns into an array/list
# interjecting variables into a string
name = "Bob"
machine = "HAL"
print("Nice to meet you {0}. My name is {1}".format(name, machine))
print("First is %s, Last is %s" % ('Ken', 'Shabby'))
print('First is {0}, Last is {1}'.format('The', 'Knight'))
print('First is {}, Last is {}'.format('Spiny', 'Norman'))
print('First is {first}, Last is {last}'.format(first='Spiny', last='Norman'))
print('The U.S. Debt is {:,}'.format(17701622650999)) # The U.S. Debt is 17,701,622,650,999
# * another way to do it, preferred way, interjecting variables into a string
print(f"Nice to meet you {name}. My name is {machine}")
print(f'Nice to meet you {name}. My name is {machine}')
# concatenation, string injection of variables above
str1 = 'Your'
str2 = 'face'
str3 = str1 + " " + str2 + "!"
print(str3)
str4 = 'Hi'
str4 += ' there!'
print(str4)
# accessing string characters
print(str4[0])
print(str4[0:4]) # slice
print(str4[-1])
# turn things into a string
num = 100
print(type(num), num)
print(type(str(num)), str(num))
# timesing strings 
print("So so!!!\n" * 22)
# some string functions
# .find – Returns left most index of the search string, or -1 if not found.
some_string = 'A long string to search'
print(some_string.find('long'))
# .join – Joins each item in the sequence together
print('.'.join('Knights')) #K.n.i.g.h.t.s
# upper and lower
print('Knights'.lower())
print('Knights'.upper())
# .replace… e.g.
print('Hello my naem is, hello my naem is, hello my naem is'.replace('naem','name'))
# .strip
print('    Hello!!!    ')
print('    Hello!!!    '.strip())



# # list (array)
student_names = []
student_names = list()
# or
student_names = ["Joe", "Russell", "sam", "Gill"]
print(student_names)
print(student_names[1])
print(student_names[-1])
# copy list
student_names2 = list(student_names) # copy, not reference
# replace list value
student_names[1] = "I-soso"
print(student_names)
# add to list
student_names.append("Homer")
print(student_names)
# or
print(student_names + ['Rayla'])
# in list
print("Joe" in student_names)
print(str("Joe" in student_names))
# count/length/len
print(len(student_names))
# remove list item 
del student_names[1]
print(student_names)
# slicing
student_names = ["Joe", "Russell", "sam", "Gill"]
# get all after the first item
print(student_names[1:])
# ignore the first and the last item
print(student_names[1:-1])
# string list into array
string_list = 'Snickers::$0.98::33'.split('::')
print(string_list)
string_list2 = '1,2,3,4,5,6,7,8,9,10'.split(',')
print(string_list2)
# sort 
l = [5,3,4,2,1]
l.sort()
print(l)
cars = ['Ford', 'BMW', 'Volvo']
cars.sort()
print(cars)
cars = ['Ford', 'BMW', 'Volvo']
cars.sort(reverse=True)
print(cars)


# # dict/dictionary (Associative array or object)
food = {'food': 'spam', 'taste': 'yum'} 
print(food)
print(food['food'])


# # sets
# Sets are like lists but they are required to have only unique items. This makes them useful for storing things like colors, or number lookup tables. 
# * You cannot access items in a set by referring to an index, since sets are unordered the items has no index.
colors = {'red','blue','green'}
print(colors)
this_set = {"apple", "banana", "cherry"}
this_set.add("orange")
print(this_set)
print("banana" in this_set)
this_set = {"apple", "banana", "cherry"}
this_set.update(["orange", "mango", "grapes"])
print(this_set)
thisset = {"apple", "banana", "cherry"}
for x in thisset:
  print(x)

# # tuple
# Just like lists, but they are immutable, meaning they can’t be changed. 
# Created using comma separated values or empty parentheses. 
# tuple() will convert a value to a tuple.
list1 = ["apple", "banana", "cherry"]
print(list1)
list_to_tuple = tuple(list1)
print(list_to_tuple)
print(list_to_tuple[2])
tuple1 = ('Hello','World')
print(tuple1)
print(tuple1[1])

# # Immutable – Unchanging over time or unable to be changed once created. 
# Numbers
# Strings, 
# Tuples

# # Mutable – Liable to change after creation. 
# Lists, 
# Dictionaries



