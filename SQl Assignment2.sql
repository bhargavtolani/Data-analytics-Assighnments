use company_db;

create table employees (
Empid int ,
Empname varchar(50),
department varchar(50),
city varchar(20),
salary int,
hiredate date
);

insert into employees (Empid , Empname ,department , city , salary , hiredate) values
(101, "Rahul Mehta" ,"Sales" , "Delhi", 55000, "2020-04-12"),
(102 ,"priya sharma" , "HR" , "Mumbai" , 62000, "2019-09-25"),
(103 , "Aman singh" , "IT" , "Bengluru" , 72000 , "2021-03-10"),
(104 , "Neha patel" , "Sales" , "Delhi" , 48000 , "2022-01-14"),
(105 , "Karan joshi" , "Marketing" , "Pune" , 45000 , "2018-07-22"),
(106 , "Divya nair" , "IT" , "Chennai" , 81000 , "2019-12-11"),
(107 , "Raj kumar" , "HR" , "Delhi" , 60000 ,"2020-05-28"),
(108 , "simran kaur" , "finance" , "Mumbai" ,58000 , "2021-08-03"),
(109 , "Arjun pandey" , "IT", "Hydrabad" , 70000 , "2022-02-18" ),
(110 , "Anjali Das" , "Sales" , "Kolkata" , 51000 , "2023-01-15" );

## Question 1 : Show employees working in either the ‘IT’ or ‘HR’ departments
select * from employees where department = "IT" or department = "HR";

## Question 2 : Retrieve employees whose department is in ‘Sales’, ‘IT’, or ‘Finance’.
select * from employees where department = "sales" or department = "IT" or  department ="Finance";

## Question 3 Display employees whose salary is between ₹50,000 and ₹70,000.
select * from employees where salary between 50000 and 70000;

##Question 4 List employees whose names start with the letter ‘A’.
select * from employees where Empname like 'A%';

##Question 5 : Find employees whose names contain the substring ‘an’
SELECT * FROM employees WHERE empname LIKE '%an%';

## Question 6 : Show employees who are from ‘Delhi’ or ‘Mumbai’ and earn more than ₹55,000.
select * from employees where city = "Delhi" or city = "Mumbai" and salary >55000;

## Question 7 : Display all employees except those from the ‘HR’ department
select * from employees where not department = "Hr";

## Question 8 : Get all employees hired between 2019 and 2022, ordered by HireDate (oldest first).
select * from employees where hiredate between '2019-01-01' and '2022-12-31' order by hiredate asc;
