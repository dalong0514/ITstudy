from urllib import request

# test the code
url = 'http://www.baidu.com'
response = request.urlopen(url, timeout=1)
print(response.read().decode('utf-8'))