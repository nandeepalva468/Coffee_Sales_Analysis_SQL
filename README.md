# ☕ Coffee_Sales_Analysis_SQL

**Level:** Beginner  
**Database:** COFFEE_SQL_PROJECT  
**Author:** nandeepalva468

---

This project showcases how SQL can be used to explore and analyze coffee shop sales data. It covers everything from data cleaning and exploration to business-driven query analysis. It's perfect for beginner data analysts aiming to build SQL skills using real-world scenarios.

---

📥 **Dataset Download:**  
You can download the dataset from Kaggle or available in GitHub repo:  
🔗 [Coffee Store Sales Dataset](https://www.kaggle.com/datasets/reignrichard/coffee-store-sales?select=Coffe_sales.xlsx)

---
## 📌 Project Objectives

- **Set Up a Sales Database**: Create and populate a `coffee_sales` table.
- **Clean the Data**: Identify and handle missing or invalid records.
- **Perform Exploratory Data Analysis (EDA)**: Analyze time trends, product performance, and customer behavior.
- **Answer Business Questions**: Use SQL queries to drive sales insights.

---
## 🧱 Database Structure

A table named `coffee_sales` is created with the following columns:

| Column Name     | Description                     |
|-----------------|---------------------------------|
| date            | Sale date (dd-mm-yyyy format)   |
| datetime        | Full date-time of sale          |
| hour_of_day     | Hour of transaction             |
| cash_type       | Payment method (card/cash)      |
| card            | Anonymized card number          |
| money           | Transaction amount (e.g., R38.70)|
| coffee_name     | Type of coffee sold             |
| Time_of_Day     | Time bucket (Morning, etc.)     |
| Weekday         | Day of the week                 |
| Month_name      | Month name                      |
| Weekdaysort     | Weekday numeric order           |
| Monthsort       | Month numeric order             |

---
## 🔍 Data Cleaning & Preprocessing

- Removed `R` symbol from the `money` column and converted it to a numeric type.
- No null records were found in the initial exploration.
- Converted relevant time and date fields for easy grouping and analysis.

---
### 1. Database Setup

```sql
CREATE DATABASE COFFEE_SQL_PROJECT;
```
### 2. Table Creation
```sql
USE COFFEE_SQL_PROJECT;

CREATE TABLE COFFEE_SALES (
    date DATE,
    datetime DATETIME,
    hour_of_day INT,
    cash_type VARCHAR(50),
    card VARCHAR(50),
    money VARCHAR(20),
    coffee_name VARCHAR(100),
    Time_of_Day VARCHAR(50),
    Weekday VARCHAR(50),
    Month_name VARCHAR(50),
    Weekdaysort INT,
    Monthsort INT
);
```
### 3.Data Cleaning
```sql
-- Rename incorrectly encoded column
ALTER TABLE COFFEE_SALES RENAME COLUMN ï»¿date TO date;

-- Remove rows with NULLs in important fields
DELETE FROM COFFEE_SALES
WHERE date IS NULL OR datetime IS NULL OR hour_of_day IS NULL OR 
      cash_type IS NULL OR card IS NULL OR money IS NULL OR 
      coffee_name IS NULL OR Time_of_Day IS NULL OR Weekday IS NULL OR
      Month_name IS NULL OR Weekdaysort IS NULL OR Monthsort IS NULL;
```
### 4.Delete if there is an NULL
```sql
DELETE FROM COFFEE_SALES
WHERE date IS NULL OR datetime IS NULL OR hour_of_day IS NULL OR 
      cash_type IS NULL OR card IS NULL OR money IS NULL OR 
      coffee_name IS NULL OR Time_of_Day IS NULL OR Weekday IS NULL OR
      Month_name IS NULL OR Weekdaysort IS NULL OR Monthsort IS NULL;
```
### 5.Coffee sales on date 01-03-2024
```sql
SELECT * FROM COFFEE_SALES
WHERE date='01-03-2024';
```
### 6.Coffee sales where coffee name is LATTE and date between '01-03-2024' & '31-03-2024'
```sql
SELECT * FROM COFFEE_SALES
WHERE  coffee_name = 'Latte' AND 
DATE BETWEEN '01-03-2024' AND '31-03-2024';
```
### 7.Total sales per weekday
```sql
SELECT Weekday,
SUM(CAST(REPLACE(money, 'R', '') AS DECIMAL(10,2))) AS total_sale
FROM coffee_sales
GROUP BY Weekday
ORDER BY total_sale DESC;
```
### 8.Most popular coffee (by number of sales)
```sql
SELECT coffee_name,
COUNT(*) AS total_orders
FROM coffee_sales
GROUP BY coffee_name
ORDER BY total_orders DESC;
```
### 9.Sales split by payment method (cash/card)
```sql
SELECT cash_type,
SUM(CAST(REPLACE(money, 'R', '') AS DECIMAL(10,2))) AS total_sale
FROM coffee_sales
GROUP BY cash_type;
```
### 10.Hourly sales distribution
```sql
SELECT hour_of_day,
SUM(CAST(REPLACE(money, 'R', '') AS DECIMAL(10,2))) AS total_sale
FROM coffee_sales
GROUP BY hour_of_day
ORDER BY hour_of_day;
```
### 11. Sales by time of day (Morning, Afternoon, etc.)
```sql
SELECT Time_of_Day,
SUM(CAST(REPLACE(money, 'R', '') AS DECIMAL(10,2))) AS total_sale
FROM coffee_sales
GROUP BY Time_of_Day;
```
### 12. Monthly coffee sales trend
```sql
SELECT Month_name,
SUM(CAST(REPLACE(money, 'R', '') AS DECIMAL(10,2))) AS total_sale
FROM coffee_sales
GROUP BY Month_name, Monthsort
ORDER BY Monthsort;
```
### 13. Top 3 best-selling coffees in terms of revenue
```sql
SELECT coffee_name,
SUM(CAST(REPLACE(money, 'R', '') AS DECIMAL(10,2))) AS total_sale
FROM coffee_sales
GROUP BY coffee_name
ORDER BY total_sale DESC
LIMIT 3;
```


