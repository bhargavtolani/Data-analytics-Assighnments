CREATE DATABASE Data_quality;
USE Data_quality;
-- Question 1 : Define Data Quality in the context of ETL pipelines. Why is it more than just data cleaning?
-- it ensures that the data provided for analysis or desicion making is trustworthy 

-- Why Data Quality Is More Than Just Data Cleaning
-- 1. It Starts Before Transformation:-
-- Verifying source reliability
-- Monitoring data drift

-- 2. It Involves Prevention, Not Just Correction
-- data cleaning fix many types of issues like remove duplicates , it can fill missing value
-- data quality includes :-
-- Implementing automated quality checks
-- Setting up monitoring and alerts
-- also it focus on preventing the bad data from entering system

-- 3. It Requires Governance and Standards
-- Data quality includes:-
-- Data ownership
-- Documentation
-- Cleaning alone does not address these structural aspects.

-- 4. It Is Continuous, Not One-Time
-- Data quality is an ongoing process involving:-
-- Monitoring pipelines
-- Quality metrics dashboards
-- Auditing and logging

-- Question 2 : Explain why poor data quality leads to misleading dashboards and incorrect decisions.
-- 1. Inaccurate data produces false insights :-
-- if data contains some error then dashboards will display incorrect insights 
-- Decision-makers may believe performance is improving or declining when it is not, leading to wrong strategic actions.

-- 2. Incomplete data hides the full picture:-
-- Missing values or partial data can distort trends and comparisons. 
-- Ex :- if some transactions are not recorded, revenue dashboards will underestimate actual performance
-- possibly leading to unnecessary cost-cutting. 

-- 3. Inconsistent data creates confusion :-
-- When data is recorded in different formats or definitions dashboards may show conflicting numbers.

-- 4. Duplicate data inflates metrics:-
-- 	Duplicate entries can artificially increase totals resulting in overestimated performance and unrealistic forecasts.

-- 5. Loss of trust in analytics:-
-- When users discover inconsistencies or errors they lose confidence in the dashboard.
-- As a result, they may ignore data-driven insights and revert to intuition-based decision-making.


-- Question 3 : What is duplicate data? Explain three causes in ETL pipelines.
-- 1. Data comes from different sources:-
-- If you collect data from many systemsthe same person or product might exist in more than one system.
-- If the ETL process does not check properly, it may load the same record twice.
 
-- 2. The system reloads old data:-
-- Sometimes ETL pipelines run daily or hourly.
-- If the system does not correctly track which data was already loaded, it may load the same data again, creating duplicates.

-- 3. No rules to stop duplicates:-
-- If the database does not have rules like a unique ID or primary key
-- it will allow the same record to be inserted many times.

-- Question 4 : Differentiate between exact, partial, and fuzzy duplicates.
-- 1. Exact Duplicates :-
-- these records are completely match with other record all data match with another data
-- Ex :- Two record with same name , same e-mail and same phone number
-- this is called exact match 

-- 2. Partial Duplicates:-
-- these record does not match completely but most of important information match 
-- Ex:-record 1 :- name :- yash , e-mail :- yash12@gmail , phone:- 9998712240
-- record 2 :- name :- yash , e-mail :- yash12@gmail , phone :- missing

-- 3. Fuzzy Duplicates :-
-- These records are slightly different due to spelling mistakes 
-- formatting changes, or small variations, but they represent the same entity.
-- Ex :- Record 1: Jon Smith, john@email.com
--       Record 2: John Smyth, john@email.com

-- Question 5 : Why should data validation be performed during transformation rather than after loading?
-- 1. Errors can be fixed early:-
-- If you check data during transformation, you can catch mistakes before they enter the final database.
-- Fixing problems early is easier and faster.

-- 2. Prevents bad data from entering the system:-
-- If validation is done only after loading, incorrect or incomplete data is already stored in the database.
-- This can affect reports, dashboards, and business decisions.

-- 3. Saves time and cost
-- Correcting data after it is loaded may require deleting, updating, or reloading records.
-- Validating during transformation avoids rework and reduces processing time.

-- 4. Improves data quality
-- Transformation is the stage where data is cleaned and standardized.
-- Validating at this step ensures only accurate and consistent data is loaded.


-- Question 6 : Explain how business rules help in validating data accuracy. Give an example.
-- How business rules help in validating data accuracy:-
-- 1. Ensure correct values :-
-- They check if the data falls within acceptable limits.

-- 2. Maintain consistency:-
-- They make sure related data makes sense together.

-- 3. Prevent invalid entries:- 
-- They stop wrong or unrealistic data from entering the system.

-- Ex:- A customer's age must be between 18 to 60
-- age = 15 invalid , age = 18 valid

-- If a form asks for an email address, the system can check that it includes “@”.

-- If someone places an order, the quantity must be more than 0.

CREATE TABLE Sales_Transactions (
    Txn_ID INT PRIMARY KEY,
    Customer_ID VARCHAR(10),
    Customer_Name VARCHAR(50),
    Product_ID VARCHAR(10),
    Quantity INT,
    Txn_Amount INT,
    Txn_Date DATE,
    City VARCHAR(50)
);

INSERT INTO Sales_Transactions VALUES
(201, 'C101', 'Rahul Mehta', 'P11', 2, 4000, '2025-12-01', 'Mumbai'),
(202, 'C102', 'Anjali Rao', 'P12', 1, 1500, '2025-12-01', 'Bengaluru'),
(203, 'C101', 'Rahul Mehta', 'P11', 2, 4000, '2025-12-01', 'Mumbai'),
(204, 'C103', 'Suresh Iyer', 'P13', 3, 6000, '2025-12-02', 'Chennai'),
(205, 'C104', 'Neha Singh', 'P14', NULL, 2500, '2025-12-02', 'Delhi'),
(206, 'C105', 'N/A', 'P15', 1, NULL, '2025-12-03', 'Pune'),
(207, 'C106', 'Amit Verma', 'P16', 1, 1800, NULL, 'Pune'),
(208, 'C101', 'Rahul Mehta', 'P11', 2, 4000, '2025-12-01', 'Mumbai');


-- Question 7 : Write an SQL query on to list all duplicate keys and their counts using the
-- business key (Customer_ID + Product_ID + Txn_Date + Txn_Amount )

SELECT 
    Customer_ID,
    Product_ID,
    Txn_Date,
    Txn_Amount,
    COUNT(*) AS Duplicate_Count
FROM Sales_Transactions
GROUP BY 
    Customer_ID,
    Product_ID,
    Txn_Date,
    Txn_Amount
HAVING COUNT(*) > 1;

CREATE TABLE Customers_Master (
    CustomerID VARCHAR(10) PRIMARY KEY,
    CustomerName VARCHAR(50),
    City VARCHAR(50)
);

INSERT INTO Customers_Master VALUES
('C101', 'Rahul Mehta', 'Mumbai'),
('C102', 'Anjali Rao', 'Bengaluru'),
('C103', 'Suresh Iyer', 'Chennai'),
('C104', 'Neha Singh', 'Delhi');

SELECT DISTINCT s.customer_ID FROM sales_transactions s
LEFT JOIN  Customers_Master c 
ON s.customer_ID = c.customerID
WHERE c.customerID IS NULL;

