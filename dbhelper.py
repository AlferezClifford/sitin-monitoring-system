from mysql.connector import connect

def dbconnect () -> None: 
    return connect(
        host = '127.0.0.1',
        user = 'root',
        password = '',
        database = 'sitin_monitoring'
    )

def post_process(sql: str) -> bool: 
    db = dbconnect()

    cursor = db.cursor(dictionary = True)
    cursor.exectue(sql)
    cursor.commit()

    sucess = cursor.rowcount > 0
    cursor.close()
    db.close()
    return sucess

def get_process(sql: str) -> list:
    db = dbconnect()

    cursor = db.cursor()
    cursor.execute(sql)
    data = cursor.fetchall()

    return data
