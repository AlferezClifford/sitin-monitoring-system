import bcrypt 
from better_profanity import profanity
from flask import Flask, render_template,request,redirect,url_for,session,make_response,jsonify,flash
import os
from werkzeug.utils import secure_filename
from dbhelper import (
                    insert_student, get_student, update_user, search_active_student, list_labs,list_purposes,sitin_student, 
                    list_current_sitin,logout_student,post_announcement, get_all_data,delete_student_by_id,search_student_info,
                    reset_all_sessions,get_history,create_feedback,profile_viewing, get_announcements, clear_notification
                    )
import json
from fuzzywuzzy import fuzz

app = Flask(__name__)
app.secret_key = "asdf"

UPLOAD_FOLDER = 'static/uploads'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

os.makedirs(UPLOAD_FOLDER, exist_ok=True)  # Ensure folder exists

ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif'}
BISAYA_PROFANITIES = {"yawa", "pisti", "gago", "ulol", "buang", "atay", "bogo", "shet","bushet","bushit"}
TAGALOG_PROFANITIES = {"putangina", "tangina", "gago", "bobo", "tanga", "punyeta", "ulol"}

ALL_PROFANITIES = BISAYA_PROFANITIES.union(TAGALOG_PROFANITIES)
profanity.add_censor_words(list(ALL_PROFANITIES))

# Function for fuzzy matching with a threshold
def is_similar_to_profanity(word):
    threshold = 80  # similarity threshold
    for profane_word in ALL_PROFANITIES:
        if fuzz.ratio(word.lower(), profane_word.lower()) > threshold:
            return True
    return False

def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

@app.route('/')
def login_template():
    if "record" in session:  
        return redirect(url_for('dashboard'))  # Redirect if logged in
    return render_template("login.html")


@app.route('/login')
def login () -> None:
    if not session: 
        return render_template('login.html')
    response = make_response(redirect(url_for('dashboard')))
    return prevent_cache(response)


@app.route('/privacy', methods=['POST', 'GET'])
def privacy():
    username = request.form.get('username')
    password = request.form.get('password')
    account = get_student(username)
    print(account)
    if not account: 
        flash("Invalid username or password", "danger")
        return redirect(url_for('login_template'))
    role = ""
    for value in account: 
        if value in ['Admin','Student']:
            role = value 
            break
    print(role)
    if role == 'Admin': 
        mpassword = account[3]
        if password == mpassword: 
            session["record"] = account
            return redirect(url_for('dashboard'))
        else :
            flash("Invalid username or password", "danger")
            return redirect(url_for('login_template'))
    elif role == 'Student': 
       
        if bcrypt.checkpw(password.encode('utf-8'), account[2].encode('utf-8')):
            print('True')
            session["record"] = account
            return redirect(url_for('dashboard'))
        else:
            flash("Invalid username or password", "danger")
            return redirect(url_for('login_template'))

# @app.route('/admin')
# def admin_template():
#     if "record" in session: 
#         record = session["record"]
#         return render_template("admin-dashboard.html",record=record)
#     return redirect(url_for('login'))
    
@app.route('/logout')
def logout(): 
    
    session.clear()
    response = redirect(url_for("login_template"))
    response.headers["Cache-Control"] = "no-store, no-cache, must-revalidate, max-age=0"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "0"
    response.headers["X-UA-Compatible"] = "IE=Edge,chrome=1"     
    response.headers["Cache-Control"] = "public, max-age=0"   
    return response


@app.route('/dashboard')
def dashboard(): 
    
    if "record" in session: 
        record = session["record"]
        role = ""
        print(record)
        for value in record: 
            if value in ['Admin', 'Student']: 
                role = value
                break
        if role == 'Admin': 
            return redirect(url_for('announcement_template'))
        else: 
            announcement = get_all_data('display_announcements')
            return render_template('dashboard.html', record = record, announcement = announcement)
    return redirect(url_for('login_template'))



@app.route('/editprofile')
def edit_profile_template():
    hasSession = check_session()
    if hasSession:
        # user = session["record"]
        idno = session["record"][0]
        record = profile_viewing(idno)
        print(record)
        return render_template('edit-profile.html',record=record)
    return redirect(url_for('login'))

