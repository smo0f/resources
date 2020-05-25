# @ http requests
# pip install requests

# * to use: python python/http.py

import requests
import json
# url = 'https://www.python.org'
url = 'http://localhost/open_source_project/public/api/restApi/v1/'
# help(requests)
res = requests.get(url)
res_json = json.loads(res.text)

print(f'Your request to {url} return the status code {res.status_code}')
print(res_json['companyName'])
# print(res_json['routes']['quickViewOFRoutesAvailable'])
print(json.dumps(res_json['routes']['quickViewOFRoutesAvailable'], indent=4))


import requests
import json
# url = 'https://www.python.org'
url = 'http://localhost/open_source_project/public/api/restApi/v1/labels?authToken=T3$$tK3y!2456!&page=3'
res = requests.get(url)
res_json = json.loads(res.text)

print(f'Your request to {url} return the status code {res.status_code}')
print('statusCode', res_json['statusCode'])
print('paramsAccepted', res_json['paramsAccepted'])
print('paramsSent', res_json['paramsSent'])
print('paramsNotAccepted', res_json['paramsNotAccepted'])
print('content', json.dumps(res_json['content'], indent=4))