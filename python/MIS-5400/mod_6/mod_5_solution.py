"""
MIS 5400 Module 5 Homework Solution
"""

##############
# Question 1 #
##############
'''
Define a function that meets the following reqs:
1. Accepts a string > 3 characters.
2. If the string is less than 4 characters throw an Exception with an appropriate message.
3. Capitalizes ONLY the first letter in the sentence.
4. Replaces all letters 'z' or 's' with '5'.
5. Returns the new string (with capitalization and replaced letters)
'''

def question_one(input):

    print(type(input))
    if len(input) < 4:
        raise Exception('String must be at least 3 characters.')

    updated_string = input.replace('z', '5').replace('s', '5').capitalize()
    return updated_string, '100'



##############
# Question 2 #
##############
'''
Define a function that meets the following reqs:
1. Accepts a string > 3 characters.
2. If the string is less than 4 characters throw and Exception with an appropriate message.
3. If the string contains any non-alpha characters, throw an appropriate message
4. Make all of the characters in the string lowercase
5. Reverse the string
6. Return the new string.
'''
def question_two(input):
    if len(input) < 4:
        raise Exception('String must be at least 3 characters.')

    if not input.replace(' ','').isalpha():
        raise Exception('String must contain all characters')

    return input.lower()[::-1]

##############
# Question 3 #
##############
'''
Define a function that meets the following reqs:
1. Accepts 3 string parameters, a full sentence, a string to be replaced, and the string to replace it with
2. This function should take a full string, and replace all instances of the "string to be replaced" with
   the "string to replace"...
3. for example: func("Hello World", "Hello", "Good Bye") would return "Good Bye World"
'''
def question_three(sentence, word_to_be_replaced, new_word):
    return sentence.replace(word_to_be_replaced, new_word)


#########
# TESTS #
#########

def test_question_one():
    # TEST REQ 1 - two chars should fail (This one expects an exception)
    print('Testing 3 char requirement')
    try:
        output = question_one('ab')
    except Exception as e:
        print('SUCCESS. Test one passed... An exception was thrown with 2 chars.')
    else:
        print ('FAILURE. No Exception was thrown with 2 chars!')

    # TEST REQ 2 / REQ 3 - capitalize first character (We don't expect an exception to be thrown on this one)
    print('Testing capitalization requirement.')
    test_sentence = 'this is all lowercaze.'
    expected_result = 'Thi5 i5 all lowerca5e.'

    actual_result = question_one(test_sentence)

    if actual_result != expected_result:
        print('FAILURE. Actual result did not match expected result.')
    else:
        print('SUCCESS. Actual result matched expected result.')


def test_question_two():
    # TEST REQ 1 - two chars should fail (This one expects an exception)
    print('Testing 3 char requirement')
    try:
        output = question_two('ab')
    except Exception as e:
        print(f'SUCCESS. Test one passed... Following exception was thrown with 2 chars: {e}')
    else:
        print('FAILURE. No Exception was thrown with 2 chars!')

    # TEST REQ 2  - Expect error if not alpha
    print('Testing alpha requirement. Part 1')
    try:
        test_sentence = 'contains a numb3r'
        question_two(test_sentence)
    except Exception as e:
        print('SUCCESS. Test Q2, Req 2 Passed, an exception was thrown for non-alpha.')
    else:
        print('FAILURE. No Exception was thrown with non-alpha char.')

    # TEST REQ 2  - Make sure all alpha passes
    print('Testing alpha requirement. Part 2')
    try:
        test_sentence = 'does not contain a number'
        question_two(test_sentence)
    except Exception as e:
        print('FAILURE. Alpha string threw exception')
    else:
        print('SUCCESS. No exception was thrown for all alpha string')

    # TEST REQ 3/4 - Reverse and lower
    print('Testing reverse and lowercasing requirement')
    test_sentence = 'ALLUPPER'
    expected_result = 'reppulla'

    actual_result = question_two(test_sentence)
    if actual_result != expected_result:
        print('FAILURE! REQ 3/4 of Exercise 2 FAILED!')
    else:
        print('SUCCESS. Input string successfully lowered and reversed.')


def test_question_three():
    try:
        print('Testing Exercise 3')
        test_full_sentence = 'Something in here is going to get replaced! Ahhhhh!'
        test_to_be_replaced_string = '!'
        test_to_replace_with_string = '.'
        expected_result = 'Something in here is going to get replaced. Ahhhhh.'

        acutal_result = question_three(test_full_sentence, test_to_be_replaced_string, test_to_replace_with_string)
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
