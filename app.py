from flask import Flask, render_template, url_for,request,redirect
from dbhelper import add_student_record, get_student_account

app = Flask(__name__)

@app.route("/")
def login_template() -> None: 
      return render_template("login.html")

@app.route("/registration_template")
def registration_template() -> None: 
     return render_template("register.html")

@app.route("/dashboard_template")
def dashboard_template() -> None: 
     return render_template("dashboard.html")

@app.route("/login", methods=['POST'])
def login() -> None: 
     username = request.form['username']
     password = request.form['password']
     if len(get_student_account(username,password)) > 0: 
          return redirect(url_for("dashboard_template"))
     else: 
          return redirect(url_for("login_template"))

# get_student info from client 
@app.route("/student_info", methods=['POST'])
def student_info() -> None: 
     student_data = {
          "student_id" : request.form['student_id'],
          "last_name" : request.form['last_name'],
          "first_name" : request.form['first_name'],
          "middle_name" : request.form['middle_name'],
          "course" : request.form['course'],
          "year_level" : request.form['year_level'],
          "username" : request.form['username'],
          "password" : request.form['password']
     }
     add_student_record(**student_data)
     return redirect(url_for("login_template"))

if __name__ == "__main__": 
    app.run(debug=True)