##############
# Exceptions #
##############

# All built-in exception types: https://docs.python.org/3/library/exceptions.html
# All exceptions are derived from the BaseException type.

# try, except, else, finally... and raise


# Below shows how to catch 2 specific types of errors (ValueError and ZeroDivisionError)

try:
    x = int(input('Put in a number: '))
    y = int(input('Put in another number: '))

    result = x / y
except ZeroDivisionError:
    print('Number cannot be 0!')
except ValueError:
    print('Value must be a number!')
except Exception as e:
    print('This is an unknown error type')
else:  # Runs when no exceptions are thrown
    print('Good jerb! No Exceptions!')
    print(result)
finally:  # Runs regardless of if an exception is thrown or not. (Close streams, etc..)
    print('Thanks for playing')


# Catching Multiple Exceptions (2 ways)
try:
    x = int(input('Put in a number: '))
    y = int(input('Put in another number: '))
    result = x / y
except (ZeroDivisionError, ValueError):
    print('Number cannot be 0 and must be a number')
else:  # Runs when no exceptions are thrown
    print(result)
finally:  # Runs regardless of if an exception is thrown or not. (Close streams, etc..)
    print('Thanks for playing')



# Getting Details on the exception object
try:
    x = int(input('Put in a number: '))
    y = int(input('Put in another number: '))

    result = x / y
    if x == 13:
        raise Exception("This will show as the error if we type 13")

except Exception as e:
    print(e)
else:  # Runs when no exceptions are thrown
    print(result)
finally:  # Runs regardless of if an exception is thrown or not. (Close streams, etc..)
    print('Thanks for playing')


# Raise
# Get input from the user, if they don't type "delete" then throw and exception
try:
    should_be_delete = input('Please type ''delete'' to delete.')
    if should_be_delete.lower() != 'delete':
        raise Exception("delete was not typed!")
except Exception as e:
    print(e)
else:  # Runs when no exceptions are thrown
    print(should_be_delete)
finally:  # Runs regardless of if an exception is thrown or not. (Close streams, etc..)
    print('Thanks for playing')