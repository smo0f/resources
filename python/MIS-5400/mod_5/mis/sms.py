def send(message):
    try:
        if len(message) > 124:
            raise Exception('Message is too long')
        return True
    except Exception as e:
        raise e

def test_send():
    result = send('Hey Buddy')
    if result == True:
        print('Message Sent, Test Passed')
    else:
        print('Message Failed')

def test_make_sure_long_message_fails():
    try:
        send('a' * 1000)
    except:
        print('Test Passed')

def say_my_name():
    return __name__
        
        
if __name__ == '__main__':
    try:
        print('Starting all tests')
        test_send()
        test_make_sure_long_message_fails()
    except:
        print('Fail...')
