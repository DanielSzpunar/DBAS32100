/*

If an element can have a null chances are OUTER JOIN is best suited.
select * FROM HR.employees emp 
left outer JOIN hr.employees mgr on emp.manager_id = mgr.employee_id;
ctrl + f7
-- is to comment out one line.

COnnect by prior, th efirst is the left point of the join and the second is the right part of the join.
When in doubt play with it both ways.

AGGREGATE FUNCTIONS:
take all the info from a column and returns one value ie sum, min,max,avg,count

ANALYTIC FUNCTIONS:
On module extra resource third link down second one fomr the bottom. Analytic functions concepts and reading.
*/
/*
SELECT
     mgr.first_name, mgr.last_name
FROM
    hr.employees emp
    LEFT OUTER JOIN hr.employees mgr
    ON emp.manager_id = mgr.employee_id
where emp.first_name = 'John' AND emp.last_name = 'Chan';


SELECT employee_id,department_id, 
       COUNT(*) AS dept_count
  FROM hr.employees
 WHERE department_id IN (20, 30)
 GROUP BY employee_id, department_id;
 
 
 SELECT employee_id, department_id, 
       COUNT(*) OVER (PARTITION BY department_id) AS dept_count
  FROM hr.employees
 WHERE department_id IN (20, 30);

SELECT employee_id, salary, department_id, 
       COUNT(*) OVER (
            PARTITION BY department_id 
            ORDER BY salary DESC
        ) AS dept_count
  FROM hr.employees
 WHERE department_id IN (20, 30);

*/
select  * from sh.costs;


/*

Write a SQL statement that returns the difference between the product
cost in every transaction made on 'January 29, 2000' (time_id) and the
average cost of all the products in all the transaction

*/
SELECT *
FROM sh.costs
WHERE time_id = '29-JAN-2000';

SELECT AVG(unit_price) as "Average Cost"
FROM sh.costs
WHERE tie_id = '29-JAN-2000';
/*
SELECT
c.prod_id,
prod_name,
unit_cost,
round(unit_c*/
/*
SELECT
    c.prod_id
   ,prod_name
   ,unit_cost
   ,time_cost
   ,SUM(unit_cost) over (RANGE BETWEEEN INTERVAL '5' DAY PRECEDING AND CURRENT ROW) as "test"
FROM
    sh.costs
    INNER JOIN sh.products p
    ON c.prod_id = p.prod_id
ORDER
    by c.time_id;
    */
    /*
SELECT
    *
FROM
    (
        SELECT
            c.prod_id
           ,prod_name
           ,unit_price
           ,DENSE_RANK() OVER(
                ORDER BY
                    unit_price NULLS LAST
            ) AS "all_ranks"
        FROM
            sh.costs c
            INNER JOIN sh.products p
            ON c.prod_id = p.prod_id
    )
WHERE
    ranks = 2;
    */
    

    

    
    

