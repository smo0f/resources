# @ Python built-in modules
# # math
# import
import math
# use
square = math.sqrt(9)
print(square)

# # random
# import
# imports random, and in its own namespace
import random
choices = ['rock', 'paper', 'scissors']
# use, AI input
player_two_action = random.choice(choices)
print(player_two_action)

# # date
# does not put it in its own namespace
from datetime import datetime
now= datetime.now()
print(now.year)
print(now.month)
print(now.day)

# add date
import datetime
date_now = datetime.datetime.now()
print(date_now.day)
print(date_now.strftime("%A, %B %d"))
date_now = date_now + datetime.timedelta(days=1)
print(date_now.day)
print(date_now.strftime("%A, %B %d"))

# date difference
from datetime import datetime
d0 = datetime.strptime("18/8/08", "%d/%m/%y")
d1 = datetime.strptime("26/9/08", "%d/%m/%y")
print(d1)
delta = d1 - d0
print(delta)
print(delta.days)

from datetime import datetime
d0 = datetime.strptime("23/9/08", "%d/%m/%y")
d1 = datetime.strptime("26/9/08", "%d/%m/%y")
print(d1)
delta = d1 - d0
print(delta)
print(delta.days)

from datetime import date
d0 = date(2008, 8, 18)
d1 = date(2008, 9, 26)
print(d1)
delta = d1 - d0
print(delta)
print(delta.days)

d0 = date(2007, 8, 18)
d1 = date(2008, 9, 26)
delta = d1 - d0
print(delta.days)
