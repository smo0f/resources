######################################################
#   MIS 5400
#   Module 3 Homework
#
#   INSTRUCTIONS
#   1) Write code to to complete exercises below.
#   2) Save the file and submit it using Canvas.
######################################################
'''
MIS 5400 Module 3 Homework
'''
###############
# Exercise  1 #
###############
'''
    Write code to analyze each number between 2000 and 6500 and do the following (HINT use the range function)
    1.) If the number is divisible by 5 then print out [Fitty].
    2.) If the number is divisible by 7 then print out [Sevvy].
    3.) If the number is divisible by BOTH 5 and 7 print out ["Winner's win", said Bob] (quotes included)
'''

# WRITE YOUR CODE HERE
for number in range(2000, 6501):
    # print(number)
    if number % 5 == 0 and number % 7 == 0:
        print('"Winner\'s win", said Bob')
    elif number % 5 == 0:
        print('Fitty')
    elif number % 7 == 0:
        print('Sevvy')


###############
# Exercise  2 #
###############
'''
    Using the file "access.log", write code that does the following:
    
    1) Read the file into a list.
    2) Print out the following information:

    How many Total logs are there? 
    How many logs have a status code of 404? (Hint: Membership Checking)
    How many logs have a status code of 200?
    How many of the logs contain the text "mis"?

    3) Write some code that replaces all instances of "redflag" with "greenlight" (Hint: string replace method)
    4) Put all logs with the replaced values in a new list
    5) Create a file named "mis5400.log" and write out the list with the replaced values. 
'''

# WRITE YOUR CODE HERE

# get path
path = r'C:\Users\truth\Desktop\code and resources\projects\resources\python\MIS-5400\mod_3\access.log'
with open(path) as f:
    # # Read the file into a list.
    lines = f.readlines()
    # print(lines[0])
    # print(lines[1])
    log_404 = []
    log_200 = []
    log_mis = []
    log_check = []
    log_check_404 = []
    log_check_200 = []
    log_check_404_not_list = []
    log_check_200_not_list = []
    # Loop over and extract information
    for line in lines:
        if 'HTTP/1.1" 404' in line or 'HTTP/1.0" 404' in line:
            log_404.append(line)
        if 'HTTP/1.1" 200' in line or 'HTTP/1.0" 200' in line:
            log_200.append(line)
        if 'mis' in line:
            log_mis.append(line)
        # research and debugging
        if not ('HTTP/1.1" 404' in line or 'HTTP/1.1" 200' in line or 'HTTP/1.0" 404' in line or 'HTTP/1.0" 200' in line) :
            log_check.append(line)
        if '404' in line:
            log_check_404.append(line)
        if '200' in line:
            log_check_200.append(line)
        if not ('HTTP/1.1" 404' in line or 'HTTP/1.0" 404' in line) and '404' in line:
            log_check_404_not_list.append(line)
        if not ('HTTP/1.1" 200' in line or 'HTTP/1.0" 200' in line) and '200' in line:
            log_check_200_not_list.append(line)
    # research and debugging
    print(f'log_404 = {len(log_404)}, log_check_404 = {len(log_check_404)}')
    print(f'log_200 = {len(log_200)}, log_check_200 = {len(log_check_200)}')
    print(log_check_404_not_list[0])
    print(log_check_200_not_list[0])
    if len(log_check) > 0:
        print(log_check[0])
        print(len(log_check))
    else:
        print(f'No extras {len(log_404)} + {len(log_200)} = {len(log_200) + len(log_404)} = {len(lines)}')
    # # Print out the following information:
    print(f'How many Total logs are there? {len(lines)}')
    print(f'How many logs have a status code of 404? {len(log_404)}')
    print(f'How many logs have a status code of 200? {len(log_200)}')
    print(f'How many of the logs contain the text "mis"? {len(log_mis)}')




# debugging version, I'm sure there might be a little bit more to cleanup but it produces some really good results
path = r'C:\Users\truth\Desktop\code and resources\projects\resources\python\MIS-5400\mod_3\access.log'
with open(path) as f:
    # # Read the file into a list.
    lines = f.readlines()
