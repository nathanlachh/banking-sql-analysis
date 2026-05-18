# Banking SQL Analysis

A comprehensive SQL analysis of a synthetic banking dataset containing 50,000 customers, 75,000 accounts, and 1 million transactions.

## Bank Summary
| Metric | Value |
|--------|-------|
| Total Customers | 50,000 |
| Total Accounts | 75,000 |
| Total Deposits | $7.49 billion |
| Total Loans | $4.51 billion |
| Total Transactions | 1,000,000 |
| Average Credit Score | 575 (Poor range) |

## Key Findings
- 25,355 customers fall into the Poor credit score band — the largest segment
- Smith Ltd is the top merchant by transaction volume at nearly $10 million
- Interest rates showed no significant variation across credit score bands (8.52%–8.57%)
- Michael Smith is the highest spending customer at $3.1 million in transactions
- Identified customers with loans but no credit card — potential upsell targets for the bank

### Questions Answered
**Single Table**
- Total customer count and account distribution by type
- Total loan amount issued and average interest rate
- Debit vs credit card breakdown
- Total and average transaction amount across 1 million transactions

**Joining Tables**
- Credit score segmentation across Poor, Fair, Good, and Excellent bands
- Top 10 customers by total account balance
- Top 10 customers by total loan amount and average interest rate
- Top 10 accounts by total transaction volume
- Top 10 merchants by total transaction value

**Multi Table Analysis**
- Credit card upsell targets (customers with loans but no card)
- Interest rate comparison across credit score bands
- Over-leveraged customers (total balance lower than total loans)
- Top 10 highest spending customers across all transactions
- Full bank executive summary in a single query

## Tools Used
- SQL / SQLite
- DB Browser for SQLite

## Dataset
Synthetic Banking Dataset from Kaggle — 6 tables including customers, accounts, 
loans, cards, transactions, and merchants.
