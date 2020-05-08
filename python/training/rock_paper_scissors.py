# # import
import random

# # game variables
game = True
player_one_wins = 0
player_two_wins = 0
draws = 0

while game:
    # # user input
    player_one_action = input('\nWhat is your choice between rock(1), paper(2), scissors(3)? ')
    # check to see if were  ending the game
    if player_one_action == 'exit':
        print(f'You have successfully left the game!!! Player one won: {player_one_wins} times, player two won: {player_two_wins} times. There were also {draws} draws.')
        game = False
        continue
    # if they pass a number in hurry and switch it to the string form
    if player_one_action.isnumeric():
        player_one_action = int(player_one_action)
        if player_one_action == 1:
            player_one_action = 'rock'
        elif player_one_action == 2:
            player_one_action = 'paper'
        elif player_one_action == 3:
            player_one_action = 'scissors'
        else:
            player_one_action = ''

    # # list of choices
    choices = ['rock', 'paper', 'scissors']

    # # AI input
    player_two_action = random.choice(choices)

    # # see who one
    if player_one_action in choices:
        if player_one_action == player_two_action:
            draws += 1
            print(f'**It was a DRAW!** Player one: {player_one_action}, player two: {player_two_action}.')
        elif player_one_action == 'rock':
            if player_two_action == 'paper':
                player_two_wins += 1
                print(f'**player TWO won!** Player one: {player_one_action}, player two: {player_two_action}.')
            elif player_two_action == 'scissors':
                player_one_wins += 1
                print(f'**player ONE won!** Player one: {player_one_action}, player two: {player_two_action}.')
        elif player_one_action == 'paper':
            if player_two_action == 'scissors':
                player_two_wins += 1
                print(f'**player TWO won!** Player one: {player_one_action}, player two: {player_two_action}.')
            elif player_two_action == 'rock':
                player_one_wins += 1
                print(f'**player ONE won!** Player one: {player_one_action}, player two: {player_two_action}.')
        else:
            if player_two_action == 'rock':
                player_two_wins += 1
                print(f'**player TWO won!** Player one: {player_one_action}, player two: {player_two_action}.')
            elif player_two_action == 'paper':
                player_one_wins += 1
                print(f'**player ONE won!** Player one: {player_one_action}, player two: {player_two_action}.')
    else:
        print(f'You did not provide one of the options rock, paper, scissors. You provided {player_one_action}.')






    # # old    
    # see who one
    # if player_one_action in choices:
    #     if player_one_action == 'rock':
    #         if player_two_action == 'paper':
    #             print(f'**player TWO won!** Player one: {player_one_action}, player two: {player_two_action}.')
    #         elif player_two_action == 'scissors':
    #             print(f'**player ONE won!** Player one: {player_one_action}, player two: {player_two_action}.')
    #         else:
    #             print(f'**It was a DRAW!** Player one: {player_one_action}, player two: {player_two_action}.')
    #     elif player_one_action == 'paper':
    #         if player_two_action == 'scissors':
    #             print(f'**player TWO won!** Player one: {player_one_action}, player two: {player_two_action}.')
    #         elif player_two_action == 'rock':
    #             print(f'**player ONE won!** Player one: {player_one_action}, player two: {player_two_action}.')
    #         else:
    #             print(f'**It was a DRAW!** Player one: {player_one_action}, player two: {player_two_action}.')
    #     else:
    #         if player_two_action == 'rock':
    #             print(f'**player TWO won!** Player one: {player_one_action}, player two: {player_two_action}.')
    #         elif player_two_action == 'paper':
    #             print(f'**player ONE won!** Player one: {player_one_action}, player two: {player_two_action}.')
    #         else:
    #             print(f'**It was a DRAW!** Player one: {player_one_action}, player two: {player_two_action}.')
    # else:
    #     print(f'You did not provide one of the options rock, paper, scissors. You provided {player_one_action}.')