use practice;
SELECT * FROM employees;
-- Q1. What is a Common Table Expression (CTE), and how does it improve SQL query readability?
-- A Common Table Expression (CTE) is a temporary, named result set in SQL that you define using the WITH clause and then reference within a single query
-- 1. Improves readability
-- CTEs let you break a complex query into logical, readable building blocks. Instead of nesting multiple subqueries, you give each step a clear name.

-- 2. Makes complex logic easier to maintain
-- You can understand the query faster
-- Changes are easier and safer
-- Debugging becomes simpler

-- 3. Allows reuse within the same query
-- A CTE can be referenced multiple times in the main query, avoiding repeated subqueries.

-- 4. Supports recursive queries
-- CTEs are especially powerful for hierarchical or tree-structured data (e.g., org charts, category trees) using recursive CTEs.

-- Q2. Why are some views updatable while others are read-only? Explain with an example.
-- Why some views are updatable
-- A view is generally updatable when:
-- It is based on a single table
-- It does not use:
                -- GROUP BY
                -- aggregate functions (SUM, COUNT, etc.)
                -- DISTINCT
                -- set operations
-- Example: Updatable view
CREATE VIEW IT_Employees AS
SELECT empid, firstname , lastname , dept_name
FROM employees
WHERE dept_name = 'IT';

UPDATE IT_Employees 
SET 
    dept_name = 'HR'
WHERE
    empid = 4;

-- Q3. What advantages do stored procedures offer compared to writing raw SQL queries repeatedly?
-- Advantages of Stored Procedures
-- 1. Improved performance
-- 2. Reusability and consistency
-- 3. Better maintainability
-- 4. Enhanced security
-- 5. Reduced network traffic
-- 6. Supports complex logic

-- Q4. What is the purpose of triggers in a database? Mention one use case where a trigger is essential
-- Purpose of triggers  
-- Triggers are mainly used to:
                         -- Enforce business rules automatically
							-- Logic runs no matter which application modifies the data.
                         -- Maintain data integrity
                            -- Ensure related data stays consistent after INSERT, UPDATE, or DELETE.
                         -- Audit and track changes
                            -- Record who changed what and when.
                         -- Automate side effects
                            -- Update related tables, send alerts, or calculate derived values.
                 
-- Q5 Explain the need for data modelling and normalization when designing a database.
-- Need for Data Modelling
-- Data modelling is the process of defining:
										-- What data is stored
										-- How entities relate to each other
                                        -- Rules and constraints on the data
-- Why data modelling is important
-- 1. Clear understanding of requirements
       -- It translates business requirements into entities, attributes, and relationships.
-- 2. Logical structure
      -- Helps identify tables, primary keys, foreign keys, and relationships early.

-- 3. Reduced ambiguity and errors
     -- Prevents missing data, redundant fields, and inconsistent interpretations.

-- 4. Foundation for database design
	 -- A good model (ER diagram) guides efficient table creation and queries.
     
-- Need for Normalization
-- Normalization is the process of organizing data to:
   -- Reduce redundancy
   -- Improve data integrity
   -- Eliminate update anomalies

-- Problems without normalization
   -- Insert anomaly – difficulty adding new data
   -- Update anomaly – same data must be updated in multiple places
   -- Delete anomaly – deleting one fact removes unrelated data     
   
-- How normalization helps
-- 1. Reduces data redundancy
      -- Avoids storing the same data repeatedly
	  -- Saves storage and reduces inconsistency
-- 2. Improves data integrity
      -- Ensures data depends on the key, the whole key, and nothing but the key
      -- Makes relationships explicit using foreign keys
-- 3. Makes maintenance easier
	  -- Changes are made in one place
	  -- Less risk of conflicting data   


CREATE TABLE products(productid int primary key ,
 productname varchar(100) ,
 category varchar(50) ,
 price decimal(10, 2)
);

INSERT INTO products VALUES
(1 , 'Keyboard' , 'Electronics' , 1200),
(2 , 'mouse' , 'Electronics' , 800),
(3 , 'chair' , 'furniture' , 2500),
(4 , 'desk' , 'furniture' , 5500);

CREATE TABLE sales
(saleid INT PRIMARY KEY ,
productid INT,
quantity INT ,
saledate DATE,
foreign key(productid) references products(productid)
);

INSERT INTO sales VALUES
(1 , 1 , 4 , '2024-01-05'),
(2 , 2 , 10 , '2024-01-06'),
(3 , 3 , 2 , '2024-01-10'),
(4 , 4 , 2 , '2024-01-11');


-- write a cte to calculate the total revenue the total revenue for each product 
-- (Revenues = Price × Quantity), and return only products where  revenue > 3000

WITH product_revenue AS(
SELECT s.productid , 
p.productname,
SUM(price * quantity) AS revenue
FROM sales s
JOIN products p 
ON s.productid = p. productid
GROUP  BY s.productid
)
SELECT 
productid ,
productname,
revenue
FROM product_revenue
WHERE revenue > 3000;

-- Q7. Create a view named vw_categorysummary that shows: Category, TotalProducts, AveragePrice.
CREATE VIEW vw_categorysummary  AS 
SELECT category , 
COUNT(productid) AS total_product,
AVG(price) AS  avg_price
FROM products 
GROUP BY category;

-- Q8. Create an updatable view containing ProductID, ProductName, and Price.  Then update the price of ProductID = 1 using the view
 CREATE VIEW product_price_view AS 
 SELECT Productid ,
 productname , 
 price 
 FROM products;
 
 -- update the price using view 
 UPDATE product_price_view
 SET price = 1500
 WHERE productid = 1;
 
 -- Q9. Create a stored procedure that accepts a category name and returns all products belonging to that category.

--  CREATE PROCEDURE getproductbycategory(
--  IN P_category VARCHAR(100)
--  )
--  BEGIN 
--  SELECT 
-- 		productid ,
--         productname ,
--         category ,
--         price
-- 	FROM products 
-- 	WHERE category = p_category;
--  END
-- CALL getproductbycategory('Electronics');-- 

CREATE TABLE productarchive (
    ProductID INT,
    ProductName VARCHAR(255),
    Category VARCHAR(255),
    Price DECIMAL(10,2),
    DeletedAt DATETIME
);

CREATE TRIGGER trg_products_after_delete
AFTER DELETE ON products
FOR EACH ROW
INSERT INTO productarchive (
    ProductID,
    ProductName,
    Category,
    Price,
    DeletedAt
)
VALUES (
    OLD.ProductID,
    OLD.ProductName,
    OLD.Category,
    OLD.Price,
    NOW()
);


