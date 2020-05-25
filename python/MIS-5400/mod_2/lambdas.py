# In Python functions can be passed around just like any other object
# This allows functions like the following:

def transform_params(list_to_transform, tfx):
    transformed_list = []
    for item in list_to_transform:
        transformed_list.append(tfx(item))
    return transformed_list

# tfx can be any function that accepts a single numerical value and then returns an out
# so, as long as we can make a function that meets that signature we can leverage
# the transform_params function.


# We could easily write functions to match that signature
# Examples below mult_1000 which simply returns the number multiplied by 1000
# or pow_10 which returns the number raised to the power of 10

def mult_1000(num):
    return num * 1000



def pow_10(num):
    return num ** 10


# Below we see the usage of the transform_params function on a base list on numbers
base_list = [1, 2, 3, 5, 8, 13, 21]

# for each item in base_list this will return it raised to the power of 10
pow_10_list = transform_params(base_list, pow_10)
print(pow_10_list)

# for each item in base_list this will return it multiplied by 1000
mult_1000_list = transform_params(base_list, mult_1000)
print(mult_1000_list)


# Now - for the lambda part -
# Below, instead of defining a function and then passing it to the transform_params function
# we simply write the logic directly in the call -
# This is also known as an anonymous function because it essentially does the same thing
# as a named function, but it doesn't have a name.
def anon_func(x):
    return (x -1000) * 5

anon_list = transform_params(base_list, lambda x: (x  - 1000) * 5)
print(anon_list)

# x is the input
# everything after the : is the "body" of the lambda, which coorelates to the body of a function
# So the lambda above subtracts 1000 from each item in the base_list and then multiplies it by 5