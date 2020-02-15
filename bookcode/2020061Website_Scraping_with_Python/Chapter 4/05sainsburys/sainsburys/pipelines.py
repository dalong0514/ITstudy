# -*- coding: utf-8 -*-

from scrapy.exceptions import DropItem


class DuplicateItemFilter:
    def __init__(self):
        self.item_codes_seen = set()

    def process_item(self, item, spider):
        if item['item_code'] in self.item_codes_seen:
            raise DropItem("Duplicate item found: %s" % item['item_code'])

        self.item_codes_seen.add(item['item_code'])
        return item
