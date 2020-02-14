class Product:
    def __init__(self, url):
        self.url = url
        self.name = None
        self.item_code = None
        self.product_origin = None
        self.price_per_unit = None
        self.unit = None
        self.reviews = None
        self.rating = None
        self.energy_kcal = None
        self.energy_kj = None
        self.fat = None
        self.saturates = None
        self.carbohydrates = None
        self.total_sugars = None
        self.starch = None
        self.fibre = None
        self.protein = None
        self.salt = None

    def __repr__(self):
        return """Product({},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{})""".format(
            self.url,
            self.name,
            self.item_code,
            self.product_origin,
            self.price_per_unit,
            self.unit,
            self.reviews,
            self.rating,
            self.energy_kcal,
            self.energy_kj,
            self.fat,
            self.saturates,
            self.carbohydrates,
            self.total_sugars,
            self.starch,
            self.fibre,
            self.protein,
            self.salt
        )


from peewee import Model, TextField, IntegerField, DecimalField


class ProductOrm(Model):
    url = TextField()
    name = TextField()
    item_code = IntegerField(primary_key=True)
    product_origin = TextField(null=True)
    price_per_unit = TextField()
    unit = TextField(null=True)
    reviews = IntegerField(null=True)
    rating = DecimalField(null=True)
    energy_kcal = TextField(null=True)
    energy_kj = TextField(null=True)
    fat = TextField(null=True)
    saturates = TextField(null=True)
    carbohydrates = TextField(null=True)
    total_sugars = TextField(null=True)
    starch = TextField(null=True)
    fibre = TextField(null=True)
    protein = TextField(null=True)
    salt = TextField(null=True)
