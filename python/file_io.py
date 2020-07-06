# @ file input and output
'''
========= ===============================================================
Character Meaning
--------- ---------------------------------------------------------------
'r'       open for reading (default)
'w'       open for writing, truncating the file first
'x'       create a new file and open it for writing
'a'       open for writing, appending to the end of the file if it exists
'b'       binary mode
't'       text mode (default)
'+'       open a disk file for updating (reading and writing)
========= ===============================================================
    
'''


# # open file, hardcoded directory
f = open(r'C:\Users\truth\Desktop\code and resources\projects\resources\python\tester.txt')
print(f)
print('Read: ', f.read())
print('Read: ', f.read())
# # seek (use in conjunction with above code)
f.seek(0) # back to start of file
print('Read: ', f.read())
f.close()

# # read line
f = open(r'C:\Users\truth\Desktop\code and resources\projects\resources\python\tester.txt')
print(f)
print('Read: ', f.readline())
print('Read: ', f.readline())
print('Read: ', f.readline())
print('Read: ', f.readline())
f.close()

# # read lines
f = open(r'C:\Users\truth\Desktop\code and resources\projects\resources\python\tester.txt')
print(f)
fileLines = f.readlines()
print(fileLines)
f.close()

# # create a file, based off of your relative location
# create/write
f = open('tester.txt', 'x')
f.write('Hello File')
f.close()
# open and read
f = open('tester.txt')
print(f)
print(f.read())
f.close()

# # with 
path = r'C:\Users\truth\Desktop\code and resources\projects\resources\python\tester.txt'
with open(path) as f:
    print(f.read())
    f.seek(0)
    fileLines = f.readlines()
    print(fileLines)
print('f.closed: ', f.closed) # the with auto closes

# # write 
path = r'C:\Users\truth\Desktop\code and resources\projects\resources\python\writeToText.txt'
with open(path, 'w') as f:
    f.write('This is a story about a goat named Samson.\n')
    f.write('He was a very friendly goat.\n')
    f.write('He loved all sorts of chocolate.\n')
with open(path) as f:
    print(f.read())
    f.seek(0)
    fileLines = f.readlines()
    print(fileLines)
# write to newly created file
path = r'C:\Users\truth\Desktop\code and resources\projects\resources\python\new.txt'
with open(path, 'w') as f:
    f.write('GoGo!!!\n' * 50)
with open(path) as f:
    print(f.read())
    f.seek(0)
    fileLines = f.readlines()
    print(fileLines)

# # read and write
# you can use 'r+' or 'w+'
path = r'C:\Users\truth\Desktop\code and resources\projects\resources\python\writeToText.txt'
with open(path, 'r+') as f:
    f.write('This is a brand-new story.\n')
    f.write('Definitely not about a goat named Sampson.\n')
    f.write('He certainly would not like all types of chocolate.\n')
    f.seek(0)
    print(f.read())
    f.seek(0)
    fileLines = f.readlines()
    print(fileLines)
# ? https://www.udemy.com/course/the-modern-python3-bootcamp/learn/lecture/9023170#overview

# # writing experiments
# append
path = r'C:\Users\truth\Desktop\code and resources\projects\resources\python\writeToText.txt'
with open(path, 'a+') as f:
    f.write('haha!\n' * 10)
    f.seek(0)
    print(f.read())
    f.seek(0)
    fileLines = f.readlines()
    print(fileLines)
# writing to the first of the documents while keeping all the text
path = r'C:\Users\truth\Desktop\code and resources\projects\resources\python\writeToText.txt'
with open(path, 'r+') as f:
    # get text
    text = f.read()
    f.seek(0)
    f.write('I added this to the first of the text. Hahahahahaha!!!\n' + text)
    f.seek(0)
    print(f.read())
    f.seek(0)
    fileLines = f.readlines()
    print(fileLines)

# other code
# from Udemy
# ? https://www.udemy.com/course/the-modern-python3-bootcamp/learn/quiz/4373712#overview
def statistics(file_name):
    with open(file_name) as file:
        lines = file.readlines()
    return { "lines": len(lines),
            "words": sum(len(line.split(" ")) for line in lines),
            "characters": sum(len(line) for line in lines) }

# from home work
# get path
path = r'C:\Users\truth\Desktop\code and resources\projects\resources\python\MIS-5400\mod_3\access.log'
with open(path) as f:
    # Read the file into a list.
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

# Print out the following information:
print(f'How many Total logs are there? {len(lines)}')
print(f'How many logs have a status code of 404? {len(log_404)}')
print(f'How many logs have a status code of 200? {len(log_200)}')
print(f'How many of the logs contain the text "mis"? {len(log_mis)}')

# Write some code that replaces all instances of "redflag" with "greenlight" (Hint: string replace method)
# this could have been done above in the for loop, but for the sake of answering this question specifically
lines2 = [line.replace('redflag', 'greenlight') for line in lines]

# Put all logs with the replaced values in a new list
# this could have been done above in the for loop, but for the sake of answering this question specifically
lines_greenlight = [line.replace('redflag', 'greenlight') for line in lines if 'redflag' in line]

# Create a file named "mis5400.log" and write out the list with the replaced values.
# set new path
path = r'C:\Users\truth\Desktop\code and resources\projects\resources\python\MIS-5400\mod_3\mis5400.log' 
# create and write to file, if it exists it will overwrite it
with open(path, 'w') as f:
    # they already have a '\n' so don't add one
    f.write(''.join(lines_greenlight))


# Other approach, with only 1 file open at a time
from csv import reader
with open('fighters.csv') as file:
	csv_reader = reader(file)
	# data converted to list and saved to variable
	fighters = [[s.upper() for s in row] for row in csv_reader]