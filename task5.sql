--0.1. Show info about the products, whether the quantity is higher in stock or on order.

select
	p.product_name
	,case
		when p.units_in_stock > units_on_order then 'more in stock'
		when p.units_in_stock < units_on_order then 'more on order'
		else 'equal on stock and on order'
	end
from products p

--------------------------------------------------------------------------------------

--1. We'd like to show, for each product, the associated Supplier from Germany and Spain. Show the ProductID, ProductName,
--and the CompanyName of the Supplier. Sort by ProductID.

select
    p.product_id
    ,p.product_name
    ,s.company_name
from products p
join suppliers s on p.supplier_id = s.supplier_id
where s.country in ('Germany', 'Spain')

--------------------------------------------------------------------------------------

--2. We’d like to show a list of the Orders that were made, including the Shipper that was used. Show the OrderID,
--OrderDate (date only with alias ShortDate), and CompanyName of the Shipper, and sort by OrderID.
--Show only those rows with an OrderID of less than 10260.

select
    o.order_id
    ,o.order_date  as ShortDate
    ,s.company_name
from orders o
join shippers s on o.ship_via = s.shipper_id
where o.order_id < 10260

--------------------------------------------------------------------------------------

--3. We're doing inventory, and need to show information about OrderID, a list of products, and their quantity
--for orders which were shipped by Leverling Janet with quantities greater than 50.
--The result should be sorted by OrderID.

select
    o.order_id
    ,p.product_name
    ,od.quantity
from orders o
join order_details od on o.order_id = od.order_id
join products p on p.product_id = od.product_id
join employees e on o.employee_id = e.employee_id
where e.last_name = 'Leverling' and e.first_name = 'Janet'
and od.quantity > 50
order by od.quantity

--------------------------------------------------------------------------------------

--4. There are some customers who have never actually placed an order. Show these customers.

select c.company_name
from customers c
left join orders o on c.customer_id = o.customer_id
where o.order_id is Null

--------------------------------------------------------------------------------------

--5. One employee (Margaret Peacock, EmployeeID 4) has placed the most orders. However, there are some customers
--who've never placed an order with her. Show only those customers who have never placed an order with her.

select c.company_name
from customers c
left join orders o on c.customer_id = o.customer_id and o.employee_id = 4
where o.order_id is Null

--------------------------------------------------------------------------------------

--6. We want to send all of our high-value customers a special VIP gift. We're defining high-value customers as those
--who've made at least 1 order with a total value (not including the discount) equal to $10,000 or more.
--We only want to consider orders made in the year 2016.
--Use the alias TotalOrderAmount for the calculated column. Order by the total amount of the order, in descending order.

select
    c.customer_id
    ,c.company_name
    ,o.order_id
    ,sum(od.unit_price * od.quantity)::numeric::money as total_order_amount
from customers c
join orders o on c.customer_id = o.customer_id
join order_details od on o.order_id = od.order_id
where extract(year from o.order_date) = 1996
group by c.customer_id, o.order_id
having sum(od.unit_price * od.quantity)  > 10000
order by sum(od.unit_price * od.quantity) desc

--------------------------------------------------------------------------------------

--7. We want to send all of our high-value customers a special VIP gift.
--We're defining high-value customers as those who have orders totaling $15,000 or more in 2016 (not including the discount).
--Use the alias TotalOrderAmount for the calculated column. Order by the total amount of the order, in descending order.

select
    c.customer_id
    ,c.company_name
    ,sum(od.unit_price * od.quantity)::numeric::money as total_order_amount
from customers c
join orders o on c.customer_id = o.customer_id
join order_details od on o.order_id = od.order_id
where extract(year from o.order_date) = 1997
group by c.customer_id
having sum(od.unit_price * od.quantity)  > 15000
order by sum(od.unit_price * od.quantity) desc

--------------------------------------------------------------------------------------

--8. We want to send all of our high-value customers a special VIP gift. We're defining high-value customers
--as orders totaling $15,000 or more in 2016.  The result set should include the column TotalOrderAmount
--with the total sum not including the discount, and the column TotalWithDiscount with the total sum including the discount.
--Order by TotalWithDiscount in descending order.

select
    c.customer_id
    ,c.company_name
    ,sum(od.unit_price * od.quantity)::numeric::money as total_order_amount
    ,sum(od.unit_price * od.quantity * (1 - od.discount))::numeric::money as total_with_discount
from customers c
join orders o on c.customer_id = o.customer_id
join order_details od on o.order_id = od.order_id
where extract(year from o.order_date) = 1997
group by c.customer_id
having sum(od.unit_price * od.quantity * (1 - od.discount)) > 15000
order by sum(od.unit_price * od.quantity) desc

--------------------------------------------------------------------------------------

--9. The Northwind mobile app developers are testing an app that customers will use to show orders.
--In order to make sure that even the largest orders will show up correctly on the app, they'd like some samples of orders
--that have lots of individual line items. Show the 10 orders with the most line items, in order of total line items.

select
    od.order_id
    ,count(od.product_id) as total_order_lines
from order_details od
group by od.order_id
order by count(od.product_id) desc
limit 10

--------------------------------------------------------------------------------------

--10. Some salespeople have more orders arriving late than others.
--Maybe they're not following up on the order process, and need more training.
--Which salespeople have the most orders arriving late?

select
    e.employee_id
    ,e.last_name
    ,count(*) as total_late_orders
from employees e
join orders o on e.employee_id = o.employee_id
where o.shipped_date > o.required_date
group by e.employee_id
order by count(*) desc, e.employee_id