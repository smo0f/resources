# Write the following code in a .py file and upload it:

# Create a new list that contains:

# a string
# another list
# a dictionary
# Use a for loop or list comprehension to iterate through each item in the list and print out it's type. ( you can do this with the built-in "type" function)

new_list = ['a string', ['another list', 1, 2, 3], {'a': 'dictionary'}]
for item in new_list:
    print(type(item))