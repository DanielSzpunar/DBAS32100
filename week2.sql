/*Week #2:
For UNION and UNION ALL to work,
1. the Number of columns
2. the DataTypes
3. the order of the columns

must be the same. Otherwise the output will either result in error
or display data that is not specified.

UNION combines rows from 2 or more tables where JOIN combines from 2 or more tables.

EXAMPLE OF UNION: 

SELECT cust_id, cust_fist_name, cust_last_name
    FROM sh.customers
    WHERE cust_id IN (101,102,103)
UNION
SELECT cust_id, cust_first_name, cust_last_name
    FROM sh.customers
    WHERE cust_id IN (103,104,105)

**This will only display 103 once, since UNION does not display
duplicates.

UNION ALL will display 103 twice since it returns results from
both queries including duplicates.

MINUS returns the results of the first input query that
do not appear in the rsults of the second query.

SELECT cust_id, cust_first_name, cust_last_name
  FROM sh.customers
 WHERE cust_id in (101, 102, 103)
 MINUS
SELECT cust_id, cust_first_name, cust_last_name
  FROM sh.customers
 WHERE cust_id in (103, 104, 105);
 
**ONLY 101 and 102 would appear in the results...**


INTERSECT retuns a distinct set of rows that appear in all queries
SELECT cust_id, cust_first_name, cust_last_name
     FROM sh.customers
    WHERE cust_id in (101, 102, 103)
INTERSECT
   SELECT cust_id, cust_first_name, cust_last_name
     FROM sh.customers
    WHERE cust_id in (103, 104, 105);
    
**Only 103 will be returned since it appear in both queries.

*/

/*Aggregate Functions:
5 MAIN aggregate functions are as follows:

COUNT()
SUM()
AVG()
MIN()
MAX()
Aggregate functions work across multiple rows in a table
and they return one single value.

HOW many employees are in the HR database?
SELECT
    count(*) AS "Total Number of Employees"
FROM
    hr.employees;

What is the total amount of money payed monthly as salaries?

SELECT SUM(salary) AS "Total Salary"
FROM hr.employees;


What is the average salary?
SELECT AVG(salary)
FROM hr.employees;


Aggregate functions can be used in combination with scalar functions.
For example, we can round off the average od employees from the previous
example by using round.

SELECT ROUND(AVG(salary), 2)
FROM hr.employees;

Using aggregate functions can also be used with DATE:
SELECT MAX(hire_date) AS "Last Hire"
FROM hr.employees;


What is the minimum salary of the minimum salary of all jobs?
SELECT MIN(min_salary)
FROM hr.jobs;

SELECT employee_id, MIN(salary)
FROM hr.employees;
THE ABOVE IS WRONG!!!
Simple fields cannot be combined with aggregate functions.


GROUPT BY:
With an aggregate function you cannot put a field in the 
select clause that is not included in the GROUP BY
clause. If you wish to see the department_id you must also put
department_id in the GROUP BY clause


SELECT COUNT(*) AS "No. of Employees"
FROM hr.employees e
JOIN hr.departments d
ON e.department_id = d.department_id
WHERE UPPER(department_name) = 'SHIPPING';

SELECT department_name, COUNT(*) AS "No of employees"
FROM HR.employees e
JOIN HR.departments d
ON e.department_id = d.department_id
GROUP BY department_name;

SELECT department_name, COUNT(*) AS "No. of Employees"
  FROM hr.employees e
  JOIN hr.departments d
    ON e.department_id= d.department_id
 GROUP BY department_name;

 SELECT d.department_id, department_name, COUNT(*) AS "No. of Employees", 
       ROUND(AVG(salary),2) AS "Average Salary"
  FROM hr.employees e
  JOIN hr.departments d
    ON e.department_id = d.department_id
 WHERE UPPER(department_name) IN ('SHIPPING','SALES', 'IT')
 GROUP BY d.department_id, department_name;
*/


























