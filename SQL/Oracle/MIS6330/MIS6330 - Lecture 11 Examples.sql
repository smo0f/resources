/* Lecture 11 Examples
   MIS6330
*/

/******************************************************************************
*  Analytic Functions                                                        *
******************************************************************************/
SELECT employee_id, department_id, salary,
       AVG(salary) over () AS avg_salary
FROM   hr.employees;

--Add a partition
SELECT employee_id, department_id, salary,
       AVG(salary) OVER (partition by department_id) AS avg_salary
FROM   hr.employees;

--Example for Ordering
SELECT employee_id, department_id, salary
       --, AVG(salary) OVER (partition by employee_id) AS avg_salary --notice we can uncomment this and have multiple analytic functions in a query
       , first_value(salary) OVER (PARTITION BY department_id) as lowest_dept_salary
FROM   hr.employees;

-- Well that's not right!  Need to order
SELECT employee_id, department_id, salary
       , first_value(salary) OVER (PARTITION BY department_id ORDER BY salary) as lowest_dept_salary
FROM   hr.employees;

--Examples for Windowing
select last_name, first_name, department_id, salary
, SUM (salary) OVER (PARTITION BY department_id ORDER BY last_name, first_name
  ROWS 2 PRECEDING) department_total
from hr.employees
order by department_id, last_name, first_name;

select last_name, first_name, department_id, hire_date, salary
, SUM (salary) OVER (PARTITION BY department_id ORDER BY hire_date
  RANGE 90 PRECEDING) department_total
from hr.employees
order by department_id, hire_date;

select last_name, first_name, department_id, salary
, SUM (salary) OVER (PARTITION BY department_id ORDER BY last_name, first_name
  ROWS BETWEEN 0 PRECEDING AND UNBOUNDED FOLLOWING) department_total
from hr.employees
order by department_id, last_name, first_name;

--Running Total
select last_name, first_name, salary
, SUM (salary)  OVER (ORDER BY last_name, first_name) running_total
from hr.employees
order by last_name, first_name;

--Rank
select employee_id
, department_id
, salary
, RANK() OVER (PARTITION BY department_id ORDER BY salary) "rank"
from hr.employees;
--Notice that when 2 people have the same salary, they are ranked the same with the next number skipped.

--Dense Rank
select employee_id
, department_id
, salary
, dense_rank() over (partition by department_id order by salary) as "rank"
from hr.employees;

--Percent Rank
select employee_id
, department_id
, salary
, round(percent_rank() over (partition by department_id order by salary), 1) as percentile
from hr.employees;

--Ratio to Report
select employee_id
, department_id
, salary
, round(ratio_to_report(salary) over (partition by department_id) * 100, 1) as percent_in_dept
from hr.employees;

--First Value
select employee_id
, department_id
, salary
, first_value(salary) ignore nulls over (partition by department_id order by salary desc) as lowest_in_department
from hr.employees;

--Lead, Lag
select employee_id
, first_name || ' ' || last_name as emp_name
, job_id
, salary
, lag(salary, 1, 0) over (order by salary) as previous_salary
, salary - lag(salary, 1, 0) over (order by salary) as salary_diff
from hr.employees;

select employee_id
, first_name || ' ' || last_name as emp_name
, job_id
, salary
, lead(salary, 1, 0) over (order by salary) as next_salary
, lead(salary, 1, 0) over (order by salary) - salary as salary_diff
from hr.employees
order by salary;

-- Objective: Write a query using a WITH statement that shows for each listing the difference between the average price per square foot of all listings compared to this listing.
WITH LISTINGS_AVG_PRICE AS (
    SELECT 
        MLS_NUMBER,
        PRICE_PER_SQ_FT,
        AVG(PRICE_PER_SQ_FT) OVER () AS AVG_PRICE_OF_LISTINGS
    FROM RMOORE.REDFIN_PROPERTIES
)
SELECT 
    MLS_NUMBER,
    PRICE_PER_SQ_FT,
    AVG_PRICE_OF_LISTINGS,
    PRICE_PER_SQ_FT - AVG_PRICE_OF_LISTINGS AS PRICE_DIFFERENCE
FROM LISTINGS_AVG_PRICE;