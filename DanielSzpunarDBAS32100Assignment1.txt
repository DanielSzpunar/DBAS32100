/*
File: Daniel_Szpunar_DBAS32100Assignment1.sql
Author: Daniel Szpunar
Oracle Username: S11_SZPUNARD
Description: Assignment #1
*/
SET LINE 132

SET PAGESIZE 255

/*
1. Print the total amount, the average dollar value of service visits (parts and labour costs) 
and the number of those visits for Acura, Mercedes and Jaguar car makes that are sold between 
May 2017 and August 2017 inclusive (5 marks).
*/

SELECT
    SUM(s.partscost + s.laborcost) AS "Sum of parts and labor"
   ,round(AVG( (s.partscost + s.laborcost) / 2),2) AS "Average value of visit"
   ,COUNT(*) AS "Number of visits"
FROM
    si.car c
    INNER JOIN si.servinv s
    ON c.carserial = s.carserial
WHERE
    carmake IN (
        upper('mercedes')
       ,upper('acura')
       ,upper('jaguar')
    )
    AND servdate BETWEEN '01-MAY-17' AND '31-AUG-17';

/*
-------------------------- Output begins

Sum of parts and labor Average value of visit Number of visits
---------------------- ---------------------- ----------------
              10564.03                 480.18               11

-------------------------- Output ends
*/

/*

2. SI database contains customers that have bought one or more vehicles. 
They can be classified using the following criteria:
    a. Customers that have bought only one car (one-time buyer)
    b. Customer that have bought two cars (two-time buyer)
    c. Customers that have bought more than two cars (frequent buyer)
Display a list of customers with their names and what type of buyer they are 
for all those customers that have bought Jaguar car makes. (5 marks)
*/

SELECT DISTINCT
    custname   AS "Jaguar Customers"
   ,CASE
        WHEN COUNT(carmake) = 1
             AND carmake = 'JAGUAR' THEN 'one-time buyer'
        WHEN COUNT(carmake) = 2
             AND carmake = 'JAGUAR' THEN 'two-time buyer'
        WHEN COUNT(carmake) >= 3
             AND carmake = 'JAGUAR' THEN 'frequent buyer'
    END AS "Customer type"
FROM
    si.car
WHERE
    carmake = 'JAGUAR'
GROUP BY
    carmake
   ,custname
ORDER BY
    "Customer type";

/*
-------------------- Output begins

Jaguar Customers     Customer type 
-------------------- --------------
CARL EDWARDS         frequent buyer
GARY HALBIG          frequent buyer
ZAKEIR SAMSOODIN     frequent buyer
...(93 rows)
BRAYDON VAREY        two-time buyer
PAT WALTON           two-time buyer
CATY                 two-time buyer

99 rows selected
-------------------- Output ends

*/

/*
3. Using SET operations, display a list of customers that are interested in a car 
(prospect table) of the same make and model which they already own. (5 marks)
*/

SELECT
    custname
   ,carmake
   ,carmodel
FROM
    si.car
WHERE
    carmodel IN (
        SELECT
            carmodel
        FROM
            si.car
    )
    AND carmake IN (
        SELECT
            carmake
        FROM
            si.car
    )
INTERSECT
SELECT
    custname
   ,carmake
   ,carmodel
FROM
    si.prospect
WHERE
    carmodel IN (
        SELECT
            carmodel
        FROM
            si.prospect
    )
    AND carmake IN (
        SELECT
            carmake
        FROM
            si.prospect
    );

/*
-------------------- Output begins
CUSTNAME             CARMAKE    CARMODEL  
-------------------- ---------- ----------
AMANDEEP             LAND ROVER R70       
BHAVAY GROVER        LAND ROVER RRS       
MATTHEW VILJAKAINEN  LAND ROVER G4        
PATRICK SIMMONS      LAND ROVER SPORT     
SMARTH ARORA         LAND ROVER EVOQUE    
VALERIYA             LAND ROVER SPORT     

6 rows selected. 
-------------------- Output ends
*/

/*
4. Show a list of total amount of money spent on service for Toyota cars. 
Show the subtotals for each model. (5 marks)
*/

SELECT
    carmodel   AS "Toyota Model"
   ,SUM(purchcost) AS "Total Sum"
FROM
    si.car
WHERE
    carmake = 'TOYOTA'
GROUP BY
    ROLLUP(carmodel)
ORDER BY
    carmodel ASC;

/*
-------------------- Output begins
Toyota M  Total Sum
-------- ----------
4RUNNER       48975
CAMRY       4894715
COROLLA    11233.43
...(3 rows)
TL                 
YARIS              
         4963944.33
         
9 rows selected.
-------------------- Output ends
*/

/*
5. Write a query using analytic functions that will show the serial number, 
the sale price of each JAGUAR car as well as the cumulative price totals. 
(5 marks)
*/

SELECT
    c.carserial
   ,carmodel
   ,carsaleprice
   ,SUM(carsaleprice) OVER(
        PARTITION BY carmodel
        ORDER BY
            carmodel DESC
    ) AS cost_sum
FROM
    si.saleinv s
    INNER JOIN si.car c
    ON c.carserial = s.carserial
WHERE
    c.carmake = 'JAGUAR';

/*
-------------------- Output begins

CARSERIA CARMODEL CARSALEPRICE   COST_SUM
-------- -------- ------------ ----------
J16R1232 123             65748      65748
J07SC90  C9              65000      65000
J10YCOO0 COOL           228057     456114
...(41 rows)
J15YXKR1 XKR              3640     299650
J15BXKR0 XKR             50700     299650
J15RXL0  XL              40000      40000

47 rows selected. 

-------------------- Output ends
*/