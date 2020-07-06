# Write the following code in a .py file and upload it:
# * to run: python python/MIS-5400/exam1/guess.py 

# Refer to the random module included in the Python Standard Library (https://docs.python.org/3/library/random.html (Links to an external site.))

# Use the module (including import command) to generate a random number number between 1 and 100. 

# Now provide a prompt for users to guess a number between 1 and 100.

# Print out how close the users guess was to the randomly generated number.

# For example, if the random number was 34 and the user guessed the number 50 you would print out - "Sorry the number was 34, you were 16 off!"... If the user guesses the correct number congratulate them :)


# # code starting here ===============================================================================

from random import randint

playing = True

print('\n***Type "exit" to leave the game.***')

while playing:
    user_input = input('\nGuess a number between 1 and 100. ')

    rand_int = randint(1,100)

    if user_input.lower() == 'exit':
        break
    
    if user_input.isnumeric():
        user_input = int(user_input)
        if int(user_input) == rand_int:
            print('Congratulations you guessed correctly!')
        else:
            print(f'Sorry the number was {rand_int}, you were {abs(rand_int - user_input)} off!')

print('Thanks for playing, goodbye!')