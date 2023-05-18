--1
select ProductID, ProductName, CompanyName
from Products p
join Suppliers s on p.Supplierid=s.Supplierid
and country in ('Spain','Germany')
order by 1

--2
select o.OrderID , strftime('%Y-%m-%d', o.OrderDate)   ShortDate ,  p.CompanyName
from Shippers p
join Orders o on o.ShipVia = p.ShipperID
and o.OrderID <10260
order by 1

--3
select o.OrderID,  p.ProductName,  d.Quantity
from orders o
join "Order Details" d on o.orderid = d.orderid
join products p on d.productid = p.productid
join employees e on o.employeeid = e.employeeid
where d.quantity > 50
and e.lastname = 'Leverling'
and e.firstname = 'Janet'
order by 3

--4
select c.companyname
from customers c
left join orders o ON c.customerid = o.customerid
where  o.customerid is null

--5
select c.companyname
from customers c
left join orders o ON c.customerid = o.customerid
and o.EmployeeID=4
where  o.customerid is null

--6
select c.CustomerID, c.CompanyName, o.OrderID,
round(SUM(d.UnitPrice * d.Quantity), 2) TotalOrderAmount
from "Order details" d
join orders o ON d.orderid = o.orderid
join customers c ON c.customerid = o.customerid
where strftime('%Y', o.orderdate) = '2016'
group by c.CustomerID, c.CompanyName, o.OrderID
having round(sum(d.UnitPrice * d.Quantity ), 2) > 10000
order by 4 desc

--7
select c.CustomerID, c.CompanyName,
round(SUM(d.UnitPrice * d.Quantity), 2) TotalOrderAmount
from "Order details" d
join orders o ON d.orderid = o.orderid
join customers c ON c.customerid = o.customerid
where strftime('%Y', o.orderdate) = '2016'
group by c.CustomerID, c.CompanyName
having round(sum(d.UnitPrice * d.Quantity ), 2) >= 15000
order by 3 desc

--8
select c.CustomerID, c.CompanyName,
round(SUM(d.UnitPrice * d.Quantity), 2) TotalOrderAmount,
round(SUM(d.UnitPrice * d.Quantity*(1 - Discount)), 2) TotalWithDiscount
from "Order details" d
join orders o ON d.orderid = o.orderid
join customers c ON c.customerid = o.customerid
where strftime('%Y', o.orderdate) = '2016'
group by c.CustomerID, c.CompanyName
having round(sum(d.UnitPrice * d.Quantity*(1 - Discount) ), 2) >= 15000
order by 3 desc

--9
select o.OrderID, count(d.orderid) TotalOrderLines
from orders o
join "Order details" d on d.orderid = o.orderid
group by o.orderid
order by 2 desc
limit 10

--10
select e.EmployeeID, e.LastName, count(o.orderid) TotalLateOrders
from orders o
join Employees e ON e.EmployeeID = o.EmployeeID
where ShippedDate > RequiredDate
group by e.EmployeeID, e.LastName
order by 3 desc
