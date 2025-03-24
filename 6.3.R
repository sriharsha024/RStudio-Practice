library(DBI)
library(RSQLite)

print("K. Sri Harsha Royal")
print("22BCE0893")

# Step 1: Create or Connect to SQLite Database
conn <- dbConnect(SQLite(), dbname = "courses_database.db")

# Step 2: Create a Table in the Database
dbExecute(conn, "DROP TABLE IF EXISTS courses;")
dbExecute(conn, "
    CREATE TABLE courses (
        Course_ID INTEGER PRIMARY KEY,
        Course_Name TEXT,
        Students_Enrolled INTEGER,
        Course_Fee REAL
    );")

# Step 3: Insert Sample Data
dbExecute(conn, "
    INSERT INTO courses (Course_ID, Course_Name, Students_Enrolled, Course_Fee) VALUES
    (3001, 'Data Science', 50, 1200),
    (3002, 'Web Development', 75, 800),
    (3003, 'Digital Marketing', 40, 600),
    (3004, 'Cloud Computing', 90, 1000),
    (3005, 'Cybersecurity', 60, 1500);")

# Step 4: Perform SQL Queries

# i) Identify all courses where more than 50 students are enrolled
query1 <- dbGetQuery(conn, "SELECT * FROM courses WHERE Students_Enrolled > 50;")
print("Courses with More Than 50 Students:")
print(query1)

# ii) Select only the Course Name and Course Fee columns
query2 <- dbGetQuery(conn, "SELECT Course_Name, Course_Fee FROM courses;")
print("Course Name and Course Fee:")
print(query2)

# iii) Count how many courses have 50 or fewer students enrolled
query3 <- dbGetQuery(conn, "SELECT COUNT(*) AS Low_Enrollment_Count FROM courses WHERE Students_Enrolled <= 50;")
print("Count of Courses with 50 or Fewer Students:")
print(query3)

# iv) Retrieve the Course ID and Course Name of the course with the highest fee
query4 <- dbGetQuery(conn, "SELECT Course_ID, Course_Name FROM courses ORDER BY Course_Fee DESC LIMIT 1;")
print("Course with the Highest Fee:")
print(query4)

# v) Increase the fees for all courses by 5% and display the updated fees
dbExecute(conn, "UPDATE courses SET Course_Fee = Course_Fee * 1.05;")
query5 <- dbGetQuery(conn, "SELECT * FROM courses;")
print("Updated Course Fees after 5% Increase:")
print(query5)

# Step 5: Close the Database Connection
dbDisconnect(conn)
