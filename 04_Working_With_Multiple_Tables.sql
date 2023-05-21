--PRACTICE FROM PRESENTATION


--1. Create a report showing the first and last name of all sales representatives who are from  Seattle or Redmond.    

select e.first_name
	,e.last_name
	,e.city 
from employees as e
where e.city in ('Seattle', 'Redmond')


--2. Create a report that shows the company name, contact title, city and country of all  customers in Mexico or in any city in Spain except Madrid.

select c.company_name
	,c.contact_title
	,c.city
	,country
from customers as c
where c.country in ('Mexico', 'Spain') and c.city <> 'Madrid' 

-- 1. Show first and last names of the employees as well as the count of orders each of them have received during the year 1997.

select e.first_name 
	,e.last_name
	--,o.order_id
	--,o.order_date
	,count(o.order_id) as count_of_orders 
from employees as e
left outer  join orders as o
	on e.employee_id = o.employee_id
where extract(year from o.order_date) = 1997
group by e.last_name, e.first_name 
order by e.last_name 

-- 2. Show first and last names of the employees as well as the count of their orders shipped after required date during the year 1997.

select e.first_name
	,e.last_name
	,count(o.order_id) as count_orders_shipped
from employees as e
left outer join orders as o
	on e.employee_id = o.employee_id
where extract(year from o.order_date) = 1997 and o.shipped_date > o.required_date 
group by e.last_name, e.first_name  


-- 3. Create a report showing the information about employees and orders, whenever they had orders or not

select e.last_name
	,e.first_name
	,o.order_id
from employees as e
left outer join orders as o
	on e.employee_id = o.employee_id
order by e.last_name 

-- 1. Show the list of French customers’ names who used to order non-French products.

select c.contact_name
--	,c.country
--	,o.order_id
	,s.country as made_in
from customers as c
right outer join orders as o 
	on c.customer_id = o.customer_id
join order_details as od
	on o.order_id = od.order_id
join products as p
	on od.product_id = p.product_id
join suppliers as s
	on p.supplier_id = s.supplier_id
where c.country = 'France' and s.country <> 'France'


-- 2. Show the list of suppliers, products and its category.

select s.company_name
	,p.product_name
	,ca.category_name 
from suppliers as s
right outer join products as p
	on s.supplier_id = p.supplier_id
join categories as ca
	on p.category_id = ca.category_id 
order by s.company_name
	
-- 3. Create a report that shows all information about suppliers and products.

select *
from suppliers as s
right outer join products p
	on s.supplier_id = p.supplier_id
	
--Tasks from Muddle
	
--Task 1

--Here’s a data model of the relationship between Products and Suppliers.
--We’d like to show, for each product, the associated Supplier from Germany and Spain. Show the ProductID, ProductName, and the CompanyName of the Supplier. Sort by ProductID.
--Note. The Join clause is used to join two or more relational database tables together in a logical way.
	
select p.ProductID
    ,p.ProductName
    ,s.CompanyName
from Products as p
left outer join Suppliers as s
    on p.SupplierID = s.SupplierID
where s.Country in ('Germany', 'Spain')

-- Task 2

--Here’s a data model of the relationship between Orders and Shippers.
--We’d like to show a list of the Orders that were made, including the Shipper that was used. Show the OrderID, OrderDate (date only with alias ShortDate), and CompanyName of the Shipper, and sort by OrderID. Show only those rows with an OrderID of less than 10260.
--Note. Use strftime('%Y-%m-%d', OrderDate) function to extract only date.

select o.OrderID
    ,o.OrderDate as ShortDate
    ,s.CompanyName
from Orders as o
left outer join Shippers as s
    on o.ShipVia = s.ShipperID
where o.OrderID < 10260
order by o.OrderID

-- Task 3

--We're doing inventory, and need to show information about OrderID, a list of products, and their quantity for orders which were shipped by Leverling Janet with quantities greater than 50.
--The result should be sorted by OrderID.

select o.OrderID
    ,p.ProductName
    ,od.Quantity
from Orders as o
join 'Order Details' as od
    on o.OrderID = od.OrderID
join Products as p
    on od.ProductID = p.ProductID
join Employees as e
    on o.EmployeeID = e.EmployeeID
where (e.LastName || ' ' || e.FirstName) = 'Leverling Janet' and od.Quantity > 50
order by od.Quantity, o.OrderID

--code for testing
select o.order_id 
    ,p.product_name 
    ,od.quantity
    ,(e.last_name || ' ' || e.first_name) as full_name
from orders as o
join order_details as od
    on o.order_id = od.order_id 
join products as p
    on od.product_id = p.product_id
join employees as e
    on o.employee_id = e.employee_id
where (e.last_name || ' ' || e.first_name) = 'Leverling Janet' and od.quantity > 50
order by od.quantity, o.order_id

--Task 4

