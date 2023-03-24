--Practice
--1. Show the list of French customers’ names who are working in the same cities.
select c1.company_name 
from customers c1, customers c2 
where c1.country = 'France'
and c1.city = c2.city 
and c1.customer_id != c2.customer_id;

--Show the list of German suppliers’ names who are not working in the same cities.
--поки не виходить
select s1.supplier_id, s1.company_name, s1.city
, s2.supplier_id, s2.company_name, s2.city 
from suppliers s1
join suppliers s2 on s1.supplier_id = s2.supplier_id 
and s1.country = 'Germany'
and s1.city != s2.city

select  from suppliers s 
where s.country = 'Germany'

--Show the count of orders made by each customer from France
select o.customer_id, count(o.customer_id) count_orders, c.country  
from orders o, customers c 
where o.customer_id = c.customer_id 
and c.country  = 'France'  
group by o.customer_id, c.country  


--Home work
--Show the total ordering sum calculated for each country of customer.
select c.country, sum(od.unit_price * od.quantity)
from customers c
join orders o on c.customer_id = o.customer_id 
join order_details od on od.order_id = o.order_id 
group by c.country 
order by c.country;

--Show the list of product categories along with total ordering sums 
--calculated for the orders made for the products of each category, 
--during the year 1997
select c.category_name, sum(od.unit_price * od.quantity * od.discount) 
from categories c 
join products p on c.category_id = p.category_id 
join order_details od on p.product_id = od.product_id 
join orders o on od.order_id = o.order_id
where date_part('year', o.order_date) = '1997'
group by c.category_name
order by c.category_name;

--Show the list of product names along with unit prices 
--and the history of unit prices taken from the orders 
--(show ‘Product name – Unit price – Historical price’). 
--The duplicate records should be eliminated. 
--If no orders were made for a certain product, 
--then the result for this product should look like ‘Product name – Unit price – NULL’. 
--Sort the list by the product name.
--??
select p.product_id, p.product_name, p.unit_price, o.order_date, od.unit_price  
from products p
left join order_details od on p.product_id = od.product_id 
left join orders o on od.order_id = o.order_id 
group by p.product_id, p.product_name, p.unit_price, o.order_date, od.unit_price 
order by p.product_name;


