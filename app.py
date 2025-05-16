import bcrypt 
from better_profanity import profanity
from flask import Flask, render_template,request,redirect,url_for,session,make_response,jsonify,flash
import os
from werkzeug.utils import secure_filename
from dbhelper import (
                    insert_student, get_student, update_user, search_active_student, list_labs,list_purposes,sitin_student, 
                    list_current_sitin,logout_student,post_announcement, get_all_data,get_leaderboard,resset_session_per_student,search_student_info,
                    reset_all_sessions,get_history,create_feedback,profile_viewing, get_announcements, clear_notification, insert_resources,delete_some_resources,truncate_table,
                    display_pc,post_pc_status,display_student_records,display_available_pc,insert_reservation,display_reservation,display_reservation_request,
                    approve_reservation_request,display_reservation_logs,student_notification_list
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
        idno = record[0]
        role = ""
        for value in record: 
            if value in ['Admin', 'Student']: 
                role = value
                break
        if role == 'Admin': 
            return redirect(url_for('announcement_template'))
        else: 
            notifications = student_notification_list(idno)
            announcement = get_all_data('display_announcements')
            return render_template('dashboard.html', record = record, announcement = announcement, notifications=notifications)
    return redirect(url_for('login_template'))



@app.route('/editprofile')
def edit_profile_template():
    hasSession = check_session()
    if hasSession:
        # user = session["record"]
        idno = session["record"][0]
        record = profile_viewing(idno)
        print(record)
        notifications = student_notification_list(idno)
        return render_template('edit-profile.html',record=record, notifications=notifications)
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
        notifications = student_notification_list(idno)
        return render_template('history.html' ,student = student, notifications=notifications)
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
        notifications = get_announcements()
        student = get_all_data('display_feedabacks')
        
        return render_template('feedback.html',student = student, notifications=notifications)
    return redirect(url_for('logout'))

@app.route('/sitin')
def sitin_template(): 
    hasSession = check_session()
    if hasSession:
        notifications = get_announcements()
        return render_template('sitin.html', **get_sitin_context(), notifications=notifications)
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
    point = request.form['add_point'] # our key should be int
    print(value)
    print(point)
    if not value: 
        return "wala nakuha"
    print(value)
    logout_student(value,point) # Get the sitin module and [idno] -> key [0] value
    flash("Session ended.", "success")
    return redirect(url_for('sitin_template')) 

@app.route('/sitin/records')
def sitin_records_template():
    hasSession = check_session()
    if hasSession:

        context = get_sitin_context()
        records = context["history"]
        notifications = get_announcements()
        return render_template('sitin_history.html', records = records, notifications=notifications)
    return redirect(url_for('login'))

@app.route('/sitin/daily-record')
def sitin_daily_reports():
    hasSession = check_session()
    if hasSession:  
        context = get_sitin_context()
        records = context["daily-history"]
        notifications = get_announcements()
        return render_template('daily-sitin.html', records = records, notifications=notifications)
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
        notifications = get_announcements()
        students = get_all_data('student_information')
        return render_template('student-record.html', students = students, notifications=notifications)
    return redirect(url_for('login'))

@app.route('/list-of-studentsts/reset-sessions', methods = ['POST'])
def reset_per_student(): 
    idno = request.form['idno']
    print(idno)
    resset_session_per_student(idno)
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


@app.route('/resource-uploader')
def resource_template(): 
    hasSession = check_session()
    if hasSession:
        notifications = get_announcements()
        data = get_all_data('resources')
        link_dict = {}
        file_dict = {}

        print (data)
        for key, value in data.items():
            # Unpack tuple: (_, title, description, file_path_or_link, type_)
            idno, title, description, file_path_or_link, type_ = value
            
            if type_ == "Link":
                link_dict[key] = (idno,title, description, file_path_or_link)
            elif type_ == "File":
                # Convert filename to URL path
                filename = os.path.basename(file_path_or_link)
                url_path = f'/static/upload_files/{filename}'
                file_dict[key] = (idno,title, description, url_path)
                
        return render_template('resource_uploader.html', file_dict = file_dict, link_dict = link_dict, notifications=notifications)
    return redirect(url_for('login'))

@app.route('/delete_resource/<int:idno>', methods=['POST'])
def handle_resource_deletion(idno):
    if not check_session():
        return jsonify({'success': False, 'message': 'Unauthorized'}), 401
    
    try:
        # Call your existing database helper function
        success = delete_some_resources(idno)
        
        if success:
            return jsonify({'success': True, 'message': 'Resource deleted successfully'})
        else:
            return jsonify({'success': False, 'message': 'Failed to delete resource'}), 400
            
    except Exception as e:
        print(f"Error deleting resource {idno}: {str(e)}")
        return jsonify({'success': False, 'message': str(e)}), 500

@app.route('/lab_resources')
def lab_resources_template():

    hasSession = check_session()
    if hasSession:
        idno = session["record"][0]
        notifications = student_notification_list(idno)
        data = get_all_data('resources')
        link_dict = {}
        file_dict = {}

        print (data)
        for key, value in data.items():
            # Unpack tuple: (_, title, description, file_path_or_link, type_)
            _, title, description, file_path_or_link, type_ = value
            
            if type_ == "Link":
                link_dict[key] = ( title, description, file_path_or_link)
            elif type_ == "File":
                # Convert filename to URL path
                filename = os.path.basename(file_path_or_link)
                url_path = f'/static/upload_files/{filename}'
                file_dict[key] = (title, description, url_path)
                
        return render_template('resource_viewer.html', file_dict=file_dict, link_dict=link_dict, notifications=notifications)
    return redirect(url_for('login'))



@app.route('/lab-schedule')
def lab_schedule_template(): 
    hasSession = check_session()
    if hasSession: 
        idno = session["record"][0]
        notifications = student_notification_list(idno)
        return render_template('lab_schedule.html', notifications=notifications)
    return redirect(url_for('login'))

@app.route('/leaderboard')
def leaderboard_template(): 
    hasSession = check_session()
    if hasSession: 
        idno = session["record"][0]
        leaderboard = get_leaderboard()
        print(leaderboard)
        return render_template('leaderboard.html', leaderboard = leaderboard, idno = idno)
    return redirect(url_for('login'))

@app.route('/leaderboard_admin')
def leaderboard_admin_template(): 
    hasSession = check_session()
    if hasSession: 
        idno = session["record"][0]
        leaderboard = get_leaderboard()
        notifications = get_announcements()
        print(leaderboard)
        return render_template('leaderboard_admin.html', leaderboard = leaderboard, idno = idno, notifications=notifications)
    return redirect(url_for('login'))

UPLOAD_FOLDER_2 = os.path.join('static', 'upload_files')
os.makedirs(UPLOAD_FOLDER_2, exist_ok=True)


def is_upload_folder_empty():
    # Returns True if UPLOAD_FOLDER_2 is empty (no files), False otherwise
    return not any(os.scandir(UPLOAD_FOLDER_2))

@app.route('/save_upload', methods=['POST'])
def submit_upload():
    response_data = {
        'status': 'success',
        'message': '',
        'saved_files': [],
        'existing_files': [],
        'links': []
    }
    
    file_dictionary = {}
    link_dictionary = {}
    
    try:
        # Check if upload folder is empty before processing
        if is_upload_folder_empty():
            truncate_table()  # Call your truncate function here
        
        if 'files' in request.files:
            uploaded_files = request.files.getlist('files')
            file_titles = request.form.getlist('file_titles')
            file_descriptions = request.form.getlist('file_descriptions')
            
            if uploaded_files and any(f.filename != '' for f in uploaded_files):
                print("\nReceived Files:")
                for i, file in enumerate(uploaded_files):
                    if file.filename == '':
                        continue
                    
                    filename = secure_filename(file.filename)
                    current_file_path = os.path.join(UPLOAD_FOLDER_2, filename)
                    current_title = file_titles[i] if i < len(file_titles) else filename
                    current_description = file_descriptions[i] if i < len(file_descriptions) else ''
                    
                    if not file_dictionary:
                        file_dictionary = {
                            'file_title': current_title,
                            'description': current_description,
                            'file_path': filename,
                            'type': 'File'
                        }
                    
                    print("File:")
                    print(f"Title: {current_title}")
                    print(f"Description: {current_description}")
                    print(f"Path: {current_file_path}\n")
                    
                    if os.path.exists(current_file_path):
                        response_data['existing_files'].append({
                            'filename': filename,
                            'message': f'File already exists: {filename}'
                        })
                        continue
                    
                    file.save(current_file_path)
                    response_data['saved_files'].append({
                        'title': current_title,
                        'description': current_description,
                        'filename': filename,
                        'path': f'/static/upload_files/{filename}'
                    })

        # ... rest of your existing code for links and response handling ...
          # Process links
        if 'links' in request.form:
            try:
                links = json.loads(request.form.get('links', '[]'))
                
                if links:  # Only process if links array is not empty
                    print("\nReceived Links:")
                    for i, link in enumerate(links):
                        # Only store the first link
                        if not link_dictionary:
                            link_dictionary = {
                                'link_title': link.get('title', 'Untitled Link'),
                                'description': link.get('description', ''),
                                'link': link.get('path', ''),
                                'type': 'Link'
                            }
                        
                        # Print link information
                        print("Link:")
                        print(f"Title: {link.get('title', 'Untitled Link')}")
                        print(f"Description: {link.get('description', '')}")
                        print(f"Path: {link.get('path', '')}\n")
                    
                    response_data['links'] = [{
                        'path': link.get('path', ''),
                        'title': link.get('title', 'Untitled Link'),
                        'description': link.get('description', '')
                    } for link in links]
                    
            except json.JSONDecodeError as e:
                print(f"Error parsing links JSON: {str(e)}")
                response_data['links'] = []
        if file_dictionary:
            insert_resources(**file_dictionary)
        
        if link_dictionary:
            insert_resources(**link_dictionary)
        
        if response_data['existing_files']:
            if response_data['saved_files']:
                response_data['message'] = 'Some files were uploaded, but some already existed'
            else:
                response_data['message'] = 'All files already exist'
                response_data['status'] = 'warning'
        else:
            response_data['message'] = 'Files and links uploaded successfully'

        return jsonify(response_data), 200

    except Exception as e:
        print(f"Error during upload: {str(e)}")
        return jsonify({
            'status': 'error',
            'message': str(e)
        }), 500

@app.route('/pc_monitor')
def pc_monitor_template(): 
    hasSession = check_session()
    if hasSession: 
        data = display_pc()  # List of (pc_id, lab_id, status)
        grouped = {}
        for pc_id, lab_id, status in data:
            grouped.setdefault(lab_id, []).append((pc_id, status))
        lab_ids = sorted(grouped.keys())
        return render_template('pc-monitoring.html', grouped=grouped, lab_ids=lab_ids)
    return redirect(url_for('login'))

@app.route('/update_pc_status', methods=['POST'])
def update_pc_status():
    data = request.get_json()
    if isinstance(data, dict):
        # Grouped update (from set all)
        lab_id = data.get('lab_id')
        pc_ids = data.get('pc_ids')
        status = data.get('status')
        if pc_ids:
            pc_ids_str = ",".join(str(pc_id) for pc_id in pc_ids)
        print(post_pc_status(lab_id, pc_ids_str, status))
    elif isinstance(data, list):
        # Single or multiple individual updates
        print("Individual update(s):")
        for item in data:
            lab_id = item.get('lab_id')
            pc_id = item.get('pc_id')
            status = item.get('status')
            print(post_pc_status(lab_id, pc_id, status))
    else:
        print("Unknown data format:", data)
    return jsonify({'status': 'success'})

@app.route('/reservation')
def reservation_template(): 
    hasSession = check_session()
    record = session["record"]  
    if hasSession: 
        try:
            
            idno = record[0]
            # print(f"Session ID: {idno}")
            
            student_record = display_student_records(idno) or []
            # print(f"Student Record: {student_record}")

            notifications = student_notification_list(idno)
            print(f"Notification: {notifications}")
            
            lab_data = display_available_pc() or []
            # print(f"Lab Data: {lab_data}")
            
            purpose = list_purposes() or {}
            # print(f"Purposes: {purpose}")
            
            grouped = {}
            # Process lab data
            for pc_id, lab_id, status in lab_data:
                if lab_id is not None:
                    grouped.setdefault(lab_id, []).append((pc_id, status))
            # print(f"Grouped Data: {grouped}")
            
            lab_ids = sorted(grouped.keys())
            # print(f"Lab IDs: {lab_ids}")
            
            reservations = display_reservation(idno) or []
            # print(f"Reservations: {reservations}")
            
            return render_template('reservation.html', 
                student_record=student_record,
                purpose=purpose,
                lab_ids=lab_ids,
                grouped=grouped,
                reservations=reservations,
                notifications=notifications
            )
            
        except Exception as e:
            print(f"Error in reservation_template: {str(e)}")
            return render_template('reservation.html', 
                student_record=[],
                purpose={},
                lab_ids=[],
                grouped={},
                reservations=[],
                notifications=[]
            )
    return redirect(url_for('login'))

@app.route('/reservation/submit', methods=['POST'])
def submit_reservation(): 
    try:
        data = request.get_json()
        
        # Create reservation data dictionary
        reservation_data = {
            'student_id': data.get('idNo'),        # Student ID from request
            'purpose_id': int(data.get('purpose')), # Convert to int
            'lab_id': int(data.get('laboratory')),  # Convert to int
            'pc_id': int(data.get('selectedPC')),   # Convert to int
            'res_date': data.get('date'),           # Date from request
            'res_time': data.get('time')            # Time from request
        }
        
        # Validate required fields
        for key, value in reservation_data.items():
            if value is None:
                return jsonify({
                    'status': 'error',
                    'message': f'Missing required field: {key}'
                }), 400
        
        # Here you would typically call your database function
        insert_reservation(**reservation_data)
        
        return jsonify({
            'status': 'success',
            'message': 'Reservation submitted successfully',
            'data': reservation_data
        })
        
    except ValueError as e:
        return jsonify({
            'status': 'error',
            'message': 'Invalid data format. Please check your input values.'
        }), 400
    except Exception as e:
        return jsonify({
            'status': 'error',
            'message': str(e)
        }), 500

@app.route('/reservation_request')
def reservation_request_template(): 
    hasSession = check_session()
    if hasSession: 
        reservation_request = display_reservation_request()
        print(f"Reservation Request: {reservation_request}")
        notifications = get_announcements()
        return render_template('reservation_request.html', reservation_request=reservation_request, notifications=notifications)
    return redirect(url_for('login'))

@app.route('/approve_reservation', methods=['POST'])
def approve_reservation():
    try:
        # Check if content type is correct
        content_type = request.headers.get('Content-Type')
        if content_type != 'application/json':
            return jsonify({
                'status': 'error',
                'message': 'Content-Type must be application/json'
            }), 415
        
        # Parse JSON data
        data = request.get_json()
        
        # Extract and validate required fields
        reservation_id = int(data.get('reservation_id'))
        print(f"Reservation ID: {reservation_id}")
        status = data.get('status')
        print(f"Status: {status}")
        
        # Here you would add the code to update the database
        # For example: success = update_reservation_status(reservation_id, status)
        approve_reservation_request(reservation_id, status)
        # Return success response
        return jsonify({
            'status': 'success',
            'message': f'Reservation {status} successfully'
        })
        
    except Exception as e:
        print(f"Error in approve_reservation: {str(e)}")
        return jsonify({
            'status': 'error',
            'message': 'An unexpected error occurred'
        }), 500
    
@app.route('/reservation_logs')
def reservation_logs_template():
    reservation_logs = display_reservation_logs()
    notifications = get_announcements()
    return render_template('reservation_logs.html', reservation_logs=reservation_logs, notifications=notifications)



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
