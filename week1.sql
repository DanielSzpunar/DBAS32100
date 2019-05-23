/*To review some of the SQL statements you have learned in Database
Design and Implementation and get familiar with HR, SH and SI
databases, try the following exercises:
1. Using HR database find out:
a) How much does Amit Banda earn?
b) What are the addresses of the company locations in Tokyo?
c) What is the difference between max_salary and min_salary for the president of
the company?
2. Using SH database show:
 How many promotion categories are there.
3. Using SI database
Who are the customers that are interested in buying 2016 Jaguar XE
*/

/*
SELECT
    salary
   ,first_name
   ,last_name
FROM
    hr.employees
WHERE
    last_name = 'Banda'
    AND first_name = 'Amit';
*/
/*
SELECT
    street_address
FROM
    hr.locations
WHERE
    city = 'Tokyo';
*/

/* Why cant I add more to this? E.g. I want to ', job_title'
SELECT
    AVG(max_salary - min_salary) AS average_salary_of_pres
FROM
    hr.jobs
WHERE
    job_title = 'President';
*/


SELECT COUNT(promo_category) AS promotion_catagories
FROM SH.Promotions;

select * from SH.Promotions;


/*Who are the customers that are interested in buying 2016 Jaguar XE?*/
/*No solution as of yet.*/


/*Using HR database, find the department(s) that are located in 'Toronto'.*/
/*

SELECT column_name(s)
FROM table1
INNER JOIN table2
ON table1.column_name = table2.column_name;

SELECT [the column names you want returned to you.]
FROM [the first TABLE this would be the left table if LEFT INNER JOIN]
INNER JOIN [the second table you wished to join]
ON [table1.coloumnName that is also shared in table2.columns]
ON table1.column_name = table2.column_name;
*/
/*Return what departments are located in Toronto.*/
/*Explicit
SELECT
    city
   ,department_name
FROM
    hr.departments
    JOIN hr.locations
    ON departments.location_id = locations.location_id
WHERE
    city = 'Toronto';
*/

/*Implicit

SELECT
    city
   ,department_name
FROM
    hr.departments
   ,hr.locations
WHERE
    departments.location_id = locations.location_id
    AND city = 'Toronto';
*/

/*  Equijoins 
They use using


SELECT
    city
   ,department_name
FROM
    hr.departments
    JOIN hr.locations
    USING ( location_id )
WHERE
    city = 'Toronto';
*/

/*EXPLICIT Join*/
SELECT department_name, city
FROM HR.departments
JOIN HR.Locations
ON departments.location_id = locations.location_id
WHERE city = 'Toronto';

/*IMPLICIT*/
SELECT department_name,city
FROM HR.departments, HR.Locations
WHERE departments.location_id = locations.location_id AND city = 'Toronto';


/*Equijoin
Still uses JOIN 
*/
SELECT city, department_name
FROM HR.departments
JOIN HR.locations
USING ( location_id )
WHERE city = 'Toronto';

/*
Natural Join
The joining columns are not specified
The database autmatically joins the tables on all columns that have
the same name in both tables.
*/
SELECT
     city
    ,department_name
 FROM
     hr.departments 
NATURAL JOIN HR.locations
WHERE city = 'Toronto';


/*Using Aliases
Right after you declare the table you will use give it a nickname in the example below we used
d for departments and l for locations
*/

SELECT
    city
   ,department_name
FROM
    hr.departments d
    INNER JOIN hr.locations l
    ON d.location_id = l.location_id
WHERE
    city = 'Toronto';
    
/*
JOINING MORE THAN TWO TABLES:
exercise 1.5
Using the HR table show the region in which each department is located.
DEPARTMENTS to locations to countries to regions 
*/
SELECT department_name, city, region_name
FROM HR.departments d
INNER JOIN HR.locations l
ON d.location_id = l.location_id
INNER JOIN HR.countries c
ON l.country_id = c.country_id
INNER JOIN HR.regions r
ON c.region_id = r.region_id;



SELECT first_name, last_name
FROM HR.Employees WHERE last_name like ('O___n');


SELECT substr('Welcome',4,4) FROM DUAL;

SELECT first_name,last_name, end_date
FROM hr.employees e
LEFT OUTER JOIN hr.job_history jh
ON e.employee_id = jh.employee_id;






































