--Total Transactions by Customer
SELECT top 5 customer_id, COUNT(transaction_id) AS total_transactions
FROM transactions
GROUP BY customer_id
order by total_transactions desc

--Total Transactions by Product
SELECT top 15  product_id, COUNT(transaction_id) AS total_transactions
FROM transactions
GROUP BY product_id
ORDER BY total_transactions DESC;


--Total Transactions by Payment Method
SELECT  payment_method, COUNT(transaction_id) AS total_transactions
FROM transactions
GROUP BY payment_method
ORDER BY total_transactions DESC;

--Transactions Over a Certain Amount
SELECT *FROM transactions
WHERE amount > 4

--Total Amount by Customer for  Payment method
SELECT customer_id, SUM(amount) AS total_amount
FROM transactions
where payment_method='Gift'
GROUP BY customer_id;
--Transactions Within a Date Range
SELECT *FROM transactions
WHERE transaction_date BETWEEN '2023-01-01' AND '2023-12-31'
ORDER BY transaction_date


--Top Customers by Transactions for Specific Payment Methods
SELECT TOP 10 customer_id, COUNT(transaction_id) AS total_transactions
FROM transactions
WHERE payment_method = 'Debit Card' OR payment_method = 'Cash'
GROUP BY customer_id
ORDER BY total_transactions DESC;

--Transactions in the Last 30 Days
SELECT *FROM transactions
WHERE transaction_date >= DATEADD(day, -30, GETDATE())
ORDER BY transaction_date DESC;


--Monthly Transaction Count
SELECT YEAR(transaction_date) AS year, MONTH(transaction_date) AS month, COUNT(transaction_id) AS total_transactions
FROM transactions
GROUP BY YEAR(transaction_date), MONTH(transaction_date)
ORDER BY year, month;

--Monthly Total Amount
SELECT YEAR(transaction_date) AS year, MONTH(transaction_date) AS month, SUM(amount) AS total_amount
FROM transactions
GROUP BY YEAR(transaction_date), MONTH(transaction_date)
ORDER BY year, month;


