create database finance01_db;
 use finance01_db;
CREATE TABLE normalized_customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(90) NOT NULL,
    email VARCHAR(70) UNIQUE,
    phone VARCHAR(85),
    city VARCHAR(69)
);

CREATE TABLE normalized_accounts (
    account_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    account_type VARCHAR(60) NOT NULL,
    opening_balance DECIMAL(12,2) DEFAULT 0,
    FOREIGN KEY (customer_id)
        REFERENCES normalized_customers(customer_id)
);

CREATE TABLE normalized_orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    order_amount DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (customer_id)
        REFERENCES normalized_customers(customer_id)
);

CREATE TABLE normalized_invoices (
    invoice_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    invoice_date DATE NOT NULL,
    due_date DATE NOT NULL,
    invoice_amount DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (order_id)
        REFERENCES normalized_orders(order_id)
);

CREATE TABLE normalized_payments (
    payment_id INT PRIMARY KEY,
    invoice_id INT NOT NULL,
    payment_date DATE NOT NULL,
    payment_amount DECIMAL(12,2) NOT NULL,
    payment_method VARCHAR(40),
    FOREIGN KEY (invoice_id)
        REFERENCES normalized_invoices(invoice_id)
);

CREATE TABLE normalized_expenses (
    expense_id INT PRIMARY KEY,
    expense_date DATE NOT NULL,
    category VARCHAR(50) NOT NULL,
    description VARCHAR(150),
    amount DECIMAL(12,2) NOT NULL
);

INSERT INTO normalized_customers
(customer_id, customer_name, email, phone, city)
VALUES
(1, 'Rahul Sharma', 'rahul@gmail.com', '9876543210', 'Mangalore'),
(2, 'Priya Shetty', 'priya@gmail.com', '9876543211', 'Bangalore'),
(3, 'Anu Rao', 'anu@gmail.com', '9876543212', 'Mysore'),
(4, 'Kiran Kumar', 'kiran@gmail.com', '9876543213', 'Udupi'),
(5, 'Sneha Pai', 'sneha@gmail.com', '9876543214', 'Hubli');

INSERT INTO normalized_accounts
(account_id, customer_id, account_type, opening_balance)
VALUES
(101, 1, 'Savings', 50000.00),
(102, 2, 'Current', 75000.00),
(103, 3, 'Savings', 45000.00),
(104, 4, 'Current', 60000.00),
(105, 5, 'Savings', 85000.00);

INSERT INTO normalized_orders
(order_id, customer_id, order_date, order_amount)
VALUES
(1001, 1, '2026-01-10', 15000.00),
(1002, 2, '2026-01-15', 25000.00),
(1003, 3, '2026-02-05', 18000.00),
(1004, 4, '2026-02-20', 30000.00),
(1005, 5, '2026-03-10', 22000.00);

INSERT INTO normalized_invoices
(invoice_id, order_id, invoice_date, due_date, invoice_amount)
VALUES
(501, 1001, '2026-01-10', '2026-02-10', 15000.00),
(502, 1002, '2026-01-15', '2026-02-15', 25000.00),
(503, 1003, '2026-02-05', '2026-03-05', 18000.00),
(504, 1004, '2026-02-20', '2026-03-20', 30000.00),
(505, 1005, '2026-03-10', '2026-04-10', 22000.00);

INSERT INTO normalized_payments
(payment_id, invoice_id, payment_date, payment_amount, payment_method)
VALUES
(901, 501, '2026-01-25', 15000.00, 'UPI'),
(902, 502, '2026-02-05', 10000.00, 'Bank Transfer'),
(903, 503, '2026-03-01', 18000.00, 'Cash'),
(904, 504, '2026-03-15', 15000.00, 'UPI'),
(905, 505, '2026-03-25', 22000.00, 'Credit Card');

INSERT INTO normalized_expenses
(expense_id, expense_date, category, description, amount)
VALUES
(701, '2026-01-05', 'Rent', 'Office rent', 20000.00),
(702, '2026-01-12', 'Utilities', 'Electricity bill', 5000.00),
(703, '2026-02-10', 'Salary', 'Employee salary', 45000.00),
(704, '2026-02-18', 'Travel', 'Business travel', 8000.00),
(705, '2026-03-08', 'Marketing', 'Online advertising', 12000.00);

