# Exercise 1.2. Start the Python interpreter and use it as a calculator.
# 1. How many seconds are there in 42 minutes 42 seconds?
seconds = 42 * 60 + 42
print(seconds)
# 2. How many miles are there in 10 kilometers? Hint: there are 1.61 kilometers in a mile.
miles = round(10 / 1.61, 2)
print(miles)
# 3. If you run a 10 kilometer race in 42 minutes 42 seconds, what is your average pace (time per
# mile in minutes and seconds)? What is your average speed in miles per hour?
per_mile = round(seconds / miles, 2)
print(per_mile)