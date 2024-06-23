import mysql.connector
from faker import Faker
import random
from datetime import datetime, timedelta

# 创建Faker实例
fake = Faker()

# 数据库连接
conn = mysql.connector.connect(
    host='localhost',
    user='root',
    password='root',
    database='TCUStudentHub'
)
cursor = conn.cursor()

# 插入Students表数据
students = []
for _ in range(110000):
    first_name = fake.first_name()
    last_name = fake.last_name()
    email = fake.unique.email()
    date_of_birth = fake.date_of_birth(minimum_age=18, maximum_age=22)
    enrollment_date = fake.date_between(start_date='-4y', end_date='today')
    major = fake.word()
    students.append((first_name, last_name, email, date_of_birth, enrollment_date, major))

cursor.executemany("""
    INSERT INTO Students (first_name, last_name, email, date_of_birth, enrollment_date, major)
    VALUES (%s, %s, %s, %s, %s, %s)
""", students)
conn.commit()

# 插入Courses表数据
courses = []
for _ in range(200):
    course_name = fake.word().capitalize()
    description = fake.sentence()
    credits = random.randint(1, 5)
    courses.append((course_name, description, credits))

cursor.executemany("""
    INSERT INTO Courses (course_name, description, credits)
    VALUES (%s, %s, %s)
""", courses)
conn.commit()

# 插入Professors表数据
professors = []
for _ in range(200):
    first_name = fake.first_name()
    last_name = fake.last_name()
    email = fake.unique.email()
    department = fake.word()
    professors.append((first_name, last_name, email, department))

cursor.executemany("""
    INSERT INTO Professors (first_name, last_name, email, department)
    VALUES (%s, %s, %s, %s)
""", professors)
conn.commit()

# 获取Courses和Professors的ID列表
cursor.execute("SELECT course_id FROM Courses")
course_ids = [row[0] for row in cursor.fetchall()]

cursor.execute("SELECT professor_id FROM Professors")
professor_ids = [row[0] for row in cursor.fetchall()]

# 插入CourseAssignments表数据
assignments = []
for _ in range(200):
    course_id = random.choice(course_ids)
    professor_id = random.choice(professor_ids)
    assignments.append((course_id, professor_id))

cursor.executemany("""
    INSERT INTO CourseAssignments (course_id, professor_id)
    VALUES (%s, %s)
""", assignments)
conn.commit()

# 获取Students的ID列表
cursor.execute("SELECT student_id FROM Students")
student_ids = [row[0] for row in cursor.fetchall()]

# 插入Enrollments表数据
enrollments = []
for _ in range(200):
    student_id = random.choice(student_ids)
    course_id = random.choice(course_ids)
    enrollment_date = fake.date_between(start_date='-4y', end_date='today')
    grade = round(random.uniform(0, 4), 2)
    enrollments.append((student_id, course_id, enrollment_date, grade))

cursor.executemany("""
    INSERT INTO Enrollments (student_id, course_id, enrollment_date, grade)
    VALUES (%s, %s, %s, %s)
""", enrollments)
conn.commit()

# 关闭连接
cursor.close()
conn.close()
