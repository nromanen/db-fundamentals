
from configparser import ConfigParser
import psycopg2


def get_connection(filename, section):
    if len(filename) > 0 and len(section) > 0:
        parser = ConfigParser()
        parser.read(filename)

        database = {}
        if parser.has_section(section):
            params = parser.items(section)
            for param in params:
                database[param[0]] = param[1]
            return psycopg2.connect(**database)

    else:
        raise Exception('Section {0} not found in the {1} file'.format(section, filename))



# 


# conn = psycopg2.connect(database="northwind",
#                         host="localhost",
#                         user="postgres",
#                         password="root",
#                         port="5432")

# conn = get_connection("db.ini", "postgresql")


# with conn.cursor() as curs:
#     curs.execute("select * from products")
#     records = curs.fetchall()
#     column_names = curs.description

# column_names = [i[0] for i in column_names]
# for record in records:
#     for index in range(len(record) - 1):
#         print(f"{column_names[index]}: {record[index]}", end=', ')
#     print()
