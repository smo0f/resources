# @ classes
# defining class
class Customer:
    # initialization of an instance
    def __int__(self, args = {}):
        for arg in args:
            setattr(self, arg, args[arg])
            # self.[arg] = args[arg]


# create an instance
customer1 = Customer(args = {
    'f_name': 'Russell',
    'l_name': 'Moore',
    'age': '32'
})

print('hi 1',customer1.f_name)