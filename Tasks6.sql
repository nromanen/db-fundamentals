--Q1
--Create a report that shows the CompanyName and total number of orders by the customer since December 31, 2015. 
--Show the number of Orders greater than 10. Use alias NumberofOrders for the calculated column.
--
----SQLite
--select 
--    c.companyname,
--    count(o.orderid) as NumberofOrders
--from orders o
--join customers c on o.customerid = c.customerid
--where o.orderdate > '2015-12-31'
--group by c.companyname
--having count(o.orderid) > 10
--order by c.companyname collate nocase

select 
	c.company_name 
	, count(o.order_id) as NumberofOrders
from orders o
join customers c on c.customer_id = o.customer_id 
where o.order_date > '1995-12-31'
group by c.company_name 
having count(o.order_id) > 10
order by c.company_name

--Q2
--Create a report that shows the EmployeeID, the LastName and FirstName as Employee (alias), and the LastName and 
--FirstName of who they report to as Manager (alias) from the Employees table sorted by EmployeeID. 
--
----SQLite
--select 
--    E.EmployeeID
--    , E.LastName || ' ' || E.FirstName as Employee
--    , M.LastName || ' ' || M.FirstName as Manager
--from Employees E 
--left join Employees M on M.EmployeeID = E.ReportsTo

select 
    e.employee_id
    , e.last_name || ' ' || e.first_name as Employee
    , m.last_name || ' ' || m.first_name as Manager
from employees e 
left join employees m on m.employee_id = e.reports_to 


--Q3
--Create a report that shows the  ContactName of customer, TotalSum (alias for the calculated column UnitPrice*Quantity*(1-Discount)) from the 
--Order Details, and Customers table with the discount given on every purchase. Show only VIP customers with TotalSum greater than 10000.
--
----SQLite
--select
--    C.ContactName
--    , round(sum(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)), 2) as TotalSum
--from Orders O
--join Customers C
--on O.CustomerID = C.CustomerID
--join "Order Details" OD
--on O.OrderID = OD.OrderID
--and OD.Discount > 0
--group by C.ContactName
--having TotalSum >= 10000
--order by C.ContactName

select
    c.contact_name
    , round(sum(od.unit_price * od.quantity * (1 - od.discount))::numeric, 2) as TotalSum
from orders o
join customers c
on o.customer_id = c.customer_id 
join order_details od 
on o.order_id = od.order_id 
and od.discount  > 0
group by c.contact_name 
having sum(od.unit_price * od.quantity * (1 - od.discount)) >= 10000
order by c.contact_name 

--Q4
--Create a report that shows the total quantity of products (alias TotalUnits)
-- ordered. Only show records for products for which the quantity ordered is fewer than 200. 
--
----SQLite
--select 
--    P.ProductName
--    , sum(OD.Quantity) as TotalUnits
--from Orders O
--join "Order Details" OD
--on O.OrderID = OD.OrderID
--join Products P
--on OD.ProductID = P.ProductID
--group by P.ProductName
--having sum(OD.Quantity) < 200

select 
    p.product_name
    , sum(od.quantity) as TotalUnits
from orders o 
join order_details od 
on o.order_id = od.order_id  
join products p
on od.product_id = p.product_id 
group by p.product_name 
having sum(od.quantity) < 200

--Q5
--Create a report that shows the total number of orders (alias NumOrders ) by Customer since December 31, 2015.
--The report should only return rows for which the NumOrders is greater than 5.
--The result should be sorted by NumOrders descending.
--
----SQLite
--select 
--    C.CompanyName
--    , count(O.OrderID) as NumOrders
--from Orders O
--join Customers C
--on C.CustomerID = O.CustomerID
--and date(O.OrderDate) >= date('2015-12-31')
--group by C.CompanyName
--having count(O.OrderID) > 5
--order by count(O.OrderID) desc

select 
    c.company_name
    , count(o.order_id) as NumOrders
from orders o 
join customers c 
on c.customer_id = o.customer_id 
and date(o.order_date) >= date('1995-12-31')
group by c.company_name 
having count(o.order_id) > 5
order by count(o.order_id) desc

