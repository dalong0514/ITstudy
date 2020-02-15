# -*- coding: utf-8 -*-

from scrapy import Field, Item


class SainsburysItem(Item):
    url = Field()
    product_name = Field()
    product_image = Field()
    price_per_unit = Field()
    unit = Field()
    rating = Field()
    product_reviews = Field()
    item_code = Field()
    nutritions = Field()
    product_origin = Field()
    image_urls = Field()
    images = Field()

