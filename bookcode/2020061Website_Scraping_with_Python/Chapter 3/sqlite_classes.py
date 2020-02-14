import peewee
from chapter_3.product import ProductOrm


def save_to_sqlite(database_path, rows):
    """
    This function saves all entries into the database
    :param database_path: the path to the SQLite file. If not exists, it will be created.
    :param rows: the list of ProductOrm objects elements to save to the database
    """
    __connect(database_path)
    __ensure_table()
    for row in rows:
        row.save()


def __connect(database):
    ProductOrm._meta.database = peewee.SqliteDatabase(database)


def __ensure_table():
    ProductOrm.create_table(True)
