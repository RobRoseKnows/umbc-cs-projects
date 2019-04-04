import mysql.connector
import sys

if len(sys.argv) != 2:
    print("ONE command line argument please")
    exit()
else:
    print("db user: ")
    db_user = input()
    print("db password: ")
    db_password = input()
    config = {
        'user': db_user,
        'password': db_password,
        'host': 'localhost',
        'port': 3306,
        'database': str(sys.argv[1]),
        'raise_on_warnings': True
    }
    db_connection = mysql.connector.connect(**config)
    cur = db_connection.cursor()
    db_connection2 = mysql.connector.connect(**config)

    show_tables = "SHOW TABLES;"
    cur.execute(show_tables)
    for (table,) in cur:
        cur2 = db_connection2.cursor()
        query = f"SELECT COUNT(*) FROM {table};"
        cur2.execute(query)
        res = next(cur2)[0]
        print(f"{table}, rows: {res}")