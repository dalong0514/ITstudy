# -*- coding: utf-8 -*-
import scrapy


class BasicSpider(scrapy.Spider):
    name = 'basic'
    allowed_domains = ['www.sainsburys.co.uk']
    start_urls = ['https://www.sainsburys.co.uk/shop/gb/groceries/meat-fish/']

    def parse(self, response):
        pass
