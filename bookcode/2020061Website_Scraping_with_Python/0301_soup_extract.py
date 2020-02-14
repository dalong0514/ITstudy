from urllib.request import urlopen, urljoin, urlparse
import re
import requests

# r = requests.get('http:hajba.hu')
# if r.status_code == 200:
#     print(r.text[:250])
# else:
#     print(r.status_code)

links = []
ul = soup.find('ul', class_='categories departments')
if ul:
    for li in ul.find_all('li'):
        a = li.find('a',href=True)
        if a:
            links.append(a['href'])

product_pages = []
visited = set()
queue = deque()
queue.extend(department_links)
while queue:
    link = queue.popleft()
    if link in visited:
        continue
    visited.add(link)
    soup = get_page(link)
    ul = soup.find('ul', class_='produtlister gridView')
    if ul:
        product_pages.append(link)
    else:
        ul = soup.find('ul', class_='categories aisles')
        if not ul:
            continue
        for li in ul.find_all('li'):
            a = li.find('a', href=True)
            if a:
                queue.append(a['href'])


product_pages = []
visited = set()
queue = deque()
queue.extend(department_links)
while queue:
    link = queue.popleft()
    if link in visited:
        continue
    visited.add(link)
    soup = get_page(link)
    ul = soup.find('ul', class_='produtlister gridView')
    if ul:
        product_pages.append(link)
    else:
        ul = soup.find('ul', class_='categories aisles')
        if not ul:
            continue
        for li in ul.find_all('li'):
            a = li.find('a', href=True)
            if a:
                queue.append(a['href'])


def download_page(url):
    try:
        return requests.get(url).text
    except:
        print('error in the url', url)

def extract_links(page):
    if not page:
        return []
    link_regex = re.compile('<a[^>]+href=["\'](.*?)["\']', re.IGNORECASE)
    return [urljoin(page,link) for link in link_regex.findall(page)]

def get_links(page_url):
    host = urlparse(page_url)[1]
    page = download_page(page_url)
    links = extract_links(page)
    return [link for link in links if urlparse(link)[1] == host]

def depth_first_search(start_url):
    from collections import deque
    visited = set()
    queue = deque()
    queue.append(start_url)
    while queue:
        url = queue.popleft()
        if url in visited:
            continue
        visited.add(url)
        for link in get_links(url):
            queue.appendleft(link)
        print(url)

def breadth_first_search(start_url):
    from collections import deque
    visited = set()
    queue = deque()
    queue.append(start_url)
    while queue:
        url = queue.popleft()
        if url in visited:
            continue
        visited.add(url)
        queue.extend(get_links(url))
        print(url)

if __name__ == '__main__':
    start_url = 'https://www.sainsburys.co.uk/shop/gb/groceries/meat-fish'
    depth_first_search(start_url)
    breadth_first_search(start_url)