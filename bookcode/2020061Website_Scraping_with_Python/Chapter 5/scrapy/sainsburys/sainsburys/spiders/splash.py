# -*- coding: utf-8 -*-
from scrapy import Spider
import re

from sainsburys.items import SainsburysItem
from scrapy_splash import SplashRequest

reviews_pattern = re.compile("Reviews \((\d+)\)")
item_code_pattern = re.compile("Item code: (\d+)")


class BasicSpider(Spider):
    name = 'splash'
    allowed_domains = ['www.sainsburys.co.uk']
    start_urls = ['https://www.sainsburys.co.uk/shop/gb/groceries/meat-fish/']

    def start_requests(self):
        for url in self.start_urls:
            yield SplashRequest(url, callback=self.parse)

    def parse(self, response):
        urls = response.xpath('//ul[@class="categories departments"]/li/a/@href').extract()

        for url in urls:
            if url.startswith('http'):
                yield SplashRequest(url, callback=self.parse_department_pages)

    def parse_department_pages(self, response):
        product_grid = response.xpath('//ul[@class="productLister gridView"]')
        if product_grid:
            for product in self.handle_product_listings(response):
                yield product

        pages = response.xpath('//ul[@class="categories shelf"]/li/a/@href').extract()
        if not pages:
            pages = response.xpath('//ul[@class="categories aisles"]/li/a/@href').extract()
        if not pages:
            # here is something fishy
            return

        for url in pages:
            if url.startswith('http'):
                yield SplashRequest(url, callback=self.parse_department_pages)

    def handle_product_listings(self, response):
        urls = response.xpath('//ul[@class="productLister gridView"]//li[@class="gridItem"]//h3/a/@href').extract()
        for url in urls:
            if url.startswith('http'):
                yield SplashRequest(url, callback=self.parse_product_detail)

        next_page = response.xpath('//ul[@class="pages"]/li[@class="next"]/a/@href').extract()
        if next_page:
            yield SplashRequest(next_page[0], callback=self.handle_product_listings)
            # yield response.follow(next_page[0], callback=self.handle_product_listings)

    def parse_product_detail(self, response):
        item = SainsburysItem()
        item['url'] = response.url
        item['product_name'] = response.xpath('//h1/text()').extract()[0].strip()
        item['product_image'] = response.urljoin(
            response.xpath('//div[@id="productImageHolder"]/img/@src').extract()[0])
        item['image_urls'] = [response.urljoin(
            response.xpath('//div[@id="productImageHolder"]/img/@src').extract()[0])]

        item['price_per_unit'] = response.xpath('//div[@class="pricing"]/p[@class="pricePerUnit"]/text()').extract()[
            0].strip()
        units = response.xpath('//div[@class="pricing"]/span[@class="pricePerUnitUnit"]').extract()
        if units:
            item['unit'] = units[0].strip()

        ratings = response.xpath('//label[@class="numberOfReviews"]/img/@alt').extract()
        if ratings:
            item['rating'] = ratings[0]
        reviews = response.xpath('//label[@class="numberOfReviews"]').extract()
        if reviews:
            reviews = reviews_pattern.findall(reviews[0])
            if reviews:
                item['product_reviews'] = reviews[0]

        item['item_code'] = \
            item_code_pattern.findall(response.xpath('//p[@class="itemCode"]/text()').extract()[0].strip())[0]

        nutritions = {}
        rows = response.xpath('//table[@class="nutritionTable"]/tr')
        if not rows:
            rows = response.xpath('//table[@class="nutritionTable"]/tbody/tr')
        for row in rows:
            th = row.xpath('./th/text()').extract()
            if not th:
                th = ['Energy kcal']
            td = row.xpath('./td[1]/text()').extract()
            if td:
                nutritions[th[0].strip()] = td[0].strip()
        item['nutritions'] = nutritions

        item['product_origin'] = ' '.join(response.xpath(
            './/h3[@class="productDataItemHeader" and text()="Country of Origin"]/following-sibling::div[1]/p/text()').extract())

        yield item

    def parse_product_details_bs(self, response):
        from bs4 import BeautifulSoup
        soup = BeautifulSoup(response.text, 'lxml')
        item = SainsburysItem()
        h1 = soup.find('h1')
        if h1:
            item['product_name'] = h1.text.strip()

        pricing = soup.find('div', class_='pricing')
        if pricing:
            p = pricing.find('p', class_='pricePerUnit')
            unit = pricing.find('span', class_='pricePerUnitUnit')
            if p:
                item['price_per_unit'] = p.text.strip()
            if unit:
                item['unit'] = unit.text.strip()

        label = soup.find('label', class_='numberOfReviews')
        if label:
            img = label.find('img', alt=True)
            if img:
                item['rating'] = img['alt'].strip()
            reviews = reviews_pattern.findall(label.text.strip())
            if reviews:
                item['product_reviews'] = reviews[0]
        else:
            rating = soup.find('span', {'itemprop': 'ratingValue'})
            if rating:
                item['rating'] = rating.text.strip()
            reviews = soup.find('meta', {'itemprop': 'reviewCount'})
            if reviews and reviews.hasattr('content'):
                item['product_reviews'] = reviews['content'].strip()

        item_code = soup.find('p', class_='itemCode')
        if item_code:
            item_codes = item_code_pattern.findall(item_code.text.strip())
            if item_codes:
                item['item_code'] = item_codes[0]

        table = soup.find('table', class_='nutritionTable')
        if table:
            nutritions = {}
            rows = table.findAll('tr')
            for tr in rows[1:]:
                th = tr.find('th', class_='rowHeader')
                td = tr.find('td')
                if not td:
                    # print(tr.prettify())
                    # print(url)
                    continue
                if not th:
                    nutritions['Energy kcal'] = td.text
                else:
                    nutritions[th.text.replace('-', '').strip()] = td.text
            item['nutritions'] = nutritions

        product_origin_header = soup.find('h3',
                                          class_='productDataItemHeader', text='Country of Origin')
        if product_origin_header:
            # find next sibling of class 'productText'
            product_text = product_origin_header.find_next_sibling('div', class_='productText')
            if product_text:
                origin_info = []
                for p in product_text.find_all('p'):
                    origin_info.append(p.text.strip())
                item['product_origin'] = '; '.join(origin_info)

        yield item
