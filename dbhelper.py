

from mysql.connector import connect

def dbconnect() -> object:
    return connect(
        host='127.0.0.1',
        user='root',
        password='',
        database='sitin_monitoring'
    )

def get_process(sql: str, params: tuple = ()) -> list:
    db = dbconnect()
    cursor = db.cursor(dictionary=True)
    cursor.execute(sql, params)
    data = cursor.fetchall()
    cursor.close()
    db.close()
    return data

def post_process(sql: str, params: tuple = ()) -> bool:
    db = dbconnect()
    cursor = db.cursor()
    cursor.execute(sql, params)
    db.commit()
    success = cursor.rowcount > 0
    cursor.close()
    db.close()
    return success

def add_student_record(**kwargs) -> None:
    keys: list = list(kwargs.keys())
    values = list(kwargs.values())

    #output is right to left keys +',' (a','b',') right to left
    flds = "`,`".join(keys)
    datas = "','".join(values)
    
    sql = f"INSERT INTO `students_info` (`{flds}`) VALUES('{datas}')"

    return post_process(sql)

def get_student_account(username:str, password:str) -> list: 
    sql = f"SELECT * FROM`students_info` WHERE `username` = '{username}' AND `password` = '{password}'"
    return get_process(sql)


# def add_student_account(**kwargs) -> None:
#     keys: list = list(kwargs.keys()) 
#     values: list = list(kwargs.values())

#     flds = "','".join(keys)
#     datas = "','".join(values)

#     sql = f"INSERT INTO `students_account` ('{flds}') VALUES('{datas}')"

#     return post_process(sql)

# from sqlite3 import Row, connect

# database: str = "test.db"

# def post_process(sql:str) -> bool: 
#     db = connect(database)
#     cursor = db.cursor()
#     cursor.execute(sql)
#     db.commit()
#     cursor.close()
    
#     return True if cursor.rowcount > 0 else False

# def get_process(sql: str) -> dict:
#     db = connect(database)
#     cursor = db.cursor()
#     cursor.row_factory = Row
#     cursor.execute(sql)
#     data = cursor.fetchall()
#     cursor.close()
    
#     return data