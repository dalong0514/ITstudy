import requests

# 执行 API 调用并存储响应
url = 'https://api.github.com/search/repositories?q=language:python&sort=stars'
r = requests.get(url)
print("Status code:", r.status_code)

# 把 API 响应存储到一个变量里去
response_dict = r.json()

print(response_dict.keys())