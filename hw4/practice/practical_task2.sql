-- 1. Calculate the greatest, the smallest and the average age among the employees from London.
select max(extract(year from age(birth_date)))
       ,min(extract(year from age(birth_date)))
       , avg(extract(year from age(birth_date)))
from employees
where city like 'London';


-- 2. Calculate the greatest, the smallest and the average age of the employees for each city.
select city, max(extract(year from age(birth_date)))
           ,min(extract(year from age(birth_date)))
           , avg(extract(year from age(birth_date)))
    from employees
group by city;


-- 3. Show the list of cities in which the average age of employees is greater than 60 (the average age is also to be
-- shown)
select city, avg(extract(year from age(birth_date))) as average_age_of_employees
   from employees
group by city
having avg(extract(year from age(birth_date))) > 60;


-- 4. Show the first and last name(s) of the eldest employee(s).

-- select first_name, last_name
--     from employees
-- where extract(year from age(birth_date)) = (select max(extract(year from age(birth_date))) from employees);

select first_name, last_name
    from employees
order by birth_date limit 1;


-- 5. Show first, last names and ages of 3 eldest employees.
select first_name, last_name, extract(year from age(birth_date)) as employees_age
from employees
order by birth_date limit 3;