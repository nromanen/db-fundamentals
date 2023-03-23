/*Practice*/
/*1. Show the list of French customers’ names who are working in the same cities.*/

select c.company_name
, c2.company_name 
, c.city
, c2.city
from customers c, customers c2 
where c.customer_id != c2.customer_id 
and c.city = c2.city 
and c.country = 'France';

/*2. Show the list of German suppliers’ names who are not working in the same cities.*/

select s.company_name 
, s2.company_name 
, s.city 
, s2.city 
from suppliers s, suppliers s2 
where s.supplier_id != s2.supplier_id 
and s.city != s2.city 
and s.country = 'Germany'
and s2.country = 'Germany';

/*Practice*/
/*1. Show the count of orders made by each customer from France.*/

select c.company_name 
, count(o.order_id)
from customers c join orders o 
on c.customer_id = o.customer_id 
where c.country = 'France'
group by c.customer_id;

/*2. Show the list of French customers’ names who have made more than one order.*/

select c.company_name 
, count(o.order_id)
from customers c join orders o 
on c.customer_id = o.customer_id 
where c.country = 'France' 
group by c.customer_id
having count(o.order_id) > 1;

/*Practice*/
/*1. Show the list of customers’ names who used to order the ‘Tofu’ product.*/

select c.company_name 
from customers c 
join orders o on c.customer_id = o.customer_id 
join order_details od on od.order_id = o.order_id 
join products p on p.product_id = od.product_id 
where p.product_name = 'Tofu';

/*2. Show the list of French customers’ names who used to order non-French products.*/

select distinct c.company_name 
from customers c 
join orders o on c.customer_id = o.customer_id 
join order_details od on o.order_id = od.order_id 
join products p on p.product_id = od.product_id 
join suppliers s on s.supplier_id = p.supplier_id 
where c.country = 'France' and s.country !='France';

/*3. Show the list of French customers’ names who used to order French products.*/

select distinct c.company_name 
from customers c 
join orders o on c.customer_id = o.customer_id 
join order_details od on o.order_id = od.order_id 
join products p on p.product_id = od.product_id 
join suppliers s on s.supplier_id = p.supplier_id 
where c.country = 'France' and s.country = 'France';

/*Home work*/
/*1. Show the total ordering sum calculated for each country of customer.*/

select c.country 
, sum(od.quantity*od.unit_price)
from customers c 
join orders o on o.customer_id = c.customer_id 
join order_details od on od.order_id = o.order_id 
group by c.country;

/*2. Show the list of product categories along with total ordering sums calculated for the orders made for the products 
  of each category, during the year 1997.*/

select c.category_name 
, sum(od.quantity*od.unit_price)
from categories c 
join products p on c.category_id = p.category_id 
join order_details od on od.product_id = p.product_id 
join orders o on o.order_id = od.order_id 
where extract(year from o.order_date) = 1997
group by c.category_id;

/*3. Show the list of product names along with unit prices and the history of unit prices taken from the orders 
  (show ‘Product name – Unit price – Historical price’). The duplicate records should be eliminated. If no orders were made for 
  a certain product, then the result for this product should look like ‘Product name – Unit price – NULL’. Sort the list by the 
  product name.*/

select distinct p.product_name 
, p.unit_price 
, od.unit_price as historical_price
from products p
left join order_details od on p.product_id = od.product_id 
where p.unit_price != od.unit_price 
order by p.product_name;






