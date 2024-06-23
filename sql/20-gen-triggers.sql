-- 创建触发器
CREATE TRIGGER before_student_insert
BEFORE INSERT ON Students
FOR EACH ROW
BEGIN
    IF NEW.enrollment_date IS NULL THEN
        SET NEW.enrollment_date = CURDATE();
    END IF;
END

CREATE TRIGGER trg_enrollment_before_insert_update
BEFORE INSERT ON Enrollments
FOR EACH ROW
BEGIN
    DECLARE course_count INT;
    -- 检查课程是否存在于 Courses 表中
    SELECT COUNT(*) INTO course_count
    FROM Courses
    WHERE course_id = NEW.course_id;
    -- 如果课程不存在，则禁止插入或更新操作
    IF course_count = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot enroll in non-existent course';
    END IF;
END;