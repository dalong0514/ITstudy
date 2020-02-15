import requests
from bs4 import BeautifulSoup

# Change the parser below to try out different options
bs_parser = 'html.parser'
# bs_parser = 'lxml'
# bs_parser = 'lxml-xml'
# bs_parser = 'html5lib

headers = {
    "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9", 
    "Accept-Encoding": "gzip, deflate", 
    "Accept-Language": "zh-CN,zh;q=0.9,en;q=0.8", 
    "Host": "httpbin.org", 
    "Upgrade-Insecure-Requests": "1", 
    "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.100 Safari/537.36", 
    "X-Amzn-Trace-Id": "Root=1-5e46543d-bd05799e78b628face7329cc",
}

def write_to_file(soup, url, name=None):
    if not soup or not url:
        return
    if not name:
        name = url[url.rfind('/') + 1:] + '.html'
    with open(name, 'w') as outfile:
        outfile.write(soup.prettify())

def get_page(url):
    try:
        r = requests.get(url)
        if r.status_code == 200:
            return BeautifulSoup(r.content, bs_parser)
    except Exception as e:
        pass
    return None

if __name__ == '__main__':
    from time import time

    start = time()

    url = 'https://www.douban.com/doulist/1264675/'
    soup = get_page(url)
    # print(soup)
    write_to_file(soup,url)

    print('finished in', time() - start, 'seconds')