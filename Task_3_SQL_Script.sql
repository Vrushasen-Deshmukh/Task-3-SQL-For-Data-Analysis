CREATE DATABASE college;
USE college;

CREATE TABLE student
(
	rollno INT PRIMARY KEY,
    name VARCHAR(50),
    marks INT NOT NULL,
    grade VARCHAR(5),
    city VARCHAR(20)
);

INSERT INTO student(rollno, name, marks, grade, city) VALUES
(101, "Anil", 78, "C", "Pune"),
(102, "Bhumika", 93, "A", "Pune"),
(103, "Chetan", 85, "B", "Pune"),
(104, "Dhruv", 96, "A", "Pune"),
(105, "Emanuel", 12, "F", "Pune"),
(106, "Farah", 82, "B", "Pune");

-- SELECT command
-- Display the entire table.
SELECT * FROM student;

-- WHERE clause
-- Find students whose marks are more than 80 or live in Mumbai.
SELECT * FROM student
WHERE marks>80 OR city = "Mumbai";

-- Find students whose marks are more than 50 and live in Pune.
SELECT * FROM student
WHERE marks < 50 AND city = "Pune";


-- ORDER BY clause
-- Display students in descending order of cities they live in.
SELECT * FROM student
ORDER BY city DESC;

-- Display students in ascending order of their grades.
SELECT * FROM student
ORDER BY grade;

-- Display students in descending order of their grades.
SELECT * FROM student
ORDER BY grade desc;


-- GROUP BY clause
-- Find the total no. of students based on their individual grades.
SELECT grade, COUNT(*) AS total_students
FROM student
GROUP BY grade;

-- Find the total no. of students based on their individual cities.
SELECT city, COUNT(*) AS total_students
FROM student
GROUP BY city;


-- SUBQUERY NO. 1
-- Find the student(s) who have marks greater than the average marks
SELECT name, marks
FROM student
WHERE marks > (
    SELECT AVG(marks)
    FROM student
);


-- SUBQUERY NO. 2
-- Find the student(s) with the highest marks
SELECT name, marks
FROM student
WHERE marks = (
    SELECT MAX(marks)
    FROM student
);


-- Aggregate Function
-- 1. SUM Function. Find the total marks of all students.
SELECT SUM(marks) AS total_marks
FROM student;

-- 2. AVG Function. Find the average marks of all students.
SELECT round(AVG(marks),2) AS average_marks
FROM student;

-- 3. MAX Function. Find the highest marks.
SELECT MAX(marks) AS highest_marks
FROM student;


-- 4. MIN Function. Find the lowest marks.
SELECT MIN(marks) AS highest_marks
FROM student;

-- 5. COUNT function. Find the total no. of students.
SELECT COUNT(*) AS total_students
FROM student;

-- 6. All aggregate functions
SELECT 
  COUNT(*) AS total_students,
  SUM(marks) AS total_marks,
  round(AVG(marks),2) AS average_marks,
  MAX(marks) AS highest_marks,
  MIN(marks) AS lowest_marks
FROM student;

CREATE TABLE student2
(
	student2_id INT PRIMARY KEY,
    name2 VARCHAR(50)
);

INSERT INTO student2 (student2_id, name2) VALUES 
(101, "Adam"),
(102, "Dave"),
(103, "Casey");

CREATE TABLE course
(
	student2_id INT PRIMARY KEY,
    course VARCHAR(50)
);

INSERT INTO course (student2_id, course) VALUES
(102, "english"),
(105, "math"),
(103, "science"),
(107, "computer science");

SELECT * FROM student2;
SELECT * FROM course;

-- JOINS
-- 1. INNER JOIN
-- Join the 2 tables based on a related columns between them.
SELECT * FROM student2
INNER JOIN course
ON student2.student2_id = course.student2_id;

-- 2. LEFT JOIN
SELECT * FROM student2
LEFT JOIN course
ON student2.student2_id = course.student2_id;

-- 3. RIGHT JOIN
SELECT * FROM student2
RIGHT JOIN course
ON student2.student2_id = course.student2_id;


-- Creating views for analysis.
-- 1. View : High Scorers(students with marks > 90)
CREATE VIEW high_scorers AS
SELECT rollno, name, marks, grade
FROM student
WHERE marks > 85;

SELECT * FROM high_scorers;

-- 2. View: Grade-wise Summary (average and total marks per grade)
CREATE VIEW grade_summary AS
SELECT grade,
       COUNT(*) AS student_count,
       SUM(marks) AS total_marks,
       AVG(marks) AS average_marks
FROM student
GROUP BY grade;

SELECT * FROM grade_summary;

-- 3. View: City-wise Student Count
CREATE VIEW city_summary AS
SELECT city,
       COUNT(*) AS total_students
FROM student
GROUP BY city;

SELECT * FROM city_summary;

-- 4. View: Failed Students (marks below 40)
CREATE VIEW failed_students AS
SELECT rollno, name, marks, grade
FROM student
WHERE marks < 40;

SELECT * FROM failed_students;


-- Optimizing queries with indexes
-- 1. Index on marks column
CREATE INDEX idx_marks ON student(marks);

-- 2. Index on grade column
CREATE INDEX idx_grade ON student(grade);

-- 3. Index on city column
CREATE INDEX idx_city ON student(city);