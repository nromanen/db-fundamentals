--Show the total ordering sum calculated for each country of customer.
select c.country
, sum(cast(od.unit_price * od.quantity * (1 - od.discount) as numeric(20, 2))) as sum  
from customers c
inner join orders o on c.customer_id = o.customer_id 
inner join order_details od on o.order_id = od.order_id 
group by c.country
order by sum desc;

--Show the list of product categories along with total ordering sums calculated for the orders made for the products of each category, 
--during the year 1997.
select
	c.category_name 
,	sum(od_1997.sum_od)::numeric(15, 2)  as sum
from
	categories c
inner join products p on
	c.category_id = p.category_id
inner join (
	select
		od.product_id
		, (od.unit_price * od.quantity * (1 - od.discount)) as sum_od
	from
		order_details od
	inner join orders o on
		od.order_id = o.order_id
	where
		cast(extract(year from o.order_date) as varchar(4)) = '1997') od_1997 on
	p.product_id = od_1997.product_id
group by
	c.category_id,
	c.category_name;

/* Show the list of product names along with unit prices and the history of unit prices taken from the orders 
 * (show ‘Product name – Unit price – Historical price’). 
 * The duplicate records should be eliminated. If no orders were made for a certain product, 
 * then the result for this product should look like ‘Product name – Unit price – NULL’. Sort the list by the product name.
 */
select distinct p.product_name as "Product Nam"
, (p.unit_price)::numeric(15, 2) as "Unit Price"
, (od.unit_price)::numeric(15, 2) as "Historical Price"
from Products p 
left join order_details od on p.product_id = od.product_id 
order by p.product_name;