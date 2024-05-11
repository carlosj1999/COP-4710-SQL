
CALL Calculate_Grades(ACG-4101);

UPDATE Enrollment set grade = null;

DELIMITER$$
CREATE PROCEDURE Calculate_Grades(IN course_id varchar(10))
BEGIN
DECLARE letter_grade char;
DECLARE points float;
DECLARE stud varchar(10);
DECLARE sect varchar(50);
DECLARE finished INTEGER DEFAULT 0;
DECLARE students_cursor cursor for 
SELECT enr.Student, enr.Section, enr.Points from ENROLLMENT enr WHERE enr.Course = course_id;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;
START TRANSACTION;
OPEN student_cursor;
std_loop : LOOP
FETCH students_cursor INTO stud, sect, point;
	IF finished = 1 THEN
		LEAVE std_loop;
	END IF;
    
IF(points>=90) THEN
	SET letter_grade = 'A';
ELSEIF(points>=80) THEN
	SET letter_grade = 'B';
ELSEIF(points>=70) THEN
	SET letter_grade = 'C';
ELSEIF(points>=60) THEN
	SET letter_grade = 'D';
ELSE
	SET letter_grade = 'F';
    END IF;
    
UPDATE ENROLLMENT SET Grade = letter_grade WHERE Student = stud and Section = sect;
END LOOP std_loop;
CLOSE students_cursor;
COMMIT;
SELECT enr.* from ENROLLMENT enr WHERE enr.Course = course_id;
END$$;
DELIMITER;

-- Create the MAJORS table
CREATE TABLE MAJOR (
    MName VARCHAR(100) PRIMARY KEY,
    Credits INTEGER,
    MStatus ENUM('Active', 'Inactive') DEFAULT 'Active',
    Department varchar(50) NOT NULL,
    FOREIGN KEY (Department) REFERENCES department(DCode)
);

drop table MAJORS;
SELECT * FROM ENROLLMENT e Join student s where e.student = s.Sid;
SELECT * FROM SECTION;
SELECT * FROM INSTRUCTOR;
SELECT * FROM DEPARTMENT;
SELECT * FROM student;
SELECT * FROM course;

SELECT e.student as Student_ID, e.course as COURSE FROM ENROLLMENT e
JOIN Section s ON e.Section = s.SectId
WHERE Semester = '1241' and Points>=90
ORDER BY student;


SELECT distinct IName, DaysTime FROM instructor i
JOIN section s on i.Id = s.Instructor
WHERE DaysTime LIKE '%Tu%'
ORDER BY IName;

SELECT IName FROM INSTRUCTOR WHERE ID IN(
SELECT  Instructor FROM SECTION WHERE DaysTime LIKE '%Tu%') 
AND ID NOT IN
(SELECT  Instructor FROM SECTION WHERE DaysTime LIKE '%Mo%'); 


SELECT * FROM DEPARTMENT d
JOIN STUDENT s ON d.DCode = s.Department
ORDER BY DName;

SELECT Department, DName,COUNT(*) FROM Student s 
JOIN Department d On s.Department = d.DCode
Group BY Department
HAVING COUNT(*) >= 3
ORDER BY DName;




