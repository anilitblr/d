-- Create database
DROP DATABASE IF EXISTS hospital;
CREATE DATABASE IF NOT EXISTS hospital;

-- Select database
USE hospital;

-- 1. Patient Table
CREATE TABLE patient (
    patient_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50),
    gender CHAR(1) CHECK (gender IN ('M', 'F', 'O')),
    dob DATE NOT NULL,
    phone_number VARCHAR(15)
);

-- 2. Doctor Table
CREATE TABLE doctor (
    doctor_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50),
    specialization VARCHAR(100) NOT NULL,
    phone_number VARCHAR(15)
);

-- 3. Appointment Table
CREATE TABLE appointment (
    appointment_id SERIAL PRIMARY KEY,
    patient_id INT REFERENCES patient(patient_id) ON DELETE CASCADE,
    doctor_id INT REFERENCES doctor(doctor_id) ON DELETE CASCADE,
    appointment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'Scheduled' CHECK (status IN ('Scheduled', 'Completed', 'Cancelled'))
);

-- 4. Treatment Table
CREATE TABLE treatment (
    treatment_id SERIAL PRIMARY KEY,
    patient_id INT REFERENCES patient(patient_id) ON DELETE CASCADE,
    description VARCHAR(255),
    treatment_date DATE DEFAULT (CURRENT_DATE),
    cost DECIMAL(10, 2) CHECK (cost >= 0)
);
