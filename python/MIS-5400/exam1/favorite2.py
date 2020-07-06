# Write the following code in a .py file and upload it:
# * to run: python python/MIS-5400/exam1/favorite2.py 
 
# 1) Prompt a user for their name, age, and favorite color.

# 2) Assign each value to a variable. 

# 3) Use your preferred Python string formatter to print out the following:

# "Hello {insert_name_here}, I didn't know {insert_age_here} year old's liked {insert_favorite_color_here} so much!"

# Make sure to include all punctuation (apostrophes included).
 

# # code starting here =============================================================================== 

# 1) Prompt a user for their name, age, and favorite color.
# 2) Assign each value to a variable.
name = input('What is your name? ')
age = input('What is your age? ')
color = input('What is your favorite color? ')

# 3) Use your preferred Python string formatter to print out the following:
# "Hello {insert_name_here}, I didn't know {insert_age_here} year old's liked {insert_favorite_color_here} so much!"
# Make sure to include all punctuation (apostrophes included).
print(f"Hello {name}, I didn't know {age} year old's liked {color} so much!")