# * to run: python python/MIS-5400/mis_5400_mod_2.py 

# # Exercise 1
# Assume that we execute the following assignment statements: width = 17 height = 12.0 For each of the following expressions, write the value of the expression and the type (of the value of the expression).

width = 17 
height = 12.0

# 1.
# width / 2
# 8.5 <class 'float'>
print(width / 2, type(width / 2))

# 2.
# width / 2.0
# 8.5 <class 'float'>
print(width / 2.0, type(width / 2.0))

# 3.
# height / 3
# 4.0 <class 'float'>
print(height / 3, type(height / 3))

# 4.
# 1 + 2 * 5
# 11 <class 'int'>
print(1 + 2 * 5, type(1 + 2 * 5))


# # Exercise 2
# You've finished eating at a restaurant, and received this bill:
    # Cost of meal: $44.50
    # Restaurant tax: 6.75%
    # Tip: 15%
    # You'll apply the tip to the overall cost of the meal (including tax).
# First, let's declare the variable meal and assign it the value 44.50.
# Now let's create a variable for the tax percentage: The tax on your receipt is 6.75%. You'll have to divide 6.75 by 100 in order to get the decimal form of the percentage. Create the variable tax and set it equal to the decimal value of 6.75%.
# You received good service, so you'd like to leave a 15% tip on top of the cost of the meal, including tax. Before we compute the tip for your bill, let's set a variable for the tip. Again, we need to get the decimal form of the tip, so we divide 15.0 by 100. Set the variable tip to decimal value of 15% .
# Reassign in a Single Line We've got the three variables we need to perform our calculation, and we know some arithmetic operators that can help us out. (For example, we could say spam = 7, then later change our minds and say spam = 3.) Reassign meal to the value of itself + itself * tax.
# We're only calculating the cost of meal and tax here. We'll get to the tip soon. Let's introduce on new variable, total, equal to the new meal + meal * tip.
# Insert at the end this code `print("%.2f" % total). This code print to the console the value of total with exactly two numbers after the decimal.

meal = 44.50
tax = 6.75 / 100
tip = 15 / 100

meal = meal + meal * tax
total = meal + meal * tip
print("%.2f" % total)


# # Exercise 3
#Practicing with string variables, follow the steps:
# create the variable my_string and set it to any string you'd like.
my_string = 'Hello!'
# print the length of my_string.
print(len(my_string))
# print my_string capital letters.
print(my_string.upper())


# # Exercise 4
# Write a program to prompt the user for hours and rate per hour to compute gross pay. The data should be:
# Enter Hours: 35
# Enter Rate: 2.75
# Pay: 96.25

# assuming that we know they are passing in numbers
hours = float(input('Please enter in the number of hours you worked this week? ').strip())
rate = float(input('Please enter in your hourly rate. ').strip())

pay = hours * rate

print(f'Your gross pay for this week will be {round(pay, 2)}.')


# # Exercise 5
# Print the date and time together in the form: mm/dd/yyyy hh:mm:ss.

from datetime import datetime
date_now = datetime.now()
print(date_now.strftime("%m/%d/%Y %H:%M:%S"))

# # Exercise 6
# Write a program which prompts the user for a Celsius temperature,convert the temperature to Fahrenheit and print out the converted temperature. Note:` ºC *9/5 +32 = ºF

celsius = int(input('Please enter the temperature in celsius. ').strip())

fahrenheit = celsius * 9 / 5 + 32

print(f'The temperature in fahrenheit is {fahrenheit}.')
