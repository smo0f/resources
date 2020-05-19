"""
MIS 5400 Module 2 Homework Solution
"""


##############
# Exercise 1 #
##############
'''
Assume that we execute the following assignment statements: width = 17 height = 12.0 For each of the following 
expressions, write the value of the expression and the type (of the value of the expression).

width/2
width/2.0
height/3
1 + 2 * 5 Use the Python interpreter to check your answers.
'''
width = 17
height = 12.0


print('Value:',width/2)
print('Type:',type(width/2))
# Value: 8.5
# Type: <class 'float'>

# NOTE: On the expression above (width/2) Python 3 uses the more complex numeric type (float). However, in Python 2
# the result would have been 8, with a type of "int". Python 3 also allows us to do "floor" division as follows:
# width // 2

print('Value:',width//2)
print('Type:',type(width//2))
# Value: 8
# Type: <class 'int'>


print('Value:',width/2.0)
print('Type:',type(width/2.0))
# Value: 8.5
# Type: <class 'float'>


print('Value:',height/3)
print('Type:',type(height/3))
# Value: 4.0
# Type: <class 'float'>


print('Value:',1 + 2 * 5)
print('Type:',type(1 + 2 * 5))
# Value: 11
# Type: <class 'int'>


###############
# Exercise 2 #
###############
'''
You've finished eating at a restaurant, and received this bill:

Cost of meal: $44.50
Restaurant tax: 6.75%
Tip: 15%
You'll apply the tip to the overall cost of the meal (including tax).
Steps to follow:

1) First, let's declare the variable meal and assign it the value 44.50.

2) Now let's create a variable for the tax percentage: The tax on your receipt is 6.75%. You'll have to divide 6.75 by 100 
in order to get the decimal form of the percentage. 
Create the variable tax and set it equal to the decimal value of 6.75%.

3) You received good service, so you'd like to leave a 15% tip on top of the cost of the meal, including tax. 
Before we compute the tip for your bill, let's set a variable for the tip. 
Again, we need to get the decimal form of the tip, so we divide 15.0 by 100. 
Set the variable tip to decimal value of 15% .

4) Reassign in a Single Line We've got the three variables we need to perform our calculation, 
and we know some arithmetic operators that can help us out. (For example, we could say spam = 7, 
then later change our minds and say spam = 3.) Reassign meal to the value of itself + itself * tax.

5) We're only calculating the cost of meal and tax here. We'll get to the tip soon. 
Let's introduce on new variable, total, equal to the new meal + meal * tip.

6) Insert at the end this code `print("%.2f" % total). 
This code print to the console the value of total with exactly two numbers after the decimal.
'''
meal = 44.50
tax = .0675 # 6.75/100
tip = .15   # 15/100

meal = meal + (meal * tax)
total = meal + (meal * tip)

print("%.2f" % total)


##############
# Exercise 3 #
##############
'''
Practicing with string variables, follow the steps:

create the variable my_string and set it to any string you'd like.
print the length of my_string.
print my_stringon capital letters.
'''
my_string = 'A shrubbery.'
print(len(my_string))
print(my_string.upper())

##############
# Exercise 4 #
##############
'''
Write a program to prompt the user for hours and rate per hour to compute gross pay. The data should be:

Enter Hours: 35
Enter Rate: 2.75
Pay: 96.25
'''
hours = float(input('Enter Hours'))
rate = float(input('Enter Rate'))

print('Hours:', hours)
print('Rate:', rate)
print('Pay:', hours * rate)

##############
# Exercise 5 #
##############
'''
Print the date and time together in the form: mm/dd/yyyy hh:mm:ss.
'''
from datetime import datetime
print(datetime.now().strftime('%m/%d/%Y %H:%M:%S'))

##############
# Exercise 6 #
##############
'''
Write a program which prompts the user for a Celsius temperature,convert the temperature 
to Fahrenheit and print out the converted temperature. Note:` ºC *9/5 +32 = ºF
'''
c_temp = float(input('Enter the Temperature in Celsius please...'))
f_temp = c_temp * 9/5 + 32
print('It is',f_temp,'ºF')





