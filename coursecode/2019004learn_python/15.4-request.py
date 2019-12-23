import requests

# # get 请求
# url = 'http://httpbin.org/get'
# data = {'key':'value', 'abc':'xyz'}

# response = requests.get(url, data)
# print(response.text)

# post 请求
url = 'http://httpbin.org/post'
data = {'key':'value', 'abc':'xyz'}

response = requests.post(url, data)
print(response.json())