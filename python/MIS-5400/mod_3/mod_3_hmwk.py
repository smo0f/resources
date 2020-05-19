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
log_404 = []
log_200 = []
log_mis = []
# Loop over and extract information
for line in lines:
    # How many logs have a status code of 404? 
    if 'HTTP/1.1" 404' in line or 'HTTP/1.0" 404' in line:
        log_404.append(line)
    # How many logs have a status code of 200? 
    if 'HTTP/1.1" 200' in line or 'HTTP/1.0" 200' in line:
        log_200.append(line)
    # How many of the logs contain the text "mis"
    if 'mis' in line:
        log_mis.append(line)

# # Print out the following information:
print(f'How many Total logs are there? {len(lines)}')
print(f'How many logs have a status code of 404? {len(log_404)}')
print(f'How many logs have a status code of 200? {len(log_200)}')
print(f'How many of the logs contain the text "mis"? {len(log_mis)}')

# # Write some code that replaces all instances of "redflag" with "greenlight" (Hint: string replace method)
# this could have been done above in the for loop, but for the sake of answering this question specifically
lines2 = [line.replace('redflag', 'greenlight') for line in lines]

# # Put all logs with the replaced values in a new list
# this could have been done above in the for loop, but for the sake of answering this question specifically
lines_greenlight = [line.replace('redflag', 'greenlight') for line in lines if 'redflag' in line]

# # Create a file named "mis5400.log" and write out the list with the replaced values.
# set new path
path = r'C:\Users\truth\Desktop\code and resources\projects\resources\python\MIS-5400\mod_3\mis5400.log' 
# create and write to file, if it exists it will overwrite it
with open(path, 'w') as f:
    # they already have a '\n' so don't add one
    f.write(''.join(lines_greenlight))