# -*- coding: utf-8 -*-

# Define here the models for your scraped items
#
# See documentation in:
# https://docs.scrapy.org/en/latest/topics/items.html

import scrapy


class SainsburysItem(scrapy.Item):
    url = scrapy.Field()
    product_name = scrapy.Field()
    product_image = scrapy.Field()
    price_per_unit = scrapy.Field()
    unit = scrapy.Field()
    rating = scrapy.Field()
    product_reviews = scrapy.Field()
    item_code = scrapy.Field()
    nutritions = scrapy.Field()
    product_origin = scrapy.Field()