-- 1. Create a report showing the first and last name of all sales representatives who are from Seattle or Redmond.

select first_name, last_name, city
    from employees
where city in ('Seattle', 'Redmond');

-- 2. Create a report that shows the company name, contact title, city and country
--     of all customers in Mexico or in any city in Spain except Madrid.

select company_name, contact_title, city, country
    from customers
where country in ('Mexico','Spain') and city not like 'Madrid';