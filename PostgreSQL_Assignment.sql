-- Active: 1732686959244@@127.0.0.1@5432@university_db
CREATE DATABASE university_db

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(255),
    age INT,
    email VARCHAR(50),
    frontend_mark INT,
    backend_mark INT,
    status VARCHAR(20)
)

CREATE TABLE courses(
    course_id INT PRIMARY KEY,
    course_name VARCHAR(255),
    credits INT
)

CREATE TABLE enrollment (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    FOREIGN KEY (student_id) REFERENCES students (student_id),
    FOREIGN KEY (course_id) REFERENCES courses (course_id)
);

INSERT INTO students (student_id, student_name, age, email, frontend_mark, backend_mark)
VALUES 
(1, 'Alice', 22, 'alice@example.com', 55, 57),
(2, 'Bob', 21, 'bob@example.com', 34, 45),
(3, 'Charlie', 23, 'charlie@example.com', 60, 59),
(4, 'David', 20, 'david@example.com', 40, 49),
(5, 'Eve', 24, 'newemail@example.com', 45, 34),
(6, 'Rahim', 23, 'rahim@gmail.com', 46, 42);

INSERT INTO courses (course_id, course_name, credits)
VALUES
(1, 'NEXT.js', 3),
(2, 'React.js', 4),
(3, 'Databases', 3),
(4, 'Prisma', 3);

INSERT INTO enrollment (enrollment_id, student_id, course_id)
VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 1),
(4, 3, 2);

--Query 1: Insert a new student record
INSERT INTO students (student_id, student_name, age, email, frontend_mark, backend_mark, status)
VALUES 
(8, 'Debnath', 24, 'spartha344@gmail.com', 53, 55, null);

--Query 2: Retrieve the names of all students who are enrolled in the course titled 'Next.js'
SELECT student_name FROM enrollment AS e
JOIN students AS s ON e.student_id = s.student_id
JOIN courses AS c ON e.course_id = c.course_id
WHERE course_name = 'NEXT.js'

--Query 3:Update the status of the student with the highest total (frontend_mark + backend_mark) mark to 'Awarded'
UPDATE students
SET status = 'Awarded'
WHERE student_id = (
    SELECT student_id FROM students
    ORDER BY (frontend_mark + backend_mark) DESC
    LIMIT 1
)

--Query 4: Delete all courses that have no students enrolled.
DELETE FROM courses
WHERE course_id NOT IN(
    SELECT DISTINCT course_id FROM enrollment
)

--Query 5:Retrieve the names of students using a limit of 2, starting from the 3rd student.
SELECT student_name FROM students
ORDER BY student_id
OFFSET 2
LIMIT 2

--Query 6: Retrieve the course names and the number of students enrolled in each course.
SELECT c.course_name, COUNT(e.student_id) AS student_enrolled FROM courses AS c
LEFT JOIN enrollment AS e ON c.course_id = e.course_id
GROUP BY c.course_name

-- Query 7: Calculate and display the average age of all students.
SELECT AVG(age) AS average_age
FROM students;

-- Query 8: Retrieve the names of students whose email addresses contain 'example.com'.
SELECT student_name
FROM students
WHERE email LIKE '%example.com%';

