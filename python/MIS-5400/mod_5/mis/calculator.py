# calculator.py
'''
This is the calculator Module! Woot!
'''
def add(num1, num2):
    '''
    Add accepts two number and returns the sum.
    '''
    return num1 + num2

def sub(num1, num2):
    '''
    Subtract num2 from num1
    '''
    return num1 - num2

def print_name():
    print('__name__ is', __name__)

def test_add():
    result = add(1,1)
    if result == 2:
        print('All tests Passed...')
    else:
        print('Fail...')

def test_sub():
    result = sub(3,1)
    if result == 2:
        print('All tests Passed...')
    else:
        print('Fail...')

if __name__ == '__main__':
    try:
        test_add()
        test_sub()
    except Exception as ex:
        print('Fail, error',ex)
