##########################
# Requests for REST APIs #
##########################
'''
http://docs.python-requests.org/en/latest/

Requests is an http client for Python available from
http://docs.python-requests.org/en/latest/user/install/#install


Install with pip (pip install requests)

mis5400 API-Key 0kj_v4k3n1oTBWL_A5MkckOv_CW9l7xg

'''
import requests
import json

# ANY json endpoint you can find
til_request = requests.get('http://www.reddit.com/r/worldnews.json', headers = {'User-agent': 'botsbot'})

if(til_request.status_code is not 200):
    raise Exception('Something other than 200 was returned.')
else:
    print('Successful status code')

til_dictionary = til_request.json()

# This will read a list (look at the json)
data_list = til_dictionary['data']['children']

# Insert each entry
for til_entry in data_list:
    print(til_entry['data'])


# You could insert any http resource here! Amazing
r = requests.get('https://api.mongolab.com/api/1/databases/mis/collections/book_collection?apiKey=QCLQMIjE1-Y6m7OTC-joPS6VqlkoALx-')

print('Status',r.status_code) # Should be 200 et. al.

r.json()

# query
r = requests.get('https://api.mongolab.com/api/1/databases/mis/collections/book_collection?q={"tags": "rabbit"}&apiKey=QCLQMIjE1-Y6m7OTC-joPS6VqlkoALx-')

# Pretty Print
import pprint
printer = pprint.PrettyPrinter(indent=4)
printer.pprint(r.json())


