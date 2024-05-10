use assignment_1; 

/*Task 1: 
Create a new database user with 
username 'ezrentadmin' and password '3ZRent@dm1n' 
and grant all privileges for the EZRent database.*/

DROP USER 'ezrentadmin'@'localhost' ; 

CREATE USER  'ezrentadmin'@'localhost' IDENTIFIED BY '3ZRent@dm1n'; 

GRANT ALL ON assignment_1. * to 'ezrentadmin'@localhost; 

SHOW GRANTS FOR 'ezrentadmin'@localhost; 

/*Task 2: 
Create a view named 'Employees_Performance' for the SELECT 
statement written for Assignment # 2 Task # 3 */

CREATE VIEW Employees_Performance AS
SELECT e.ENumber, CONCAT(e.FName, ' ', COALESCE(e.MName, ''),
 ' ', e.LName) AS Employee_Name, COUNT(c.CNumber) AS NumContracts
FROM employee e
LEFT JOIN contract c ON e.ENumber = c.Executed_By WHERE e.EStatus = 'Active'
GROUP BY e.ENumber, Employee_Name;

SELECT * FROM Employees_Performance; 
SELECT * FROM employee; 


/*Task 3: 
Build a program that connects successfully to the
EZRent database with the user created in Task # 1.*/


