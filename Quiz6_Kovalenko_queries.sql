--1. Create a report that shows the CompanyName and total number of orders by the customer since December 31, 2015. 
-- Show the number of Orders greater than 10. Use alias NumberofOrders for the calculated column.
-- Use Orders and Customers tables.

select c.CompanyName, count(OrderID) as NumberofOrders
from Orders o, Customers c
where o.CustomerID = C.CustomerID and
OrderDate > '2015-12-31'
group by UPPER(c.CompanyName)
having NumberofOrders > 10


--2. Create a report that shows the EmployeeID, the LastName and FirstName as Employee (alias), and the LastName and 
-- FirstName of who they report to as Manager (alias) from the Employees table sorted by EmployeeID. Use the Employees table.

select e1.EmployeeID, e1.LastName||' '||e1.FirstName as Employee, 
e2.LastName||' '||e2.FirstName as Manager
from Employees e1
left join Employees e2 on e1.ReportsTo=e2.EmployeeID
order by e1.EmployeeID


--3. Create a report that shows the  ContactName of customer, TotalSum (alias for the calculated column UnitPrice*Quantity*(1-Discount)) 
-- from the Order Details, and Customers table with the discount given on every purchase. Show only VIP customers with TotalSum greater than 10000.
-- Use Order Details, Orders and Customers tables.

select c.contactname, round(sum(unitprice*quantity*(1-discount)),2) as TotalSum
from customers c 
join orders o on c.CustomerID = o.CustomerID
join 'Order Details' od on o.orderid = od.orderid 
where Discount != 0
group by c.contactname
having round(sum(unitprice*quantity*(1-discount)),2) > 10000


--4. Create a report that shows the total quantity of products (alias TotalUnits)
-- ordered. Only show records for products for which the quantity ordered is fewer than 200. 
-- Use Order Details, Orders and Customers tables.

select ProductName, sum(od.quantity) as TotalUnits
from Products p
join 'Order Details' od on p.ProductID=od.ProductID
group by ProductName
having sum(od.quantity) < 200


--5. Create a report that shows the total number of orders (alias NumOrders ) by Customer since December 31, 2015.
-- The report should only return rows for which the NumOrders is greater than 5. The result should be sorted by NumOrders descending.
-- Use Order Details, Orders and Customers tables.

select c.companyname, count(o.orderid) as NumOrders
from customers c
join orders o on c.customerid=o.customerid 
and OrderDate > '2015-12-31'
group by c.companyName
having NumOrders > 5
order by NumOrders desc


--6. Create a report that shows the company name, order id, and total price (alias TotalPrice) of all products of which Northwind 
--has sold more than $10,000 worth. The result should be sorted by TotalPrice descending.
-- Use Products, Order Details and Orders tables.

select c.companyname, o.orderid, od.unitprice*od.quantity*(1 - discount) as TotalPrice
from customers c
join orders o on c.CustomerID = o.CustomerID
join 'Order Details' od on o.orderid = od.orderid
where (od.unitprice*od.quantity*(1 - discount)) > 10000
group by c.companyname, o.orderid
order by TotalPrice desc


--7. Create a report that shows the number of employees (alias numEmployees) and number of customers (alias numCompanies)
--from each city that has employees in it. The result should be ordered by numEmployees. 

select count(distinct e.LastName) as numEmployees,
count (distinct c.CompanyName) as numCompanies, e.City
from employees e, customers c
where e.city=c.city
group by e.city
order by numEmployees


--8. Get the lastname and firstname of employee (alias Name), company names and phone numbers (alias Phone) of all employees, 
-- customers, and suppliers, who are situated in London. Add the column (alias Type) to the result set which should specify
-- what type of counterparty (employee, customer, or supplier) it is.

select companyname as Name, Phone as Phone,
'customer' as Type
from customers
where City = 'London'
Union all
select firstname||' '||lastname as Name, HomePhone as Phone, 
'employee' as Type
from employees
where City = 'London'
group by firstname
Union all
select companyname as Name, Phone as Phone,
'supplier' as Type
from suppliers
where City = 'London'


--9. Write the query which would show the list of employees (FirstName and LastName) and their total sales (alias TotalSales) 
-- who have sold more than 200 positions of products.

select FirstName, LastName, round(sum(od.unitprice*od.quantity*(1-od.discount)),2) as TotalSales
from employees e
join Orders o on e.EmployeeID=o.EmployeeID
join 'Order Details' od on o.orderid = od.orderid
join products p on od.productid=p.productid
group by FirstName, LastName
having count(o.OrderID) > 200


--10. Write the query which would show the names of employees who sell the products of more than 25 suppliers during the 2016 year.

select FirstName, LastName
from employees e
join orders o on e.employeeid=o.employeeid
join 'Order Details' od on o.orderid=od.orderid
join Products p on od.productid=p.productid
join Suppliers s on p.supplierid=s.supplierid
where strftime('%Y', o.OrderDate) = '2016'
group by e.EmployeeID
having count(distinct s.supplierid) > 25
order by FirstName