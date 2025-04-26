-- Create database
DROP DATABASE IF EXISTS school;
CREATE DATABASE IF NOT EXISTS school;

-- Select database
USE school;

-- Create tables --  
-- SCHOOL TABLE
CREATE TABLE school (
    school_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL CHECK (LENGTH (name) >= 2),
    address VARCHAR(255) DEFAULT 'Bengaluru',
    phone_number VARCHAR(15)
);

-- STUDENT TABLE
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL CHECK (LENGTH(first_name) >= 2),
    last_name VARCHAR(50) NOT NULL,
    roll_no VARCHAR(20) UNIQUE NOT NULL CHECK (LENGTH(roll_no) >= 3),
    address VARCHAR(255) DEFAULT 'Bengaluru',
    phone_number VARCHAR(15)
);

-- Subject table
CREATE TABLE subjects (
    subject_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    code VARCHAR(10) UNIQUE NOT NULL,
    description VARCHAR(255)
);

-- TEACHER TABLE
CREATE TABLE teachers (
    teacher_id SERIAL PRIMARY KEY,
    code VARCHAR(100) NOT NULL,
    first_name VARCHAR(50) NOT NULL CHECK (LENGTH(first_name) >= 2),
    last_name VARCHAR(50) NOT NULL,
    phone_number VARCHAR(15)
    REFERENCES subject(code) ON DELETE CASCADE
);

-- Describe tables
DESC school;
DESC students;
DESC subjects;
DESC teachers;

-- Insert into school table
INSERT INTO school (name, address, phone_number)
VALUES ('Oxford', "", '9241556452');

-- Insert Data into student table
INSERT INTO students (first_name, last_name, roll_no, phone_number)
VALUES ('Anil', 'Kumar', '470CS23001', '9241556452');

INSERT INTO subjects(name, code, description) VALUES 
('English', 'EN001', 'This is a English subject.');

-- Insert into teachers table
INSERT INTO teachers (code, first_name, last_name, phone_number)
VALUES ('EN001','Anita', 'D', '8887776666');

-- Verify data with select queries

SELECT * FROM school;
SELECT * FROM students;
SELECT * FROM subjects;
SELECT * FROM teachers;

-- Update Department Manager_ID (Assigning Managers)

UPDATE school SET name = "OXFORD" WHERE school_id = 1;

-- Note: To be updated.
UPDATE department SET location = "India" WHERE Name = "Human Resources";
UPDATE project SET location = "Mangaluru" WHERE id = 1;
UPDATE works_on SET hours = 500 WHERE id = 1;
UPDATE dependent SET name = "Anil" WHERE id = 1;

-- Verify data with select queries along with WHERE clause

SELECT * FROM school WHERE id > 1;
SELECT * FROM employee WHERE id < 2;
SELECT * FROM employee WHERE id >= 1;
SELECT * FROM employee WHERE id <= 1;
SELECT * FROM employee WHERE id IN (1, 2);
SELECT * FROM employee WHERE id IN (SELECT id FROM employee WHERE id > 1);
SELECT * FROM employee WHERE id BETWEEN 1 AND 2;

SELECT first_name
FROM employee
WHERE EXISTS (SELECT first_name FROM employee WHERE id = 1 AND first_name = 'Babu');

SELECT first_name
FROM employee
WHERE id = ANY (SELECT first_name FROM employee WHERE id = 1 AND first_name = 'Babu');

SELECT first_name
FROM employee
WHERE id = ALL (SELECT id FROM employee WHERE id = 2 AND first_name = 'Lokesh');

-- Delete data with WHERE Clause

DELETE FROM department WHERE id = 1;
DELETE FROM employee WHERE id = 1;
DELETE FROM project WHERE id = 1;
DELETE FROM works_on WHERE id = 1;
DELETE FROM dependent WHERE id = 1;

-- Add new column 
ALTER TABLE employee ADD phone NUMERIC(20);

-- rename phone column to phone_number --
ALTER TABLE employee CHANGE phone phone_number NUMERIC(10);

-- Modify phone column's attributes --
ALTER TABLE employee MODIFY phone NUMERIC(15);
DESC employee;
