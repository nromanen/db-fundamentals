--1. Show the list of French customers’ names who are working in the same cities.

select c1.contact_name as contact_name1
	,c2.contact_name as contact_name2
	,c1.city
from customers as c1, customers as c2
where c1.customer_id <> c2.customer_id
	and c1.country = 'France'
	and c2.country = 'France'
	and c1.city = c2.city
order by c1.city

--2. Show the list of German suppliers’ names who are not working in the same cities.

select s1.company_name as company_name1
	,s1.country
	,s1.city as company_city1
	,s2.company_name as company_name2
	,s2.city as company_city2
from suppliers as s1, suppliers as s2
where s1.supplier_id <> s2.supplier_id
	and s1.country = 'Germany'
	and s2.country = 'Germany'
	and s1.city <> s2.city
order by s1.city

--1. Show the count of orders made by each customer from France.

select c.customer_id
	,c.contact_name
	,count(o.order_id) as count_of_orders 
from customers as c, orders as o
where c.country = 'France'
	and c.customer_id = o.customer_id
group by c.customer_id
order by c.customer_id 

--2. Show the list of French customers’ names who have made more than one order.

select c.contact_name
	,c.country
	,count(o.order_id) as orders
from customers as c, orders as o
where c.country = 'France'
	and c.customer_id = o.customer_id
group by c.customer_id
having count(o.order_id) > 1



--1. Show the list of customers’ names who used to order the ‘Tofu’ product.

select c.contact_name
	,p.product_name 
from customers as c
join orders as o
	on o.customer_id = c.customer_id
join order_details as od 
	on od.order_id = o.order_id
join products as p
	on p.product_id = od.product_id
	where p.product_name = 'Tofu'
order by c.contact_name 
	
--2. Show the list of French customers’ names who used to order nonFrench products.

select c.contact_name
	,s.country 
from customers as c
join orders as o
	on o.customer_id = c.customer_id
join order_details as od
	on od.order_id = o.order_id 
join products as p
	on p.product_id = od.product_id
join suppliers as s
	on s.supplier_id = p.supplier_id
where c.country = 'France' and s.country <> 'France'
group by c.contact_name, s.country
order by c.contact_name



--3. Show the list of French customers’ names who used to order French products.

select c.contact_name
	,s.country 
from customers as c
join orders as o
	on o.customer_id = c.customer_id
join order_details as od
	on od.order_id = o.order_id 
join products as p
	on p.product_id = od.product_id
join suppliers as s
	on s.supplier_id = p.supplier_id
where c.country = 'France' and s.country = 'France'
group by c.contact_name, s.country
order by c.contact_name

--1. Show the total ordering sum calculated for each country of customer.

select c.country
	,sum(od.unit_price * od.quantity) as total_sum
from customers as c
join orders as o
	on o.customer_id = c.customer_id
join order_details as od
	on od.order_id = o.order_id
group by c.country
order by c.country
	
--2. Show the list of product categories along with total ordering sums calculated for the orders made for the products of each category, during the year 1997.

select c.category_id
	,c.category_name
	,sum(od.unit_price * od.quantity) as total_sum
from categories as c
join products as p
	on p.category_id = c.category_id
join order_details as od 
	on od.product_id = p.product_id
join orders as o 
	on o.order_id = od.order_id 
	where extract(year from o.order_date) = '1997'
group by c.category_id
order by c.category_id
	
--3. Show the list of product names along with unit prices and the history of unit prices taken from the orders (show ‘Product name – Unit price – Historical price’). The duplicate records
--should be eliminated. If no orders were made for a certain product, then the result for this product should look like ‘Product name – Unit price – NULL’. Sort the list by the product name.

select distinct p.product_name
	,p.unit_price 
	,od.unit_price AS historical_price
from products as p
left join order_details as od 
	on od.product_id = p.product_id 
order by p.product_name


-- MUDDLE TASKS

--Task 1
--Create a report that shows the CompanyName and total number of orders by the customer since December 31, 2015. Show the number of Orders greater than 10. Use alias NumberofOrders for the calculated column.

select c.CompanyName
    ,count(OrderId) as NumberofOrders
from Customers as c
join Orders as o
    on o.CustomerID = c.CustomerID
    where o.OrderDate > '2015-12-31'
group by lower(c.CompanyName)
having count(OrderId) > 10

--Task 2
--Create a report that shows the EmployeeID, the LastName and FirstName as Employee (alias), and the LastName and FirstName of who they report to as Manager (alias) from the Employees table sorted by EmployeeID. 

select e1.EmployeeID
    ,e1.LastName || ' ' || e1.FirstName as Employee
    ,e2.LastName || ' ' || e2.FirstName as Manager
