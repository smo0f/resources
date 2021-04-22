/* Advanced SQL
MIS6330
*/

/******************************************************************************
*  Date Functions                                                             *
******************************************************************************/
SELECT NEXT_DAY('31-MAY-19','Saturday')
FROM   dual;
SELECT LAST_DAY('14-FEB-20'), LAST_DAY('20-FEB-21')
FROM   dual;

SELECT ADD_MONTHS('31-JAN-17', 1),
ADD_MONTHS('01-NOV-17', 4),
ADD_MONTHS('31-JAN-17', -1)
FROM dual;
--Note there is no subtract months, just use negative numbers in add_months

SELECT MONTHS_BETWEEN('12-JUN-14','03-OCT-13')
FROM   dual;

--What is the year of next Sunday?
SELECT TRUNC(NEXT_DAY(sysdate,'Sunday'), 'YYYY')
FROM   dual;

/******************************************************************************
*  CASE versus DECODE                                                         *
******************************************************************************/

SELECT job_id
, CASE job_id WHEN 'IT_PROG' THEN 'IT_PROG'
    WHEN 'ST_MAN' THEN 'MANAGER'
    WHEN 'ST_CLERK' THEN 'CLERK'
    ELSE 'Other' END as job_title_case
, DECODE(job_id, 'IT_PROG', 'IT_PROG', 'ST_MAN', 'MANAGER', 'ST_CLERK', 'CLERK', 'Other') as job_title_decode
FROM hr.employees;

--DECODE cannot do a comparison other than equals but CASE can
SELECT job_id
, CASE WHEN job_id LIKE '%MAN%' OR job_id LIKE '%MGR%' THEN 'MANAGER'
    WHEN job_id > 'S' THEN 'STARTS WITH S'
    WHEN salary > 22000 THEN 'Executive'
    ELSE 'Other' END as job_title_case
FROM hr.employees;

/******************************************************************************
*  Listagg                                                                    *
Concatenates values from a string field into an ordered list. Aggregates
multiple records into one group.

Syntax: LISTAGG(<column>, <string to append>) WITHIN GROUP (ORDER BY<column>)

******************************************************************************/
select department_id
, listagg(last_name, ', ') within group (order by last_name) as employees_in_dept
from hr.employees
group by department_id;

/******************************************************************************
*  Rollup                                                                     *
Gives multiple levels of subtotals across a group of dimensions and a grand total

Syntax: GROUP BY ROLLUP (<columns>)

******************************************************************************/
select e.department_id
, e.job_id
, d.location_id
, sum(e.salary)
from hr.employees e
inner join hr.departments d on e.department_id = d.department_id
group by rollup (e.department_id, e.job_id, d.location_id)
;

/******************************************************************************
*  Cube                                                                       *
*  Returns rows containing subtotals for all combinations of columns          *
*  plus a grand total row                                                     *
******************************************************************************/
select department_id
, job_id
, sum(salary)
from hr.employees
group by cube (department_id, job_id)
;

/******************************************************************************
*  Grouping                                                                   *
*  GROUPING() can be used when you have null data to display a 1 when the     *
*  column with cubing is null (meaning it is a total value)                   *                                  *
******************************************************************************/
select grouping(department_id)
, job_id
, sum(salary)
from hr.employees
group by cube (department_id, job_id)
;

--GROUPING makes the most sense to use in a CASE statement
select case when grouping(department_id) = 1 then 'All Departments' else to_char(department_id) end as department
, job_id
, sum(salary)
from hr.employees
group by cube (department_id, job_id)
; 

/******************************************************************************
*  Hierarchical Queries                                                       *
******************************************************************************/
/* 
For when your data forms a tree such as with employee hierarchies or family trees.

Note that LEVEL is a keyword, not a column in the hr.employees table. Level shows us the level in the tree.
*/

select LEVEL, employee_id, manager_id, first_name, last_name
from hr.employees
start with employee_id = 100
connect by prior employee_id = manager_id;

--We can count how many levels exist in our hierarchy
select count(distinct level)
from hr.employees
start with employee_id = 100
connect by prior employee_id = manager_id;

--You can start anywhere in the tree
select LEVEL, employee_id, manager_id, first_name, last_name
from hr.employees
start with last_name = 'Kochhar'
connect by prior employee_id = manager_id;