@app.route("/update_profile", methods=["POST"])
def update():
    idno = session["record"][0]

    # Retrieve input fields
    first_name = request.form.get("first_name")
    last_name = request.form.get("last_name")
    middle_name = request.form.get("middle_name")
    email = request.form.get("email")
    username = request.form.get("username")
    password = request.form.get("password")

    # Handle "null" values by setting them to None
    user_data = {
        "idno": idno,
        "first_name": first_name if first_name != "null" else None,
        "last_name": last_name if last_name != "null" else None,
        "middle_name": middle_name if middle_name != "null" else None,
        "email": email if email != "null" else None,
        "username": username if username != "null" else None,
        "password": bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt()).decode('utf-8') if password and password != "null" else None,
        "profile_image": ""
    }

    # Handle profile image upload
    if "profile_image" in request.files:
        file = request.files["profile_image"]
        if file and file.filename and allowed_file(file.filename):
            filename = secure_filename(file.filename)
            filepath = os.path.join(app.config["UPLOAD_FOLDER"], filename)
            file.save(filepath)
            user_data["profile_image"] = f"static/uploads/{filename}"  # Fix path issue

    print(user_data)  # Debugging: Check sent data
    
    if update_user(**user_data): 
        flash("Profile updated successfully!", "success")
        return jsonify({"success": True})
    return jsonify({"success": False})



@app.route('/register', methods=['POST'])
def save_student():
    try:
        # Get and validate password
        password = request.form.get('r-password', '').encode('utf-8')
        if not password.strip():
            return "Error: Password cannot be empty", 400

        # Hash password
        hashed_password = bcrypt.hashpw(password, bcrypt.gensalt()).decode('utf-8')

        # Validate and convert year
        try:
            year = int(request.form['r-year'])
        except ValueError:
            return "Error: Year must be a number", 400

        # Create student record
        student_record = {
            "student_id": request.form['r-idno'],
            "first_name": request.form['r-firstname'],
            "last_name": request.form['r-lastname'],
            "middle_name": request.form['r-middlename'],
            "email": request.form['r-email'],
            "course": request.form['r-course'],
            "year": year,  # Already validated
            "username": request.form['r-username'],
            "password": hashed_password  # Now safely stored
        }

        print(json.dumps(student_record, indent=4))  # Debugging
        success = insert_student(**student_record)
        print(success)
        if success:
            return redirect(url_for("login_template"))

        else:
            print("❌ Error registering student")
            return "Error saving student", 500


    except Exception as e:
        print(f"🚨 Error: {e}")
        return "Internal Server Error", 500

@app.route('/history_table')
def history_table_temp():
    hasSession = check_session()
    if hasSession:

        idno = session["record"][0] if "record" in session else []
        student = get_history(idno)
        return render_template('history.html' ,student = student)
    return redirect(url_for('login'))

@app.route('/history/create-feedback', methods=['POST'])
def post_feedback():
    idno = int(request.form['idno'])
    print(idno)
    feedbackText = request.form['feedbackText']
    if profanity.contains_profanity(feedbackText) or is_similar_to_profanity(feedbackText):
        create_feedback(idno, feedbackText, True)
        return redirect(url_for('history_table_temp'))
    else:
        create_feedback(idno, feedbackText, False)
    return redirect(url_for('history_table_temp'))

    
@app.route('/Feedbacks')
def feedback_template(): 
    hasSession = check_session()
    if hasSession:
        student = get_all_data('display_feedabacks')
        
        return render_template('feedback.html',student = student)
    return redirect(url_for('logout'))

@app.route('/sitin')
def sitin_template(): 
    hasSession = check_session()
    if hasSession:
        return render_template('sitin.html', **get_sitin_context())
    return redirect(url_for('login'))

@app.route('/sitin/search', methods=['GET'])
def search_student():
   idno = request.args.get('idno')
   student = search_active_student(idno) or []
   if not student:
    flash("No user found", "danger")  
    return redirect(url_for('sitin_template'))
   return render_template('sitin.html', **get_sitin_context(student))


@app.route('/sitin/submit', methods=['POST'])
def submit_sitin():  
    log_student = {
        "s_idno" : request.form['idno'],
        "a_idno" : session["record"][0] if "record" in session else [],
        "purpose" : int(request.form["purpose"]),
        "labs" : int(request.form["laboratory"])
    }
    for value in log_student.values():
        if value == "":
            flash("Please input a valid field", "danger")
            return redirect(url_for('sitin_template/s'))
        
    success = sitin_student(**log_student)
    if not success: 
        return "Wala na sucess"
    return redirect(url_for('sitin_template'))

