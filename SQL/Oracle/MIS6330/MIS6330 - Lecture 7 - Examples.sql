/*
MIS6330
Lecture 7
DDL, Data Types
*/



/*
DATES
Recall the data format options given in your text starting on page 141
*/

/* When to use TO_CHAR vs TO_DATE */
--If I want to find all employees hired after Jan 1, 2005? How would the WHERE clause be structured?
SELECT EMPLOYEE_ID
, TO_CHAR(HIRE_DATE, 'YYYY') AS YEAR_HIRED
FROM HR.EMPLOYEES
--WHERE HIRE_DATE > TO_DATE('Jan 1, 2005', 'Mon DD, YYYY')
--WHERE HIRE_DATE > TO_DATE('12-31-2004', 'MM-DD-YYYY') AND HIRE_DATE < TO_DATE('12-31-2005', 'MM-DD-YYYY')
WHERE TO_CHAR(HIRE_DATE, 'YYYY') = 2005
ORDER BY 1;

--Change the query above to display the hire date as only the month and year
SELECT EMPLOYEE_ID
, TO_CHAR(HIRE_DATE, 'MM-YYYY') AS YEAR_HIRED
FROM HR.EMPLOYEES
--WHERE HIRE_DATE > TO_DATE('Jan 1, 2005', 'Mon DD, YYYY')
--WHERE HIRE_DATE > TO_DATE('12-31-2004', 'MM-DD-YYYY') AND HIRE_DATE < TO_DATE('12-31-2005', 'MM-DD-YYYY')
WHERE TO_CHAR(HIRE_DATE, 'YYYY') = 2005
ORDER BY 2;

/* Working with Time */
select *
from oe.orders

--Which timezone does this use?

--How can we display just the time?
select ORDER_DATE
, EXTRACT(HOUR FROM ORDER_DATE) || ':' || EXTRACT(MINUTE FROM ORDER_DATE) || ':' || EXTRACT(SECOND FROM ORDER_DATE) AS extract_version
, TO_CHAR(ORDER_DATE, 'HH24:MI:SS') AS to_char_version
, SUBSTR(TO_CHAR(ORDER_DATE), 10, 9) AS substr_version
from oe.orders;

--Create a new table by selecting from the orders table. Create two new columns: one with just the date and one with the time.
CREATE TABLE order2 AS
select o.*
, TO_CHAR(ORDER_DATE, 'DD-MON-YYYY') ORDER_DAY
, TO_CHAR(ORDER_DATE, 'HH24.MI.SS') ORDER_TIME
from oe.orders o;

DESC order2;

select *
from order2;

--How can we find how many days between two dates? Subtract them.
select sysdate - hire_date as time_hired
from hr.employees;

/*
Merge Statement
*/
create table emp_merge (employee_id number, emp_name varchar2(100), hire_date date);

insert into emp_merge
select employee_id as emp_id
, first_name || ' ' || last_name as emp_name
, hire_date
, job_id
, salary
from hr.employees
;

MERGE INTO emp_merge emp
USING (
  select 200 as employee_id, 'Mickey Mouse' as emp_name, to_date('3-JAN-2005', 'DD-MON-YYYY') as hire_date from dual
  union all
  select 201 as employee_id, 'Minnie Mouse' as emp_name, to_date('3-JAN-2005', 'DD-MON-YYYY') as hire_date from dual
  union all
  select 105 as employee_id, 'David Austin' as emp_name, to_date('21-JUN-2005', 'DD-MON-YYYY') as hire_date from dual
) new_data on (emp.employee_id = new_data.employee_id) --don't forget the parenthesis here
when matched then update set emp.hire_date = new_data.hire_date
when not matched then insert values (new_data.employee_id, new_data.emp_name, new_data.hire_date)
;
commit;
--David Austin was already in the table

--Cleanup
drop table emp_merge;
