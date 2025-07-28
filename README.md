# ☕ Coffee Sales Analysis Using SQL

**📊 Level:** Beginner  
**🗃️ Database:** `COFFEE_SQL_PROJECT`  
**👨‍💻 Author:** [nandeepalva468](https://github.com/nandeepalva468)

---

Welcome to the **Coffee Sales SQL Analysis** project! This project demonstrates how SQL can be applied to explore and analyze real-world coffee shop sales data. Perfect for beginner data analysts who want to practice SQL with hands-on examples. 📈

---

## 📥 Dataset

You can download the dataset from Kaggle or the GitHub repository:

🔗 [**Coffee Store Sales Dataset on Kaggle**](https://www.kaggle.com/datasets/reignrichard/coffee-store-sales?select=Coffe_sales.xlsx)

---

## 🎯 Objectives

- ✅ Create and populate the `coffee_sales` table  
- 🧹 Clean and preprocess raw sales data  
- 🔍 Perform exploratory data analysis (EDA)  
- 💡 Answer business-oriented questions using SQL queries

---

## 🧱 Database Structure

The project revolves around a single table `coffee_sales` with the following columns:

| Column Name     | Description                          |
|-----------------|--------------------------------------|
| `date`          | Sale date (`dd-mm-yyyy` format)      |
| `datetime`      | Full timestamp of the transaction    |
| `hour_of_day`   | Hour of the sale (0–23)              |
| `cash_type`     | Payment method (`Cash` or `Card`)    |
| `card`          | Anonymized card number               |
| `money`         | Transaction value (e.g., `R38.70`)   |
| `coffee_name`   | Type of coffee sold                  |
| `Time_of_Day`   | Time bucket (e.g., Morning, Evening) |
| `Weekday`       | Day of the week                      |
| `Month_name`    | Name of the month                    |
| `Weekdaysort`   | Weekday order (`1=Mon` ... `7=Sun`)  |
| `Monthsort`     | Month order (`1=Jan` ... `12=Dec`)   |

---

## 🧹 Data Cleaning
- Renames the ï»¿date column (caused by Excel export encoding) to date.

- Deletes any rows where crucial columns have NULL values to ensure accurate analysis.

```sql
-- Fix incorrect column encoding
ALTER TABLE COFFEE_SALES RENAME COLUMN ï»¿date TO date;

-- Remove rows with NULLs in critical columns
DELETE FROM COFFEE_SALES
WHERE date IS NULL OR datetime IS NULL OR hour_of_day IS NULL OR 
      cash_type IS NULL OR card IS NULL OR money IS NULL OR 
      coffee_name IS NULL OR Time_of_Day IS NULL OR Weekday IS NULL OR
      Month_name IS NULL OR Weekdaysort IS NULL OR Monthsort IS NULL;
```

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
### 5.Coffee Sales on a Specific Date
- Returns all sales that occurred on `March 1st, 2024`. This is helpful for analyzing specific-day trends or verifying daily transactions.
```sql
SELECT * FROM COFFEE_SALES
WHERE date='01-03-2024';
```
### 6.Latte Sales in March 2024
- Filters and displays all Latte sales between `March 1st and 31st, 2024`. Useful for product-specific trend analysis over time.
```sql
SELECT * FROM COFFEE_SALES
WHERE  coffee_name = 'Latte' AND 
DATE BETWEEN '01-03-2024' AND '31-03-2024';
```
### 7.Total sales per weekday
- Aggregates total revenue for each day of the week (Monday–Sunday), converting `money` values to numeric. Helps identify peak business days.
```sql
SELECT Weekday,
SUM(CAST(REPLACE(money, 'R', '') AS DECIMAL(10,2))) AS total_sale
FROM coffee_sales
GROUP BY Weekday
ORDER BY total_sale DESC;
```
### 8.Most popular coffee (by number of sales)
- `Counts` how many times each coffee type was sold. The one with the highest `count` is the most frequently ordered item.
```sql
SELECT coffee_name,
COUNT(*) AS total_orders
FROM coffee_sales
GROUP BY coffee_name
ORDER BY total_orders DESC;
```
### 9.Sales split by payment method (cash/card)
-  Shows how much revenue came from each payment method `Cash or Card`. Useful for finance and transaction tracking.
```sql
SELECT cash_type,
SUM(CAST(REPLACE(money, 'R', '') AS DECIMAL(10,2))) AS total_sale
FROM coffee_sales
GROUP BY cash_type;
```
### 10.Hourly sales distribution
- Shows how sales vary by hour (0 to 23). Helps identify `peak customer traffic hours` during the day.
```sql
SELECT hour_of_day,
SUM(CAST(REPLACE(money, 'R', '') AS DECIMAL(10,2))) AS total_sale
FROM coffee_sales
GROUP BY hour_of_day
ORDER BY hour_of_day;
```
### 11. Sales by time of day (Morning, Afternoon, etc.)
- Aggregates sales into general time buckets like `Morning, Afternoon, Evening`. Useful for scheduling and promotions.
```sql
SELECT Time_of_Day,
SUM(CAST(REPLACE(money, 'R', '') AS DECIMAL(10,2))) AS total_sale
FROM coffee_sales
GROUP BY Time_of_Day;
```
### 12. Monthly coffee sales trend
- Shows monthly sales trend in chronological order using `Monthsort`. Helps analyze seasonality or monthly performance.
```sql
SELECT Month_name,
SUM(CAST(REPLACE(money, 'R', '') AS DECIMAL(10,2))) AS total_sale
FROM coffee_sales
GROUP BY Month_name, Monthsort
ORDER BY Monthsort;
```
### 13. Top 3 best-selling coffees in terms of revenue
-  Ranks coffees by total revenue and returns the `top 3 performers`. Great for product strategy and pricing decisions.
```sql
SELECT coffee_name,
SUM(CAST(REPLACE(money, 'R', '') AS DECIMAL(10,2))) AS total_sale
FROM coffee_sales
GROUP BY coffee_name
ORDER BY total_sale DESC
LIMIT 3;
```


