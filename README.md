# Sitin Monitoring System

A web-based monitoring system for managing student computer laboratory usage, reservations, and resources.

## Prerequisites

- Python
- MySQL/MariaDB
- Git (optional, for cloning the repository)

## Installation
1. Install python https://www.python.org/downloads/
2. Download the zip  and extract
3. Go to visual studio code and open the extracted folder.
4. Create and activate a virtual environment. Type this in the terminal: 
```bash
3. pip install 
# Windows

venv\Scripts\activate

# Linux/Mac
python3 -m venv venv
source venv/bin/activate
```

3. Install the required Python packages:
```bash
pip install flask bcrypt better-profanity fuzzywuzzy werkzeug
```

4. Set up the database:
   - Create a MySQL database
   - Import the database schema from `sitin_db.sql`:
   ```bash
   mysql -u your_username -p your_database_name < sitin_db.sql
   ```

## Configuration

1. Create a `static/uploads` directory in the project root (the application will create this automatically if it doesn't exist)

2. Ensure your MySQL server is running and accessible

## Running the Application

1. Activate the virtual environment if not already activated:
```bash
# Windows
venv\Scripts\activate

2. Start the Flask application:
```bash
py app.py
```

3. Open your web browser and navigate to:
```
http://localhost:5000
```

## Features

- Student login and registration
- Computer laboratory monitoring
- PC status tracking
- Resource management
- Announcement system
- Reservation system
- Student records management
- Leaderboard
- Profile management

## Default Admin Account

- Username: admin
- Password: (set during database import)

## Security Notes

- The application uses bcrypt for password hashing
- Session management is implemented for secure authentication
- File upload restrictions are in place for security

## Troubleshooting

1. If you encounter database connection issues:
   - Verify MySQL service is running
   - Check database credentials
   - Ensure the database schema is properly imported

2. If the application fails to start:
   - Verify all dependencies are installed
   - Check if the virtual environment is activated
   - Ensure no other application is using port 5000
