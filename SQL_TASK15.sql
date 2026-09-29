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
CREATE TABLE customer_subquery_table (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    total_sales DECIMAL(12,2)
);

INSERT INTO customer_subquery_table
(customer_id, customer_name, city, total_sales)
VALUES
(1, 'Rahul', 'Mangalore', 75000.00),
(2, 'Priya', 'Bangalore', 92000.00),
(3, 'Anu', 'Mysore', 58000.00),
(4, 'Kiran', 'Udupi', 45000.00),
(5, 'Sneha', 'Mangalore', 88000.00),
(6, 'Arjun', 'Bangalore', 67000.00),
(7, 'Divya', 'Chennai', 105000.00),
(8, 'Rohit', 'Mysore', 52000.00),
(9, 'Pooja', 'Udupi', 81000.00),
(10, 'Vivek', 'Chennai', 63000.00);
 
SELECT *
FROM customer_subquery_table
WHERE total_sales > (
    SELECT AVG(total_sales)
    FROM customer_subquery_table
);
SELECT *
FROM customer_subquery_table
WHERE total_sales = (
    SELECT MAX(total_sales)
    FROM customer_subquery_table
);
CREATE TABLE customer_cte_table (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    month_name VARCHAR(20),
    sales DECIMAL(12,2),
    expenses DECIMAL(12,2)
);
INSERT INTO customer_cte_table
(customer_id, customer_name, month_name, sales, expenses)
VALUES
(1, 'Rahul', 'January', 55000, 32000),
(2, 'Rahul', 'February', 48000, 27000),
(3, 'Rahul', 'March', 62000, 30000),
(4, 'Priya', 'January', 68000, 34000),
(5, 'Priya', 'February', 75000, 38000),
(6, 'Priya', 'March', 79000, 40000),
(7, 'Arjun', 'January', 72000, 36000),
(8, 'Arjun', 'February', 69000, 33000),
(9, 'Arjun', 'March', 85000, 44000);
SELECT *
FROM customer_cte_table;
WITH customer_profit_cte AS (
    SELECT
        customer_id,
        customer_name,
        month_name,
        sales,
        expenses,
        sales - expenses AS profit
    FROM customer_cte_table
)
SELECT *
FROM customer_profit_cte
ORDER BY profit DESC;
WITH sales_cte AS (
    SELECT
        customer_id,
        SUM(sales) AS total_sales
    FROM customer_cte_table
    GROUP BY customer_id
),
expense_cte AS (
    SELECT
        customer_id,
        SUM(expenses) AS total_expenses
    FROM customer_cte_table
    GROUP BY customer_id
),
customer_names AS (
    SELECT DISTINCT
        customer_id,
        customer_name
    FROM customer_cte_table
)
SELECT
    s.customer_id,
    c.customer_name,
    s.total_sales,
    e.total_expenses,
    s.total_sales - e.total_expenses AS profit
FROM sales_cte s
JOIN expense_cte e
    ON s.customer_id = e.customer_id
JOIN customer_names c
    ON s.customer_id = c.customer_id
ORDER BY profit DESC;
CREATE TABLE customer_window_table (
                                       sale_month DATE, 
                                     customer_name VARCHAR(50),
                                     sales DECIMAL(12,2) );
INSERT INTO customer_window_table
(sale_month, customer_name, sales)
VALUES
('2025-01-01', 'Amit', 95000),
('2025-02-01', 'Neha', 115000),
('2025-03-01', 'Amit', 125000),
('2025-04-01', 'Kavya', 135000),
('2025-05-01', 'Neha', 145000),
('2025-06-01', 'Amit', 130000),
('2025-07-01', 'Kavya', 155000),
('2025-08-01', 'Neha', 165000),
('2025-09-01', 'Amit', 150000),
('2025-10-01', 'Kavya', 175000),
('2025-11-01', 'Neha', 180000),
('2025-12-01', 'Amit', 160000);
SELECT *
FROM customer_window_table
ORDER BY sale_month;
 SELECT 
    sale_month,
    customer_name,
    sales,
    RANK() OVER (ORDER BY sales DESC) AS sales_rank
FROM customer_window_table;
SELECT 
    sale_month,
    customer_name,
    sales,
    LEAD(sales) OVER (ORDER BY sale_month) AS next_month_sales
FROM customer_window_table;
SELECT 
    sale_month,
    customer_name,
    sales,
    LEAD(sales, 12) OVER (ORDER BY sale_month) AS next_year_sales
FROM customer_window_table;
WITH yearly_sales AS (
    SELECT 
        sale_month,
        customer_name,
        sales,
        LAG(sales, 12) OVER (
            ORDER BY sale_month
        ) AS previous_year_sales
    FROM customer_window_table
)
SELECT 
    sale_month,
    customer_name,
    sales,
    previous_year_sales,
    ((sales - previous_year_sales) / previous_year_sales) * 100
        AS yoy_growth
FROM yearly_sales;
CREATE TABLE financial_procedure_table (
id INT PRIMARY KEY,
customer_name VARCHAR(50),
month_name VARCHAR(20),
sales DECIMAL(10,2),
expenses DECIMAL(10,2),
tax_rate DECIMAL(5,2)
);

