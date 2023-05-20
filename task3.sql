1. --Return all the fields about all the ship--per
sselect *
from Shippers

2. --selecting all the fields using this SQL: 
   --select * from Categories 
   --…will return 4 columns. We only want to see two columns, CategoryName and Description.
 select CategoryName, Description
 from Categories
 
 3. --We’d like to see just the FirstName, LastName, and HireDate of all the employees with
    --the value 'Sales Representative' in the  Title field. Write a SQL statement that returns only those employees.
select FirstName, LastName, HireDate
from Employees
where Title = 'Sales Representative'

4. --show the SupplierID, ContactName, and ContactTitle for those Suppliers whose ContactTitle is not 'Marketing Manager'