from Employees as e1
left join Employees as e2
    on e1.ReportsTo = e2.EmployeeID 
order by e1.EmployeeID

--Task 3
--Create a report that shows the  ContactName of customer, TotalSum (alias for the calculated column UnitPrice*Quantity*(1-Discount)) from the Order Details, and Customers table with the discount given on every purchase. Show only VIP customers with TotalSum greater than 10000.

select c.ContactName
    ,ROUND(SUM(od.UnitPrice*od.Quantity*(1-od.Discount)),2) as TotalSum
from Customers as c
join Orders as o
    on o.CustomerID = c.CustomerID
join 'Order Details' as od
    on od.OrderID = o.OrderID
    where od.Discount <> 0
group by c.ContactName
having ROUND(SUM(od.UnitPrice*od.Quantity*(1-od.Discount)),2) > 10000

-- Task 4
--Create a report that shows the total quantity of products (alias TotalUnits)
--ordered. Only show records for products for which the quantity ordered is fewer than 200. 

select p.ProductName 
    ,Sum(od.Quantity) as TotalUnits
from Products as p
left join 'Order Details' as od
    on od.ProductID = p.ProductID
group by p.ProductName
having Sum(od.Quantity) < 200

-- Task 5
--Create a report that shows the total number of orders (alias NumOrders ) by Customer since December 31, 2015.
--The report should only return rows for which the NumOrders is greater than 5.
--The result should be sorted by NumOrders descending.

select c.CompanyName
    ,count(o.OrderID) as NumOrders
from Customers as c
join Orders as o
    on o.CustomerID = c.CustomerID
    where o.OrderDate > '2015-12-31'
group by c.CompanyName
having count(o.OrderID) > 5
order by NumOrders desc

-- Task 6
--Create a report that shows the company name, order id, and total price (alias TotalPrice) of all products of which Northwind has sold more than $10,000 worth.
--The result should be sorted by TotalPrice descending

select c.CompanyName
    ,o.OrderID
    ,(od.UnitPrice * od.Quantity * (1 - od.Discount)) as TotalPrice
from Customers as c
left join Orders as o
    on o.CustomerID = c.CustomerID
left join 'Order Details' as od
    on od.OrderID = o.OrderID
    where od.UnitPrice * od.Quantity * (1 - od.Discount) > 10000
group by c.CompanyName, o.OrderID
order by TotalPrice desc, c.CompanyName desc

-- Task 7
--Create a report that shows the number of employees (alias numEmployees) and number of customers (alias numCompanies) from each city that has employees in it.
--The result should be ordered by the name of city.

select count(distinct e.EmployeeID) as numEmployees
    , count(distinct c.CustomerID) as numCompanies
    , e.City
from Employees as e
left join Customers as c
    on c.City = e.City
group by e.City
having numEmployees > 0 and numCompanies > 0
order by numEmployees

-- Task 8
--Get the lastname and firstname of employee (alias Name), company names and phone numbers (alias Phone) of all employees, customers, and suppliers, who are situated in London.
--Add the column (alias Type) to the result set which should specify what type of counterparty (employee, customer, or supplier) it is.

select e.FirstName || ' ' || e.LastName as Name
    ,e.HomePhone as Phone
    ,'employee' as Type
from Employees as e
where e.City = 'London'
union
select c.CompanyName as Name
    ,c.Phone
    ,'customer' as Type
from Customers as c
where c.city = 'London'
union
select s.CompanyName as Name
    ,s.Phone
    ,'supplier' as Type
from Suppliers as s
where s.city = 'London'
order by type

-- Task 9
-- Write the query which would show the list of employees (FirstName and LastName) and their total sales (alias TotalSales) who have sold more than 200 positions of products.

select e.FirstName
    ,e.LastName
    ,ROUND(SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)), 2) as TotalSales
from Employees as e
left join Orders as o
    on o.EmployeeID = e.EmployeeID
left join 'Order Details' as od
    on od.OrderID = o.OrderID
left join Products as p
    on p.ProductID = od.ProductID
group by e.FirstName, e.LastName
having TotalSales > 125000

-- Task 10
-- Write the query which would show the names of employees who sell the products of more than 25 suppliers during the 2016 year.

select e.FirstName
    ,e.LastName
from Employees as e
join Orders as o
    on o.EmployeeID = e.EmployeeID
join 'Order Details' as od
    on od.OrderID = o.OrderID
join Products as p
    on p.ProductID = od.ProductID
join Suppliers as s
    on s.SupplierID = p.SupplierID
where o.OrderDate > '2016-01-01' and o.OrderDate < '2016-12-31'
group by e.FirstName, e.LastName
having count(s.SupplierID) > 80
order by e.FirstName