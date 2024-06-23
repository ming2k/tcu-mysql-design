-- 存储过程: 查询所有学生信息
CREATE PROCEDURE GetAllStudents()
BEGIN
    SELECT * FROM Students;
END

-- 存储过程: 按学生ID查询学生信息
CREATE PROCEDURE GetStudentByID(IN student_id INT)
BEGIN
    SELECT * FROM Students WHERE student_id = student_id;
END

-- 存储过程: 查询所有课程信息
CREATE PROCEDURE GetAllCourses()
BEGIN
    SELECT * FROM Courses;
END

-- 存储过程: 按课程ID查询课程信息
CREATE PROCEDURE GetCourseByID(IN course_id INT)
BEGIN
    SELECT * FROM Courses WHERE course_id = course_id;
END

-- 存储过程: 查询所有教授信息
CREATE PROCEDURE GetAllProfessors()
BEGIN
    SELECT * FROM Professors;
END

-- 存储过程: 按教授ID查询教授信息
CREATE PROCEDURE GetProfessorByID(IN professor_id INT)
BEGIN
    SELECT * FROM Professors WHERE professor_id = professor_id;
END

-- 存储过程: 查询所有课程分配信息
CREATE PROCEDURE GetAllCourseAssignments()
BEGIN
    SELECT * FROM CourseAssignments;
END

-- 存储过程: 查询某课程的所有学生
CREATE PROCEDURE GetStudentsByCourseID(IN course_id INT)
BEGIN
    SELECT s.*
    FROM Students s
    INNER JOIN Enrollments e ON s.student_id = e.student_id
    WHERE e.course_id = course_id;
END

-- 存储过程: 统计每门课程的学生人数
CREATE PROCEDURE CountStudentsPerCourse()
BEGIN
    SELECT course_id, COUNT(*) AS student_count
    FROM Enrollments
    GROUP BY course_id;
END

-- 存储过程: 查询某教授的所有课程
CREATE PROCEDURE GetCoursesByProfessorID(IN professor_id INT)
BEGIN
    SELECT c.*
    FROM Courses c
    INNER JOIN CourseAssignments ca ON c.course_id = ca.course_id
    WHERE ca.professor_id = professor_id;
END

-- 存储过程: 查询某生日月份的学生
CREATE PROCEDURE GetStudentsByBirthMonth(IN birth_month INT)
BEGIN
    SELECT *
    FROM Students
    WHERE MONTH(date_of_birth) = birth_month;
END

-- 存储过程: 根据课程名称模糊查询课程
CREATE PROCEDURE SearchCoursesByName(IN course_name_pattern VARCHAR(100))
BEGIN
    SELECT *
    FROM Courses
    WHERE course_name LIKE CONCAT('%', course_name_pattern, '%');
END

-- 存储过程: 添加新学生
CREATE PROCEDURE AddStudent(IN first_name VARCHAR(50), IN last_name VARCHAR(50), IN email VARCHAR(100), IN date_of_birth DATE, IN enrollment_date DATE, IN major VARCHAR(100))
BEGIN
    INSERT INTO Students (first_name, last_name, email, date_of_birth, enrollment_date, major)
    VALUES (first_name, last_name, email, date_of_birth, enrollment_date, major);
END

-- 存储过程: 更新学生信息
CREATE PROCEDURE UpdateStudent(IN student_id INT, IN first_name VARCHAR(50), IN last_name VARCHAR(50), IN email VARCHAR(100), IN date_of_birth DATE, IN enrollment_date DATE, IN major VARCHAR(100))
BEGIN
    UPDATE Students
    SET first_name = first_name,
        last_name = last_name,
        email = email,
        date_of_birth = date_of_birth,
        enrollment_date = enrollment_date,
        major = major
    WHERE student_id = student_id;
END

-- 存储过程: 删除学生
CREATE PROCEDURE DeleteStudent(IN student_id INT)
BEGIN
    DELETE FROM Students WHERE student_id = student_id;
END

-- 存储过程: 添加新课程
CREATE PROCEDURE AddCourse(IN course_name VARCHAR(100), IN description TEXT, IN credits INT)
BEGIN
    INSERT INTO Courses (course_name, description, credits)
    VALUES (course_name, description, credits);
END

-- 存储过程: 更新课程信息
CREATE PROCEDURE UpdateCourse(IN course_id INT, IN course_name VARCHAR(100), IN description TEXT, IN credits INT)
BEGIN
    UPDATE Courses
    SET course_name = course_name,
        description = description,
        credits = credits
    WHERE course_id = course_id;
END

