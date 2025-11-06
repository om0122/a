

CREATE TABLE student_log (
    LogID INT AUTO_INCREMENT PRIMARY KEY,
    ActionType VARCHAR(50),
    Rollno INT,
    ActionDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
DELIMITER //
CREATE TRIGGER before_student_insert
BEFORE INSERT ON student
FOR EACH ROW
BEGIN
    -- You can modify or check values here
    IF NEW.Marks < 0 THEN
        SET NEW.Marks = 0; -- Prevent negative marks
    END IF;
END;
//
DELIMITER ;
DELIMITER //
CREATE TRIGGER after_student_insert
AFTER INSERT ON student
FOR EACH ROW
BEGIN
    INSERT INTO student_log(ActionType, Rollno)
    VALUES ('INSERT', NEW.Rollno);
END;
//
DELIMITER ;
DELIMITER //
CREATE TRIGGER after_student_update
AFTER UPDATE ON student
FOR EACH ROW
BEGIN
    INSERT INTO student_log(ActionType, Rollno)
    VALUES ('UPDATE', NEW.Rollno);
END;
//
DELIMITER ;
DELIMITER //
CREATE TRIGGER after_student_delete
AFTER DELETE ON student
FOR EACH ROW
BEGIN
    INSERT INTO student_log(ActionType, Rollno)
    VALUES ('DELETE', OLD.Rollno);
END;
//
DELIMITER ;


