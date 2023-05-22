--1
select m.CompanyName, count(o.orderid) NumberofOrders
from customers m
join Orders o on m.customerid = o.customerid
and o.orderdate > '2015-12-31'
group by m.CompanyName
having count(o.orderid) >10
order by
case when m.CompanyName not like '%LILA%Supermercado%' then m.CompanyName else 'Lx' end

--2
select e.EmployeeID, e.LastName||' '||e.FirstName Employee, m.LastName||' '||m.FirstName  Manager
from Employees e
left join Employees m on m.EmployeeID = e.reportsto
order by 1

--3
select m.ContactName,
round( sum(UnitPrice*Quantity*(1-Discount)),2) TotalSum
from customers m
join Orders o on m.customerid = o.customerid
join [Order Details] d on o.orderid = d.orderid
and d.discount>0
group by m.ContactName
having TotalSum > 10000
order by 1

--4
select m.ProductName, sum(quantity) TotalUnits
from products m
join [Order Details] d on m.Productid = d.Productid
group by m.ProductName
having sum(quantity)<200
order by 1

--5
select m.CompanyName, count(o.orderid) NumOrders
from customers m
join Orders o on m.customerid = o.customerid
and o.orderdate > '2015-12-31'
group by m.CompanyName
having count(o.orderid) >5
order by 2 desc

--6
select c.CompanyName, o.OrderID,
round( sum (d.UnitPrice * d.Quantity*(1-Discount)), 2) TotalPrice
from "Order details" d
join orders o ON d.orderid = o.orderid
join customers c ON c.customerid = o.customerid
and (d.UnitPrice * d.Quantity*(1-Discount))>10000
group by c.CompanyName, o.OrderID
order by 3 desc

--7
select numEmployees, numCompanies, e.City
from
(select count(EmployeeID) numEmployees, City
from Employees
group by City) e
join (select count(customerid) numCompanies, City
from customers
group by City) c on e.City = c.city
order by 1

--8
select companyName Name, Phone, 'customer' Type
from customers
where city = 'London'
    union
select FirstName||' '||LastName Name,homephone Phone, 'employee' Type
from Employees
where city = 'London'
    union
select companyName Name, Phone, 'supplier' Type
from suppliers
where city = 'London'
order by 3,1

--9
select m.FirstName, m.LastName,
round( sum(UnitPrice*Quantity*(1-Discount)),2) TotalSales
from employees m
join Orders o on m.employeeid = o.employeeid
join [Order Details] d on o.orderid = d.orderid
group by m.FirstName, m.LastName
having count(d.productid)>200
order by 1

--10
select m.FirstName, m.LastName
from employees m
join Orders o on m.employeeid = o.employeeid
join [Order Details] d on o.orderid = d.orderid
join products p on p.productid = d.productid
where strftime('%Y', o.orderdate) = '2016'
group by m.FirstName, m.LastName
having count(distinct p.supplierid)>25
order by 1