SELECT * FROM normalized_customers;
SELECT * FROM normalized_accounts;
SELECT * FROM normalized_orders;
SELECT * FROM normalized_invoices;
SELECT * FROM normalized_payments;
SELECT * FROM normalized_expenses;

CREATE TABLE basic_financial_queries (
    transaction_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    transaction_type VARCHAR(30),
    transaction_date DATE,
    amount DECIMAL(12,2)
);
INSERT INTO basic_financial_queries
(transaction_id, customer_name, transaction_type, transaction_date, amount)
VALUES
(1, 'Rahul', 'Deposit', '2026-01-05', 25000.00),
(2, 'Priya', 'Withdrawal', '2026-01-08', 5000.00),
(3, 'Anu', 'Deposit', '2026-01-12', 30000.00),
(4, 'Kiran', 'Withdrawal', '2026-01-15', 8000.00),
(5, 'Sneha', 'Deposit', '2026-02-02', 45000.00),
(6, 'Rahul', 'Withdrawal', '2026-02-10', 10000.00),
(7, 'Priya', 'Deposit', '2026-02-18', 35000.00),
(8, 'Anu', 'Withdrawal', '2026-02-25', 7000.00),
(9, 'Kiran', 'Deposit', '2026-03-05', 28000.00),
(10, 'Sneha', 'Withdrawal', '2026-03-12', 6000.00);

SELECT * FROM basic_financial_queries;
SELECT *
FROM basic_financial_queries
WHERE transaction_type = 'Deposit';
SELECT *
FROM basic_financial_queries
WHERE amount > 9000;

SELECT *
FROM basic_financial_queries
WHERE transaction_date BETWEEN '2026-01-05' AND '2026-02-18';

SELECT *
FROM basic_financial_queries
ORDER BY amount DESC;

SELECT amount,
       COUNT(*) AS transaction_count,
       SUM(amount) AS total_amount,
       AVG(amount) AS average_amount
FROM basic_financial_queries
GROUP BY amount ;

SELECT transaction_id,
       customer_name,
       amount,
       CASE
           WHEN amount >= 8000 THEN 'High'
           WHEN amount >= 62000 THEN 'Medium'
           ELSE 'Low'
       END AS transaction_category
FROM basic_financial_queries;

CREATE TABLE customer_join_table (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);

INSERT INTO customer_join_table 
(customer_id, customer_name, city)
VALUES
(1, 'Rahul', 'Mangalore'),
(2, 'Ananya', 'Bangalore'),
(3, 'Arjun', 'Mysore'),
(4, 'Sneha', 'Udupi'),
(5, 'Kiran', 'Mangalore'),
(6, 'Priya', 'Bangalore'),
(7, 'Rohit', 'Kundapura'),
(8, 'Divya', 'Mysore'),
(9, 'Sanjay', 'Udupi'),
(10, 'Kavya', 'Bangalore');

SELECT * FROM customer_join_table;


CREATE TABLE sales_join_table (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    sale_date DATE,
    production VARCHAR(60),
    amount DECIMAL(12,2)
);

INSERT INTO sales_join_table
(sale_id, customer_id, sale_date, production, amount)
VALUES
(1, 1, '2026-01-05', 'Laptop', 55000.00),
(2, 2, '2026-01-08', 'Mobile Phone', 25000.00),
(3, 3, '2026-01-15', 'Tablet', 30000.00),
(4, 4, '2026-01-20', 'Laptop', 65000.00),
(5, 5, '2026-02-03', 'Monitor', 18000.00),
(6, 1, '2026-02-10', 'Keyboard', 2500.00),
(7, 2, '2026-02-18', 'Mouse', 1500.00),
(8, 3, '2026-02-25', 'Printer', 12000.00),
(9, 4, '2026-03-05', 'Laptop', 70000.00),
(10, 5, '2026-03-12', 'Headphones', 5000.00);