/* Question
Change the query above to show the employee's name spaced in 2 spaces for each level
*/


--Traverse upward through the tree
select LEVEL, employee_id, manager_id, first_name, last_name
from hr.employees
start with last_name = 'Urman'
connect by prior manager_id = employee_id;


/******************************************************************************
*  Summary Function                                                           *
******************************************************************************/
/*
Similar to summary functions in stats tools to give you basics about a data field.
Great for data discovery before using a new field.
*/

SET SERVEROUTPUT ON;
DECLARE
sigma number := 3;
S DBMS_STAT_FUNCS.summaryType;
item number;
cnt number;
BEGIN
DBMS_STAT_FUNCS.SUMMARY ('hr', 'employees', 'salary', sigma, S);
DBMS_OUTPUT.PUT_LINE('COUNT = ' || S.count);
DBMS_OUTPUT.PUT_LINE('MIN = ' || S.min);
DBMS_OUTPUT.PUT_LINE('MAX = ' || S.max);
DBMS_OUTPUT.PUT_LINE('RANGE = ' || S.range);
DBMS_OUTPUT.PUT_LINE('VARIANCE = ' || S.variance);
DBMS_OUTPUT.PUT_LINE('STDDEV = ' || S.stddev);
DBMS_OUTPUT.PUT_LINE('5th QUANTILE = ' || S.quantile_5);
DBMS_OUTPUT.PUT_LINE('25th QUANTILE = ' || S.quantile_25);
DBMS_OUTPUT.PUT_LINE('MEDIAN = ' || S.median);
DBMS_OUTPUT.PUT_LINE('75th QUANTILE = ' || S.quantile_75);
DBMS_OUTPUT.PUT_LINE('95th QUANTILE = ' || S.quantile_95);
DBMS_OUTPUT.PUT_LINE('PLUS X SIGMA = ' || S.plus_x_sigma);
DBMS_OUTPUT.PUT_LINE('MINUS X SIGMA = ' || S.minus_x_sigma);

FOR item IN S.cmode.FIRST..S.cmode.LAST
LOOP
DBMS_OUTPUT.PUT_LINE('MODE [' || item || '] = ' || S.cmode(item));
END LOOP;

FOR item IN S.top_5_values.FIRST..S.top_5_values.LAST
LOOP
DBMS_OUTPUT.PUT_LINE('TOP ' || item || ' VALUE = ' || S.top_5_values(item));
END LOOP;

cnt := S.bottom_5_values.LAST;
FOR item IN S.bottom_5_values.FIRST..S.bottom_5_values.LAST
LOOP
DBMS_OUTPUT.PUT_LINE('BOTTOM ' || cnt || ' VALUE = ' || S.bottom_5_values(item));
cnt := cnt - 1;
END LOOP;

END;
/

/******************************************************************************
*  Let's solve a problem together                                             *
******************************************************************************/
--Using the Olympics dataset, write a query to select the top 2 medal winners
--  for each sport. Show one row per sport.

select olympic_year
, sport
, gender
, event
, gold_athlete
, silver_athlete
from (select olympic_year, sport, gender, event, medal, athlete from class_datasets.olympic_medal_winners) om
pivot (min(athlete) as athlete for (medal) in ('Gold' as gold, 'Silver' as silver))
order by sport, event, gender;

--step by step
--write select * from class_datasets.olympic_medal_winners
--add the pivot clause
--Change select * to specify columns
--Run query
--Notice nulls in gold
--Run query below to check one event
--Notice that we are not grouping correctly due to columns we've excluded
--Change to subquery in from

select *
from class_datasets.olympic_medal_winners
where event = 'Men''s 10,000m';

--Another method
select olympic_year
, sport
, gender
, event
, listagg(athlete, ', ') within group (order by athlete) --do this first without the within group
from class_datasets.olympic_medal_winners
where medal in ('Gold', 'Silver')
group by olympic_year, sport, gender, event
;

--What if we wanted medal counts for the top 5 countries?
select * from (
 select noc, medal from class_datasets.olympic_medal_winners
)
pivot ( 
 count(*) for medal in ( 'Gold' gold, 'Silver' silver, 'Bronze' bronze )
)
order  by 2 desc, 3 desc, 4 desc
fetch first 5 rows only;