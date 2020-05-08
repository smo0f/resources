# @ Exercise 1 (and Solution)
# Create a program that asks the user to enter their name and their age. Print out a message addressed to them that tells them the year that they will turn 100 years old.
# Extras:
# Add on to the previous program by asking the user for another number and printing out that many copies of the previous message. (Hint: order of operations exists in Python)
# Print out that many copies of the previous message on separate lines. (Hint: the string "\n is the same as pressing the ENTER button)

# * to run: python python/MIS-5400/web_exercise_1.py 

# get input
name = input("What is your name? ").strip()
age = input("What is your age or birth date(mm/dd/yy)? ").strip()

# check to see if real number
keep_looping = True
while keep_looping:
    # check to see if it's a number
    if age.isnumeric():
        # change the age to a number, int
        age = int(age)
        years_to_100 = 100 - age
        # stop the loop
        keep_looping = False
        # print message
        message = f"{name}, you have {years_to_100} years until you turned 100."
        print(message)
    else:
        # import date
        import datetime
        # see if it is a date and in the right format
        try:
            date_born_object = datetime.datetime.strptime(age, '%m/%d/%y')
            # if no error, it will continue
            # set now and now variables
            date_now_object = datetime.datetime.now()
            date_now_year = int(date_now_object.strftime("%Y")) 
            date_now_month = int(date_now_object.strftime("%m")) 
            date_now_day = int(date_now_object.strftime("%d")) 
            # set born variables
            date_born_year = int(date_born_object.strftime("%Y")) 
            date_born_month = int(date_born_object.strftime("%m")) 
            date_born_day = int(date_born_object.strftime("%d")) 
            # process age
            # year
            age = date_now_year - date_born_year 
            # check to see if you're really that age
            if date_born_month > date_now_month: 
                age -= 1 
            elif date_born_month == date_now_month: 
                if date_born_day > date_now_day:
                    age -= 1 
            # set variables
            birth_date = date_born_object.strftime("%A, %B %d %Y")
            years_to_100 = 100 - age
            # print message
            message = f"{name}, you were born on {birth_date}. That means you are {age} years old. You have {years_to_100} years until you turned 100."
            print(message)
            # stop the loop
            keep_looping = False
        # this means that we did not get a number or a valid date
        except ValueError as err:
            pass
            age = input("Sorry you did not give a number or a valid date(mm/dd/yy). Please provide your age or birth date. ")
# end of loop

# extra task
print_message = input("Would you like to print this message out more times? ").strip().lower()

if print_message == 'y' or print_message == 'yes':
    number_of_times = input("How many times would you like to repeat the message ").strip()
    # check to see if it's a number
    while not(number_of_times.isnumeric()):
        number_of_times = input("Sorry you must provide a whole number. ").strip()
    # go ahead and print the message the number of times
    number_of_times = int(number_of_times)
    print((message + '\n') * number_of_times)
else:
    print("Thanks for your time!")

# ? References
# https://stackoverflow.com/questions/25341945/check-if-string-has-date-any-format
# https://www.w3schools.com/python/python_datetime.asp
# https://stackoverflow.com/questions/466345/converting-string-into-datetime
# https://stackoverflow.com/questions/6871016/adding-5-days-to-a-date-in-python
# https://stackoverflow.com/questions/8419564/difference-between-two-dates-in-python



# ! test it when I come back, when I'm feeling a little bit more alert.