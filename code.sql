CREATE DATABASE COFFEE_SQL_PROJECT;

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

-- Rename incorrectly encoded column
ALTER TABLE COFFEE_SALES RENAME COLUMN ï»¿date TO date;

-- Remove rows with NULLs in important fields
DELETE FROM COFFEE_SALES
WHERE date IS NULL OR datetime IS NULL OR hour_of_day IS NULL OR 
      cash_type IS NULL OR card IS NULL OR money IS NULL OR 
      coffee_name IS NULL OR Time_of_Day IS NULL OR Weekday IS NULL OR
      Month_name IS NULL OR Weekdaysort IS NULL OR Monthsort IS NULL;

DELETE FROM COFFEE_SALES
WHERE date IS NULL OR datetime IS NULL OR hour_of_day IS NULL OR 
      cash_type IS NULL OR card IS NULL OR money IS NULL OR 
      coffee_name IS NULL OR Time_of_Day IS NULL OR Weekday IS NULL OR
      Month_name IS NULL OR Weekdaysort IS NULL OR Monthsort IS NULL;

SELECT * FROM COFFEE_SALES
WHERE date='01-03-2024';

SELECT * FROM COFFEE_SALES
WHERE  coffee_name = 'Latte' AND 
DATE BETWEEN '01-03-2024' AND '31-03-2024';

SELECT Weekday,
SUM(CAST(REPLACE(money, 'R', '') AS DECIMAL(10,2))) AS total_sale
FROM coffee_sales
GROUP BY Weekday
ORDER BY total_sale DESC;

SELECT coffee_name,
COUNT(*) AS total_orders
FROM coffee_sales
GROUP BY coffee_name
ORDER BY total_orders DESC;

SELECT cash_type,
SUM(CAST(REPLACE(money, 'R', '') AS DECIMAL(10,2))) AS total_sale
FROM coffee_sales
GROUP BY cash_type;

SELECT hour_of_day,
SUM(CAST(REPLACE(money, 'R', '') AS DECIMAL(10,2))) AS total_sale
FROM coffee_sales
GROUP BY hour_of_day
ORDER BY hour_of_day;

SELECT Time_of_Day,
SUM(CAST(REPLACE(money, 'R', '') AS DECIMAL(10,2))) AS total_sale
FROM coffee_sales
GROUP BY Time_of_Day;

SELECT Month_name,
SUM(CAST(REPLACE(money, 'R', '') AS DECIMAL(10,2))) AS total_sale
FROM coffee_sales
GROUP BY Month_name, Monthsort
ORDER BY Monthsort;

SELECT coffee_name,
SUM(CAST(REPLACE(money, 'R', '') AS DECIMAL(10,2))) AS total_sale
FROM coffee_sales
GROUP BY coffee_name
ORDER BY total_sale DESC
LIMIT 3;