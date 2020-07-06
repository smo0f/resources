# Write the following code in a .py file and upload it:
# * to run: python python/MIS-5400/exam1/talk.py 

# Define a function named "talk" that accepts the following parameters:

# name - required
# age - optional parameter - default value should be 21
# occupation - required parameter
# In the body of the function do the following:

# Make sure the name contains no numeric digits (0-9) - If not raise Exception
# Make sure the age is not a negative value or over 150 - If not raise Exception
# If the first letter in the name is between 'A' and 'M' then return a string result of 'Group 1'
# If the first letter in the name is between 'N' and 'Z' then return a string result of 'Group 2'

# Define a function named "talk" that accepts the following parameters:
# name - required
# age - optional parameter - default value should be 21
# occupation - required parameter
def talk(name, occupation, age=21):
    # In the body of the function do the following:
    # Make sure the name contains no numeric digits (0-9) - If not raise Exception
    if not name.isalpha():
        raise Exception('The parameter "name" can have no numeric digits.')
    # Make sure the age is not a negative value or over 150 - If not raise Exception
    if age < 0 or age > 150:
        raise Exception('The parameter "age" must be between the digits of 0 - 150.')
    # If the first letter in the name is between 'A' and 'M' then return a string result of 'Group 1'
    if name[0].lower() >= 'a' and name[0].lower() <= 'm':
        return 'Group 1'
    # If the first letter in the name is between 'N' and 'Z' then return a string result of 'Group 2'
    if name[0].lower() >= 'n' and name[0].lower() <= 'z':
        return 'Group 2'


# Using the talk function defined above, show an example innovation of the function using the following, alternative ways:

# 1) Using all of the default parameters

# 2) Overriding the default age parameter

# 3) Using named-parameters, invoke with the parameters in the following order: age, name, occupation. 

# 4) Invoke the function using a try / except statement that "handles" the raised exception and prints out "Try Again..."

# # code starting here ===============================================================================

# 1) Using all of the default parameters
print(talk('Russell', 'Developer'))

# 2) Overriding the default age parameter
print(talk('Sam', 'UX Designer', 33))

# 3) Using named-parameters, invoke with the parameters in the following order: age, name, occupation. 
print(talk(age=33, name='Jill', occupation='UI Designer'))

# 4) Invoke the function using a try / except statement that "handles" the raised exception and prints out "Try Again..."
try:
    talk('Sam', 'UX Designer', -10)
except Exception as e:
    print(e)
    print("Try Again...")