# -*- coding: utf-8 -*-
import scrapy
from properties.items import PropertiesItem
from scrapy.loader import ItemLoader

class BasicSpider(scrapy.Spider):
    name = 'basic'
    allowed_domains = ['web']
    start_urls = ['http://web:9312/properties/property_000000.html']

    def parse(self, response):
        l = ItemLoader(item=PropertiesItem(), response=response)
        l.add_xpath('title', '//*[@itemprop="name"][1]/text()')
        l.add_xpath('price', '//*[@itemprop="price"][1]/text()', re='[.0-9]+')
        l.add_xpath('description', '//*[@itemprop="description"][1]/text()')
        l.add_xpath('address', '//*[@itemtype="http://schema.org/Place"][1]/text()')
        l.add_xpath('image_URL', '//*[@itemprop="image"][1]/@src')
        return l.load_item()