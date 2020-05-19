######################################################
#   MIS 5400
#   Module 4 Homework
#
#   --------------------------------------------------
#   Instructions:
#
#   1. Do exercises 1 - 4 below.
#   2. Make sure all tests pass.
#
######################################################
# * to run: python python/MIS-5400/mod_4/mod_4_hmwk.py 
import random

###################
# SAMPLE QUESTION #
###################
'''
 Write a function named add_me that accepts two numbers, adds them, then returns the result.
'''

###############################################################################################
def add_me(num_one, num_two):
    return num_one + num_two


##############
# Exercise 1 #
##############
'''
    Write a function function named "dedupe" that accepts two lists as parameters, for example
    dedupe(list_one, list_two).

    The function will return a new list that contains only unique values that occurred in either
    one of the lists.
'''
###############################################################################################

# WRITE CODE HERE
def dedupe(list_one, list_two):
    # add the lists to gether, make them unique, and then turn it back into a list
    temp_list = list(set(list_two + list_one))
    # return list
    return temp_list

# verify functions performance
# print(dedupe([0,1,2,3,4,5], [0,4,5,6,7,8,9,10]))
# print(dedupe(['Buzz light year', 'Bo Peep', 'Jesse', 'Woody'], ['Woody', 'Buzz light year', 'Rex', 'Mr. Potato Head']))

# list1 = [0,4,5,6,7,8,9,10]
# list2 = [0,1,2,3,4,5]
# new_list = dedupe(list1, list2)
# print(new_list, type(new_list))


##############
# Exercise 2 #
##############
'''
    "NOTE: A 'palindrome' is: a word, phrase, or sequence that reads the same backward as forward, e.g., 'madam' or 'nurses run'."

    Write a function named "is_palindrome" that does the following:
    1. The function should have one parameter, with a default value of 'kayak'
    2. The function should check the given string, and determine if string is a palindrome.
    3. The function should return True if the string is a palindrome, and return False if the string is not a palindrome.
    4. Make sure that the function is NOT case sensitive, meaning lower case or upper case letters will not affect the result.
    5. Also, make sure if the given string is a phrase (eg. 'nurses run'), that any white spaces are removed from string BEFORE checking if palindrome.
'''

###############################################################################################



# WRITE CODE HERE
def is_palindrome(string = 'kayak'):
    # get original strain
    first_string = string.lower().replace(' ', '')
    # get comparisons during
    second_string = first_string[::-1]
    # return true or false, whether or not itt is a palindrome
    return True if first_string == second_string else False

# verify functions performance
# print(is_palindrome('madam'))
# print(is_palindrome('nurses run'))
# print(is_palindrome('kayak'))

##############
# Exercise 3 #
##############
'''
    Write a function named "check_answer" that contains a 'Try and Except' statement. The goal of this function is to
    test if a user's input is the correct answer to a simple math problem.

    1. The function should have two parameters, x and y.
    2. The function should 'try' to ask the user what x + y equals.
    3. If the user answers correctly, print '{User's answer} is correct!' (Note: replace {User's answer} with the actual answer the user gave)
    4. If the user fails to answer correctly, raise an exception with the following 
       string as the description. '{User's answer} is not the correct answer!' (Note: replace {User's answer} with the actual answer the user gave)
    5. When exception is thrown, print out exception's description.

    NOTE: The values of x & y will be auto generated when script is ran.  You do not need to populate these values.
'''

# WRITE CODE HERE
def check_answer(x,y):
    # get the person's guess
    user_input = input(f'What is the answer to {x} + {y}? ')
    # check to see if they answered correctly
    try:
        answer = x + y
        if not (int(user_input) == answer):
            raise Exception(f'{user_input} is not the correct answer!')
    except ValueError:
        print('Your answer must be a number!')
    except Exception as e:
        print(e)
    else:  # if answer is correct show this
        print(f'{answer} is correct!')


#################################
# TESTS                         #
# DO NOT MODIFY BELOW THIS LINE #
#################################
#################################################################################################
# Sample Question
def test_sample_question():
    print('\n', '=============== Sample Exercise Test ===============')
    try:
        result = add_me(5, 8)
        if result != 13:
            raise Exception('add_me fails.')

        result = add_me(-5, 3)
        if result != -2:
            raise Exception('add_me fails.')

        print('Sample Question Passed! Great Job!')
    except:
        print('Ooops, please try the sample question again.')


# Question 1
def test_question_one():
    print('\n', '=============== Exercise 1 Test ===============')
    try:
        l_one = [1, 2, 3, 4, 1]
        l_two = [2, 5, 6, 7]
        deduped = dedupe(l_one, l_two)
        if (deduped.count(2) > 1) or len(deduped) < 7:
            raise Exception('dedup fails.')
        else:
            print('Question One Passed! Great Job!')
    except:
        print('Ooops, please try question one again.')


# Question 2
def test_question_two():
    print('\n', '=============== Exercise 2 Test ===============')
    try:
        if not is_palindrome():
            raise ValueError('Default parameter in is_palindrome() function failed.')
        elif not is_palindrome('nurses run'):
            raise ValueError('nurses run failed is_palindrome() test.')
        elif not is_palindrome('NurSes Run'):
            raise ValueError('NurSes Run failed is_palindrome() test.')
        else:
            print('Question Two Passed! Great Job!')
    except ValueError as e:
        print('Ooops, please try question two again.')
        print(e)


# Question 3
def test_question_three():
    print('\n', '=============== Exercise 3 Test ===============')
    x = random.randint(0, 10)
    y = random.randint(0, 10)
    check_answer(x, y)

#######################
# MAIN                #
# THIS RUNS THE TESTS #
# DO NOT MODIFY       #
#######################

if __name__ == '__main__':
    test_sample_question()
    test_question_one()
    test_question_two()
    test_question_three()