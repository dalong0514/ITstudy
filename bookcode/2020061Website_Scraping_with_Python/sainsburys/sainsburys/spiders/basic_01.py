# -*- coding: utf-8 -*-
import scrapy
import re

from sainsburys.items import SainsburysItem

# what is the meaning?
reviews_pattern = re.compile("Reviews \((\d+)\)")
item_code_pattern = re.compile("Item code: (\d+)")

class BasicSpider(scrapy.Spider):
    name = 'basic'
    allowed_domains = ['www.sainsburys.co.uk']
    start_urls = ['http://www.sainsburys.co.uk/shop/gb/groceries/meat-fish/']

    def parse(self, response):
        urls = response.xpath('//ul[@class="categories departments"]/li/a')

        for url in urls:
            yield response.follow(url, callback=self.parse_department_pages)

    def parse_department_pages(self, response):
        product_grid = response.xpath('//ul[@class="productLister gridView"]')
        if product_grid:
            for product in self.handle_product_listings(response):
                yield product

        pages = response.xpath('//ul[@class="categories aisles"]/li/a')
        # @class="categories shelf" has been deleted
        # if not pages:
        #     pages = response.xpath('//ul[@class="categories aisles"]/li/a')
        if not pages:
            # here is something fishy
            return

        for url in pages:
            yield response.follow(url, callback=self.parse_department_pages)

    def handle_product_listings(self, response):
        urls = response.xpath('//ul[@class="productLister gridView"]//li[@class="gridItem"]//h3/a')
        for url in urls:
            yield response.follow(url, callback=self.parse_product_detail)

        next_page = response.xpath('//ul[@class="pages"]/li[@class="next"]/a')
        if next_page:
            yield response.follow(next_page, callback=self.handle_product_listings)

    def parse_product_detail(self, response):
        item = SainsburysItem()
        item['url'] = response.url
        item['product_name'] = response.xpath('//h1/text()').extract()[0].strip()
        item['product_image'] = response.urljoin(
            response.xpath('//div[@id="productImageHolder"]/img/@src').extract()[0])

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
        for row in response.xpath('//table[@class="nutritionTable"]/tr'):
            th = row.xpath('./th/text()').extract()
            if not th:
                th = ['Energy kcal']
            td = row.xpath('./td[1]/text()').extract()[0]
            nutritions[th[0]] = td
        item['nutritions'] = nutritions

        item['product_origin'] = ' '.join(response.xpath(
            './/h3[@class="productDataItemHeader" and text()="Country of Origin"]/following-sibling::div[1]/p/text()').extract())

        yield item
