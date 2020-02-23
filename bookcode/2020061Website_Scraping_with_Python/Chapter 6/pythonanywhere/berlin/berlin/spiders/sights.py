# -*- coding: utf-8 -*-
import scrapy

from berlin.items import BerlinItem


class SightsSpider(scrapy.Spider):
    name = 'sights'
    allowed_domains = ['berlin.de']
    start_urls = ['https://www.berlin.de/en/attractions-and-sights/']

    def parse(self, response):
        for sight in response.xpath('//div[contains(@class, "teaser")]'):
            item = BerlinItem()
            name = sight.xpath('./h3/a/text()').extract()
            if name:
                item['name'] = name[0]
                description = sight.xpath('./div[@class="inner"]/p/text()').extract()
                if description:
                    item['description'] = description[0]
                    yield item
