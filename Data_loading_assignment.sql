-- Dataset
-- Order_ID  Customer_ID  Sales_Amount  Order_Date
-- O101      C001		  4500          12-01-24
-- O102      C002         NULL			15-01-24
-- O103      C003		  3200			2024/01/18
-- O101      C001		  4500			12-01-24
-- O104      C004		Three Thousand  20-01-2024
-- O105      C005		5100 			25-01-2024

-- Q1. Data Understanding :-
-- This dataset have many issues that can cause problem during Data loading
-- 1. Duplicate Records - 
-- Order_ID O101 appears twice with identical data.
-- it can cause issue if order_id expected to be unique

-- 2.Missing values - 
-- sale amount for O102 is NULL
	
-- 3. Inconsistent Date Format - 
-- Most dates are in DD-MM-YYYY format (e.g., 12-01-2024).
-- One date is in YYYY/MM/DD format (2024/01/18).
-- Mixed formats can cause parsing failures during loading.

-- 4. Invalid Data Type in Sales_Amount -
-- Record O104 contains "Three Thousand" instead of a numeric value.
-- This will fail if the column expects numeric data. 

-- Primary Key Violation -
-- Since Order_ID is assumed to be the Primary Key, duplicates violate uniqueness constraints.

-- Q2. Primary Key Validation 
-- Assume Order_ID is the Primary Key
-- a) Is the dataset violating the Primary Key rule?
-- b) Which record(s) cause this violation?

-- a) Is the dataset violating the Primary Key rule?
-- Yes, it violates the Primary Key 
-- There is a duplicate value.

-- b) Which record(s) cause this violation?
-- Order_ID: O101
-- appers twice
-- same customer_id
-- same sale_amount
-- same order_date

-- Q3. Missing Value Analysis
-- Which column(s) contain missing values?
-- a) List the affected records
-- b) Explain why loading these records without handling missing values is risky

-- a) Which column(s) contain missing values?
-- Sales_Amount

-- b) Why is loading these records without handling missing values risky?
-- Aggregation Errors :-
-- total sales calculation will be incorrect
-- average may not be accurate

-- Q4. Data Type Validation
-- Identify records where Sales_Amount violates expected data type rules.
-- a) Which record(s) will fail numeric validation?
-- b) What would happen if this dataset is loaded into a SQL table with Sales_Amount as DECIMAL?

-- a) Which record(s) will fail numeric validation? :- 
-- invalid records in sale_amount :- 
-- O102 -> NULL
-- O104 -> Three Thousand

-- b) What happens if loaded into SQL with Sales_Amount DECIMAL?
-- 1. Three Thousand -> it will throw an error
-- 2. NULL -> its allowed if column permits NULL
-- it will throw an error if NOT NULL constraint exist
-- 3. Data load process may stop completely.

-- Q5. Date Format Consistency
-- a) Date formats present in the dataset:
-- 12-01-2024 
-- 2024/01/18
-- here dates are in diffrent formats
-- convert all dates into one format 

-- Q6. Load Readiness Decision
-- a) Should this dataset be loaded directly into the database?
-- dataset should not be loaded directly because cleaning is required 

-- b) Justification (at least 3 reasons):
-- there is sale_amount missing 
-- invalid numeric value (Three thousand)
-- primary key violation
-- diffrent date format

-- Q7. Pre-Load Validation Checklist
-- List the exact pre-load validation checks you would perform on this dataset before loading

-- 1.Structure Validation :-
-- Validate correct data types

-- 2. Primary Key Validation :-
-- ensure order_id is unique 
-- check for dupplicate records

-- 3. check missing values
--  validate NOT NULL constraints
-- Identify NULLs in mandatory columns

-- 4. Data Type Validation :-
-- Ensure Sales_amount is numeric
-- validate date column format

-- 5. Date Format Standardization Check
-- Detect mixed formats (DD-MM-YYYY, YYYY/MM/DD)
-- Validate valid calendar dates

-- 6.Range & Business Rule Validation
-- ensure sale_amount >0
-- check unrealstic values like it shoud not be negative

-- 7. Referential Integrity Check 
-- verify customer_id exists in customers table 
-- if customer_id exists in order table but not exist in customer table then it doesn't make sense

-- 8.Duplicate Record Detection 
-- check all duplicate values 

-- these are the steps which must be followed before loading the data

-- Q8. Cleaning Strategy
-- Describe the step-by-step cleaning actions required to make this dataset load-ready.

-- 1. remove duplicate 
-- firstly check all data and if there is any duplicate data remove them 

-- 2. fix missing sale_ampunt :-
-- for O102 -> NULL
-- Replace null value with correct value from source OR
-- reject record OR 
-- impute average or 0 

-- 3. Fix Invalid Numeric Value:-
-- Convert three thousand into numeric value -> 3000
-- if value unknown mark it as error and reject

-- 4. Diffrent date formats :-
-- Dates should be in one format only 
-- here dates are in diffrent formats
-- it can cause error in analysis

-- 5. Validate Data Types :-
-- Cast Sales_Amount → DECIMAL
-- Cast Order_Date → DATE

-- 6. Apply Business Rule Checks
-- Ensure Sales_Amount > 0

-- 7. Final Quality Check :-
-- Confirm no NULL in mandatory fields
-- confirm no duplicates

-- 8. into Staging Table First
-- Load into staging
-- Run validation queries
-- Then move to production table

-- Q9. Loading Strategy Selection
-- Assume this dataset represents daily sales data.
-- a) Should a Full Load or Incremental Load be used?
-- b) Justify your choice

-- a) Should a Full Load or Incremental Load be used? :-
-- Incremental Load

-- b) Justify your choice :-
-- Loading entire dataset daily increases processing time.
-- Incremental load improves performance.
-- Reduces database lock time.
-- Standard practice for transactional systems.
-- Minimizes risk of duplication (if handled correctly).

-- Q10. BI Impact Scenario
-- Assume this dataset was loaded without cleaning and connected to a BI dashboard.

-- a) What incorrect results might appear in Total Sales KPI?
-- b) Which records specifically would cause misleading insights?
-- c) Why would BI tools not detect these issues automatically?

-- a) What incorrect results might appear in Total Sales KPI? :-
-- 1. Inflated Total Sales :- Duplicate O101 counted twice.
-- 2. Underreported Sales :- NULL Sales_Amount ignored in SUM().
-- 3. Incorrect Sales Value :- "Three Thousand" might be treated as 0 or excluded.
-- 4. Wrong Daily Sales Trend :- Due to date parsing issues.

-- b) Which records cause misleading insights? :-
-- 1. Duplicate :- O101 appears twice
-- 2. Missing Sales:- O102 -> NULL
-- 3. Invalid Value:- O104 -> three thousand
-- 4.Mixed Date :- O103 → 2024/01/18

-- c) Why BI tools may not detect issues automatically?
-- BI tools assume data is already clean.
-- Duplicate records look valid unless flagged.
-- BI tools validate structure, not business logic.
-- No built-in duplicate detection unless explicitly modeled.