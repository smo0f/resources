# Write the following code in a .py file and upload it:

#  Use pip to install the Requests package (Documentation from here: https://requests.readthedocs.io/en/master/ (Links to an external site.)) 

# Use the Requests library to simple "get" the page "www.google.com". 

# When you are done, take a screen-shot and upload to this question. 

import requests
url = 'https://www.google.com'
res = requests.get(url)

print(res.text)