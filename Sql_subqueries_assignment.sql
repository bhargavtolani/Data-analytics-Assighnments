create database company_data;
use company_data;
create table employee (empid int , name varchar(30) , department_id varchar(10) , salary int);

insert into employee(empid , name , department_id , salary) values
(101 , 'Abhishek' , 'D01' , 62000),
(102 , 'Shubham' , 'D01' , 58000),
(103 , 'priya' , 'D02' , 67000),
(104 , 'rohit' , 'D02' , 64000),
(105 , 'neha' , 'D03' , 72000),
(106 , 'aman' , 'D03' , 55000),
(107 , 'ravi' , 'D04', 60000),
(108 , 'sneha' , 'D04', 75000),
(109 , 'kiran' , 'D05' , 70000),
(110 , 'tanuja' , 'D05' , 65000);  

create table department (department_id char(5) , department_name varchar(25) , location varchar(25));
insert into department (department_id , department_name , location) values
('D01' , 'sales' , 'mumbai'),
('D02' , 'marketing' , 'delhi'),
('D03' , 'finance' , 'pune'),
('D04' , 'hr' , 'bengluru'),
('D05' , 'it' , 'hyderabad');

create table sales (sale_id int , empid int ,sale_amount int , sale_date date);
insert into sales (sale_id , empid , sale_amount , sale_date) values
(201 , 101 , 4500 , '2025-01-05'),
(202 , 102 , 7800 , '2025-01-10'),
(203 , 103 , 6700 , '2025-01-14'),
(204 , 104 , 12000 , '2025-01-20'),
(205 , 105 , 9800 , '2025-02-02'),
(206 , 106 , 10500 , '2025-02-05'),
(207 , 107 , 3200 , '2025-02-09'),
(208 , 108 , 5100 , '2025-02-15'),
(209 , 109 , 3900 , '2025-02-20'),
(210 , 110 , 7200 , '2025-03-01');

-- Basic Level
-- 1.Retrieve the names of employees who earn more than the average salary of all employees 
select name  from employee where salary > (select avg(salary) from employee);

-- 2.Find the employees who belong to the department with the highest average salary. 

select e.* from employee e
where e.department_id = (
select d.department_id
from employee d
group by d.department_id
order by avg(d.salary) desc
limit 1
);

-- 3 List all employees who have made at least one sale.

select distinct e.name 
from employee e
join sales s 
on s.empid = e.empid;

-- 4 Find the employee with the highest sale amount.

select e.empid , name , sale_amount 
from employee e 
join sales s 
on e.empid = s.empid 
order by s.sale_amount desc
limit 1;

select  name , salary 
from employee 
where salary > (select salary 
from employee 
where name = 'shubham');

-- Intermediate Level

-- 1 Find employees who work in the same department as Abhishek.

select name 
from employee
where department_id = (
select department_id from employee
where name = 'Abhishek'
);

-- 2. List departments that have at least one employee earning more than ₹60,000.
select distinct d.department_id , d.department_name
from department d 
join employee e 
on d.department_id = e.department_id
where e.salary >60000;

-- 3 Find the department name of the employee who made the highest sale.

select d.department_name 
from department d 
join employee e 
on d.department_id = e.department_id
join sales s 
on e.empid = s.empid
order by s.sale_amount desc
limit 1 ;

-- 4 Retrieve employees who have made sales greater than the average sale amount. 
select distinct e.empid , e.name from employee e
join sales s 
on e.empid = s.empid
where s.sale_amount > (select avg(sale_amount)
from sales);

-- 5 Find the total sales made by employees who earn more than the average salary.
 
select sum(sale_amount) as tptal_sales
from employee e 
join sales s 
on e.empid = s.empid
where e.salary >(select avg(salary) from employee);

-- Advanced Level 

-- 1 Find employees who have not made any sales.

select e.empid , e.name from employee e 
join sales s 
on e.empid = s.empid 
where s.sale_id is null;

-- 2 List departments where the average salary is above ₹55,000.
select d.department_name , avg(salary) as avg_salary
from employee e 
join department d 
on e.department_id = d.department_id 
group by d.department_name
having avg(e.salary) > 55000;

-- 3. Retrieve department names where the total sales exceed ₹10,000.
select d.department_name , sum(sale_amount) as total_sales 
from sales s
join employee e 
on s.empid = e.empid
join department d 
on e.department_id = d.department_id
group by d.department_name 
having sum(sale_amount) > 10000;


-- 4 Find the employee who has made the second-highest sale.
select e.empid,name , sale_amount from sales s 
join employee e 
on s.empid = e.empid
order by sale_amount desc
limit 1 offset 1;

-- 5 Retrieve the names of employees whose salary is greater than the highest sale amount recorded.

select name from employee 
where salary > (
select max(sale_amount)
from sales
);