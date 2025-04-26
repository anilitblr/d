-- Create database
DROP DATABASE IF EXISTS library;
CREATE DATABASE IF NOT EXISTS library;

-- Select database
USE library;

-- 1. Book Table
CREATE TABLE book (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(100) NOT NULL,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    category VARCHAR(50),
    status VARCHAR(20) DEFAULT 'Available' CHECK (status IN ('Available', 'Issued', 'Reserved'))
);

-- 2. Member Table
CREATE TABLE member (
    member_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL CHECK (LENGTH(first_name) >= 2),
    last_name VARCHAR(50) NOT NULL CHECK (LENGTH(last_name) >= 2),
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(15),
    join_date DATE DEFAULT (CURRENT_DATE)
);

-- 3. Loan Table (tracks borrowing)
CREATE TABLE loan (
    loan_id SERIAL PRIMARY KEY,
    book_id INT REFERENCES book(book_id) ON DELETE CASCADE,
    member_id INT REFERENCES member(member_id) ON DELETE CASCADE,
    issue_date DATE DEFAULT (CURRENT_DATE),
    due_date DATE NOT NULL,
    return_date DATE
);

-- 4. Staff Table
CREATE TABLE staff (
    staff_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    role VARCHAR(30) CHECK (role IN ('Librarian', 'Assistant')),
    phone_number VARCHAR(15)
);
