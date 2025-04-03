from mysql.connector import connect

# def main() -> None: 
   
#    test = "Fuck you"
#    print(test)
#    if profanity.contains_profanity(test):
#        print("gg")
# #    for key, values in records.items(): 
# #        print(f"{key}: {values}")
# #        for record in values: 
# #            print(record)


def dbconnect () -> None: 
    return connect(
        host = '127.0.0.1',
        user = 'root',
        password = 'admin',
        database = 'sitin_db'
    )

def post_process(sql: str) -> bool: 
    db = dbconnect()
    cursor = db.cursor()

    cursor.execute(sql)
    db.commit()
    success = cursor.rowcount >= 0
    cursor.close()
    db.close()
    return success


def get_process(sql: str) -> list:
    db = dbconnect()

    cursor = db.cursor()
    cursor.execute(sql)
    data:list = list(cursor.fetchall())
    return data


def insert_student(**kwargs) -> bool:
   values = list(kwargs.items())
   formatted_values = [
        f"'{v}'" if k != "year" else str(v)  # Only exclude quotes for 'year'
        for k, v in values
    ]
   data = ",".join(formatted_values)
   sql = f"CALL add_student({data})"  
   print(sql)
   return post_process(sql)

def get_student(username: str) -> list:
    sql = f"CALL student_account('{username}')"
    records = get_process(sql)  # Fetch results

    if not records:  # Check if the list is empty
        return []  # Return empty list instead of causing an error

    return list(records[0])

def update_user (**kwargs):
  values = kwargs.items()
  formatted_values = ["NULL" if v is None else (f"'{v}'" if not isinstance(v, int) else str(v))
    for k, v in values
    ]
  data = ",".join(formatted_values)
  sql = f"CALL update_user({data})"
  success = post_process(sql)
  if not success : 
      return False
  return success

def search_active_student(id:str):
    sql = f"CALL search_student('{id}')"
    print(sql)
    records = get_process(sql) 
    if not records: 
        return []
    return list(records[0])

def search_student_info(idno:str): 
    sql = f"SELECT * FROM full_student_information WHERE idno = '{idno}'"
    records = get_process(sql)
    return list(records[0])

def list_current_sitin(): 
    sql = "CALL current_sitin()"
    records = get_process(sql) 
    list_of_sitin = list_to_dict(records)
    return list_of_sitin

def sitin_student(**kwargs):
    values = list(kwargs.values())
    format = ", ".join(f"'{x}'" if isinstance(x,str) else str(x) for x in values) 
    sql = f"CALL sitin({format})"
    data = post_process(sql)
    return data

def logout_student(idno: str): 
    sql = f"CALL end_session('{idno}', NOW())"
    return post_process(sql)

def post_announcement(admin_id,content:str): 
    sql = f"CALL create_announcement('{admin_id}', '{content}') "
    print(sql)
    sucess = post_process(sql)
    if sucess:
        return sucess
    else:
        return sucess

def get_all_data(table:str): 
    sql = f"SELECT * FROM {table} ORDER BY 1 DESC"
    test = get_process(sql)
    results = list_to_dict(test)
    return results

def get_history(idno): 
    sql = f"SELECT * FROM logout_records WHERE student_id = {idno} ORDER BY 6 DESC"
    announcements = get_process(sql)
    results = list_to_dict(announcements)
    return results

def list_purposes(): 
    sql = "SELECT * FROM purpose ORDER BY 1"
    data = get_process(sql)
    purposes = dict(data)
    return purposes

def list_labs(): 
    sql = "SELECT * FROM labs"
    data = get_process(sql)
    labs = [row[0] for row in data]
    return labs

def list_to_dict(datas:list) -> dict: 
    list_of_logouts:dict = {}
    if not datas: 
        return {}
    else:
        for i in range (len(datas)):
            list_of_logouts[i+1] = datas[i] 
        return list_of_logouts
    
def delete_student_by_id(id:str):
    sql = f"DELETE FROM users WHERE user_id = '{id}'"
    return post_process(sql)

def reset_all_sessions():
    sql = "UPDATE students set student_session = 30"
    return post_process(sql)

def create_feedback(idno:int,  feedback:str, has_profanity:bool): 
    sql = f"CALL create_feedback({idno},'{feedback}', {has_profanity})"

    print(has_profanity)
    success = post_process(sql)
    if success: 
        print("Nakasud")
    else :
        print("wala kasulod")
    return success

def profile_viewing(idno:str):
    sql = f"SELECT * FROM profile_view WHERE user_id = {idno}"
    data =  list(get_process(sql)[0])
    print(data)
    if not data: 
        print("wala naka kuha")
    return data
def get_announcements(): 
    sql = "SELECT message FROM notifications WHERE status = 'unread' ORDER BY created_at DESC; "
    notifications = get_process(sql)
    result = list_to_dict(notifications)
    if not result:
        return []
    return result

def clear_notification(status: str):
    sql = f"UPDATE notifications SET status = '{status}'"
    success = post_process(sql)
    if success: 
        return success
    return success

if __name__ == "__main__":
    get_announcements()