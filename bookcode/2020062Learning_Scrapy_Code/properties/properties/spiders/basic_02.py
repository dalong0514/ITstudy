# -*- coding: utf-8 -*-
import scrapy
from properties.items import PropertiesItem

class BasicSpider(scrapy.Spider):
    name = 'basic'
    allowed_domains = ['web']
    start_urls = ['http://web:9312/properties/property_000000.html']

    def parse(self, response):
        item = PropertiesItem()
        item['title'] = response.xpath(
            '//*[@itemprop="name"][1]/text()').extract()
        item['price'] = response.xpath(
            '//*[@itemprop="price"][1]/text()').re('[.0-9]+')
        item['description'] = response.xpath(
            '//*[@itemprop="description"][1]/text()').extract()
        item['address'] = response.xpath(
            '//*[@itemtype="http://schema.org/Place"][1]/text()').extract()
        item['image_URL'] = response.xpath(
            '//*[@itemprop="image"][1]/@src').extract()
        return item