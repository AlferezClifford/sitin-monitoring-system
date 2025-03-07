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

    cursor = db.cursor()
    cursor.execute(sql)
    db.commit()

    sucess = cursor.rowcount > 0
    cursor.close()
    db.close()
    return sucess

def get_process(sql: str) -> list:
    db = dbconnect()

    cursor = db.cursor()
    cursor.execute(sql)
    data:list = list(cursor.fetchall())
    return data

def add_student(**kwargs) -> bool:
   values: list = list(kwargs.values())
   keys: list = list(kwargs.keys())
   data = "','".join(values)
   flds = "`,`".join(keys)
   print(flds)
   sql = f"INSERT INTO `students_info` (`{flds}`) VALUES('{data}')"
   return post_process(sql)



def student_account(**kwargs) -> list: 
    values: list = list(kwargs.values())
    keys: list = list(kwargs.keys())
    f_username: str = keys[0]
    f_password: str = keys[1]

    d_username: str = values[0]
    d_password: str = values[1]

    sql: str = f"SELECT * FROM `students_info` WHERE `{f_username}` = '{d_username}' AND `{f_password}` = '{d_password}'"
    cursor = get_process(sql)
    if cursor: 
        data = list(cursor[0])
    else:
        data = []
    return data

# if __name__ == "__main__":

#     add_student()