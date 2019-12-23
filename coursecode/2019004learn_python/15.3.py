from urllib import parse
from urllib import request

url = 'http://httpbin.org'

headers = {
    "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9", 
    "Accept-Encoding": "gzip, deflate", 
    "Accept-Language": "zh-CN,zh;q=0.9,en;q=0.8", 
    "Host": "httpbin.org", 
    "Upgrade-Insecure-Requests": "1", 
    "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.88 Safari/537.36"
  }

dict = {'name':'value'}

data = bytes(parse.urlencode(dict), encoding='utf8')
res = request.Request(url=url, data=data, headers=headers, method='POST')
response = request.urlopen(res)
print(response.read().decode('utf-8'))