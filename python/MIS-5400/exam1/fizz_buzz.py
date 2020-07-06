# Write the following code in a .py file and upload it:

 

# Use a for loop to iterate through a range of numbers between 400 and 1000. If the number is divisible by 3 print out 'fizz'. If the number is divisible by 8 print out 'buzz'. If the number is divisible by both 3 and 8 then print out 'fizzbuzz'.
for num in range(400, 1001):
    if num % 3 == 0 and num % 8 == 0:
        # print(f'{num} = fizzbuzz')
        print('fizzbuzz')
    elif num % 3 == 0:
        # print(f'{num} = fizz')
        print('fizz')
    elif num % 8 == 0:
        # print(f'{num} = buzz')
        print('buzz')