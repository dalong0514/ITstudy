import pymongo

connection = None
db = None


def save_to_database(database_name, products):
    global connection
    __connect(database_name)
    for product in products:
        __save(product)
    __close_connection()


def __save(product):
    db['sainsburys'].insert_one(product.__dict__)


def __connect(database):
    global connection, db
    connection = pymongo.MongoClient()
    db = connection[database]


def __close_connection():
    if connection:
        connection.close()
