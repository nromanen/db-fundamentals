-- Show the list of french customers’ names who used to order non-french products (use left join).
-- Don't forget to use uppercase letters

select distinct  c.contact_name 
from customers c 
left join orders o 
on c.customer_id = o.customer_id 
left join order_details od 
on o.order_id = od.order_id 
left join products p 
on od.product_id = p.product_id 
join suppliers s 
on p.supplier_id = s.supplier_id and s.country <> 'France'
where c.country = 'France';

SELECT distinct  c.contactname
FROM customers c 
LEFT JOIN orders o 
on c.customerid = o.customerid 
LEFT JOIN [order details] od 
on o.orderid = od.orderid 
LEFT JOIN products p 
on od.productid = p.productid 
JOIN suppliers s 
on p.supplierid = s.supplierid and s.country != 'France'
WHERE c.country = 'France';


-- Show the list of french customers’ names who used to order french products.

select distinct  c.contactname
from customers c 
left join orders o 
on c.customerid = o.customerid 
left join [order details] od 
on o.orderid = od.orderid 
left join products p 
on od.productid = p.productid 
join suppliers s 
on p.supplierid = s.supplierid and s.country = 'France'
where c.country = 'France';


--Show the total ordering sum calculated for each country where orders were shipped.
--While calculating the sum take into account the value of the discount (Discount).

select o.ship_country 
, round(sum(od.unit_price  * od.quantity  *(1- od.discount))::numeric (10, 2), 2) as Sum
from orders o 
join order_details od 
on o.order_id = od.order_id 
group by o.ship_country 

select o.shipcountry 
, round(sum(od.unitprice  * od.quantity  *(1- od.discount)), 2) as Sum
from orders o 
left join [order details] od 
on o.orderid = od.orderid 
group by o.shipcountry 

--Show the list of product categories along with total ordering sums (considering Discount) calculated 
--for the orders made for the products of each category, during the year 1997.

select c.category_name 
, round(sum(od.unit_price  * od.quantity  *(1- od.discount))::numeric (10, 2), 2) as Sum
from categories c 
left join products p 
on c.category_id =p.category_id 
left join order_details od 
on p.product_id = od.product_id 
join orders o 
on od.order_id = o.order_id and extract (year from o.shipped_date) = 1997
group by c.category_name 

select c.CategoryName 
, round(sum(od.unitprice  * od.quantity  *(1- od.discount)), 2) as Sum
from categories c 
left join products p 
on c.categoryid =p.categoryid 
left join [order details] od 
on p.productid = od.productid 
join orders o 
on od.orderid = o.orderid and strftime('%Y', o.shippeddate) like '1997'
group by c.categoryname 

--Show the list of product names along with unit prices and the history of unit prices taken from the orders 
--(show ‘Product name – Unit price – Historical price’). The duplicate records should be eliminated. 
--If no orders were made for a certain product, then the result for this product should look like ‘Product name – Unit price – NULL’. 
--Sort the list by the product name.

select distinct p.product_name 
, p.unit_price 
, od.unit_price 
from products p 
left join order_details od 
on p.product_id = od .product_id 
order by p.product_name

select distinct ProductName 
, p.unitprice as UnitPrice
, od.unitprice as HistoricalPrice
from products p 
left join [order details] od 
on p.productid = od .productid 
order by p.productname

--Show the list of employees’ names along with names of their chiefs (use left join with the same table).
select  e2.last_name 
, e2.first_name 
, e.last_name as ChiefLastName
, e.first_name as ChiefFirstName
from employees e2 
left join employees e
on  e.employee_id = e2.reports_to

select  e2.lastname 
, e2.firstname 
, e.lastname as ChiefLastName
, e.firstname as ChiefFirstName
from employees e2 
left join employees e 
on e.employeeid = e2.reportsto 

-- Show the list of cities where employees and customers are from. Duplicates should be eliminated.

select distinct c.city 
from customers c 
union
select distinct e.city
from employees e
order by 1

select distinct c.city 
from customers c 
union
select distinct e.city
from employees e
order by 1