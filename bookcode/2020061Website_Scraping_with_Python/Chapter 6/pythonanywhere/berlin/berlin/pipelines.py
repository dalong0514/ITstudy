# -*- coding: utf-8 -*-

import pymysql.cursors

insert_template = """INSERT INTO berlinsights (name, description) VALUES (%s, %s)"""


class BerlinMySQLPipeline(object):

    def process_item(self, item, spider):
        connection = pymysql.connect(host='???',  # TODO add your database host
                                     user='???',  # TODO add your database user
                                     password='???',  # TODO add your database password
                                     db='???',  # TODO add your database name like GHajba$berlinsights
                                     charset='utf8mb4',
                                     cursorclass=pymysql.cursors.DictCursor)
        try:
            with connection.cursor() as cursor:
                cursor.execute(insert_template, (item['name'], item['description']))
                connection.commit()
        finally:
            connection.close()

        return item
