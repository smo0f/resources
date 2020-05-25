# @ functions

# function
def add(num1, num2):
    return num1 + num2

print(add(5,10))

# other example
def question_one(input):
    if len(input) < 4:
        raise Exception('String must be at least 3 characters.')

    return input.capitalize().replace('z', '5').replace('s', '5')

# other example
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

# other example
def dedupe(list_one, list_two):
    # add the lists to gether, make them unique, and then turn it back into a list
    temp_list = list(set(list_two + list_one))
    # return list
    return temp_list

# other example
def is_palindrome(string = 'kayak'):
    # get original strain
    first_string = string.lower().replace(' ', '')
    # get comparisons during
    second_string = first_string[::-1]
    # return true or false, whether or not itt is a palindrome
    return True if first_string == second_string else False

# kwargs
def display(**kwargs):
    for key, value in kwargs.items():
        print(f'{key}: {value}')

display(fun='stuff', gogo='other')
print('')
display(f_name='Russell', l_name='Moore', age=32)

# Docstrings - String literal as the first thing in a function
def speak():
    """
    Speak will make a wonderful animal sound
    """
    print('Heeeelllllooooo!!!!!!!')

help(speak)

# test stuff in mod 4 & 5
