from scrapy.exporters import BaseItemExporter
import io
import csv


class CsvItemExporter(BaseItemExporter):
    fieldnames_standard = ['item_code', 'product_name', 'url', 'price_per_unit', 'unit', 'rating', 'product_reviews',
                           'product_origin', 'product_image']

    def __init__(self, file, **kwargs):
        self._configure(kwargs)
        if not self.encoding:
            self.encoding = 'utf-8'

        self.file = io.TextIOWrapper(file,
                                     line_buffering=False,
                                     write_through=True,
                                     encoding=self.encoding)
        self.file.truncate(0)
        self.items = []

    def finish_exporting(self):
        spamwriter = csv.DictWriter(self.file, fieldnames=self.__get_fieldnames(), lineterminator='\n')
        spamwriter.writeheader()
        for item in self.items:
            spamwriter.writerow(item)

    def export_item(self, item):
        new_item = dict(item)
        new_item.pop('nutritions')
        new_item.pop('image_urls')
        self.items.append({**new_item, **item['nutritions']})

    def __get_fieldnames(self):
        field_names = set()
        for product in self.items:
            for key in product.keys():
                if key not in self.fieldnames_standard:
                    field_names.add(key)
        return self.fieldnames_standard + list(field_names)