# print(lines[0])
# print(lines[1])
log_404 = []
log_200 = []
log_206 = []
log_304 = []
log_405 = []
log_mis = []
log_check = []
log_check2 = []
log_check_404 = []
log_check_200 = []
log_check_404_not_list = []
log_check_200_not_list = []
# Loop over and extract information
for line in lines:
    if 'HTTP/1.1" 404' in line or 'HTTP/1.0" 404' in line:
        log_404.append(line)
    if 'HTTP/1.1" 200' in line or 'HTTP/1.0" 200' in line:
        log_200.append(line)
    if 'HTTP/1.1" 206' in line or 'HTTP/1.0" 206' in line:
        log_206.append(line)
    if 'HTTP/1.1" 304' in line or 'HTTP/1.0" 304' in line:
        log_304.append(line)
    if 'HTTP/1.1" 405' in line or 'HTTP/1.0" 405' in line:
        log_405.append(line)
    if 'mis' in line:
        log_mis.append(line)
    # research and debugging
    if not ('HTTP/1.1" 404' in line or 'HTTP/1.1" 200' in line or 'HTTP/1.0" 404' in line or 'HTTP/1.0" 200' in line) :
        log_check.append(line)
    if not ('HTTP/1.1" 404' in line or 'HTTP/1.1" 200' in line or 'HTTP/1.0" 404' in line or 'HTTP/1.0" 200' in line or 'HTTP/1.1" 206' in line or 'HTTP/1.0" 206' in line or 'HTTP/1.1" 304' in line or 'HTTP/1.0" 304' in line or 'HTTP/1.1" 405' in line or 'HTTP/1.0" 405' in line) :
        log_check2.append(line)
    if '404' in line:
        log_check_404.append(line)
    if '200' in line:
        log_check_200.append(line)
    if not ('HTTP/1.1" 404' in line or 'HTTP/1.0" 404' in line) and '404' in line:
        log_check_404_not_list.append(line)
    if not ('HTTP/1.1" 200' in line or 'HTTP/1.0" 200' in line) and '200' in line:
        log_check_200_not_list.append(line)
# research and debugging
print('**count debugging**')
print(f'log_404 = {len(log_404)}, log_check_404 = {len(log_check_404)}')
print(f'log_200 = {len(log_200)}, log_check_200 = {len(log_check_200)}')
print('**not_list debugging**')
print(log_check_404_not_list[0])
print(log_check_200_not_list[0])
print('**log_check debugging**')
print('log_206', len(log_206))
print('**log_check debugging**')
# log_check
if len(log_check) > 0:
    print(log_check[0])
    print(len(log_check))
else:
    print(f'No extras {len(log_404)} + {len(log_200)} = {len(log_200) + len(log_404)} = {len(lines)}')
print('**log_check 2 debugging**')
# log_check 2
if len(log_check2) > 0:
    print(log_check2[0])
    print(len(log_check2))
# # Print out the following information:
print(f'How many Total logs are there? {len(lines)}')
print(f'How many logs have a status code of 404? {len(log_404)}')
print(f'How many logs have a status code of 200? {len(log_200)}')
print(f'How many of the logs contain the text "mis"? {len(log_mis)}')
# # Write some code that replaces all instances of "redflag" with "greenlight" (Hint: string replace method)
count_before = [line for line in lines if 'redflag' in line]
print('count_before', len(count_before))
lines_green_light = [line.replace('redflag', 'greenlight') for line in lines]
after_before = [line for line in lines_green_light if 'redflag' in line]
print('after_before', len(after_before))
print('lines_green_light', len(lines_green_light))
print('lines', len(lines))





# # Write some code that replaces all instances of "redflag" with "greenlight" (Hint: string replace method)
count_before = [line for line in lines if 'redflag' in line]
print('count_before', len(count_before))
lines2 = [line.replace('redflag', 'greenlight') for line in lines]
after_before = [line for line in lines2 if 'redflag' in line]
print('after_before', len(after_before))
# # Put all logs with the replaced values in a new list
lines_greenlight = [line.replace('redflag', 'greenlight') for line in lines if 'redflag' in line]
print('lines_greenlight', len(lines_greenlight))







# get path
path = r'C:\Users\truth\Desktop\code and resources\projects\resources\python\MIS-5400\mod_3\access.log'
with open(path) as f:
    # # Read the file into a list.
    lines = f.readlines()
# print(lines[0])
# print(lines[1])
log_404 = []
log_200 = []
log_mis = []
# Loop over and extract information
for line in lines:
    if 'HTTP/1.1" 404' in line or 'HTTP/1.0" 404' in line:
        log_404.append(line)
    if 'HTTP/1.1" 200' in line or 'HTTP/1.0" 200' in line:
        log_200.append(line)
    if 'mis' in line:
        log_mis.append(line)

# # Print out the following information:
print(f'How many Total logs are there? {len(lines)}')
print(f'How many logs have a status code of 404? {len(log_404)}')
print(f'How many logs have a status code of 200? {len(log_200)}')
print(f'How many of the logs contain the text "mis"? {len(log_mis)}')

# # Write some code that replaces all instances of "redflag" with "greenlight" (Hint: string replace method)
count_before = [line for line in lines if 'redflag' in line]
print('count_before', len(count_before))
lines2 = [line.replace('redflag', 'greenlight') for line in lines]
after_before = [line for line in lines2 if 'redflag' in line]
print('after_before', len(after_before))
# # Put all logs with the replaced values in a new list
lines_greenlight = [line.replace('redflag', 'greenlight') for line in lines if 'redflag' in line]
print('lines_greenlight', len(lines_greenlight))
# # Create a file named "mis5400.log" and write out the list with the replaced values.
path = r'C:\Users\truth\Desktop\code and resources\projects\resources\python\MIS-5400\mod_3\mis5400.log' 
with open(path, 'w+') as f:
    f.write(''.join(lines_greenlight))
    f.seek(0)
    new_lines = f.readlines()
    print(len(new_lines))