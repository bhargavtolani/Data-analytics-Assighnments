
# question 1
create database company_db;
use company_db;
create table Employe (
employee_id int , 
first_name varchar(50),
last_name varchar(50),
department varchar(50),
salary int,
hire_date date);

use company_db;

# Question 2
insert into employe values (
101, "Amit" , "Sharma" , "HR" , 55000 , "2020-01-15");

insert into employe (employee_id , first_name , last_name , department , salary , hire_date) 
values (
102, "Riya" , "Kapoor" , "Sales" , 75000 , "2019-03-22"),
(
103, "Raj" , "Mehta" , "IT" , 90000 , "2018-07-11"),
(
104, "Neha" , "Verma" , "IT" , 85000 , "2021-09-01"),
(
105, "Arjun" , "Singh" , "Finance" , 60000 , "2022-02-10");

# Question 3
select * from employe order by salary;

# Question 4
select * from employe order by department asc , salary desc;

# Question 5
select * from employe where department = "IT" order by hire_date desc;

## question 6 

create table sales (
sale_id int ,
customer_name varchar(50),
amount int ,
sale_date date);
insert into sales (sale_id , customer_name , amount , sale_date)
values (
1 , "Aditi" , 1500 , "2024-08-01"),
 (
2 , "Rohan" , 2200 , "2024-08-03"),
 (
3 , "Aditi" , 3500 , "2024-09-05"),
 (
4 , "meena" , 2700 , "2024-09-15"),
 (
5, "Rohan" , 4500 , "2024-09-25");


## Question 7 
## . Display All Sales Records Sorted by Amount (Highest → Lowest)
select * from sales order by amount desc;

## Question 8
##Show All Sales Made by Customer “Aditi” 
select * from sales where customer_name = "aditi";

## question 9 
## A primary key uniquely identifies each record in a table
## Key characteristics:

# Must be unique for every row
# Cannot be NULL
# Each table has only one primary key

# Foreign Key :-
# A foreign key creates a relationship between two tables.
# Key characteristics:
# Can have duplicate values
# Can be NULL
# A table can have multiple foreign keys
# Refers to a primary key in another table


# question 10 
# What Are Constraints in SQL and Why Are They Used? 

# Constraints in SQL are rules applied to table columns that control what kind of data can be stored in a database.

#Why Are Constraints Used?
#Prevent invalid data from being entered
# Maintain data integrity
# Enforce business rules
# Reduce errors and improve data quality