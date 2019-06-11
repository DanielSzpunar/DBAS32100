/*
1. 
Using analytic functions display the highest and the lowest carsaleprice 
for each make in SI database and rank them based on the highest price in 
descending order. (5 marks)



2.
Using analytic functions return the name of the customer who bought the 
third most expensive car. (5 marks)

3. 
For each customer from London, return the price of the car they bought 
and the difference between that price and the average price of the cars 
sold in that city. (5 marks)

4.  
Options table is frequently used in queries that often require optionsedc 
as part of the condition. For example:
SELECT * FROM options WHERE optiondesc LIKE '%ROOF%';
Create an index that will improve the performance of this query. 
You can copy the table and the data from si.options table to test your code. 
Submit the code used for coping the table and the data, the code for creating 
the index, and the query performance with and without index as well as the 
results of your code execution and testing. You will have to use command 
line statements for explaining the plan and displaying it to be able to 
print the results on the console for coping. (5 marks)




5.
Place all the SQL code that would perform the above written steps in one single file and run it as a
single transaction. Submit the results of the whole transaction. (5 marks)
The transaction output must contain:
1. Remove the table (this step will allow you to run your transaction multiple times without errors. 
Comment it out when you run the transaction the first time)
2. Create the table and copy the data from si.options
3. Explain plan command for the query shown in the previous question.
4. Display the plan
5. Create index for optiondesc column
6. Explain plan command for the query shown in the previous question.
7. Display the plan

*/

/*
Using analytic functions display the highest and the lowest carsaleprice 
for each make in SI database and rank them based on the highest price in 
descending order. (5 marks)
*/

SELECT
    c.carmake   AS "CAR MAKE"
   ,MAX(s.carsaleprice) AS "HIGHEST"
   ,MIN(s.carsaleprice) AS "LOWEST"
   ,dense_RANK()       
 OVER(
    ORDER BY
        MAX(carsaleprice) DESC
) AS "RANK"
FROM
    si.saleinv s
    INNER JOIN si.car c
    ON s.carserial = c.carserial
GROUP BY
    c.carmake;



/*
select carmake, carsaleprice,
MIN(carsaleprice) KEEP (DENSE_RANK FIRST ORDER BY carsaleprice) OVER(
PARTITION BY carmake
)AS lowest,
MAX(carsaleprice) KEEP (DENSE_RANK LAST ORDER BY carsaleprice) OVER(
PARTITION BY carmake
) AS highest
FROM si.car c
INNER JOIN si.saleinv s
ON c.carserial = s.carserial
ORDER BY carmake,carsaleprice DESC;
*/
SELECT
     *
 FROM
     si.saleinv; 
     
SELECT
    carmake
   ,carsaleprice
   ,MIN(carsaleprice) KEEP(DENSE_RANK FIRST ORDER BY carsaleprice) OVER(
        PARTITION BY carmake
    ) AS lowest
   ,MAX(carsaleprice) KEEP(DENSE_RANK LAST ORDER BY carsaleprice) OVER(
        PARTITION BY carmake
    ) AS highest
   ,DENSE_RANK() OVER(
        PARTITION BY carmake
        ORDER BY
            carsaleprice DESC
    ) AS price_rank
FROM
    si.car c
    INNER JOIN si.saleinv s
    ON c.carserial = s.carserial
ORDER BY
    carsaleprice DESC;
--GROUP by carsaleprice,carmake
--ORDER BY carsaleprice DESC;
--Not sure what you mean by how to order them boss... 
--So I went with my gut..

/*
2. 
Using analytic functions return the name of the customer who bought the 
third most expensive car. (5 marks)

select * from si.customer;
select * from si.saleinv;
select * from si.car;

select * from si.saleinv;*/

WITH RESULT AS
(
select custname, carsaleprice,
DENSE_RANK() over (order by carsaleprice desc) as DENSERANK
from si.saleinv
)
SELECT custname, carsaleprice FROM RESULT where result.denserank = 3;

SELECT custname,carsaleprice,
DENSE_RANK() over (order by carsaleprice desc) AS car_price
FROM si.saleinv;

/*
3.
For each customer from London, return the price of the car they bought 
and the difference between that price and the average price of the cars 
sold in that city. (5 marks)

select * from si.car;
select * from si.customer where custcity = 'London';
select * from si.saleinv;
*/



