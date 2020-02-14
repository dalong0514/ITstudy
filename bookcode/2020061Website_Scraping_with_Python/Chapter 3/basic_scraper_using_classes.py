from collections import deque
import re
import csv
import json
from progressbar import ProgressBar, UnknownLength
from chapter_3 import sqlite_classes
from chapter_3.product import Product, ProductOrm
from chapter_3 import mongo_database

# Change the parser below to try out different options
# bs_parser = 'html.parser'
bs_parser = 'lxml'
# bs_parser = 'lxml-xml'
# bs_parser = 'html5lib'


headers = {
    'Accept-Encoding': 'gzip, deflate, br',
    'Accept-Language': 'en-US,en-US;q=0.5,en;q=0.4',
    'Upgrade-Insecure-Requests': '1',
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Safari/537.36',
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8',
    'Connection': 'keep-alive',
}

reviews_pattern = re.compile("Reviews \((\d+)\)")
item_code_pattern = re.compile("Item code: (\d+)")
product_id_mapping = re.compile('&productId=(\d+)')

from chapter_3.downloader import Downloader

downloader = Downloader(hard_cache=True)


def write_to_file(soup, url, name=None):
    if not soup or not url:
        return
    if not name:
        name = url[url.rfind('/') + 1:] + '.html'
    with open(name, 'w') as outfile:
        outfile.write(soup.prettify())


def get_page(url):
    return downloader.get_soup(url)


def extract_product_information(product_urls):
    product_information = []
    visited = set()
    bar = ProgressBar()
    for url in bar(product_urls):
        if url in visited:
            continue
        visited.add(url)
        product = Product(url)
        # product = ProductOrm() # use ProductOrm classes if you want to use an ORM tool for saving to a relational database, like SQLite
        product.url = url
        soup = get_page(url)
        if not soup:
            continue
        h1 = soup.find('h1')
        if h1:
            product.name = h1.text.strip()

        pricing = soup.find('div', class_='pricing')
        if pricing:
            p = pricing.find('p', class_='pricePerUnit')
            unit = pricing.find('span', class_='pricePerUnitUnit')
            if p:
                product.price_per_unit = p.text.strip()
            if unit:
                product.unit = unit.text.strip()

        label = soup.find('label', class_='numberOfReviews')
        if label:
            img = label.find('img', alt=True)
            if img:
                product.rating = img['alt'].strip()
            reviews = reviews_pattern.findall(label.text.strip())
            if reviews:
                product.reviews = reviews[0]
        else:
            rating = soup.find('span', {'itemprop': 'ratingValue'})
            if rating:
                product.rating = rating.text.strip()
            reviews = soup.find('meta', {'itemprop': 'reviewCount'})
            if reviews and reviews.hasattr('content'):
                product.reviews = reviews['content'].strip()

        item_code = soup.find('p', class_='itemCode')
        if item_code:
            item_codes = item_code_pattern.findall(item_code.text.strip())
            if item_codes:
                product.item_code = item_codes[0]

        table = soup.find('table', class_='nutritionTable')
        if table:
            rows = table.findAll('tr')
            for tr in rows[1:]:
                th = tr.find('th', class_='rowHeader')
                td = tr.find('td')
                if not td:
                    continue
                if not th:
                    pass
                else:
                    pass

        product_origin_header = soup.find('h3',
                                          class_='productDataItemHeader', text='Country of Origin')
        if product_origin_header:
            product_text = product_origin_header.find_next_sibling('div', class_='productText')
            if product_text:
                origin_info = []
                for p in product_text.find_all('p'):
                    origin_info.append(p.text.strip())
                product.product_origin = '; '.join(origin_info)

        product_information.append(product)
    return product_information


def extract_product_details(product_pages):
    products = []
    visited = set()
    queue = deque()
    queue.extend(product_pages)
    bar = ProgressBar(max_value=UnknownLength)
    c = 0
    while queue:
        product_page = queue.popleft()
        c += 1
        bar.update(c)
        if product_page in visited:
            continue
        visited.add(product_page)
        soup = get_page(product_page)
        if soup:
            ul = soup.find('ul', class_='productLister gridView')
            if ul:
                for li in ul.find_all('li', class_='gridItem'):
                    a = li.find('a', href=True)
                    if a:
                        products.append(a['href'])

            next_page = soup.find('li', class_='next')
            if next_page:
                a = next_page.find('a', href=True)
                if a:
                    qm = a['href'].find('?')
                    if '#' in product_page:
                        product_page = product_page[:product_page.find('#')]
                    queue.append(product_page + '#' + a['href'][qm + 1:])
    return products


def extract_links_to_product_pages(department_links):
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
        ul = soup.find('ul', class_='productLister gridView')
        if ul:
            product_pages.append(link)
        else:
            ul = soup.find('ul', class_='categories shelf')
            if not ul:
                ul = soup.find('ul', class_='categories aisles')
            if not ul:
                continue
            for li in ul.find_all('li'):
                a = li.find('a', href=True)
                if a:
                    queue.append(a['href'])
    return product_pages


def extract_department_links(url):
    links = []
    soup = get_page(url)
    ul = soup.find('ul', class_='categories departments')
    if not ul:
        return links
    for li in ul.find_all('li'):
        a = li.find('a', href=True)
        if a:
            links.append(a['href'])
    return links


def write_results_to_csv(filename, products):
    with open(filename, 'w') as outfile:
        spamwriter = csv.DictWriter(outfile, fieldnames=get_field_names(products), lineterminator='\n')
        spamwriter.writeheader()
        spamwriter.writerows(map(lambda p: p.__dict__, products))


def get_field_names(product_information):
    return set(vars(product_information[0]).keys())


def write_results_to_json(filename, products):
    with open(filename, 'w') as outfile:
        json.dump(list(map(lambda p: p.__dict__, products)), outfile)


def save_results_to_database(products, database_name='sainsburys.db'):
    sqlite_classes.save_to_sqlite(database_name, products)


def save_results_to_mongo(products):
    mongo_database.save_to_database('sainsburys', products)


if __name__ == '__main__':
    from time import time

    start = time()
    department_links = extract_department_links('https://www.sainsburys.co.uk/shop/gb/groceries/meat-fish/')
    print(len(department_links), 'department links found')

    product_pages = extract_links_to_product_pages(department_links)
    print(len(product_pages), 'product pages found')

    product_details = extract_product_details(product_pages)
    # print(len(product_details), 'product details found')
    # print(len(set(product_details)), 'distinct product details found')

    product_information = extract_product_information(product_details)
    csv_file = 'sainsburys.csv'
    # write_results_to_csv(csv_file, product_information)
    # print(len(product_information), 'products extracted')
    # save_results_to_database(product_information, 'sainsburys_orm.db')
    save_results_to_mongo(product_information)
    print('finished in', time() - start, 'seconds')
