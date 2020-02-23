import pymongo
import sqlite3
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
            # spider.logger.info('URL of item: %s', item['url'] )
            raise DropItem("Duplicate item found: %s" % item['item_code'])
        else:
            self.item_codes_seen.add(item['item_code'])
            return item


class MongoDBPipeline:

    def __init__(self, mongo_uri, mongo_db, collection_name):
        self.mongo_uri = mongo_uri
        self.mongo_db = mongo_db
        self.collection_name = collection_name

    @classmethod
    def from_crawler(cls, crawler):
        return cls(
            mongo_uri=crawler.settings.get('MONGO_URI'),
            mongo_db=crawler.settings.get('MONGO_DATABASE', 'items'),
            collection_name=crawler.settings.get('MONGO_COLLECTION', 'sainsburys')
        )

    def open_spider(self, spider):
        self.client = pymongo.MongoClient(self.mongo_uri)
        self.db = self.client[self.mongo_db]

    def close_spider(self, spider):
        self.client.close()

    def process_item(self, item, spider):
        self.db[self.collection_name].insert_one(dict(item))
        return item


sqlite_ddl = """
CREATE TABLE IF NOT EXISTS {} (
    item_code INTEGER PRIMARY KEY,
    product_name TEXT NOT NULL,
    url TEXT NOT NULL,
    product_image TEXT,
    product_origin TEXT,
    price_per_unit TEXT,
    unit TEXT,
    product_reviews INTEGER,
    rating REAL
)
"""

sqlite_insert = """
INSERT OR REPLACE INTO {}
    values (?, ?, ?, ?, ?, ?, ?, ?, ?)
"""


class SQLitePipeline:
    def __init__(self, database_location, table_name):
        self.database_location = database_location
        self.table_name = table_name
        self.db = None

    @classmethod
    def from_crawler(cls, crawler):
        return cls(
            database_location=crawler.settings.get('SQLITE_LOCATION'),
            table_name=crawler.settings.get('SQLITE_TABLE', 'sainsburys'),
        )

    def open_spider(self, spider):
        self.db = sqlite3.connect(self.database_location)
        self.db.execute(sqlite_ddl.format(self.table_name))

    def close_spider(self, spider):
        if self.db:
            self.db.close()

    def process_item(self, item, spider):
        if type(item) == SainsburysItem:
            self.db.execute(sqlite_insert.format(self.table_name),
                            (
                                item['item_code'], item['product_name'], item['url'], item['product_image'],
                                item['product_origin'], item['price_per_unit'],
                                item['unit'] if hasattr(item, 'unit') else None,
                                int(item['product_reviews']) if hasattr(item, 'product_reviews') else None,
                                float(item['rating']) if hasattr(item, 'rating') else None
                            )
                            )
            self.db.commit()
