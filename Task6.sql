--Create a report that shows the CompanyName and total number of orders by the customer
--since December 31, 2015. Show the number of Orders greater than 10.
--Use alias NumberofOrders for the calculated column.

select c.companyname, count(o.orderid ) as NumberofOrders
from orders o, customers c 
where o.orderdate >= '2015-12-31'
group by  c.customerid, c.companyname, o.customerid 
having c.customerid = o.customerid and count(o.orderid )>10
order by lower(c.companyname) 


--Create a report that shows the EmployeeID, the LastName and FirstName as
--Employee (alias), and the LastName and FirstName of who they report to as 
--Manager (alias) from the Employees table sorted by EmployeeID. 

select e1.employeeid,e1.lastname || ' ' || e1.firstname as Employee,e2.lastname || ' ' || e2.firstname as Manager
from employees e1
left join employees e2 on e1.reportsto  =  e2.employeeid

-- Create a report that shows the  ContactName of customer, 
--TotalSum (alias for the calculated column UnitPrice*Quantity*(1-Discount)) from
-- the Order Details, and Customers table with the discount given on every purchase.
-- Show only VIP customers with TotalSum greater than 10000.

select c.contactname, round(sum(od.UnitPrice*od.quantity*(1-od.Discount)),2) as TotalSum
from customers c 
join orders o on c.customerid = o.customerid 
join 'Order details' od on o.orderid = od.orderid 
where od.discount>0
group by c.contactname 
having sum(UnitPrice*Quantity*(1-Discount)) > 10000
order by c.contactname 

--Create a report that shows the total quantity of products (alias TotalUnits) ordered.
--Only show records for products for which the quantity ordered is fewer than 200. 

select p.productname , sum(od.quantity) as TotalUnits
from "order details" od 
join products p on p.productid = od.productid 
join orders o on o.orderid = od.orderid 
join customers c  on c.customerid = o.customerid 
group by p.productname
having sum(od.quantity)<200


--Create a report that shows the total number of orders (alias NumOrders ) by Customer 
--since December 31, 2015.
--The report should only return rows for which the NumOrders is greater than 5.
--The result should be sorted by NumOrders descending.

select c.companyname , count(o.customerid) as NumOrders
from customers c 
join orders o on c.customerid = o.customerid 
where o.orderdate>'2015-12-31'
group by c.companyname 
having count(o.customerid)>5
order by NumOrders desc

--Create a report that shows the company name, order id, and total price 
--(alias TotalPrice) of all products of which Northwind has sold more than $10,000 worth.
--The result should be sorted by TotalPrice descending

select c.companyname, o.orderid , od.unitprice*od.quantity*(1-discount) as TotalPrice
from customers c 
join orders o on c.customerid = o.customerid 
join "order details" od on o.orderid = od.orderid 
group by  o.orderid, c.companyname, od.unitprice, od.quantity  
having od.unitprice*od.quantity*(1-discount)>10000
order by TotalPrice desc 

--Create a report that shows the number of employees (alias numEmployees) and number
-- of customers (alias numCompanies) from each city that has employees in it.
--The result should be ordered by numEmployees.

select  count(distinct e.employeeid) as numEmployees,count(distinct c.customerid) as numCompanies, c.city
from customers c 
join employees e on e.city = c.city 
group by c.city
order by numEmployees


-- Get the lastname and firstname of employee (alias Name), company names and 
-- phone numbers (alias Phone) of all employees, customers, and suppliers, 
--who are situated in London.
-- Add the column (alias Type) to the result set which should specify what type of
-- counterparty (employee, customer, or supplier) it is.

select c.companyname as Name, c.phone as Phone, 'customer'as Type
from customers c 
where city = 'London'
union
select e.firstname ||' '||e.lastname as Name, e.homephone as Phone , 'employee'as Type
from employees e 
where city = 'London'
union
select s.companyname as Name, s.phone as Phone, 'supplier'as Type
from suppliers s  
where city = 'London'
order by "type"

--Write the query which would show the list of employees (FirstName and LastName) and
-- their total sales (alias TotalSales) who have sold more than 200 positions of products.

select e.firstname , e.lastname ,  ROUND(cast(sum(od.quantity*od.unitprice*(1-od.discount)) as numeric),2) as TotalSales
from employees e 
join orders o on o.employeeid = e.employeeid 
join "order details" od on o.orderid  = od.orderid 
group by e.firstname , e.lastname
having count(od.quantity) > 200
order by e.firstname

--Write the query which would show the names of employees who sell the products of 
-- more than 25 suppliers during the 2016 year.


select e.firstname, e.lastname
from employees e 
join orders o on e.employeeid = o.employeeid 
join "order details" od on o.orderid = od.orderid 
join products p on p.productid = od.productid
where strftime('%Y', OrderDate) = '2016'
group by e.firstname, e.lastname
having count(distinct p.supplierid)>25