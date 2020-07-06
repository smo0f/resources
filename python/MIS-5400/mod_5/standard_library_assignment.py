# @ working with CSV's
# https://docs.python.org/3/library/csv.html
# below I am working with the CSV module in Python to read and write to an CSV file.

# ! each of these sections are supposed to be run on their own!
# they show different ways of working with CSV files.

# # using the csv reader, returns an object
from csv import reader
# creating path to CSV
path = r'C:\Users\truth\Desktop\code and resources\projects\resources\python\MIS-5400\mod_5\csv_test.csv'
# opening CSV with reader, this gives back an object of lists
with open(path) as f:
    csv_f = reader(f)
    # move forward one, so we don't get the header
    next(csv_f)
    for row in csv_f:
        # print(row)
        print(f'The product "{row[1]}" has an id of {row[0]}. It sells for {row[3]}, and there are only {row[4]} left.')


# # using the csv as a list of lists
from csv import reader
# creating path to CSV
path = r'C:\Users\truth\Desktop\code and resources\projects\resources\python\MIS-5400\mod_5\csv_test.csv'
# opening CSV with reader, this time turn it into a list
with open(path) as f:
    csv_f = list(reader(f))
    # skip the first list in the list
    for row in csv_f[1:]:
        print(f'The product "{row[1]}" has an id of {row[0]}. It sells for {row[3]}, and there are only {row[4]} left.')


# # using the csv DictReader, returns an object of dictionaries
from csv import DictReader
# creating path to CSV
path = r'C:\Users\truth\Desktop\code and resources\projects\resources\python\MIS-5400\mod_5\csv_test.csv'
# opening CSV with DictReader
with open(path) as f:
    csv_f = DictReader(f)
    for row in csv_f:
        print(f"The product \"{row['name']}\" has an id of {row['id']}. It sells for {row['cost']}, and there are only {row['qty']} left.")

# can specify a delimiter
# example: csv.DictReader(f, delimiter='|')

# # writing to a CSV file, using writer
from csv import writer
# creating path to CSV
path = r'C:\Users\truth\Desktop\code and resources\projects\resources\python\MIS-5400\mod_5\csv_test.csv'
# writing to CSV with writer
with open(path, 'a') as f:
    csv_f = writer(f)
    csv_f.writerow([2356, 'Hot Tamales', '', '$0.68', 66])
    csv_f.writerow([2326, 'Bit of Honey', '', '$0.06', 300])
    # you could also use writerows to put them all and at once
    # csv_f.writerows([['2326', 'Bit of Honey', '', '$0.06', '300'], ['2356', 'Hot Tamales', '', '$0.68', '66']])


# # writing to a CSV file, using DictWriter
from csv import DictWriter
# creating path to CSV
path = r'C:\Users\truth\Desktop\code and resources\projects\resources\python\MIS-5400\mod_5\csv_test.csv'
# writing to CSV with DictWriter
with open(path, 'a') as f:
    headers = ['id', 'name', 'description', 'cost', 'qty']
    csv_f = DictWriter(f, fieldnames=headers)
    csv_f.writerow({
        'id': 2356, 
        'name': 'Hot Tamales', 
        'cost':'$0.68', 
        'qty': 66 
    })
    # or you can write multiple at a time 
    # csv_f.writerows([
    #     {
    #         'id': 2356, 
    #         'name': 'Hot Tamales', 
    #         'cost':'$0.68', 
    #         'qty': 66 
    #     },
    #     {
    #         'id': 2326, 
    #         'name': 'Bit of Honey', 
    #         'cost':'$0.06', 
    #         'qty': 300 
    #     },
    # ])