--Q6
--Create a report that shows the company name, order id, and total price (alias TotalPrice) of all products of which Northwind has sold more than $10,000 worth.
--The result should be sorted by TotalPrice descending
--
----SQLite
--select 
--    C.CompanyName
--    , O.OrderID
--    , sum(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) as TotalPrice
--from Customers C
--join Orders O
--on C.CustomerID = O.CustomerID
--join "Order Details" OD
--on O.OrderID = OD.OrderID
--and (OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) > 10000
--group by O.OrderID
--order by TotalPrice desc

select 
    c.company_name
    , o.order_id
    , sum(od.unit_price * od.quantity * (1 - od.discount)) as TotalPrice
from orders o 
join customers c 
on c.customer_id = o.customer_id 
join order_details od 
on o.order_id = od.order_id 
and (od.unit_price * od.quantity * (1 - od.discount)) > 10000
group by o.order_id, c.company_name  
order by sum(od.unit_price * od.quantity * (1 - od.discount)) desc


--Q7
--Create a report that shows the number of employees (alias numEmployees) and number of customers (alias numCompanies) from each city that has employees in it.
--The result should be ordered by the name of city.
--
----SQLite
--select 
--    count(distinct E.EmployeeID) as numEmployees
--    , count(distinct C.CustomerID) as numCompanies
--    , C.City
--from Employees E
--join Customers C
--on E.City = C.City
--group by C.City
--order by numEmployees

select 
    count(distinct e.employee_id) as numEmployees
    , count(distinct c.customer_id) as numCompanies
    , c.city 
from employees e 
join customers c 
on e.city  = c.city 
group by c.city 
order by count(distinct e.employee_id)


--Q8
--Get the lastname and firstname of employee (alias Name), company names and phone numbers (alias Phone) of all employees, customers, and suppliers, who are situated in London.
--Add the column (alias Type) to the result set which should specify what type of counterparty (employee, customer, or supplier) it is.
--
----SQLite
--select S.CompanyName as Name, S.Phone, 'supplier' as Type
--from Suppliers S
--where S.City = 'London'
--union
--select C.CompanyName  as Name, C.Phone, 'customer' as Type
--from Customers C
--where C.City = 'London'
--union
--select E.FirstName || ' ' || E.LastName  as Name, E.HomePhone, 'employee'
--from Employees E
--where E.City = 'London'
--order by Type

select s.company_name as Name, s.phone, 'supplier' as Type
from suppliers s 
where s.city  = 'London'
union
select c.company_name as Name, c.phone, 'customer' as Type
from customers c 
where c.city  = 'London'
union
select e.first_name || ' ' || e.last_name as Name, e.home_phone, 'employee' as Type
from employees e 
where e.city = 'London'
order by Type

--Q9
--Write the query which would show the list of employees (FirstName and LastName) and 
--their total sales (alias TotalSales) who have sold more than 200 positions of products.
--
----SQLite
--select
--    E.FirstName
--    , E.LastName
--    , round(sum(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)), 2) as TotalSales
--from Employees E 
--join Orders O on E.EmployeeID = O.EmployeeID 
--join "Order Details" OD on O.OrderID = OD.OrderID
--group by E.EmployeeID 
--having count(OD.ProductID) > 200
--order by E.FirstName

select
    e.first_name
    , e.last_name
    , round(sum(od.unit_price * od.quantity * (1 - od.discount))::numeric, 2) as TotalSum
from employees e  
join orders o on e.employee_id = o.employee_id  
join order_details od on o.order_id = od.order_id 
group by e.employee_id 
having count(od.product_id) > 200
order by e.first_name 

--Q10
--Write the query which would show the names of employees who sell the products of more than 25 suppliers during the 2016 year.
--
----SQLite
--select 
--    E.FirstName,
--    E.LastName
--from Employees E
--join Orders O on E.EmployeeID = O.EmployeeID
--and strftime('%Y', O.OrderDate) = '2016'
--join "Order Details" OD on O.OrderID = OD.OrderID
--join Products P on OD.ProductID = P.ProductID
--join Suppliers S on P.SupplierID = S.SupplierID
--group by E.EmployeeID
--having count(distinct S.SupplierID) > 25
--order by E.FirstName

select 
    e.first_name
    , e.last_name 
from employees e 
join orders o on e.employee_id = o.employee_id 
and extract(year from o.order_date) = 1996
join order_details od on o.order_id = od.order_id 
join products p on od.product_id = p.product_id 
join suppliers s on p.supplier_id = s.supplier_id 
group by e.employee_id 
having count(distinct s.supplier_id) > 25
order by e.first_name 