from flask import Flask, render_template,request,redirect,url_for,session,make_response
import os
from werkzeug.utils import secure_filename
from dbhelper import add_student, student_account


app = Flask(__name__)
app.secret_key = "asdf"

UPLOAD_FOLDER = 'static/uploads'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

os.makedirs(UPLOAD_FOLDER, exist_ok=True)  # Ensure folder exists

ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif'}

def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS


@app.route('/')
def login_template():
    if not session: 
        return render_template("login.html")
    else: 
         return redirect(url_for('dashboard'))


@app.route('/login', methods=['POST','GET'])
def login () -> None:
    if not session: 
        return render_template('login.html')
    response = make_response(redirect(url_for('dashboard')))
    return prevent_cache(response)
     
@app.route('/privacy', methods=['POST','GET'])
def privacy():
    account = {
        "username": request.form.get('username'),
        "password": request.form.get('password')
    }
    record = student_account(**account)
    if len(record) > 0:
        session["record"] = record
        return redirect(url_for('dashboard'))  
    else: 
        return render_template('login.html')
@app.route('/logout')
def logout(): 
    session.clear()
    response = redirect(url_for("login_template"))
    response.headers["Cache-Control"] = "no-store, no-cache, must-revalidate, max-age=0"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "0"
    response.headers["X-UA-Compatible"] = "IE=Edge,chrome=1"     
    response.headers["Cache-Control"] = "public, max-age=0"   
    return redirect(url_for(('login_template')))

@app.route('/dashboard')
def dashboard(): 
    if "record" in session: 
        record = session["record"]
        name = record[2]
        return render_template("dashboard.html", name = name)
    else: 
        return redirect(url_for("login"))

@app.route('/editprofile')
def edit_profile_template():
    if "record" not in session:
        return render_template('login.html')

    record = session["record"]  # Get the existing record
    return render_template('edit-profile.html', record=record)

@app.route("/update_profile", methods=["POST"])
def edit_profile():
    profile_image_path = None  # Default if no new image is uploaded

    if "profile_image" in request.files:
        file = request.files["profile_image"]
        if file and file.filename:
            filename = secure_filename(file.filename)
            filepath = os.path.join(app.config["UPLOAD_FOLDER"], filename)
            file.save(filepath)
            profile_image_path = f"/{filepath}"  # File path to store in DB

    # Retrieve other input fields
    first_name = request.form.get("first_name")
    last_name = request.form.get("last_name")
    middle_name = request.form.get("middle_name")
    email = request.form.get("email")
    username = request.form.get("username")
    password = request.form.get("password")

    # Mock Database Update (Replace with actual DB operation)
    user_data = {
        "first_name": first_name,
        "last_name": last_name,
        "middle_name": middle_name,
        "email": email,
        "username": username,
        "password": password,
        "profile_image": profile_image_path  # Save image path
    }
    filtered_data = {k: v for k, v in user_data.items() if v}


    print("Updated User Data:", user_data)  # Debugging
    print("Para backend: ", filtered_data)  # Debugging

    return redirect(url_for("edit_profile_template")) # Redirect back to profile page

@app.route('/register', methods=['POST'])
def save_student():
    student_record = {
        "student_id": request.form['r-idno'],
        "first_name": request.form['r-firstname'],
        "last_name": request.form['r-lastname'],
        "middle_name": request.form['r-middlename'],
        "email": request.form['r-email'],
        "course": request.form['r-course'],
        "year_level": request.form['r-year'],  # Match database column name
        "username": request.form['r-username'],

        "password": request.form['r-password']  # Consider hashing passwords!
    }

    if add_student(**student_record):
        print("Student successfully registered:", student_record)
        return redirect(url_for("login_template"))
    else:
        print("Error registering student")
        return "Error saving student", 500

def prevent_cache(response):
    response.headers["Cache-Control"] = "no-cache, no-store, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "0"
    
    return response
if __name__ == "__main__":
    app.run(debug=True)