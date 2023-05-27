--1
select orderid
from [Order Details] d
where d.quantity>59
group by orderid,quantity
having count(productid)>1
order by 1

--2
select e.LastName, e.FirstName
from Employees e
where hiredate<(select hiredate from Employees m
where m.LastName= 'Fuller' and m.FirstName = 'Andrew')

--3
select e.ProductName, e.UnitPrice
from products e
where UnitPrice>(select avg(UnitPrice) from products m)
order by 2

--4
select m.CompanyName
from customers m
where country = 'Germany'
and exists(select 1 from orders o where m.customerid = o.customerid
    and o.orderdate like '2016%')

--5
select o.ShippedDate,
    count(distinct o.orderid) NumberOfOrders,
    round( sum (d.UnitPrice * d.Quantity*(1-Discount)), 2) Total
from Orders o
join "Order details" d ON d.orderid = o.orderid
and o.ShippedDate between '2016-01-01' and '2016-03-31'
group by o.ShippedDate
having count(distinct o.orderid)>3
order by 1

--6
select 'Dairy Products' CategoryName,
    p.ProductName,
    round( sum (d.UnitPrice * d.Quantity*(1-Discount)), 2) ProductSales
from Orders o
join "Order details" d ON d.orderid = o.orderid
join products p on p.productid = d.productid
and o.orderDate between '2016-01-01' and '2016-03-31'
and p.Categoryid = 4
group by p.ProductName
order by 2

select CategoryName, ProductName, sum(ProductSales)
from(
select 'Dairy Products' CategoryName,
    o.orderid,
    p.ProductName,
    round( sum (d.UnitPrice * d.Quantity*(1-Discount)), 2) ProductSales
from Orders o
join "Order details" d ON d.orderid = o.orderid
join products p on p.productid = d.productid
and o.orderDate between '2016-01-01' and '2016-03-31'
and p.Categoryid = 4
group by p.ProductName, o.orderid
)
group by CategoryName, ProductName
order by 2

--7
select c.CompanyName
from orders o
join customers c ON c.customerid = o.customerid
where o.orderid = 10290

--8
select m.EmployeeID, m.LastName, count(1) AllOrders,
    sum(case when RequiredDate <= ShippedDate then 1 else 0 end) LateOrders
from employees m
join Orders o on m.employeeid = o.employeeid
group by m.EmployeeID
order by 1


--9
with main as (select  m.employeeid, m.LastName, m.FirstName, count(o.orderid) cnt_ord
from employees m
join Orders o on m.employeeid = o.employeeid
group by  m.employeeid, m.FirstName, m.LastName)
select LastName, FirstName
from main
where cnt_ord>(select cnt_ord from main
where LastName = 'Fuller')
order by employeeid


--10
select m.EmployeeID, m.OrderID,  m.OrderDate
from Orders m
join (select EmployeeID, max(OrderDate) maxOrderDate
 from Orders
group by EmployeeID) o on m.employeeid = o.EmployeeID
and m.OrderDate = o.maxOrderDate
order by 1