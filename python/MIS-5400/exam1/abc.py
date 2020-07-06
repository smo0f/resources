# Write the following code in a .py file and upload it:

# Use the following code to create a list with all the letters of the alphabet:

 
# import string

# alphabet = list(string.ascii_lowercase)

# Now write a for loop to iterate through each character in the list and add (append) the upper-case version of the character to a NEW list named "alphabet_upper".

# # code starting here ===============================================================================

import string
alphabet = list(string.ascii_lowercase)

alphabet_upper = []

for letter in alphabet:
    alphabet_upper.append(letter.upper())