###########################
# Python Standard Library #
###########################
'''
Learn it, love it, live it!

-->        https://docs.python.org/3/library/index.html         <--

'''



#############################
# Example: Data Persistence #
#############################


'''
Built-in Python object persistence

Some Key Terms You Will See:
* Serialization - Writing an object to disk
* Deserialization - Reading an object from disk

Pickle -> A binary file.
https://docs.python.org/3/library/pickle.html 


Shelve -> A collection of Pickles
https://docs.python.org/3/library/shelve.html

'''
# Pickle 
import pickle

potential_land = {
        'location':'Mendon',
        'price':200000,
        'ratings':[4,5,4,4,5,3]
        }

with open(r'd:/land.pickle', 'wb') as pick:
    pickle.dump(potential_land, pick)


# Leave somewhere, suffer power outage, etc...
import pickle
with open(r'd:/land.pickle', 'rb') as pick:
    potential_land = pickle.load(pick)
    print(potential_land)

# Shelve
import shelve
jar = shelve.open(r'd:/yummy.db')


jar['land_stuff'] = potential_land
jar['future_stuff'] = ['401K','kids','travel','$$$$']

jar.close()

# Leave somewhere, suffer power outage, etc...
import shelve
jar = shelve.open(r'd:/yummy.db')
jar['future_stuff'] # Still There