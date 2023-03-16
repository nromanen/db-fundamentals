select * from Employees where EmployeeID = 8;

select FirstName, LastName from Employees where City like 'London';

select FirstName, LastName from Employees where FirstName like 'A%'

select COUNT(EmployeeID) as 'COUNT(FirstName)' from Employees where City like 'London';