@app.route('/sitin/end-session', methods=['POST'])
def end_session(): 
    value = request.form['idno'] # our key should be int
    print(value)
    if not value: 
        return "wala nakuha"
    print(value)
    logout_student(value) # Get the sitin module and [idno] -> key [0] value
    flash("Session ended.", "success")
    return redirect(url_for('sitin_template')) 

@app.route('/sitin/records')
def sitin_records_template():
    hasSession = check_session()
    if hasSession:

        context = get_sitin_context()
        records = context["history"]
        return render_template('sitin_history.html', records = records)
    return redirect(url_for('login'))

@app.route('/sitin/daily-record')
def sitin_daily_reports():
    hasSession = check_session()
    if hasSession:  
        context = get_sitin_context()
        records = context["daily-history"]
        return render_template('daily-sitin.html', records = records)
    return redirect(url_for('login'))

# This is the module in sitin page
def get_sitin_context(student=None): 
   return {
        "labs": list_labs(),
        "purpose": list_purposes(),
        "student": student or [],
        "sitin": list_current_sitin(),
        "history": get_all_data('sitin_reports'), 
        "daily-history": get_all_data('daily_report')
    }
    
@app.route('/announcement')
def announcement_template():
    hasSession = check_session()
    if hasSession:
        announcements = get_all_data('display_announcements')
        notifications = get_announcements()
        return render_template('announcement.html', announcements = announcements, notifications = notifications )
    return redirect(url_for('logout'))
@app.route('/announcement/create-announcement', methods = ['POST'])
def create_announcement():
    admin_id = session["record"][0]
    content = request.form['announcement']
    if not content: 
        return "Dili ka sulod"
    
    post_announcement(admin_id, content)
    return redirect(url_for('announcement_template'))

@app.route('/clear-notification', methods=['POST'])
def clear_notifications():
    hasSession = check_session()
    if hasSession:
        clear_notification('read')
        return jsonify({"status": "success"})
    return jsonify({"status": "error"})

@app.route('/list-of-students')
def students_record_template(): 
    hasSession = check_session()
    if hasSession: 
        students = get_all_data('student_information')
        return render_template('student-record.html', students = students)
    return redirect(url_for('login'))

@app.route('/list-of-studentsts/deleted', methods = ['POST'])
def delete_student(): 
    idno = request.form['idno']
    print(idno)
    delete_student_by_id(idno)
    return redirect(url_for('students_record_template'))
    
@app.route('/list-of-studentsts/searched_by_id', methods = ['GET'])
def search_record(): 
    idno = request.args.get('idno')
    student = search_student_info(idno)
    print(student)
    if not student: 
        return "Wala"
    return jsonify({
        "idno": student[0],
        "first_name": student[1],
        "middle_name": student[2],
        "last_name": student[3],
        "email": student[4],
        "course": student[5],
        "year": student[6],
        "remaining_session": student[7],
        "user_name": student[8]
    })

@app.route('/list-of-studentsts/update_student', methods=['POST'])
def update_student(): 
    record = {
        "idno": request.form['idno'],
        "first_name": request.form['first_name'],
        "middle_name": request.form['middle_name'],
        "last_name":request.form['last_name'],
        "email": request.form['email'],
        "course":request.form.get('course',None),
        "year":  int(request.form['year']) if request.form.get('year') else None,
        "remaining_session": int(request.form['remaining_session']) if request.form.get('remaining_session') else None,
        "user_name": request.form['user_name'],
        "password": None,
        "profile_pic": None
    }
    update_user(**record)
    return redirect(url_for('students_record_template'))

@app.route('/list-of-studentsts/reset_sessions')
def reset_sessions():
    reset_all_sessions()
    return students_record_template()



 # Pass as query parameter
def prevent_cache(response):
    response.headers["Cache-Control"] = "no-cache, no-store, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "0"
    return response

def check_role(record: list) -> str: 
    result = ""
    for data in record: 
        if data == 'Admin' or 'Student':
            result = data
    return result

def check_session(): 
    if "record" in session: 
        return True
    return False
if __name__ == "__main__":
    app.run(debug=True)

