"""
#   Module 5 Exercises
#   Strings Lab
#
#   --------------------------------------------------
#   Instructions:
#
#   1) Create the functions for the 3 questions below.
#   2) Write the tests for each function
"""

# * to run: python python/MIS-5400/mod_5/mod_5_hmwk.py 

##############
# Question 1 #
##############
'''
Define a function that meets the following reqs:
1. Accepts a string > 3 characters.
2. If the string is less than 4 characters raise an Exception with an appropriate message.
3. Capitalizes ONLY the first letter in the sentence.
4. Replaces all letters 'z' or 's' with '5'.
5. Returns the new string (with capitalization and replaced letters)
'''

# question_one
def cap_and_replace(string):
    try:
        string_len = len(string)
        if string_len < 4:
            raise Exception(f'This function only allows strings that are larger than three characters. You passed in {string_len} characters.')
    except Exception as e:
        print(e)
        raise
    else: # if pass run this
        # replace strings
        string = string.lower().replace('z', '5')
        string = string.replace('s', '5')
        # capitalize first letter
        string = string[0].upper() + string[1:]
        # return string
        return string
    
# print(cap_and_replace('zopdksfor'))
# print(cap_and_replace('aopdksfor'))
# print(cap_and_replace('zz'))
    
##############
# Question 2 #
##############
'''
Define a function that meets the following reqs:
1. Accepts a string > 3 characters.
2. If the string is less than 4 characters raise an Exception with an appropriate message.
3. If the string contains any non-alpha characters (EXCLUDING SPACES), raise an appropriate message
4. Make all of the characters in the string lowercase
5. Reverse the string
6. Return the new string.
'''


# question_two
def alpha_reverse(string):
    # setting up default variables
    string_len = len(string)
    non_alpha = [letter for letter in string if not (letter.isalpha()) and letter != ' ']
    try:
        # [line.replace('redflag', 'greenlight') for line in lines if 'redflag' in line]
        if string_len < 4:
            raise ValueError(f'This function only allows strings that are larger than three characters. You passed in {string_len} characters.')
        elif len(non_alpha) > 0:
            raise ValueError(f'This function only allows alphanumeric strings. You passed in these {non_alpha} unauthorized characters.')
    except ValueError as e:
        print(e)
        raise
    else: # if pass run this
        # replace strings
        string = string.lower()[::-1]
        # return string
        return string

# print(alpha_reverse('gogo'))
# print(alpha_reverse('go go go go go go'))
# print(alpha_reverse('No way'))
# print(alpha_reverse('No'))
# print(alpha_reverse('No way!'))
# print(alpha_reverse('No w gofo klfkg :">?<{}!@#$%^&*()_+'))

# print('a'.isalpha())
# print(not 'a'.isalpha())
# print(' '.isalpha())
# print('A'.isalpha())
# print('5'.isalpha())
# print('@'.isalpha())

##############
# Question 3 #
##############
'''
Define a function that meets the following reqs:
1. Accepts 3 string parameters, a full sentence, a string to be replaced, and the string to replace it with
2. This function should take a full string, and replace all instances of the "string to be replaced" with the "string to replace"...
3. for example: func("Hello World", "Hello", "Good Bye") would return "Good Bye World"
'''


# question_three
def replace_string(full_sentence, string_to_be_replaced, string_to_replace_it):
    return full_sentence.replace(string_to_be_replaced, string_to_replace_it)

# print(replace_string('Hello World!', 'Hello', 'Good Bye'))
# print(replace_string('Hello World!', 'l', '!'))
# print(replace_string('Hello World!', 'o', '0'))

#########
# TESTS #
#########

def test_question_one():
    # TEST REQ 1 - two chars should fail (This one expects an exception)
    print('\n=============== Testing Question One ===============')
    print('--- Testing 3 char requirement ---')
    try:
        output = cap_and_replace('ab')
    except Exception as e:
        print('SUCCESS. Test one passed... An exception was raised with 2 chars.')
    else:
        print ('FAILURE. No Exception was raised with 2 chars!')

    # TEST REQ 2 / REQ 3 - capitalize first character (We don't expect an exception to be raised on this one)
    print('\n--- Testing capitalization requirement. ---')
    test_sentence = 'this is all lowercaze.'
    expected_result = 'Thi5 i5 all lowerca5e.'

    actual_result = cap_and_replace(test_sentence)

    if actual_result != expected_result:
        print('FAILURE. Actual result did not match expected result.')
    else:
        print('SUCCESS. Actual result matched expected result.')


def test_question_two():
    # TEST REQ 1 - two chars should fail (This one expects an exception)
    print('\n=============== Testing Question Two ===============')
    print('--- Testing 3 char requirement ---')
    try:
        output = alpha_reverse('ab')
    except Exception as e:
        print('SUCCESS. Test one passed... An exception was raised with 2 chars.')
    else:
        print('FAILURE. No Exception was raised with 2 chars!')

    # TEST REQ 2  - Expect error if not alpha
    print('\n--- Testing alpha requirement. Part 1 ---')
    try:
        test_sentence = 'contains a numb3r'
        alpha_reverse(test_sentence)
    except Exception as e:
        print('SUCCESS. Test Q2, Req 2 Passed, an exception was raised for non-alpha.')
    else:
        print('FAILURE. No Exception was raised with non-alpha char.')

    # TEST REQ 2  - Make sure all alpha passes
    print('\n--- Testing alpha requirement. Part 2 ---')
    try:
        test_sentence = 'does not contain a number'
        alpha_reverse(test_sentence)
    except Exception as e:
        print('FAILURE. Alpha string threw exception')
    else:
        print('SUCCESS. No exception was rased for all alpha string')

    # TEST REQ 3/4 - Reverse and lower
    print('\n--- Testing reverse and lowercasing requirement ---')
    test_sentence = 'ALLUPPER'
    expected_result = 'reppulla'

    actual_result = alpha_reverse(test_sentence)
    if actual_result != expected_result:
        print('FAILURE! REQ 3/4 of Exercise 2 FAILED!')
    else:
        print('SUCCESS. Input string successfully lowered and reversed.')


def test_question_three():
    print('\n =============== Testing Question Three ===============')
    try:
        print('--- Testing Exercise 3 ---')
        test_full_sentence = 'Something in here is going to get replaced! Ahhhhh!'
        test_to_be_replaced_string = '!'
        test_to_replace_with_string = '.'
        expected_result = 'Something in here is going to get replaced. Ahhhhh.'

        acutal_result = replace_string(test_full_sentence, test_to_be_replaced_string, test_to_replace_with_string)
        if acutal_result != expected_result:
            print('FAILURE! Test 3 Failed')
        else:
            print('SUCCESS. Test 3 Passed.')

    except Exception as ex:
        print('Ooops, please try question three again.', ex)


#######################
# MAIN                #
# THIS RUNS THE TESTS #
# DO NOT MODIFY       #
#######################

if __name__ == '__main__':
    test_question_one()
    test_question_two()
    test_question_three()