SELECT * FROM sales_join_table;


-- INNER JOIN
SELECT 
    c.customer_id,
    c.customer_name,
    c.city,
    s.sale_id,
    s.production,
    s.amount
FROM customer_join_table c
INNER JOIN sales_join_table s
ON c.customer_id = s.customer_id;


-- LEFT JOIN
SELECT 
    c.customer_id,
    c.customer_name,
    c.city,
    s.sale_id,
    s.production,
    s.amount
FROM customer_join_table c
LEFT JOIN sales_join_table s
ON c.customer_id = s.customer_id;


-- RIGHT JOIN
SELECT 
    c.customer_id,
    c.customer_name,
    c.city,
    s.sale_id,
    s.production,
    s.amount
FROM customer_join_table c
RIGHT JOIN sales_join_table s
ON c.customer_id = s.customer_id;

SELECT 
    c.customer_id,
    c.customer_name,
    COALESCE(SUM(s.amount), 0) AS total_sales
FROM customer_join_table c
LEFT JOIN sales_join_table s
ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.customer_name;

SELECT c.customer_name,
       o.order_id,
       o.order_amount,
       i.invoice_id,
       i.invoice_amount,
       p.payment_id,
       p.payment_amount
FROM normalized_customers c
JOIN normalized_orders o
    ON c.customer_id = o.customer_id
JOIN normalized_invoices i
    ON o.order_id = i.order_id
LEFT JOIN normalized_payments p
    ON i.invoice_id = p.invoice_id;
    
    
    
CREATE TABLE customer_view_table (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE invoice_view_table (
    invoice_id INT PRIMARY KEY,
    customer_id INT,
    invoice_amount DECIMAL(12,2),
    due_date DATE
);

CREATE TABLE payment_view_table (
    payment_id INT PRIMARY KEY,
    invoice_id INT,
    payment_amount DECIMAL(12,2),
    payment_date DATE
);

INSERT INTO customer_view_table
(customer_id, customer_name, city)
VALUES
(1, 'Rahul', 'Mangalore'),
(2, 'Ananya', 'Bangalore'),
(3, 'Arjun', 'Mysore'),
(4, 'Sneha', 'Udupi'),
(5, 'Kiran', 'Mangalore');

INSERT INTO invoice_view_table
(invoice_id, customer_id, invoice_amount, due_date)
VALUES
(101, 1, 55000.00, '2026-02-05'),
(102, 2, 25000.00, '2026-02-08'),
(103, 3, 30000.00, '2026-02-15'),
(104, 4, 65000.00, '2026-02-20'),
(105, 5, 18000.00, '2026-03-03');

INSERT INTO payment_view_table
(payment_id, invoice_id, payment_amount, payment_date)
VALUES
(2001, 101, 55000.00, '2026-02-01'),
(2002, 102, 15000.00, '2026-02-05'),
(2003, 103, 30000.00, '2026-02-10'),
(2004, 104, 50000.00, '2026-02-18'),
(2005, 105, 18000.00, '2026-02-28');

SELECT * FROM customer_view_table;

SELECT * FROM invoice_view_table;

SELECT * FROM payment_view_table;


CREATE OR REPLACE VIEW customer_balance_view AS
SELECT c.customer_id,
       c.customer_name,
       i.invoice_id,
       i.invoice_amount,
       COALESCE(SUM(p.payment_amount),0) AS paid_amount,
       i.invoice_amount - COALESCE(SUM(p.payment_amount),0) AS balance
FROM customer_view_table c
JOIN invoice_view_table i
    ON c.customer_id = i.customer_id
LEFT JOIN payment_view_table p
    ON i.invoice_id = p.invoice_id
GROUP BY c.customer_id, c.customer_name,
         i.invoice_id, i.invoice_amount;

SELECT * FROM customer_balance_view;

CREATE OR REPLACE VIEW overdue_balance_view AS
SELECT customer_id,
       invoice_id,
       invoice_amount
FROM invoice_view_table
WHERE invoice_amount > 1;

SELECT * FROM overdue_balance_view;






