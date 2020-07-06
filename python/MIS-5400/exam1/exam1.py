alphabet = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
# Get the first 10 letters (Start at 0, go to 10, note that the letter in index 10 IS NOT returned)
print(alphabet[0:10])
print(alphabet[:10])
# Get everything after 10
print(alphabet[10:])
# Get the middle 2
print(alphabet[12:14])
# Get the last letter
print(alphabet[-1])


some_nums = [1, 2, 3, 4, 5]
new_nums = some_nums
new_nums[2] = 100

print(new_nums)

list1 = [1,2,3,4,5,'Jim',['Gogo!', 'Ham']]
person = {
    'f_name': 'Jim',
    'l_name': 'Smith',
    'age': 42
}

print(type(('a', 'b', 'c')))
print(type(tuple('a', 'b', 'c')))
stuff = 'a', 'b', 'c' 
print(type(stuff))