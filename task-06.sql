-- Task #1
-- Create a report that shows the CompanyName and total number of orders by the customer since December 31, 2015. 
-- Show the number of Orders greater than 10. Use alias NumberofOrders for the calculated column.

select c.CompanyName
    ,count(o.OrderID) NumberofOrders
from Customers c
join Orders o on c.CustomerID = o.CustomerID
where o.OrderDate >= '2015-12-31'
group by lower(c.CompanyName)
having count(OrderId) > 10

-- Task #2
-- Create a report that shows the EmployeeID, the LastName and FirstName as Employee (alias), 
-- and the LastName and FirstName of who they report to as Manager (alias) 
-- from the Employees table sorted by EmployeeID. 

select e1.EmployeeID
    ,e1.LastName || ' ' || e1.FirstName Employee
    ,e2.LastName || ' ' || e2.FirstName Manager
from Employees e1
left join Employees e2
    on e1.ReportsTo = e2.EmployeeID 
order by e1.EmployeeID

-- Task #3
-- Create a report that shows the  ContactName of customer, 
-- TotalSum (alias for the calculated column UnitPrice*Quantity*(1-Discount)) from the Order Details, 
-- and Customers table with the discount given on every purchase. 
-- Show only VIP customers with TotalSum greater than 10000.

select c.ContactName
    ,round(sum(od.UnitPrice * od.Quantity * (1 - od.Discount)),2) TotalSum
from Customers c
join Orders o on c.CustomerID = o.CustomerID
join 'Order Details' od on o.OrderID = od.OrderID
where od.Discount <> 0
group by c.ContactName
having TotalSum > 10000

-- Task #4
-- Create a report that shows the total quantity of products (alias TotalUnits) ordered. 
-- Only show records for products for which the quantity ordered is fewer than 200. 

select p.ProductName
    ,sum(od.Quantity) TotalUnits
from Products p
left join 'Order Details' od on p.ProductID = od.ProductID
group by p.ProductName
having TotalUnits < 200

-- Task #5
-- Create a report that shows the total number of orders (alias NumOrders ) by Customer since December 31, 2015.
-- The report should only return rows for which the NumOrders is greater than 5.
-- The result should be sorted by NumOrders descending.

select c.CompanyName
    ,count(o.OrderID) NumOrders
from Customers c
join Orders o on c.CustomerID = o.CustomerID
where o.OrderDate > '2015-12-31'
group by c.CompanyName
having NumOrders > 5
order by NumOrders desc

-- Task #6
-- Create a report that shows the company name, order id, and total price (alias TotalPrice) 
-- of all products of which Northwind has sold more than $10,000 worth.
-- The result should be sorted by TotalPrice descending

select c.CompanyName 
    ,o.OrderID
    ,(od.UnitPrice * od.Quantity * (1 - od.Discount)) TotalPrice
from Customers c
join Orders o on c.CustomerID = o.CustomerID
join 'Order Details' od on o.OrderID = od.OrderID
where TotalPrice > 10000
group by c.CompanyName
order by TotalPrice desc

-- Task #7
-- Create a report that shows the number of employees (alias numEmployees) 
-- and number of customers (alias numCompanies) from each city that has employees in it.
-- The result should be ordered by numEmployees.

select count(distinct e.EmployeeID) numEmployees
    ,count(distinct c.CustomerID) numCompanies
    ,e.City
from Employees e
left join Customers c on e.City = c.City
group by e.City
having numEmployees > 0 and numCompanies > 0
order by numEmployees

-- Task #8
-- Get the lastname and firstname of employee (alias Name), company names and phone numbers (alias Phone) of all 
-- employees, customers, and suppliers, who are situated in London.
-- Add the column (alias Type) to the result set which should specify 
-- what type of counterparty (employee, customer, or supplier) it is.

select e.FirstName || ' ' || e.LastName Name
    ,e.HomePhone Phone
    ,'employee' Type
from Employees e
where e.City = 'London'
union
select c.CompanyName Name
    ,c.Phone
    ,'customer' Type
from Customers c
where c.city = 'London'
union
select s.CompanyName Name
    ,s.Phone
    ,'supplier' Type
from Suppliers s
where s.city = 'London'
order by Type

-- Task #9
-- Write the query which would show the list of employees (FirstName and LastName) 
-- and their total sales (alias TotalSales) who have sold more than 200 positions of products.

select e.FirstName 
    ,e.LastName
    ,round(sum(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2) TotalSales
from Employees e
left join Orders o on e.EmployeeID = o.EmployeeID
left join 'Order Details' od on o.OrderID = od.OrderID
left join Products p on od.ProductID = p.ProductID
group by e.FirstName, e.LastName
having TotalSales > 125000

-- Task #10
-- Write the query which would show the names of employees 
-- who sell the products of more than 25 suppliers during the 2016 year.

select e.FirstName
    ,e.LastName
from Employees e
join Orders o on e.EmployeeID = o.EmployeeID
join 'Order Details' od on o.OrderID = od.OrderID
join Products p on od.ProductId = p.ProductID
join Suppliers s on p.SupplierID = s.SupplierID
where o.OrderDate > '2016-01-01' and o.OrderDate < '2016-12-31'
group by e.FirstName, e.LastName
having count(s.SupplierID) > 80 
order by e.FirstName
