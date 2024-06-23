-- 创建视图
CREATE VIEW StudentCoursesView AS
SELECT s.student_id, s.first_name, s.last_name, c.course_name, e.enrollment_date, e.grade
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id;

CREATE VIEW ProfessorCoursesView AS
SELECT p.professor_id, p.first_name, p.last_name, c.course_name
FROM Professors p
JOIN CourseAssignments ca ON p.professor_id = ca.professor_id
JOIN Courses c ON ca.course_id = c.course_id;

CREATE VIEW CourseEnrollmentCountView AS
SELECT c.course_id, c.course_name, COUNT(e.student_id) AS enrollment_count
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;

CREATE VIEW StudentGPAView AS
SELECT s.student_id, s.first_name, s.last_name,
       AVG(CASE WHEN e.grade IS NOT NULL THEN e.grade ELSE 0 END) AS gpa
FROM Students s
LEFT JOIN Enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.first_name, s.last_name;

-- 创建触发器
CREATE TRIGGER before_insert_students_trigger
BEFORE INSERT ON Students
FOR EACH ROW
BEGIN
  DECLARE email_count INT;
  SELECT COUNT(*) INTO email_count FROM Students WHERE email = NEW.email;
  IF email_count > 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Email must be unique.';
  END IF;
END;

CREATE TRIGGER after_insert_enrollments_trigger
AFTER INSERT ON Enrollments
FOR EACH ROW
BEGIN
  CALL update_student_gpa(NEW.student_id);
END;
