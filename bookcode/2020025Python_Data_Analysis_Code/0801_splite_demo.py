import sqlite3

with sqlite3.connect(":memory:") as con:
    c = con.cursor()
c.execute('''CREATE TABLE sensors (date text, city text, code text, sensor_id real,
temperature real)''')
for table in c.execute("SELECT name FROM sqlite_master WHERE type = 'table'"):
    print("Table", table[0])

c.execute("INSERT INTO sensors VALUES ('2020-02-07', 'HangZhou', '31000', 42.0, 15.14)")
c.execute("SELECT * FROM sensors")
print(c.fetchone())

con.execute("DROP TABLE sensors")
print("# of tables", c.execute("SELECT COUNT(*) FROM sqlite_master WHERE type = 'table'").fetchone()[0])

c.close()