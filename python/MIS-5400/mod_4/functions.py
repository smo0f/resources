
#############
# Functions #
#############

# When to create a function ?
























































# When the code is needed more than once.
# Remember the best coders are lazy!
# If code can be re-used, just do it.


# Syntax
# First define the function
def speak():
    print('Woof!')


# Once it has been defined we can invoke it.
speak()

# Defining with parameters
def speak(animal):
    if animal.lower() == 'dog':
        print('Woof!')
    elif animal.lower() == 'cat':
        print('Meow')
    elif animal.lower() == 'human':
        print('Hello')
    elif animal.lower() == 'knight':
        print('Ni!')
    else:
        print('mmaaaaaaaarrrrr!')


speak('Knight')
speak('beast')



# Multiple Parameters
def speak(animal, decibel):
    sound = ''
    if animal.lower() == 'dog':
        sound = 'Woof'
    elif animal.lower() == 'cat':
        sound = 'Meow'
    elif animal.lower() == 'human':
        sound = 'Hello'
    elif animal.lower() == 'knight':
        sound = 'Ni'
    else:
        sound = 'mmaaaaaaaarrrrr'

    sound += decibel
    print(sound)

# Invoking with named-parameters
speak(decibel='!!!!', animal='knight')


# Default Parameters
def speak(sound, decibel='!'):
    print(sound + decibel)


speak('Moo') # Will use the default parameter for decibel
speak('Mooo', '!!!!!!!')



# Return Values
def get_a_quote():
    return '''Are you sure you're not an encyclopedia salesman?" No, Ma'am. Just a burglar, come to ransack the flat.'''

a_quote = get_a_quote()
print(a_quote)


# Make sure you don't leave out the () when invoking a function
a_quote = get_a_quote # This will just make a_quote reference a function object


from datetime import datetime
def get_my_age(year_of_birth):
    return datetime.now().year - year_of_birth


# Docstrings - String literal as the first thing in a function
def speak():
    """
    Speak will make a wonderful animal sound
    """
    print('Heeeelllllooooo!!!!!!!')



help(speak)
