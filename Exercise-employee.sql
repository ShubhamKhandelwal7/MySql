CREATE TABLE Departments
(
ID INTEGER PRIMARY KEY,
NAME VARCHAR(20)
);

CREATE TABLE Employees
(
ID INTEGER PRIMARY KEY,
Name VARCHAR(20),
Salary INTEGER,
DEPARTMENT_ID INTEGER,
FOREIGN KEY (DEPARTMENT_ID) REFERENCES Departments(ID)
);

CREATE TABLE Commissions
(
ID INTEGER PRIMARY KEY,
EMPLOYEE_ID INTEGER,
COMMISSION_AMOUNT INTEGER,
FOREIGN KEY (EMPLOYEE_ID) REFERENCES Employees(ID)
);

CREATE UNIQUE INDEX index_id_dept ON Departments (ID);
CREATE UNIQUE INDEX index_id_emp ON Employees (ID);
CREATE UNIQUE INDEX index_id_comm ON Commissions (ID);
 

INSERT INTO Departments
VALUES (1,'Banking'),
(2,'Insurance'),
(3,'Services');

INSERT INTO Employees
VALUES (1,'Chris Gayle',1000000,1),
(2,'Michael Clarke',800000,2),
(3,'Rahul Dravid',700000,1),
(4,'Ricky Pointing',600000,2),
(5,'Albie Morkel',650000,2),
(6,'Wasim Akram',750000,3);

INSERT INTO Commissions
VALUES (1,1,5000),
(2,2,3000),
(3,3,4000),
(4,1,4000),
(5,2,3000),
(6,4,2000),
(7,5,1000),
(8,6,5000);


SELECT emp.name, sum(comm.COMMISSION_AMOUNT) 
FROM employees AS emp
JOIN Commissions AS comm ON emp.ID = comm.employee_ID
GROUP BY comm.employee_ID
HAVING sum(comm.COMMISSION_AMOUNT)>=ALL(
SELECT sum(comm.COMMISSION_AMOUNT) 
FROM Commissions AS comm 
GROUP BY comm.employee_id);

SELECT name,max(salary) 
FROM employees
WHERE salary NOT IN(SELECT * FROM(
SELECT salary FROM employees 
ORDER BY salary DESC LIMIT 3) temp);
-- another easier approach for the same problem --
SELECT name,salary FROM employees 
ORDER BY salary DESC LIMIT 3,1;

SELECT dept.name,sum(comm.Commission_amount) 
FROM Commissions  AS comm 
JOIN Employees AS emp ON comm.employee_id=emp.id
JOIN Departments AS dept ON emp.department_id=dept.id
GROUP BY comm.employee_id
HAVING sum(comm.commission_amount)>=ALL(
SELECT sum(comm.Commission_amount) FROM Commissions AS comm
GROUP BY comm.employee_id);

SELECT CONCAT(group_CONCAT(emp.name order by emp.name),' ',comm.Commission_amount) AS Employees 
FROM Commissions AS comm
JOIN employees AS emp ON comm.employee_id=emp.id
WHERE comm.commission_amount>3000
GROUP BY comm.Commission_amount