/*
4. 
Options table is frequently used in queries that often require optiondesc 
as part of the condition. For example:
SELECT * FROM options WHERE optiondesc LIKE '%ROOF%';
Create an index that will improve the performance of this query. 
You can copy the table and the data from si.options table to test your code. 
Submit the code used for copying the table and the data, the code for creating 
the index, and the query performance with and without index as well as the 
results of your code execution and testing. You will have to use command 
line statements for explaining the plan and displaying it to be able to 
print the results on the console for copying. (5 marks)
*/

CREATE TABLE copy_options AS SELECT * FROM si.options;
--DROP TABLE copy_options;
select * from copy_options;
SELECT * FROM copy_options WHERE optiondesc LIKE '%ROOF%';
--EXPLAIN PLAN FOR SELECT * FROM copy_options WHERE optiondesc LIKE '%ROOF%';
--CREATE INDEX IXcopy_options_optiondesc ON copy_options (optiondesc asc);
CREATE INDEX IX_copy_options_optiondesc ON copy_options(optiondesc);
--DROP INDEX IXcopy_options_optiondesc;
SELECT * FROM table(dbms_xplan.display());
--CREATE BITMAP INDEX IX_test ON copy_options(copy_options.optiondesc)
--FROM copy_options WHERE copy_options.optiondesc LIKE '%ROOF%'; 











SELECT * FROM hr.employees;


SELECT * from si.saleinv;

SELECT c.carmake, MAX(s.carsaleprice)
FROM si.car c
INNER JOIN si.saleinv s
ON c.carserial = s.carserial
GROUP BY c.carmake;

SELECT c.carmake, MIN(s.carsaleprice)
FROM si.car c
INNER JOIN si.saleinv s
ON c.carserial = s.carserial
GROUP BY c.carmake;

SELECT carmake,carsaleprice, MIN(carsaleprice) OVER
(PARTITION BY carmake
ORDER BY carsaleprice) AS minsale_price FROM si.saleinv s
INNER JOIN si.car c
ON c.carserial = s.carserial;

/*
2.
Using analytic functions return the name of the customer who bought the 
third most expensive car. (5 marks)
*/
SELECT * FROM si.saleinv;

with result as
(
select carsaleprice,
row_number() over (order by carsaleprice desc) as rownumber
from si.saleinv
)
select carsaleprice, custname
from result
where rownumber = 3;

SELECT
    s.carserial
    , s.carsaleprice
    , s.carsaleprice
    , c.carmake
    , DENSE_RANK() OVER(
        PARTITION BY c.carmake
        ORDER BY
            s.carsaleprice DESC
    ) AS topsellingmake
FROM
    si.saleinv s
    inner join si.car c on s.carserial = c.carserial;
    

SELECT
    *
FROM
    (
        SELECT
            custname
            , DENSE_RANK() OVER(
                ORDER BY
                    carsaleprice DESC
            ) s
        FROM
            si.saleinv
    )
WHERE
    s = 3;


SELECT
    s.custname       AS "Customer"
   ,s.carsaleprice   AS "Purchase Price"
   , (
        SELECT
            round(AVG(carsaleprice),2)
        FROM
            si.saleinv
    ) AS "Avg Price"
   , (
        SELECT
            round(AVG(carsaleprice),2) - s.carsaleprice
        FROM
            si.saleinv
    ) AS "DIfference From Avg."
FROM
    si.saleinv s
    INNER JOIN si.customer c
    ON c.custname = s.custname
WHERE
    c.custcity = 'LONDON'
    OR c.custcity = 'London';


SELECT
    s.custname       AS "Customer"
   ,s.carsaleprice   AS "Price"
   , (
        SELECT
            round(AVG(carsaleprice),2) 
        FROM
            si.saleinv
    ) AS "Average Price In London"
    ,(
        SELECT
            round(AVG(carsaleprice),2) 
        FROM
            si.saleinv
    ) AS "Difference"
FROM
    si.saleinv s
    INNER JOIN si.customer c
    ON c.custname = s.custname
WHERE
    c.custcity = 'LONDON'
    OR c.custcity = 'London';
