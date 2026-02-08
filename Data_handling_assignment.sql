-- Handling Missing Data In ETL Assignment--

-- Q1. What are the most common reasons for missing data in ETL pipelines?
-- 1. user error :- User did not filled form properly 
-- 2. system error :- Failed Api calls , faulty sensors 
-- 3. optional  fields :- users allow to skip fields which is not important
-- 4. human error :- mis-entries or typing error 

-- these are the main reasons for the missing data 

-- Q2. Why is blindly deleting rows with missing values considered a bad practice in ETL?
-- Deleting missing rows blindly cause damage data quality And it may cause bad impact on analysis
-- it may give error in analysis 
-- you may lose some important data you need 
-- you can mark them as missing or also you can fill in values only when some important data missing

-- Q3.Explain the difference between:
-- Listwise deletion :-
-- You remove an entire row if any value in that row is missing.
-- Ex :- If one column is empty, the whole record is dropped.
-- You can lose a lot of data very quickly, even when most of the row is complete.

-- Column deletion :-
-- You remove an entire column if it has too many missing values.
-- Ex :- If a field is mostly empty, you drop that field but keep all the rows.
-- You lose information about that specific feature, but the rest of the data stays intact.

-- Q4. Why is median imputation preferred over mean imputation for skewed data such as income?
-- Income is skewed: Most people earn around a typical range, but a few earn very high amounts.
-- in mean method there is more chance of outliers
-- The mean gets distorted: Those extreme high incomes pull the average up, so the mean doesn’t represent a “typical” person.

-- the median stays stable and also it gives realistic , typicle income
-- Better imputation: Filling missing values with the median keeps the data more representative and avoids inflating values.

-- Q5. What is forward fill and in what type of dataset is it most useful?
-- forward fill means replace a missing value with its last value which was just before
-- Ex :- if value is missing today , replace it with yesterday's value 
-- some examples :-
-- time series data where data change gradully over time
-- stock prices 
-- daily temreture 

-- in time based data the previous value is best until new value is available 

-- Q6.Why should flagging missing values be done before imputation in an ETL workflow?
-- 1.Missing at random :-
-- in real data values missing for a reasone , there are many reason due to which values may miss
-- A customer didn't provided income 
-- system failure

-- 2. diffrent missing mechanism need diffrent handling
-- MCAR – Missing Completely At Random
-- MAR – Missing At Random
-- MNAR – Missing Not At Random

-- 3.Prevents leakage and distortion in ML pipelines :-
-- If you impute without flags:- 
-- Models assume imputed values are “real”
-- Variance is reduced artificially
-- With flags :- 
-- Models can condition on missingness
-- You avoid learning misleading patterns from fake data

-- 4. ETL principle: never destroy raw signal
-- A good ETL rule of thumb:-
-- Transform, don’t erase

-- Flagging missing values :- 
-- Is reversible
-- Adds interpretability

-- 5. avoids confusion later :-
-- Analysts can decide to trust, ignore, or treat filled-in values differently if they know which ones were missing.

-- Q7. Consider a scenario where income is missing for many customers.
-- How can this missingness itself provide business insights?

-- some customers don't want to share their income 
-- they care about privacy or don't fully trust company

-- Certain types of customers skip the question :-
-- For example, students, new users, or people signing up online might leave it blank more often.

-- Something may be wrong with the process
-- The income question might be confusing, optional, or easy to skip.

-- Missing income can link to behavior
-- Customers who don’t share income may spend differently, churn faster, or respond less to offers.


-- SECTION B – PRACTICAL QUESTIONS
-- DATABASE CREATION 
CREATE DATABASE business_info;
USE business_info;

CREATE TABLE Customers (
    Customer_ID INT PRIMARY KEY,
    Name VARCHAR(50),
    City VARCHAR(50),
    Monthly_Sales INT,
    Income INT,
    Region VARCHAR(20)
);

INSERT INTO Customers (Customer_ID, Name, City, Monthly_Sales, Income, Region) VALUES
(101, 'Rahul Mehta', 'Mumbai', 12000, 65000, 'West'),
(102, 'Anjali Rao', 'Bengaluru', NULL, NULL, 'South'),
(103, 'Suresh Iyer', 'Chennai', 15000, 72000, 'South'),
(104, 'Neha Singh', 'Delhi', NULL, NULL, 'North'),
(105, 'Amit Verma', 'Pune', 18000, 58000, NULL),
(106, 'Karan Shah', 'Ahmedabad', NULL, 61000, 'West'),
(107, 'Pooja Das', 'Kolkata', 14000, NULL, 'East'),
(108, 'Riya Kapoor', 'Jaipur', 16000, 69000, 'North');

SELECT * FROM customers;
SET SQL_SAFE_UPDATES = 0;

-- Q8. Listwise Deletion 
-- Remove all rows where Region is missing.
DELETE FROM customers WHERE region IS NULL;

-- Q9. Imputation 
-- Handle missing values in Monthly_Sales using:
-- Forward Fill

SELECT 
customer_id ,
name,
city,
monthly_sales,
COALESCE(monthly_sales ,
LAG(monthly_sales)OVER(ORDER BY customer_id)) AS monthly_sales_forward ,
income,
region
FROM customers;

-- Q10. Flagging Missing Data

-- Create a flag column for missing Income.
-- Tasks:
-- Create Income_Missing_Flag (0 = present, 1 = missing)
-- Show updated dataset
-- Count how many customers have missing income

-- Create Income_Missing_Flag (0 = present, 1 = missing)
ALTER TABLE customers
ADD Income_missing_flag INT;

UPDATE customers
SET Income_missing_flag =
CASE WHEN income IS NULL THEN 1
ELSE 0
END;

-- Show updated dataset
SELECT * FROM customers;

-- Count how many customers have missing income
