/*1. Calculate the greatest, the smallest and the average age among the employees from London.*/

select extract(year from max(age(now(), birth_date))) as "Greatest Age"
, extract(year from min(age(now(), birth_date))) as "Smallest Age"
, extract(year from avg(age(now(), birth_date))) as "Avarage Age"
from employees 
where city like 'London';


/*2. Calculate the greatest, the smallest and the average age of the employees for each city.*/

select city
, extract(year from max(age(now(), birth_date))) as "Greatest Age"
, extract(year from min(age(now(), birth_date))) as "Smallest Age"
, extract(year from avg(age(now(), birth_date))) as "Avarage Age"
from employees 
group by city;


/*3. Show the list of cities in which the average age of employees is greater than 60 (the average age is also to be shown).*/

select city
, extract(year from avg(age(now(), birth_date))) as "Avarage Age"
from employees
group by city
having  extract(year from avg(age(now(), birth_date))) > 60;

/*4. Show the first and last name(s) of the eldest employee(s).*/

select first_name
, last_name 
from employees 
order by birth_date asc limit 1;

/*5. Show first, last names and ages of 3 eldest employees.*/

select first_name
, last_name 
, extract(year from age(now(), birth_date)) as age
from employees 
order by birth_date asc limit 3;
