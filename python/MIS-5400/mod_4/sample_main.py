########
# MAIN #
########
# * to run: python python/MIS-5400/mod_4/sample_main.py 

# Imports go up top

from datetime import datetime


# Next we define the functions
def get_name():
    first = input('Hello! Please enter your first name:\n')
    last = input('Now enter your last name:\n')
    return '{0} {1}'.format(first, last)


def say_hello(name_in):
    current_time = datetime.now()

    if current_time.hour < 12:
        return 'Good Morning {0}'.format(name_in)
    elif current_time.hour < 18:
        return 'Good Afternoon {0}'.format(name_in)
    else:
        return 'Good Night {0}...'.format(name_in)


def do_some_math():
    return (10 ** 2)


def add(num1, num2):
    return num1 + num2


def say_goodbye(name_in):
    print('Good Bye', name_in)


# Now we can use them
if __name__ == '__main__':
    name = get_name()
    print(say_hello(name))
    print(do_some_math())
    added_nums = add(5,10)
    print(added_nums)
    say_goodbye(name)

