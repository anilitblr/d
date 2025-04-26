-- Create database
DROP DATABASE IF EXISTS company;
CREATE DATABASE IF NOT EXISTS company;

-- Select database
USE company;

-- Create tables --  

-- department table

CREATE TABLE department (
    department_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    location VARCHAR(255) NOT NULL DEFAULT 'Bengaluru'
);

-- employees table

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender CHAR(1) NOT NULL,
    date_of_birth DATE NOT NULL,
    salary DECIMAL(10,2) NOT NULL,
    address VARCHAR(255) NOT NULL,
    department_id INT REFERENCES department(department_id) ON DELETE CASCADE,
    CHECK (gender IN ('M', 'F')),
    CHECK (salary > 0)
);

-- project table 

CREATE TABLE project (
    project_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    location VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    end_date DATE,
    budget DECIMAL(12,2) NOT NULL,
    CHECK (end_date > start_date),
    CHECK (budget > 0)
);

-- works_on table (Associative Entity for Employee-Project) 

CREATE TABLE works_on (
    id INT,
    project_id INT,
    hours INT,
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES project(project_id) ON DELETE CASCADE,
    CHECK (hours >= 0)
);

-- dependent table

CREATE TABLE dependent (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    relationship VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    CHECK (relationship IN ('Spouse', 'Child', 'Parent', 'Other'))
);

-- Describe tables
DESC employee;
DESC department;
DESC project;
DESC works_on;
DESC dependent;

-- Delete table
-- DROP TABLE location;

-- Insert Data into employee table

INSERT INTO employee (id, first_name, last_name, gender, date_of_birth, salary, address)  VALUES 
(1, 'Anil', 'Kumar N', 'M', '1985-06-15', 25000.00, "Bengaluru"),
(2, 'Lokesh', 'Polu', 'M', '1985-06-15', 85000.00, "Mangaluru");

-- Insert Data into department table

INSERT INTO department (id, employee_id, name, location) VALUES
(1, 1, 'Human Resources', 'New York'),
(2, 2, 'Engineering', 'San Francisco');

-- Insert Data into Project Table

INSERT INTO Project (id, name, location, start_date, end_date, budget) VALUES
(1, 'HR System Upgrade', 'Bengaluru', '214-01-01', '214-12-31', 50000.00);

-- Insert Data into Works_On Table

INSERT INTO works_on (id, Project_id, hours) VALUES (1, 1, 40);

-- Insert Data into dependent table

INSERT INTO Dependent (id, name, relationship, date_of_birth) VALUES (1, 'Sophia Johnson', 'Child', '2015-07-10');

-- Verify data with select queries

SELECT * FROM employee;
SELECT * FROM department;
SELECT * FROM project;
SELECT * FROM works_on;
SELECT * FROM dependent;

-- Update Department Manager_ID (Assigning Managers)

UPDATE employee SET first_name = "Babu" WHERE id = 1;
UPDATE department SET location = "India" WHERE Name = "Human Resources";
UPDATE project SET location = "Mangaluru" WHERE id = 1;
UPDATE works_on SET hours = 500 WHERE id = 1;
UPDATE dependent SET name = "Anil" WHERE id = 1;

-- Verify data with select queries along with WHERE clause

SELECT * FROM employee WHERE id > 1;
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
