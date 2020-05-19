from datetime import datetime
from datetime import timedelta


# Generators are created when a function  "promises" to return values "on the fly", or "on demand"
# as they are requested. This differs from a regular function because a regular function ALWAYS returns
# results immediately and then finishes.

# Below you can see the keyword "yield".
# This tells the interpreter to return values only when requested (see example below)
# Instead of the date_range() function call returning a result immediately, it only promises to return a result

# Looking specifically at the logic of date_range - it accepts an (optional) start_date, defaulting to now
# It then accepts a parameter named "days_back", defaulted to 365
# It then promises to return every date (segmented by days) from the start_date to days_back in history
# This can be useful for populating data rows that are sparse - or for handling dates going back quite far
# in history without having to load all of the dates in memory at the same time
def date_range(start_date = datetime.now().date(), days_back=365):
    current_date = start_date
    end_date = datetime.now().date() - timedelta(days=days_back)
    while (current_date >= end_date):
        yield current_date
        current_date -= timedelta(days=1)


# date_range is a ?
print('date_range is a',type(date_range))


# Instead of returning a "list" of dates - it returns a generator
# The generator can then be used like a collection - returning
# dates on demand.
default_date_generator = date_range()

#print('date_range() does not return an actual collection, but a', type(default_date_generator))

#for date in default_date_generator:
#    print(date)

# now we can create one that promises to return 100000 days back!
# this illustrates the benefits of generators - because now we don't have to store all of those
# values in memory.
long_range_generator = date_range(days_back=100000)

# type(long_range_generator)


# Now we will loop through the long_range_generator and match up with some set of data.
# We only "do something" when we have data for that date.
data = [(datetime.strptime('1/2/2019', '%m/%d/%Y').date(), 100),
        (datetime.strptime('2/2/2019', '%m/%d/%Y').date(),200),
        (datetime.strptime('3/2/2019', '%m/%d/%Y').date(), 500)]

for date in long_range_generator:
    for check_date in data:
        if check_date[0] == date:
            print(date, check_date)
        print(date)