--There are some customers who have never actually placed an order. Show these customers.
--Use the model:
--Note. One way of doing this is to use a left join, also known as a left outer join.

select c.CompanyName
from Customers as c
left outer join Orders as o
    on c.CustomerID = o.CustomerID
where o.OrderID is null

--Task 5

--One employee (Margaret Peacock, EmployeeID 4) has placed the most orders. However, there are some customers who've never placed an order with her. Show only those customers who have never placed an order with her.
--Use the model:
--Note. One way of doing this is to use one type of outer join (left or right). Because the filters in the WHERE clause are applied after the results of the JOIN, we need the EmployeeID = 4 filter in the JOIN clause, instead of the WHERE clause.

select c.CompanyName
from Customers as c
left outer join Orders as o
    on c.CustomerID = o.CustomerID
    and o.EmployeeID = 4
where o.OrderID is null

--Task 6

--We want to send all of our high-value customers a special VIP gift. We're defining high-value customers as those who've made at least 1 order with a total value (not including the discount) equal to $10,000 or more. We only want to consider orders made in the year 2016.
--Use the alias TotalOrderAmount for the calculated column. Order by the total amount of the order, in descending order.

select  c.CustomerID
    ,c.CompanyName
    ,od.OrderID
    ,SUM(od.UnitPrice * od.Quantity) as TotalOrderAmount
from 'Order Details' as od
inner join Orders as o
    on od.OrderID = o.OrderID
left outer join Customers as c
    on o.CustomerID = c.CustomerID
where o.OrderDate > '2016-01-01' and o.OrderDate < '2016-12-31' and o.CustomerID not NULL
group by od.OrderID
having SUM(od.UnitPrice * od.Quantity) > 10000
order by TotalOrderAmount DESC

--Task 7

--We want to send all of our high-value customers a special VIP gift. We're defining high-value customers as those who have orders totaling $15,000 or more in 2016 (not including the discount). 
--Use the alias TotalOrderAmount for the calculated column. Order by the total amount of the order, in descending order.

select  c.CustomerID
    ,c.CompanyName
    ,SUM(od.UnitPrice * od.Quantity) as TotalOrderAmount
from 'Order Details' as od
inner join Orders as o
    on od.OrderID = o.OrderID
left outer join Customers as c
    on o.CustomerID = c.CustomerID
where o.OrderDate > '2016-01-01' and o.OrderDate < '2016-12-31' and o.CustomerID not NULL
group by c.CustomerID
having SUM(od.UnitPrice * od.Quantity) > 15000
order by TotalOrderAmount DESC


-- Task 8

--We want to send all of our high-value customers a special VIP gift. We're defining high-value customers as orders totaling $15,000 or more in 2016.  The result set should include the column TotalOrderAmount with the total sum not including the discount, and the column TotalWithDiscount with the total sum including the discount.
--Order by TotalWithDiscount in descending order.

select  c.CustomerID
    ,c.CompanyName
    ,round(SUM(od.UnitPrice * od.Quantity), 2) as TotalOrderAmount
    ,round(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2) as TotalWithDiscount 
from 'Order Details' as od
inner join Orders as o
    on od.OrderID = o.OrderID
left outer join Customers as c
    on o.CustomerID = c.CustomerID
where o.OrderDate > '2016-01-01' and o.OrderDate < '2016-12-31' and o.CustomerID not NULL
group by c.CustomerID
having round(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2) >= 15000
order by TotalOrderAmount desc

--Task 9

--The Northwind mobile app developers are testing an app that customers will use to show orders. In order to make sure that even the largest orders will show up correctly on the app, they'd like some samples of orders that have lots of individual line items. Show the 10 orders with the most line items, in order of total line items.
--Note. Using Orders and OrderDetails, you'll use Group by and count() functionality. 
-- Use the alias TotalOrderLines for the calculated column.

select o.OrderID
    ,count(od.ProductID) as TotalOrderLines
from Orders as o
left outer join 'Order Details' as od
    on o.OrderID = od.OrderID
group by o.OrderID
order by TotalOrderLines DESC
limit 10

-- Task 10

--Some salespeople have more orders arriving late than others. Maybe they're not following up on the order process, and need more training. Which salespeople have the most orders arriving late?
--Note. To determine which orders are late, you can use a combination of the RequiredDate and ShippedDate. It's not exact, but if ShippedDate is actually after RequiredDate, you can be sure it's late.
--Use the alias TotalLateOrders for the calculated column.
--You'll need to join to the Employee table to get the last name, and also add Count to show the total late orders.

select e.EmployeeID
    ,e.LastName
    ,count(o.OrderID) as TotalLateOrders
from Employees as e
left outer join Orders as o
    on e.EmployeeID = o.EmployeeID
    where o.ShippedDate > o.RequiredDate
group by e.EmployeeID
order by TotalLateOrders DESC, e.EmployeeID
