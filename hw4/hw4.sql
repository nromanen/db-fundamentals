-- 1. Write a query to get Product name and quantity/unit.
select product_name, quantity_per_unit
    from products;

-- 2. Write a query to get current Product list (Product ID and name).
select product_id, product_name
    from products
where discontinued = 1;

-- 3. Write a query to get discontinued Product list (Product ID and name).
select product_id, product_name
from products
where discontinued = 0;

-- 4. Write a query to get most expense and least expensive Product list (name and unit price)
select product_name, unit_price
    from products
where unit_price = (select max(unit_price) from products) or unit_price = (select min(unit_price) from products);

-- 5. Write a query to get Product list (id, name, unit price) where current products cost less than $20.
select product_id, product_name, unit_price
    from products
where discontinued = 1 and unit_price > 20;

-- 6. Write a query to get Product list (id, name, unit price) where products cost between $15 and $25
select product_id, product_name, unit_price
    from products
where unit_price between 15 and 25;

-- 7. Write a query to get Product list (name, unit price) of above average price.
select product_name, unit_price
    from products
where unit_price > (select avg(unit_price) from products);

-- 8. Write a query to get Product list (name, unit price) of ten most expensive products
select product_name, unit_price
    from products
order by unit_price desc limit 10;

-- 9. Write a query to count current and discontinued products.
select count(*), discontinued
    from products
group by discontinued;

-- 10. Write a query to get Product list (name, units on order , units in stock) of stock is less than the quantity on order
select product_name, units_on_order, units_in_stock
    from products
where units_in_stock < products.units_on_order;