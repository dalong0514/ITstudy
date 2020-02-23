# -*- coding: utf-8 -*-


import scrapy


class BerlinItem(scrapy.Item):
    name = scrapy.Field()
    description = scrapy.Field()
