--1. Show the list of French customers’ names who are working in the same cities.

select c1.contact_name as contact_name1
	,c2.contact_name as contact_name2
	,c1.city
from customers as c1, customers as c2
where c1.customer_id <> c2.customer_id
	and c1.country = 'France'
	and c2.country = 'France'
	and c1.city = c2.city
order by c1.city

--2. Show the list of German suppliers’ names who are not working in the same cities.

select s1.company_name as company_name1
	,s1.country
	,s1.city as company_city1
	,s2.company_name as company_name2
	,s2.city as company_city2
from suppliers as s1, suppliers as s2
where s1.supplier_id <> s2.supplier_id
	and s1.country = 'Germany'
	and s2.country = 'Germany'
	and s1.city <> s2.city
order by s1.city

--1. Show the count of orders made by each customer from France.

select c.customer_id
	,c.contact_name
	,count(o.order_id) as count_of_orders 
from customers as c, orders as o
where c.country = 'France'
	and c.customer_id = o.customer_id
group by c.customer_id
order by c.customer_id 

--2. Show the list of French customers’ names who have made more than one order.

select c.contact_name
	,c.country
	,count(o.order_id) as orders
from customers as c, orders as o
where c.country = 'France'
	and c.customer_id = o.customer_id
group by c.customer_id
having count(o.order_id) > 1



--1. Show the list of customers’ names who used to order the ‘Tofu’ product.

select c.contact_name
	,p.product_name 
from customers as c
join orders as o
	on o.customer_id = c.customer_id
join order_details as od 
	on od.order_id = o.order_id
join products as p
	on p.product_id = od.product_id
	where p.product_name = 'Tofu'
order by c.contact_name 
	
--2. Show the list of French customers’ names who used to order nonFrench products.

select c.contact_name
	,s.country 
from customers as c
join orders as o
	on o.customer_id = c.customer_id
join order_details as od
	on od.order_id = o.order_id 
join products as p
	on p.product_id = od.product_id
join suppliers as s
	on s.supplier_id = p.supplier_id
where c.country = 'France' and s.country <> 'France'
group by c.contact_name, s.country
order by c.contact_name



--3. Show the list of French customers’ names who used to order French products.

select c.contact_name
	,s.country 
from customers as c
join orders as o
	on o.customer_id = c.customer_id
join order_details as od
	on od.order_id = o.order_id 
join products as p
	on p.product_id = od.product_id
join suppliers as s
	on s.supplier_id = p.supplier_id
where c.country = 'France' and s.country = 'France'
group by c.contact_name, s.country
order by c.contact_name

--1. Show the total ordering sum calculated for each country of customer.

select c.country
	,sum(od.unit_price * od.quantity) as total_sum
from customers as c
join orders as o
	on o.customer_id = c.customer_id
join order_details as od
	on od.order_id = o.order_id
group by c.country
order by c.country
	
--2. Show the list of product categories along with total ordering sums calculated for the orders made for the products of each category, during the year 1997.

select c.category_id
	,c.category_name
	,sum(od.unit_price * od.quantity) as total_sum
from categories as c
join products as p
	on p.category_id = c.category_id
join order_details as od 
	on od.product_id = p.product_id
join orders as o 
	on o.order_id = od.order_id 
	where extract(year from o.order_date) = '1997'
group by c.category_id
order by c.category_id
	
--3. Show the list of product names along with unit prices and the history of unit prices taken from the orders (show ‘Product name – Unit price – Historical price’). The duplicate records
--should be eliminated. If no orders were made for a certain product, then the result for this product should look like ‘Product name – Unit price – NULL’. Sort the list by the product name.

select distinct p.product_name
	,p.unit_price 
	,od.unit_price AS historical_price
from products as p
left join order_details as od 
	on od.product_id = p.product_id 
order by p.product_name