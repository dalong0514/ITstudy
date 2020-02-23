# -*- coding: utf-8 -*-

from scrapy import Item, Field


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
    # below are the fields required for image download
    image_urls = Field()
    images = Field()


class FlatSainsburysItem(Item):
    url = Field()
    product_name = Field()
    product_image = Field()
    price_per_unit = Field()
    unit = Field()
    rating = Field()
    product_reviews = Field()
    item_code = Field()
    product_origin = Field()

    energy = Field()
    energy_kj = Field()
    kcal = Field()
    fibre_g = Field()
    carbohydrates_g = Field()
    of_which_sugars = Field()
    # ...
