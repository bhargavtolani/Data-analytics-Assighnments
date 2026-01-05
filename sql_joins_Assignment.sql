use company_db;
create table customers (customerid int , customername varchar(50), city varchar(50));

insert into customers (customerid , customername , city)
values 
(1 , "John smith" , "New york"),
(2 , "Mary Johnson" , "Chicago"),
(3 , "Peter Adams" , "Los Angeles"),
(4 , "Nancy Miller" , "Houston"),
(5 , "Robert White" , "Miami");

create table orders (orderid int , customerid int ,orderdate date , amount int);
insert into orders (orderid,customerid,orderdate,amount) values
(101 , 1 , "2024-10-01" , 250),
(102 , 2 , "2024-10-05" , 300),
(103 , 1 , "2024-10-7" , 150),
(104 , 3 , "2024-10-10" , 450),
(105 , 6 , "2024-10-12" , 400);

create table payments (paymenid int, customerid int, paymentdate date, amount int);
alter table payments modify paymenid varchar(10);


insert into payments (paymenid , customerid , paymentdate ,amount) values
("P001" , 1 , "2024-10-02" , 250),
("P002" , 2 , "2024-10-06" , 300),
("P003" , 3 , "2024-10-11" , 450),
("P004" , 4 , "2024-10-15" , 200);

create table employee (employeeid int , employeename varchar(50),managerid int);

insert into employee (employeeid , employeename , managerid) values
(1 , "Alex Green" , null),
(2 , "Brian Lee" , 1),
(3 , "Carol Ray" , 1),
(4 , "David Kim" , 2),
(5 , "Eva Smith" , 2);


## Question 1. Retrieve all customers who have placed at least one order.

select *
from customers c
where exists (
    select 1
    from orders o
    where o.customerid = c.customerid
);

## Question 2. Retrieve all customers and their orders, including customers who have not placed any orders
select * from customers c left join orders o on c.customerid = o.customerid;

## Question 3. Retrieve all orders and their corresponding customers, including orders placed by unknown customers.
select
orders.orderid,
orders.orderdate,
customers.customerid,
customers.customername
from orders
left join customers
on orders.customerid = customers.customerid;

## Question 4. Display all customers and orders, whether matched or not
select 
customers.customerid,
customers.customername,
orders.orderid,
orders.orderdate
from customers 
left join orders on customers.customerid = orders.customerid 
union
select customers.customerid,
customers.customername,
orders.orderid,
orders.orderdate
from customers
right join orders
on customers.customerid = orders.customerid;

##Question 5. Find customers who have not placed any orders
select c.* from customers c left join orders o on c.customerid = o.customerid where o.customerid is null;

## Question 6. Retrieve customers who made payments but did not place any orders 

select distinct c.* from customers c join payments p on c.customerid = p.customerid left join orders o 
on c.customerid = o.customerid where o.customerid is null;

## Question 7 Generate a list of all possible combinations between Customers and Orders
select c.customerid,
c.customername,
o.orderid,
o.orderdate
from customers c
cross join orders o;

## Question 8. Show all customers along with order and payment amounts in one table.	

select 
c.customerid,
c.customername,
coalesce(sum(distinct o.amount),0) as total_order_amount,
coalesce(sum(distinct p.amount),0) as total_payment_amount
from customers c
left join orders o
on c.customerid = o.customerid 
left join payments p
on c.customerid = p.customerid
group by
c.customerid,
c.customername;


## Question 9. Retrieve all customers who have both placed orders and made payments
select distinct c.customerid , c.customername
from customers c
inner join orders o 
on c.customerid = o.customerid
inner join payments p 
on c.customerid = p.customerid;
