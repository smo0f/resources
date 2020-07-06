import json
from pprint import pprint

#########
# LOADS -  #
#########
# Load a raw string as a json object (json.loads will create a dictionary)
json_data = '{"name": "Frank", "age": 39}'
parsed_json = json.loads(json_data)

# Notice this is a dictionary obj
print(type(parsed_json))
pprint(parsed_json)

# We can access by key
print(parsed_json['name'])


########
# LOAD #
########
# Load from a file (json.load will create a dictionary)
with open(r'c:/users/mpeart/desktop/todayilearned.json') as json_file:
    parsed_json_file = json.load(json_file)

    # Also a dictionary obj
    print(type(parsed_json_file))
    pprint(parsed_json_file)

    # Can also access by key, nesting can by difficult.
    pprint(parsed_json_file['glossary']['GlossDiv']['GlossList']['GlossEntry'])


####################################
# Working with list types in  json #
####################################
json_data = '{"name": "Frank", "age": 39, "pets":["dog","fish","cat"]}'
parsed_json = json.loads(json_data)

print(type(parsed_json['pets']))

print(parsed_json['pets'][0])

#############################
# Working with nested types #
#############################
json_data = '{' \
            '   "name": "Frank", ' \
            '   "age": 39, ' \
            '   "pets":["dog","fish","cat"], ' \
            '   "books": [{"title":"Summer of the Monkeys","tags":["monkeys","summer"]}],' \
            '   "meta": {"father":"Frank Sr."}' \
            '}'
parsed_json = json.loads(json_data)

print(parsed_json['meta']['father'])


########
# DUMP #
########
some_dictionary = {
    'name': 'Frank',
    'age' : 40,
    'hobbies' : ['Skiing', 'Fishing', 'Homework']
}

json_from_dict = json.dumps(some_dictionary)

# Below is now a json string
pprint(json_from_dict)


