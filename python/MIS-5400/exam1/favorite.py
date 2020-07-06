# Write the following code in a .py file and upload it:
# * to run: python python/MIS-5400/exam1/favorite.py 


# 1) Get the following input from a user and assign the responses to a variable

# Name
# Favorite Color
# Favorite Food
# Favorite Number

# 2) Using conditional logic / statements do the following:

# 3) If the name is "monster", regardless of casing (upper, lower, mixed) - print out "raaaaawr"

# 4) If the favorite food is any one of the following  "cheese", "beef", "cream", "orange juice", then print out "ah I see you like [insert favorite food here]!" (hint - use string formatting). 

# 5) If their favorite number is divisible by 5 then print out "That's another...... high five!"


# # code starting here ===============================================================================

# Name
name = input('What is your name? ').lower()
# 3) If the name is "monster", regardless of casing (upper, lower, mixed) - print out "raaaaawr"
if name == 'monster':
    print("raaaaawr")

# Favorite Color
color = input('What is your favorite Color? ').lower()

# Favorite Food
food = input('What is your favorite food? ').lower()
# 4) If the favorite food is any one of the following  "cheese", "beef", "cream", "orange juice", then print out "ah I see you like [insert favorite food here]!" (hint - use string formatting). 
list_of_food = ["cheese", "beef", "cream", "orange juice"]
if food in list_of_food:
    print(f"ah I see you like {food}!")

# Favorite Number
# assuming that we get a correct input
number = int(input('What is your favorite number? '))
# 5) If their favorite number is divisible by 5 then print out "That's another...... high five!"
if number % 5 == 0:
    print("That's another...... high five!")