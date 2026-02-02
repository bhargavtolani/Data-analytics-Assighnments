-- Question 1 : Describe different types of data sources used in ETL with suitable examples.
-- 1. Relational database - structured data stored in tables with rows and column
-- ex:- MYSQL , ORACLE , SQL SERVER

-- 2. Flat files - Data stored in simple formats.
-- ex:- CSV FILE , TEXT FILE

-- 3. Data warehouse - Centralized repositories designed for analytical processing.
-- ex:- Google Bigquery , Amazon Redshift , Snowflake

-- 4. APIS - Data is fetched from web-based services
-- ex:- REST APIs  , SOAP APIs

-- 5. Cloud storage - Data is stored in coloud based storage system 
-- ex:- Amazon web service , google cloud storage 

-- 6. noSQL database - Database is designed to store unstructured data
-- ex:- mongoDB , dynamoDB


-- Question 2 : What is data extraction? Explain its role in the ETL pipeline
-- Data extraction means taking the data from diffrent sources and bringing it into one place for further processing  
-- its the first step in the etl

-- role of data extraction in ETL 
-- 1. collects data : it collects data from various sources like database , excel or csv file  , website or APIs

-- 2. makes data ready for use :- extracted data is kept in temporary place for cleaning and transforming

-- 3.help in correct analysis :-if data is extracted correctly then analysis can be performed with high accuracy

-- Question 3 : Explain the difference between CSV and Excel in terms of extraction and ETL usage.


--  Feature                 | CSV File                        | Excel File                                 
--  ----------------------- | ------------------------------- | ------------------------------------------ 
--  **File type**           | Plain text file                 | Binary file (.xls, .xlsx)                  
--  **Structure**           | Simple rows and columns         | Can have multiple sheets, formulas, charts 
--  **Extraction**          | Very easy to extract            | Slightly complex to extract               
--  **ETL Performance**     | Faster to process               | Slower compared to CSV                    
--  **Formatting**          | No formatting (only data)       | Contains formatting, formulas, styles     
--  **Tools compatibility** | Works with almost all ETL tools | Needs Excel-specific connectors            
--  **File size**           | Smaller                         | Larger                                     

-- csv in ETL
-- CSV stores only raw data
-- easy for ETL tools to read 
-- best for large dataset

-- ex :- customer data exported from website as customer.csv

-- Excel in ETL
-- Can obtain multiple sheets
-- may include formats and formulas 
-- slower extraction if file is large 

-- Question 4 : Explain the steps involved in extracting data from a relational database.
-- 1 understand the data requirement
-- What data is needed?
-- From which tables?
-- Which columns are required?

-- 2.conect to the database 
-- Create a connection using:
						-- Database credentials (username, password)
						-- Database type (MySQL, Oracle, SQL Server, etc.)
						-- Hostname and port number
-- 3. Write SQL Query :
-- write the SQL query for to fetch the data according to the requirement

-- 4. Execute the Query :-
-- After writing the SQL query Execute the SQL query 

-- 5. Varify the Extracted Data 
-- After executing the SQL query now varify data like all data extracted ? is there any missing data ?
--  is there any dupplicate or missing values ?

-- 6. Store or Export the Data
-- after varifying the data store the data in form of csv files or excel files 

-- Question 5 : Explain three common challenges faced during data extraction

-- 1. Data Quality Issues :- The data you extract may be incomplete, wrong, duplicated, or in different formats.
-- ex : Some rows have NULL values in important columns like email or phone number.

-- 2. Data from Multiple Sources :- Data comes from diffrent system like database , excel files , APIs etc.
-- These Sources may not match structure	
-- EX :- Customer ID in one system is cust_id, but in another system it is customer_no.

-- 3.Performance & Large Data Volume : - Large amount of data can be loaded slowly and also it can affect performance of source system
-- Ex :- Extracting 10 million rows from a production database slows down the live website.

-- Question 6 : What are APIs? Explain how APIs help in real-time data extraction.
-- API stands for Application Programming Interface.
-- In simple words, an API is a bridge that allows one software application to talk to another and request data or services.

-- EX :- E-commerce Website:-
-- Fetch live product prices
-- Get latest orders
-- When a customer places an order, the system uses APIs to instantly update the inventory.

-- APIs make this possible because they:
-- Provide direct access to live systems
-- Return fresh data whenever you send a request
-- Can be called continuously or at short intervals

-- Ex 2: Weather App :-
-- Fetch live temperature
-- Show current weather conditions

-- Question 7 : Why are databases preferred for enterprise-level data extraction?

-- 1. Handle Large Amounts of Data :- Databases can handle large amount of data and enterprises deal in millions of data 
-- Example: A bank stores millions of transactions per day in database like oracle , MYSQL;
-- Databases are built to handle big data volumes smoothly.
 
-- 2. High Performance & Speed :- Databases use indexes, optimized queries (SQL), and partitions, which make data extraction fast even with large tables.
-- Ex :- An e-commerce company wants daily sales reports. Using SQL queries on a database can fetch filtered data  in seconds.
 
-- 3. Data Consistency & Accuracy :- Database  follow constraints 
-- PRIMARY KEYS , NOT NULL , FOREIGH KEYS , UNIQUE
-- These  clean and consistent data.

-- 4. Security & Access Control :-Enterprise databases provide strong security features
-- User roles , Permissions , Authentication
-- EX :- HR salary data can be accessed only by authorized users or ETL jobs, not by everyone.
-- This is critical for sensitive enterprise data.

-- 5.Easy Integration with ETL Tools :- Most ETL tools (Informatica, Talend, SSIS, Airflow, etc.) connect directly to databases using standard connectors.
-- Ex :-Connecting a MySQL database to a data warehouse like Snowflake for daily reporting.
-- atabases fit perfectly into enterprise ETL pipelines.

-- Question 8 : What steps should an ETL developer take when extracting data from large CSV files (1GB+)?
-- When CSV files are very large 1GB or more, extracting data the normal way can be slow.So ETL 
-- developers follow some smart practices to extract data safely and efficiently:

-- 1. Use Chunking :- Don’t load the full CSV into memory at once. Read it in small chunks
-- EX:- Instead of loading a 1GB file at once, read 100,000 rows at a time.

-- 2. Validate & Clean Data During Extraction :- Apply basic validation rules while reading the file:
-- Handle missing values , Fix wrong data types , Remove duplicate rows
-- Ex :- If the “amount” column has empty values or text like “N/A”, convert or flag them during extraction.

-- 3. Use Efficient File Formats :- If you control the source, convert large CSVs into compressed formats (gzip) or more efficient columnar formats (like Parquet) before extraction.
-- Ex :- Receiving daily logs as compressed CSV (.csv.gz) reduces file size and transfer time.

-- 4. Parallel Processing :- Split the CSV into multiple smaller files and process them in parallel.
-- EX :- Split a 1GB file into 4 files of 250MB and process them at the same time.

-- 5. Define Schema Explicitly :- Define column data types beforehand instead of letting the system guess.
-- Ex :- Specify:-
			    -- order_id → INT , order_date → DATE , amount → DECIMAL
                
-- 6. Monitor Performance & Handle Failures :- Log progress , Add checkpointing so the job can resume from where it failed
-- Ex :- If the job fails after processing 60% of the file, restart from that point instead of starting from zero.                