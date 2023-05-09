import psycopg2

conn = psycopg2.connect(database="northwind",
                        host="localhost",
                        user="postgres",
                        password="root",
                        port="5432")

records = []
column_names = []
with conn.cursor() as curs:
    curs.execute("select * from products")
    records = curs.fetchall()
    column_names = curs.description

# print(records)
column_names = [i[0] for i in column_names]
for record in records:
    for index in range(len(record)-1):
        print(f"{column_names[index]}: {record[index]}", end = ', ')
    print()

