-- 创建 Students 表
CREATE TABLE Students (
  student_id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  email VARCHAR(100),
  date_of_birth DATE,
  enrollment_date DATE,
  major VARCHAR(100)
);

-- 创建 Courses 表
CREATE TABLE Courses (
  course_id INT AUTO_INCREMENT PRIMARY KEY,
  course_name VARCHAR(100),
  description TEXT,
  credits INT
);

-- 创建 Enrollments 表
CREATE TABLE Enrollments (
  enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
  student_id INT,
  course_id INT,
  enrollment_date DATE,
  grade DECIMAL(3,2),
  FOREIGN KEY (student_id) REFERENCES Students(student_id),
  FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- 创建 Professors 表
CREATE TABLE Professors (
  professor_id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  email VARCHAR(100),
  department VARCHAR(100)
);

-- 创建 CourseAssignments 表
CREATE TABLE CourseAssignments (
  assignment_id INT AUTO_INCREMENT PRIMARY KEY,
  course_id INT,
  professor_id INT,
  FOREIGN KEY (course_id) REFERENCES Courses(course_id),
  FOREIGN KEY (professor_id) REFERENCES Professors(professor_id)
);


