# print('How many kilometers did you cycle today?') # if you want on in put on its own line 
# kms = input()
kms = input('How many kilometers did you cycle today? ')
if kms.isnumeric():
    kms = float(kms)
    miles = round(kms / 1.60934, 2)
    print(f'That means you went {miles} miles!')
else:
    print(f'Sorry, you provided a string "{kms}". We were expecting a number please try again.')