INSERT INTO financial_procedure_table
(id, customer_name, month_name, sales, expenses, tax_rate)
VALUES
(1, 'Vikram', 'January', 48000, 26000, 7),
(2, 'Meera', 'January', 72000, 41000, 12),
(3, 'Sanjay', 'January', 55000, 30000, 9),
(4, 'Vikram', 'February', 62000, 34000, 7),
(5, 'Meera', 'February', 80000, 45000, 12),
(6, 'Sanjay', 'February', 59000, 32000, 9),
(7, 'Vikram', 'March', 70000, 38000, 7),
(8, 'Meera', 'March', 85000, 47000, 12),
(9, 'Sanjay', 'March', 65000, 35000, 9);
select *from financial_procedure_table;
 DELIMITER //
CREATE PROCEDURE calculate_tax(
IN p_sales DECIMAL(10,2),
IN p_tax_rate DECIMAL(10,2)
)
BEGIN
SELECT
    p_sales AS sales,
    p_tax_rate AS tax_rate,
    (p_sales * p_tax_rate) / 100 AS tax_amount;
END //
DELIMITER ;
-- Test the procedure
CALL calculate_tax(50000, 3);
CALL calculate_tax(22000, 5);
 CREATE TABLE Customers_SECURITY_FEATURES ( Customer_ID INT PRIMARY KEY, Customer_Name VARCHAR(100) NOT NULL, Email VARCHAR(100) );

CREATE TABLE Customers_SECURITY_FEATURES (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100)
);
INSERT INTO Customers_SECURITY_FEATURES
(Customer_ID, Customer_Name, Email)
VALUES
(1, 'Amit Sharma', 'amit@gmail.com'),
(2, 'Neha Patel', 'neha@gmail.com'),
(3, 'Kavya Rao', 'kavya@gmail.com'),
(4, 'Vikram Singh', 'vikram@gmail.com'),
(5, 'Meera Nair', 'meera@gmail.com');
CREATE TABLE Transactions_SECURITY_FEATURES (
    Transaction_ID INT PRIMARY KEY,
    Customer_ID INT,
    Amount DECIMAL(10,2),
    TransactionDate DATE,
    FOREIGN KEY (Customer_ID)
        REFERENCES Customers_SECURITY_FEATURES(Customer_ID)
);
INSERT INTO Transactions_SECURITY_FEATURES
(Transaction_ID, Customer_ID, Amount, TransactionDate)
VALUES
(101, 1, 25000.00, '2026-01-10'),
(102, 2, 18500.00, '2026-01-15'),
(103, 3, 42000.00, '2026-02-05'),
(104, 4, 31500.00, '2026-02-18'),
(105, 5, 27500.00, '2026-03-02'),
(106, 1, 15000.00, '2026-03-12'),
(107, 3, 38000.00, '2026-03-25');
CREATE TABLE Salaries_SECURITY_FEATURES (
    Employee_ID INT PRIMARY KEY,
    Employee_Name VARCHAR(100) NOT NULL,
    Salary DECIMAL(10,2)
);
INSERT INTO Salaries_SECURITY_FEATURES
(Employee_ID, Employee_Name, Salary)
VALUES
(201, 'Arjun Kumar', 45000.00),
(202, 'Pooja Shetty', 52000.00),
(203, 'Rohan Das', 48000.00),
(204, 'Divya Rao', 60000.00),
(205, 'Kiran Joshi', 55000.00);
CREATE USER IF NOT EXISTS 'finance_app'@'localhost'
IDENTIFIED BY 'FinanceApp@123';

CREATE USER IF NOT EXISTS 'finance_report'@'localhost'
IDENTIFIED BY 'FinanceReport@123';



ON complete_financial_db_project.*
TO 'finance_app'@'localhost';


GRANT SELECT
ON complete_financial_db_project.*
TO 'finance_report'@'localhost';


REVOKE INSERT
ON complete_financial_db_project.*
FROM 'finance_report'@'localhost';


SHOW GRANTS FOR 'finance_app'@'localhost';

SHOW GRANTS FOR 'finance_report'@'localhost';
 CREATE TABLE transaction_records (
    transaction_id INT PRIMARY KEY,
    account_name VARCHAR(90),
    transaction_type VARCHAR(60),
    amount DECIMAL(10,2),
    transaction_date DATE
);


INSERT INTO transaction_records
(transaction_id, account_name, transaction_type, amount, transaction_date)
VALUES
(101, 'Main Cash Account', 'Deposit', 7500.00, '2026-01-12'),
(102, 'Business Bank', 'Withdrawal', 4200.00, '2026-02-18'),
(103, 'Sales Revenue', 'Credit', 9500.00, '2026-03-15');



CREATE TABLE transaction_audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    transaction_id INT,
    account_name VARCHAR(90),
    transaction_type VARCHAR(60),
    amount DECIMAL(10,2),
    action_type VARCHAR(70),
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


DELIMITER //

