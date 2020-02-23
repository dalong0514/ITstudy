from sainsburys.items import SainsburysItem

from scrapy.exceptions import DropItem


class CsvItemPipeline:
    fieldnames_standard = ['item_code', 'product_name', 'url', 'price_per_unit', 'unit', 'rating', 'product_reviews',
                           'product_origin', 'product_image']

    def __init__(self, csv_filename):
        self.items = []
        self.csv_filename = csv_filename

    @classmethod
    def from_crawler(cls, crawler):
        return cls(
            csv_filename=crawler.settings.get('CSV_FILENAME', 'sainsburys.csv'),
        )

    def open_spider(self, spider):
        pass

    def close_spider(self, spider):
        import csv
        with open(self.csv_filename, 'w', encoding='utf-8') as outfile:
            spamwriter = csv.DictWriter(outfile, fieldnames=self.__get_fieldnames(), lineterminator='\n')
            spamwriter.writeheader()
            for item in self.items:
                spamwriter.writerow(item)

    def process_item(self, item, spider):
        if type(item) == SainsburysItem:
            new_item = dict(item)
            new_item.pop('nutritions')
            new_item.pop('image_urls')
            self.items.append({**new_item, **item['nutritions']})
        return item

    def __get_fieldnames(self):
        field_names = set()
        for product in self.items:
            for key in product.keys():
                if key not in self.fieldnames_standard:
                    field_names.add(key)
        return self.fieldnames_standard + list(field_names)


class DuplicateItemFilter:
    def __init__(self):
        self.item_codes_seen = set()

    def process_item(self, item, spider):
        if item['item_code'] in self.item_codes_seen:
            raise DropItem("Duplicate item found: %s" % item['item_code'])
        else:
            self.item_codes_seen.add(item['item_code'])
            return item
