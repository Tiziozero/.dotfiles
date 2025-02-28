import sqlite3
import sys



# dbPath = os.environ["DB_1_PATH"]
dbPath = ""
dbPath = dbPath if dbPath != "" else "../several/uquwadro.db"
# print(dbPath)
with sqlite3.connect(dbPath) as db:
    c = db.cursor()
    statement = ""
    if len(sys.argv) > 1:
        statement = sys.argv[1]
    if statement == "": statement = "select link from image_links"
    c.execute(statement)
    data = c.fetchall()
    data = [ d[0] for d in data]
    for d in data: print(d)
