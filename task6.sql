--1.Create a report that shows the CompanyName and total number of orders by the customer since December 31, 2015.
--Show the number of Orders greater than 10. Use alias NumberofOrders for the calculated column.
select c.CompanyName
, count(o.OrderID) as NumberofOrders
from Orders o
join Customers c on o.CustomerID = c.CustomerID
where o.OrderDate > "2015-12-31"
group by c.CompanyName
having count(o.OrderID) > 10
order by lower(c.CompanyName)

--2.Create a report that shows the EmployeeID, the LastName and FirstName as Employee (alias),
--and the LastName and FirstName of who they report to as Manager (alias) from the Employees table sorted by EmployeeID.
select e.EmployeeID, e.LastName || ' ' || e.FirstName Employee, m.LastName || ' ' ||m.FirstName Manager 
from Employees e
left join Employees m on e.ReportsTo = m.EmployeeID
order by e.EmployeeID

--3.Create a report that shows the  ContactName of customer, TotalSum (alias for the calculated column UnitPrice*Quantity*(1-Discount))
--from the Order Details, and Customers table with the discount given on every purchase.
--Show only VIP customers with TotalSum greater than 10000.
--Note. Use ROUND() function to round TotalSum to the 2nf digit after the decimal point.
select c.ContactName
, round(sum(od.UnitPrice * od.Quantity * (1- od.Discount)), 2) as TotalSum 
from Customers c
join Orders o on c.CustomerID = o.CustomerID
join "Order Details" od on o.OrderID = od.OrderId
where od.Discount > 0
group by c.ContactName   
having round(sum(od.UnitPrice * od.Quantity * (1- od.Discount)), 2) > 10000  

--4.Create a report that shows the total quantity of products (alias TotalUnits)
 --ordered. Only show records for products for which the quantity ordered is fewer than 200.
 select p.ProductName, sum(od.Quantity) as TotalUnits 
from Orders o
join "Order Details" od on o.OrderID = od.OrderID
join Products p on od.ProductID = p.ProductID
group by p.ProductName
having sum(od.Quantity) < 200

--5.Create a report that shows the total number of orders (alias NumOrders ) by Customer since December 31, 2015.
--The report should only return rows for which the NumOrders is greater than 5.
--The result should be sorted by NumOrders descending.
select c.CompanyName, count(o.OrderID) as NumOrders
from Customers c
join Orders o on o.CustomerID = c.CUstomerID
where o.OrderDate > "2015-12-31" 
group by c.CompanyName
having count(o.OrderID) > 5
order by count(o.OrderID) desc 

--6.Create a report that shows the company name, order id, and total price (alias TotalPrice) of all products
--of which Northwind has sold more than $10,000 worth. The result should be sorted by TotalPrice descending
select c.CompanyName, o.OrderID, sum(od.UnitPrice * od.Quantity * (1 - od.Discount)) as TotalPrice
from Customers c 
join Orders o on c.CustomerID = o.CustomerID
join "Order Details" od on o.OrderID = od.OrderID
group by c.CompanyName, o.OrderID, od.ProductID
having sum(od.UnitPrice * od.Quantity * (1 - od.Discount)) > 10000 
order by sum(od.UnitPrice * od.Quantity * (1 - od.Discount)) desc

--7.Create a report that shows the number of employees (alias numEmployees) and number of customers (alias numCompanies)
--from each city that has employees in it. The result should be ordered by the name of city.
select count(distinct e.EmployeeID) as numEmployees, count(distinct c.CustomerID) as numCompanies, e.City
from Employees e
join Customers c on e.City = c.City
group by e.City 
order by count(distinct e.EmployeeID)

--8.Get the lastname and firstname of employee (alias Name), company names and phone numbers (alias Phone) of all employees,
--customers, and suppliers, who are situated in London.
--Add the column (alias Type) to the result set which should specify what type of counterparty (employee, customer, or supplier) it is.
select e.FirstName || ' ' || e.LastName as Name, e.HomePhone as Phone, 'employee' as Type
from Employees e
where e.City = 'London'
union 
select s.CompanyName, s.Phone, 'supplier' as Type
from Suppliers s
where s.City = 'London'
union
select c.CompanyName, c.Phone, 'customer' as Type
from Customers c
where c.City = 'London'
order by Type

--9.Write the query which would show the list of employees (FirstName and LastName) and their total sales (alias TotalSales)
--who have sold more than 200 positions of products.
--Note. Use ROUND() function to round the TotalSales values to the 2nd digit.
select e.FirstName, e.LastName, round(sum(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2) as TotalSales 
from Employees e
join Orders o on e.EmployeeID = o.EmployeeID
join "Order Details" od on o.OrderID = od.OrderID
group by e.FirstName, e.LastName
having count(od.Quantity) > 200
order by e.FirstName

--10.Write the query which would show the names of employees who sell the products of more than 25 suppliers during the 2016 year.
--Note. Use strtime('%Y', OrderDate) function get the year from date.
select e.FirstName, e.LastName
from Employees e
join Orders o on e.EmployeeID = o.EmployeeID
join "Order Details" od on o.OrderID = od.OrderID
join Products p on od.ProductID = p.ProductID
join Suppliers s on p.SupplierID = s.SupplierID
where strftime('%Y', OrderDate) = '2016'
group by e.FirstName, e.LastName
having count(distinct s.SupplierID) > 25
