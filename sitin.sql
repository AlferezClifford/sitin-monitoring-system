CREATE DATABASE sitin_db;
use sitin_db;

CREATE TABLE users (
	user_id VARCHAR (50) PRIMARY KEY NOT NULL,
	first_name VARCHAR (50) NOT NULL, 
    middle_name VARCHAR (50) NOT NULL, 
    last_name VARCHAR (50) NOT NULL, 
    email VARCHAR (50) NOT NULL, 
    type_of_user ENUM ('Student', 'Admin') DEFAULT 'Student',
	profile_picture VARCHAR (100),
    registered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE users
MODIFY type_of_user ENUM ('Student', 'Admin') DEFAULT 'Student';

CREATE TABLE students (
	idno VARCHAR (50) PRIMARY KEY NOT NULL,
    COURSE ENUM ('BSIT', 'BSCPE', 'BSCS', 'BSHM', 'BSBA', 'BSCRIM') NOT NULL, 
    year INT NOT NULL,
    student_session INT NOT NULL DEFAULT 30,
    FOREIGN KEY (idno) REFERENCES users(user_id) ON DELETE CASCADE
);

ALTER TABLE STUDENTS 
MODIFY student_session INT NOT NULL DEFAULT 30;

CREATE TABLE sessions (
	session_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id VARCHAR (50) NOT NULL, 
    sitin_by VARCHAR (50) NOT NULL,
    time_in DATETIME NOT NULL, 
    time_out DATETIME,
    isActive BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (student_id) REFERENCES students (idno) ON DELETE CASCADE,
    FOREIGN KEY (sitin_by) REFERENCES admin (admin_id) ON DELETE CASCADE
);

CREATE TABLE admin (
	admin_id VARCHAR (50) PRIMARY KEY NOT NULL
);


CREATE TABLE accounts (
	user_id VARCHAR (50) PRIMARY KEY NOT NULL, 
    user_name VARCHAR (50) NOT NULL, 
    user_password VARCHAR (255) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE
);

CREATE TABLE announcements (
	announcement_id VARCHAR (50) NOT NULL, 
    created_by VARCHAR (50) NOT NULL, 
    title VARCHAR (200) NOT NULL, 
	description TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES admin(admin_id) ON DELETE CASCADE
);



