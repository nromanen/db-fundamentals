/*------HW4-----*/
/*Task from Softserve Academy*/
/*
 * Task 1 
 *Given the Northwind database (see the structure below).
 *Show the list of first and last names and ages of the employees over 55. 
 *The result should be sorted by last name.
*/

select e.first_name 
, e.last_name 
, date_part('year',age(current_date,e.birth_date) )
from employees e 
where date_part('year',age(current_date,e.birth_date))>55

/*
 * Task 2
 * Given the Northwind database (see the structure below).
 * Calculate the greatest, the smallest and the average age among the employees from London.
 */
select max(date_part('year',age(current_date,em.birth_date))) as "Greatest"
, min(date_part('year',age(current_date,em.birth_date))) as "Smallest"
, avg(date_part('year',age(current_date,em.birth_date))) as "Average"
from employees em
where em.city like 'London';

/*
 * Task 3
 * Given the Northwind database (see the structure below).
 * Calculate the greatest, the smallest and the average age of the employees for each city.
 */

select em.city 
, max(date_part('year',age(current_date,em.birth_date))) as "Greatest"
, min(date_part('year',age(current_date,em.birth_date))) as "Smallest"
, avg(date_part('year',age(current_date,em.birth_date))) as "Average"
from employees em
where em.birth_date notnull 
group by em.city;

/*
 * Task 4
 * Given the Northwind database (see the structure below).
 * Show the FirstName and LastName columns from the Employees table, 
 * and then create a new column called FullName, showing FirstName and LastName joined together in one column, 
 * with a space in between for those employees, who live in the USA or Germany.
 */

SELECT first_name
, last_name  
, first_name || ' '||last_name  as full_name
from employees e 
WHERE country in ('USA','Germany')
