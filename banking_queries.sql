-- Q1: Total number of customers
SELECT COUNT(*) FROM customers;

-- Q2: Account count and total balance by account type
SELECT account_type,
       COUNT(*) AS number_of_accounts,
       ROUND(SUM(balance_usd), 2) AS total_balance
FROM accounts
GROUP BY account_type;

-- Q3: Total loan amount and average interest rate
SELECT SUM(loan_amount) AS total_loans,
       ROUND(AVG(interest_rate), 2) AS avg_interest_rate
FROM loans;

-- Q4: Count of each card type
SELECT card_type,
       COUNT(*) AS number_of_cards
FROM cards
GROUP BY card_type;

-- Q5: Total and average transaction amount
SELECT SUM(amount_usd) AS total_transactions,
       ROUND(AVG(amount_usd), 2) AS avg_transaction
FROM transactions;

-- Q6: Customer count and average credit score by credit band
SELECT
    CASE
        WHEN credit_score < 580 THEN 'Poor'
        WHEN credit_score BETWEEN 580 AND 669 THEN 'Fair'
        WHEN credit_score BETWEEN 670 AND 739 THEN 'Good'
        ELSE 'Excellent'
    END AS credit_category,
    COUNT(customer_id) AS customer_count,
    ROUND(AVG(credit_score), 1) AS average_credit_score
FROM customers
GROUP BY credit_category;

-- Q7: Top 10 customers by total account balance
SELECT
    c.first_name,
    c.last_name,
    ROUND(SUM(a.balance_usd), 2) AS total_balance
FROM customers c
INNER JOIN accounts a ON c.customer_id = a.customer_id
GROUP BY c.first_name, c.last_name
ORDER BY total_balance DESC
LIMIT 10;

-- Q8: Total loan amount and average interest rate per customer
SELECT 
    c.first_name,
    c.last_name,
    ROUND(SUM(l.loan_amount), 2) AS total_loan,
    ROUND(AVG(l.interest_rate), 2) AS avg_interest
FROM customers c
INNER JOIN loans l ON c.customer_id = l.customer_id
GROUP BY c.first_name, c.last_name;

-- Q9: Top 10 accounts by total transaction volume
SELECT
    a.account_id,
    ROUND(SUM(t.amount_usd), 2) AS total_amount
FROM accounts a
INNER JOIN transactions t ON a.account_id = t.account_id
GROUP BY a.account_id
ORDER BY total_amount DESC
LIMIT 10;

-- Q10: Top 10 merchants by total transaction value
SELECT 
	m.merchant_id,
	m.merchant_name,
	SUM(t.amount_usd) AS total_amount
FROM merchants m
INNER JOIN transactions t
	ON m.merchant_id = t.merchant_id
GROUP BY m.merchant_id, m.merchant_name
ORDER BY total_amount DESC;

-- Q11: Find customers who have a loan but no card linked to any of their accounts. These are potential credit card upsell targets.

SELECT DISTINCT
	c.first_name,
	c.last_name
FROM customers c
INNER JOIN loans l ON c.customer_id = l.customer_id
INNER JOIN accounts a ON c.customer_id = a.customer_id
LEFT JOIN cards cd ON a.account_id = cd.account_id
WHERE cd.card_id IS NULL
LIMIT 10;

-- Q12: Do higher credit score customers get lower interest rates? Compare avg interest rate by credit score band.
SELECT
	CASE
	WHEN c.credit_score < 580 THEN 'Poor'
	WHEN c.credit_score BETWEEN 580 AND 669 THEN 'Fair'
	WHEN c.credit_score BETWEEN 670 AND 739 THEN 'Good'
	ELSE 'Excellent'
	END AS credit_category,
	ROUND(AVG(l.interest_rate),2) AS avg_interest
FROM customers c
INNER JOIN loans l ON c.customer_id = l.customer_id
GROUP BY  credit_category;
	
-- Q13: Which customers have a total balance lower than their total loan amount? (over-leveraged customers)
SELECT
	c.first_name,
	c.last_name,
	SUM(a.balance_usd) AS total_account_balance,
	SUM(l.loan_amount) AS total_loan_amount
FROM customers c
INNER JOIN accounts a ON c.customer_id = a.customer_id
INNER JOIN loans l ON c.customer_id = l.customer_id
GROUP BY c.first_name, c.last_name
HAVING total_account_balance < total_loan_amount;

-- Q14: Who are the top 10 highest spending customers by total transaction amount?
SELECT	
	c.first_name,
	c.last_name,
	SUM(t.amount_usd) AS total_transaction_amount
FROM customers c
INNER JOIN accounts a ON c.customer_id = a.customer_id
INNER JOIN transactions t ON a.account_id = t.account_id
GROUP BY  c.first_name, c.last_name
ORDER BY total_transaction_amount DESC
LIMIT 10;

-- Q15: Write a full bank summary: total customers, total accounts, total deposits (balance), total loans issued, total transactions processed, and average customer credit score — all in one query.
SELECT
	(SELECT COUNT(*) FROM customers) AS total_customers,
	(SELECT COUNT(*) FROM accounts) AS total_accounts,
	(SELECT ROUND(SUM(balance_usd),2) FROM accounts) AS total_deposits,
	(SELECT ROUND(SUM(loan_amount),2) FROM loans) AS total_loans,
	(SELECT COUNT(*) FROM transactions) AS total_transactions,
	(SELECT ROUND(AVG(credit_score),1) FROM customers) AS avg_credit_score;
	
	

