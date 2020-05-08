# print statement
print("Hello World")

# # integers and floats
answer = 42
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
# string functions
print('hello world'.capitalize())
print('hello world'.replace("o", "*"))
print('hello world'.isalpha())
print('123'.isdigit())
print('some,csv,values'.split(","))
# interjecting variables into a string
name = "Bob"
machine = "HAL"
print("Nice to meet you {0}. My name is {1}".format(name, machine))
# another why to do it
print(f"Nice to meet you {name}. My name is {machine}")

# # bullion and none
Python_course = True
Java_course = False
print(int(Python_course))
print(int(Java_course))
print(str(Python_course)) # string interpretation
# None is like NULL
aliens_found = None

# # if statments
# no type juggling
number = 5
if number == 5:
    print("Number is five")
else:
    print("Number is NOT five")
# not 
if number != "5":
    print("Number is five")
else:
    print("Number is NOT five")
# truthy and falsity values 
text = "Joe"
if number:
    print("Number passed, truthy")
if text:
    print("text passed, truthy")
# falsity = "", 0, None
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
# ternary if statement
a = 1
b = 2
print("bigger" if a > b else "smaller")

# # lists/array
student_names = []
# or
student_names = ["Joe", "Russell", "sam", "Gill"]
print(student_names)
print(student_names[1])
print(student_names[-1])
# replace list value
student_names[1] = "I-soso"
print(student_names)
# add to list
student_names.append("Homer")
print(student_names)
# in list
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