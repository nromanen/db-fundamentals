-- 1. Show the total ordering sum calculated for each country of customer.

select c.country, sum(od.unit_price * od.quantity * (1 - od.discount)) as total_ordering_sum
from orders o
         inner join customers c on o.customer_id = c.customer_id
         inner join order_details od on o.order_id = od.order_id
group by c.country;



-- 2. Show the list of product categories along with total ordering sums calculated for the orders made for the products of
-- each category, during the year 1997.

select c.category_id,
       c.category_name,
       sum(od.unit_price * od.quantity * (1 - od.discount)) as total_ordering_sum
from categories c
         inner join products p on c.category_id = p.category_id
         inner join order_details od on p.product_id = od.product_id
         inner join orders o on od.order_id = o.order_id
where extract(year from o.order_date) = 1997
group by c.category_id;


-- 3. Show the list of product names along with unit prices and the history of unit prices taken from the orders (show
-- ‘Product name – Unit price – Historical price’). The duplicate records should be eliminated. If no orders were made
-- for a certain product, then the result for this product should look like ‘Product name – Unit price – NULL’. Sort the list
-- by the product name.

select distinct p.product_name, p.unit_price, od.unit_price as historical_price
from products p
         left join order_details od on p.product_id = od.product_id
where p.unit_price != od.unit_price
order by p.product_name;