CREATE TRIGGER after_transaction_records_insert
AFTER INSERT ON transaction_records
FOR EACH ROW
BEGIN
    INSERT INTO transaction_audit
    (transaction_id, account_name, transaction_type, amount, action_type)
    VALUES
    (NEW.transaction_id,
     NEW.account_name,
     NEW.transaction_type,
     NEW.amount,
     'INSERT');
END //
INSERT INTO transaction_records
(transaction_id, account_name, transaction_type, amount, transaction_date)
VALUES
(104, 'Office Expenses', 'Debit', 6800.00, '2026-04-20');

SELECT * FROM transaction_audit;  
DELIMITER //

CREATE TRIGGER after_transaction_records_update
AFTER UPDATE ON transaction_records
FOR EACH ROW
BEGIN
    INSERT INTO transaction_audit
    (transaction_id, account_name, transaction_type, amount, action_type)
    VALUES
    (NEW.transaction_id,
     NEW.account_name,
     NEW.transaction_type,
     NEW.amount,
     'UPDATE');
END //

DELIMITER ;


UPDATE transaction_records
SET amount = 12500.00
WHERE transaction_id = 102;

SELECT * FROM transaction_audit;  



DELIMITER //

CREATE TRIGGER after_transaction_records_delete
AFTER DELETE ON transaction_records
FOR EACH ROW
BEGIN
    INSERT INTO transaction_audit
    (transaction_id, account_name, transaction_type, amount, action_type)
    VALUES
    (OLD.transaction_id,
     OLD.account_name,
     OLD.transaction_type,
     OLD.amount,
     'DELETE');
END //

DELIMITER ;



DELETE FROM transaction_records
WHERE transaction_id = 104;

SELECT * FROM transaction_audit;
DROP TABLE IF EXISTS financial_summary_report;

CREATE TABLE financial_summary_report (
    report_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    report_date DATE,
    revenue DECIMAL(12,2),
    expenses DECIMAL(12,2),
    tax_amount DECIMAL(12,2),
    total_assets DECIMAL(12,2),
    total_liabilities DECIMAL(12,2),
    accounts_receivable DECIMAL(12,2),
    accounts_payable DECIMAL(12,2),
    net_profit DECIMAL(12,2),
    profit_margin DECIMAL(6,2)
);


INSERT INTO financial_summary_report
(
    report_id,
    customer_name,
    report_date,
    revenue,
    expenses,
    tax_amount,
    total_assets,
    total_liabilities,
    accounts_receivable,
    accounts_payable,
    net_profit,
    profit_margin
)
VALUES
(1, 'Amit', '2026-01-31', 90000.00, 52000.00, 7600.00, 270000.00, 95000.00, 20000.00, 13000.00, 30400.00, 33.78),

(2, 'Neha', '2026-01-31', 78000.00, 45000.00, 6600.00, 230000.00, 78000.00, 16000.00, 11000.00, 26400.00, 33.85),

(3, 'Kavya', '2026-01-31', 68000.00, 41000.00, 5400.00, 195000.00, 68000.00, 13000.00, 9000.00, 21600.00, 31.76),

(4, 'Amit', '2026-02-28', 95000.00, 56000.00, 7800.00, 285000.00, 99000.00, 22000.00, 15000.00, 31200.00, 32.84),

(5, 'Neha', '2026-02-28', 82000.00, 47000.00, 7000.00, 245000.00, 82000.00, 18000.00, 12000.00, 28000.00, 34.15),

(6, 'Kavya', '2026-02-28', 73000.00, 44000.00, 5800.00, 210000.00, 72000.00, 15000.00, 10000.00, 23200.00, 31.78),

(7, 'Amit', '2026-03-31', 102000.00, 60000.00, 8400.00, 300000.00, 102000.00, 24000.00, 16000.00, 33600.00, 32.94),

(8, 'Neha', '2026-03-31', 88000.00, 50000.00, 7500.00, 260000.00, 87000.00, 20000.00, 13000.00, 30500.00, 34.66),

(9, 'Kavya', '2026-03-31', 79000.00, 46000.00, 6200.00, 220000.00, 75000.00, 16000.00, 10500.00, 26800.00, 33.92);



SELECT *
FROM financial_summary_report;
 



SELECT
    AVG(revenue) AS average_revenue,
    AVG(expenses) AS average_expenses,
    AVG(net_profit) AS average_net_profit,
    AVG(profit_margin) AS average_profit_margin
FROM financial_summary_report;
 


SELECT
    SUM(revenue) AS total_revenue,
    SUM(expenses) AS total_expenses,
    SUM(tax_amount) AS total_tax,
    SUM(net_profit) AS total_net_profit
FROM financial_summary_report;
 

SELECT
    SUM(revenue) AS total_revenue,
    SUM(expenses) AS total_expenses,
    SUM(tax_amount) AS total_tax,
    SUM(net_profit) AS total_net_profit,
    SUM(total_assets) AS total_assets,
    SUM(total_liabilities) AS total_liabilities,
    SUM(accounts_receivable) AS total_receivables,
    SUM(accounts_payable) AS total_payables,
    ROUND(
        (SUM(net_profit) / SUM(revenue)) * 100,
        2
    ) AS overall_profit_margin
FROM financial_summary_report;
 


 



 









