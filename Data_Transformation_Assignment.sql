-- Question 1 : Define Data Transformation in ETL and explain why it is important.
-- it is process the raw data into clean and structured data 
-- why data transformation is important ?
-- 1. Improve Data Quality :-
-- Removes duplicate records
-- Fixes missing or incorrect values

-- 2. Ensures Data Consistency :-
-- Standardizes formats and units

-- 3. Makes Data Ready for Analysis :-
-- Converts raw data into business-friendly format
-- Ex :- Calculating total_sales = quantity × price

-- 4. Integrates Data from Multiple Sources :-
-- Combines data from different systems into one format
-- Ex :- Customer data from CRM + Orders from ERP → One clean customer sales table.

-- 5. Improves Performance of Reporting & BI : 
-- Clean, structured data makes dashboards and reports faster and more accurate.


-- Question 2 : List any four common activities involved in Data Cleaning.
-- 1. Removing Duplicate Records :
-- it means it deletes repeated entries of same data because duplicate data can give wrong analysis

-- 2. Handling Missing Values : 
-- it means fix empty or null values 
-- Ex :- if city name is missing then fill it with 'unknown' or use a default value

-- 3. Correcting Inconsistent Data : 
-- Making data formats uniform.
-- Ex:- Mumbai, mumbai, MUMBAI → convert all to MUMBAI

-- 4. Validating and Correcting Wrong Data :
-- it means find incorrect data and fix it with valid values 
-- Ex :- Age should not be in negative , price should not be zero or negative

-- Question 3 : What is the difference between Normalization and Standardization? 
-- Basis          | **Normalization**                                        | **Standardization**                              |
-- ---------------| -------------------------------------------------------- | ------------------------------------------------ |
-- Meaning        | Scaling numerical data to a fixed range (usually 0 to 1) | Converting data into a common format or standard |
-- Main Purpose   | To bring values to a similar scale for analysis / ML     | To make data consistent across different formats |
-- Used For       | Numerical values (like age, salary, marks)               | Text, dates, categories, units, formats          |
-- Example        | Salary 50,000 → 0.5 (scaled value)                       | “mumbai”, “Mumbai” → “MUMBAI”                    |
-- Where Used     | Data preprocessing, machine learning, analytics          | Data cleaning in ETL, reporting, integration     |
-- Effect on Data | Changes the scale of numbers                             | Changes the format, not the meaning              |

-- Question 4 : A dataset has missing values in the “Age” column. Suggest two techniques to handle this and
-- explain when they should be used.

-- 1. Replace Missing Age with Mean/Median :-
-- fill missing Age column with mean / median 
-- Ex :-  if average age is 30 then replace null values with 30 in the age column 
-- it should use when only smaller number of values missing 

-- 2. Remove Records with Missing Age :-
-- Delete rows where age is NULL 
-- it should be used when few records of data is missing 
-- when age is not important for analysis

-- Question 5 : Convert the following inconsistent “Gender” entries into a standardized format (“Male”, “Female”):
-- ["M", "male", "F", "Female", "MALE", "f"]

-- Input :-["M", "male", "F", "Female", "MALE", "f"] 
-- standardized format : ["Male" , "Male" , "Female" , "Female" , "Male" , "Female"]

-- convert all variations (different cases and short forms) into one consistent format so that :-
-- Data is clean
-- No duplicate categories exist
-- Analysis and reporting become accurate


-- Question 6 : What is One-Hot Encoding? Give an example with the categories: “Red, Blue, Green”.
-- One-Hot Encoding is a data transformation technique used to convert categorical (text) values into numerical form so that machine learning models can understand them.
-- In one-hot encoding, each category becomes a separate binary column
-- 1 means the category is present
-- 0 means it is not

-- Ex :- 
-- If the color is Red, mark Red = 1, others = 0
-- If the color is Blue, mark Blue = 1, others = 0
-- If the color is Green, mark Green = 1, others = 0

-- Question 7 : Explain the difference between Data Integration and Data Mapping in ETL.
-- 1. Data Integration :- it means combining data from multiple sources into a single unified system 
-- bringing data from diffrent places into one place
-- Ex:- 
-- sales data from CRM 
-- customer data from MYSQL database
-- ALL are integrated into one place 

-- 2. Data Mapping :- Data Mapping means defining how fields/columns from source data match with fields in the target system.
-- Deciding which source column goes into which target column.
-- Ex:-
-- Source column: cust_name , Target column: customer_name
-- Source column: mob_no , Target column: phone_number

-- Question 8 : Explain why Z-score Standardization is preferred over Min-Max Scaling when outliers exist.
-- Problem with outliers:-
-- If there is a very large or very small value (outlier),
-- it stretches the range.
-- As a result, most normal values get squeezed into a very small range near 0.

-- Ex:- 18,20,24,25,95(outlier)
-- 95 is the max so all ages get very close to 0 This distorts the data distribution.

-- Z-score Standardization :-
-- z-score transforms data using :- Z = X - μ​ / σ
-- It scales data based on mean and standard deviation, not min and max.

-- Why it handles outliers better:
-- Outliers do affect mean and standard deviation,but they don’t compress the rest of the values into a tiny range.
-- relative position of normal values is better preserved.
-- Outliers remain visible as large positive/negative