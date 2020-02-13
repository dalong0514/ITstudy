# -*- coding: utf-8 -*-
import scrapy
# import urllib.parse as urlparse
# The urlparse in Python 2.7.11 was renamed to urllib.parse in Python 3
import urlparse
import datetime
import socket

from properties.items import PropertiesItem
from scrapy.loader import ItemLoader
from scrapy.loader.processors import MapCompose, Join

class BasicSpider(scrapy.Spider):
    name = 'basic'
    allowed_domains = ['web']
    start_urls = ['http://web:9312/properties/property_000000.html']

    def parse(self, response):
        l = ItemLoader(item=PropertiesItem(), response=response)
        l.add_xpath('title', '//*[@itemprop="name"][1]/text()', 
        MapCompose(unicode.strip, unicode.title))
        l.add_xpath('price', '//*[@itemprop="price"][1]/text()', 
        MapCompose(lambda i: i.replace(',', ''), float), re='[.0-9]+')
        l.add_xpath('description', '//*[@itemprop="description"][1]/text()', 
        MapCompose(unicode.strip), Join())
        l.add_xpath('address', '//*[@itemtype="http://schema.org/Place"][1]/text()',
        MapCompose(unicode.strip))
        l.add_xpath('image_URL', '//*[@itemprop="image"][1]/@src', 
        MapCompose(lambda i: urlparse.urljoin(response.url, i)))
        # Housekeeping fields
        l.add_value('url', response.url)
        l.add_value('project', self.settings.get('BOT_NAME'))
        l.add_value('spider', self.name)
        l.add_value('server', socket.gethostname())
        l.add_value('date', datetime.datetime.now())
        return l.load_item()