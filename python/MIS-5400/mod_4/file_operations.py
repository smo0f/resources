###################
# FILES & STREAMS #
###################
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
# First let's create a file
f = open('tester.txt', 'x')

# Where did the file go? Find working directory!
import os

print(os.getcwd())

# Change working directory?
os.chdir(r'c:/temp')

# or with full path
f1 = open(r'c:\temp\tester1.txt', 'x')

# Write-to and close the file.
f.write('Hello File')
f.close()

# Now open it for reading and writing
f = open('tester.txt', 'r+')
f.read()

# Find out where the cursor is
f.tell()
f.read()  # This will fail because the cursor is at the end of the file.

# Move the cursor
f.seek(0)
f.read()  # There we go

# Write Multiple Lines
colors = ['red', 'blue', 'green', 'purple', 'yellow', 'orange']
f.seek(0)
f.truncate()

# Write a list with each item on a separate line
f.write('\n'.join(colors))

# using 'r' before the file path turns it into a raw string literal
# this makes it easy because there is no need to comment out the '\'
logs = open(r'd:\drive\usu\fall_2018\mod_3\access.log')
logs.close()

# "with" statement (Similar to "using" in C# / .NET if you are familiar with disposables)
# When we use the with statement it will close the file for us when it is done reading...
# same as f.open and then f.close

all_404_errors = []
with open(r'd:\drive\usu\fall_2018\mod_3\access.log') as f:
    for line in f:
        if '404' in line:
            all_404_errors.append(line)  # add to new list

[print(line, '\n') for line in all_404_errors]

new_file = open(r'404_errorsA.log', 'x')
new_file.write('\n'.join(all_404_errors))