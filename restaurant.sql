-- Create database
DROP DATABASE IF EXISTS restaurant;
CREATE DATABASE IF NOT EXISTS restaurant;

-- Select database
USE restaurant;

-- 1. Menu Item Table
CREATE TABLE menu_item (
    item_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(30) CHECK (category IN ('Starter', 'Main', 'Dessert', 'Beverage')),
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    availability VARCHAR(15) DEFAULT 'In Stock' CHECK (availability IN ('In Stock', 'Out of Stock'))
);

-- 2. Customer Table
CREATE TABLE customer (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50),
    phone_number VARCHAR(15) NOT NULL,
    email VARCHAR(100)
);

-- 3. Orders Table
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customer(customer_id) ON DELETE CASCADE,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2) CHECK (total_amount >= 0),
    status VARCHAR(20) DEFAULT 'Pending' CHECK (status IN ('Pending', 'Completed', 'Cancelled'))
);

-- 4. Order Items Table
CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id) ON DELETE CASCADE,
    item_id INT REFERENCES menu_item(item_id) ON DELETE CASCADE,
    quantity INT NOT NULL CHECK (quantity > 0)
);
