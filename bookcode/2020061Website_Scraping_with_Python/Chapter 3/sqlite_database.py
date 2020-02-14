import sqlite3

table_ddl = """
CREATE TABLE IF NOT EXISTS sainsburys (
    item_code INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    url TEXT NOT NULL,
    energy_kcal TEXT,
    energy_kjoule TEXT,
    fat TEXT,
    saturates TEXT,
    carbohydrates TEXT,
    total_sugars TEXT,
    starch TEXT,
    fibre TEXT,
    protein TEXT,
    salt TEXT,
    country_of_origin TEXT,
    price_per_unit TEXT,
    unit TEXT,
    number_of_reviews INTEGER,
    average_rating REAL
)
"""

sqlite_insert = """
INSERT OR REPLACE INTO sainsburys
    values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
"""

connection = None


def save_to_sqlite(database_path, rows):
    """
    This function saves all entries into the database
    :param database_path: the path to the SQLite file. If not exists, it will be created.
    :param rows: the list of dictionary elements to save to the database
    """
    global connection
    connection = __connect(database_path)
    __ensure_table()
    for row in rows:
        __save_row(row)
    __close_connection()


def __save_row(row):
    connection.execute(sqlite_insert, (
        row.get('item_code'), row.get('name'), row.get('url'), row.get('Energy kcal'), row.get('Energy'),
        row.get('Fat'), row.get('Saturates'), row.get('Carbohydrates'), row.get('Total Sugars'), row.get('Starch'),
        row.get('Fibre'), row.get('Protein'), row.get('Salt'), row.get('Country of Origin'), row.get('price'),
        row.get('unit'), row.get('reviews'), row.get('rating')))


def __connect(database):
    return sqlite3.connect(database)


def __close_connection():
    if connection:
        connection.close()


def __ensure_table():
    connection.execute(table_ddl)
