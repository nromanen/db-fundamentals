
from connection import get_connection
from base import Base

class Repository:

    def __init__(self):
        self.connection = get_connection("db.ini", "postgresql")

    
    def get_by_query(self, query):
        with self.connection.cursor() as curs:
            curs.execute(query)
            records = curs.fetchall()
            column_names = curs.description

        column_names = [i[0] for i in column_names]
        result = []
        for record in records:
            one_line = {}
            for index in range(len(record)):
                one_line[column_names[index]] = record[index]
            result.append(Base(**one_line))
        return result