-- 存储过程: 删除课程
CREATE PROCEDURE DeleteCourse(IN course_id INT)
BEGIN
    DELETE FROM Courses WHERE course_id = course_id;
END

-- 存储过程: 添加新教授
CREATE PROCEDURE AddProfessor(IN first_name VARCHAR(50), IN last_name VARCHAR(50), IN email VARCHAR(100), IN department VARCHAR(100))
BEGIN
    INSERT INTO Professors (first_name, last_name, email, department)
    VALUES (first_name, last_name, email, department);
END

-- 存储过程: 更新教授信息
CREATE PROCEDURE UpdateProfessor(IN professor_id INT, IN first_name VARCHAR(50), IN last_name VARCHAR(50), IN email VARCHAR(100), IN department VARCHAR(100))
BEGIN
    UPDATE Professors
    SET first_name = first_name,
        last_name = last_name,
        email = email,
        department = department
    WHERE professor_id = professor_id;
END

-- 存储过程: 删除教授
CREATE PROCEDURE DeleteProfessor(IN professor_id INT)
BEGIN
    DELETE FROM Professors WHERE professor_id = professor_id;
END

-- 存储过程: 分配教授给课程
CREATE PROCEDURE AssignProfessorToCourse(IN course_id INT, IN professor_id INT)
BEGIN
    INSERT INTO CourseAssignments (course_id, professor_id)
    VALUES (course_id, professor_id);
END

-- 存储过程: 取消课程的教授分配
CREATE PROCEDURE UnassignProfessorFromCourse(IN course_id INT)
BEGIN
    DELETE FROM CourseAssignments WHERE course_id = course_id;
END

-- 存储过程: 统计每位教授所授课程数量
CREATE PROCEDURE CountCoursesPerProfessor()
BEGIN
    SELECT professor_id, COUNT(*) AS course_count
    FROM CourseAssignments
    GROUP BY professor_id;
END

-- 存储过程: 查询学生的选课情况
CREATE PROCEDURE GetStudentCourseInfo(IN student_id INT)
BEGIN
    SELECT s.*, c.course_name, e.enrollment_date, e.grade
    FROM Students s
    INNER JOIN Enrollments e ON s.student_id = e.student_id
    INNER JOIN Courses c ON e.course_id = c.course_id
    WHERE s.student_id = student_id;
END

-- 存储过程: 查询学生的总学分
CREATE PROCEDURE GetStudentTotalCredits(IN student_id INT)
BEGIN
    SELECT s.student_id, s.first_name, s.last_name, SUM(c.credits) AS total_credits
    FROM Students s
    INNER JOIN Enrollments e ON s.student_id = e.student_id
    INNER JOIN Courses c ON e.course_id = c.course_id
    WHERE s.student_id = student_id
    GROUP BY s.student_id, s.first_name, s.last_name;
END

-- 存储过程: 查询课程的平均成绩
CREATE PROCEDURE GetCourseAverageGrade(IN course_id INT)
BEGIN
    SELECT course_id, AVG(grade) AS avg_grade
    FROM Enrollments
    WHERE course_id = course_id
    GROUP BY course_id;
END

-- 存储过程: 按教授姓名查询教授信息
CREATE PROCEDURE GetProfessorByName(IN first_name VARCHAR(50), IN last_name VARCHAR(50))
BEGIN
    SELECT *
    FROM Professors
    WHERE first_name = first_name AND last_name = last_name;
END

-- 存储过程: 按课程ID查询授课教授信息
CREATE PROCEDURE GetProfessorByCourseID(IN course_id INT)
BEGIN
    SELECT p.*
    FROM Professors p
    INNER JOIN CourseAssignments ca ON p.professor_id = ca.professor_id
    WHERE ca.course_id = course_id;
END

-- 存储过程: 按专业查询所有学生信息
CREATE PROCEDURE GetStudentsByMajor(IN major VARCHAR(100))
BEGIN
    SELECT *
    FROM Students
    WHERE major = major;
END

-- 存储过程: 查询学生在某个时间段的选课信息
CREATE PROCEDURE GetStudentCoursesByDateRange(IN student_id INT, IN start_date DATE, IN end_date DATE)
BEGIN
    SELECT c.*, e.enrollment_date, e.grade
    FROM Courses c
    INNER JOIN Enrollments e ON c.course_id = e.course_id
    WHERE e.student_id = student_id
      AND e.enrollment_date BETWEEN start_date AND end_date;
END

-- 存储过程: 统计某专业的学生数量
CREATE PROCEDURE CountStudentsByMajor()
BEGIN
    SELECT major, COUNT(*) AS student_count
    FROM Students
    GROUP BY major;
END


