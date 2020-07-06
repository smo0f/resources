# Write the following code in a .py file and upload it:
# * to run: python python/MIS-5400/exam1/guess2.py 

# Using the random module in the Python standard library generate a number between 1 - 10. 
# Using while(True) prompt a user to guess a number between 1 - 10. 
# Continue to prompt the user for another guess until the guess the correct number, then exit the loop and print an awesome congratulatory message. 
# Also - Tell the user if they guessed too high or too low. 


# # code starting here ===============================================================================

from random import randint

playing = True

while playing:
    user_input = input('\nGuess a number between 1 and 10. ')

    rand_int = randint(1,10)
    
    if user_input.isnumeric():
        user_input = int(user_input)
        if int(user_input) == rand_int:
            print('Congratulations you guessed correctly!')
            break
        else:
            guess_type = 'high' if rand_int - user_input < 0 else 'low'
            print(f'Sorry the number was {rand_int}, you were {abs(rand_int - user_input)} off! You guessed to {guess_type}.')

print('Thanks for playing, goodbye!')