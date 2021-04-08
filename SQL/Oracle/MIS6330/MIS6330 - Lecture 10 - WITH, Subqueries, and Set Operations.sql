/*
Lecture 10 - WITH, Subqueries, and Set Operations
MIS6330 - Spring 2021
*/

/*
Set Operators
UNION - Combines row sets. Eliminates duplicate rows.
UNION ALL - Combines row sets without eliminating duplicates.
INTERSECT - Includes only rows that are present in both queries.
MINUS - Subtracts rows in the second row set from the rows in the first row set.

Rules:
* Number of expressions in the SELECT statement must be identical
* Datatypes in each expression in the SELECT statement must match in the same order
* Large datatypes (BLOB & CLOB) cannot be used
* ORDER BY can only be used at the end
*/

--Setup two tables to use for this lecture
create table members
(member_id number
, email_address varchar2(100 char)
, member_type varchar2(10)
, first_name varchar2(30)
, last_name varchar2(30)
, age number
);
create table contacts
(contact_id number
, email varchar2(200)
);
insert into members values (1, 'mickey.mouse@disney.com', 'mouse', 'Mickey', 'Mouse', 20);
insert into members values (2, 'minnie.mouse@disney.com', 'mouse', 'Minnie', 'Mouse', 19);
insert into members values (3, 'donald.duck@disney.com', 'duck', 'Donald', 'Duck', 20);
insert into members values (4, 'daisy.duck@disney.com', 'duck', 'Daisy', 'Duck', null);
insert into contacts values (1, 'goofy@disney.com');
insert into contacts values (2, 'mickey.mouse@disney.com');
insert into contacts values (3, NULL);
commit;

--Which do you think runs faster? The first query with UNION or second with UNION ALL?
select email_address as em
from members
union
select email as em
from contacts
;

select email
from contacts
union all
select email_address
from members
;

--Columns must match
select email_address, first_name
from members
union all
select email
from contacts
;

--Sorting in a Set Operation
select email_address
from members
union all
select email
from contacts
order by 1
;

--Find anyone who is in both lists
select email_address, member_id
from members
intersect
select email, contact_id
from contacts
;

--MINUS: Why do these two queries return different results?
select email_address
from members
minus
select email
from contacts
;

select email
from contacts
minus
select email_address
from members
;

--How do you set a column header title in a union query?


--NULL values
-- Now let's look at the one null email address in the contacts table
select email
from contacts
union all
select email_address
from members;

select null
from dual
intersect
select email_address
from members
;

select email
from contacts
minus
select email_address
from members
;
select email
from contacts
minus
select NULL from dual
;

select *
from members where email_address not in 
    (select email from contacts)
;

select *
from members where email_address not in 
    (select email from contacts where email is not null)
;


/*
Subqueries
Subqueries are queries within queries. They may or may not run on their own.

Can be used in the SELECT, FROM and WHERE portions of our query.
If used in the WHERE, we cannot display any results from the subquery. It can only be used for filtering.
If used in the SELECT, we cannot filter on the results of the subquery. It can only be used for displaying.
In the FROM clause, we can use the results of the subquery anywhere in the query but we also must join the 
	data in some way to other tables queried.
*/

--Example: We want to find any employee with a salary above the average for anyone hired in 2005.
--First, let's do this manually with two queries.
select avg(salary)
from hr.employees
where extract(year from hire_date) = 2005
;

select first_name, last_name, salary
from hr.employees
where salary > 6824
;
--Now as one query using a subquery.
select first_name, last_name, salary
from hr.employees
where salary > (select avg(salary) from hr.employees where extract(year from hire_date) = 2005)
;

/*
Types of Subqueries (Subquery can be more than 1 of these)

Single-row subqueries
Multiple-row subqueries - Returns 0, 1, or more rows in its result
Multiple-column subqueries
Correlated subqueries - Specifies columns that belong to tables referenced by the parent query.
Scalar subqueries - Only 1 column of output

*/

--Correlated subquery
--  Cannot be executed on it's own
--  Can be used in SELECT, UPDATE, and DELETE statements
select a.employee_id
, a.job_id
, a.salary
from hr.employees a
where a.salary >
(select avg(salary)
from hr.employees
where job_id = a.job_id)
order by job_id, employee_id
;
--How often is the subquery executing in this query?

--Correlated with Update & Delete
create table employees_temp as
select * from hr.employees;

select * from employees_temp;
drop table employees_temp;
rollback;

--What does this query do?
update employees_temp e
set commission_pct = .10
where exists (select * from employees_temp where manager_id = e.employee_id)
;

--Will this query execute?
update employees_temp e
set commission_pct = (select 0.10 from hr.employees where e.manager_id = employee_id)
where exists (select * from employees_temp where e.manager_id = employee_id)
;

--What does this query do?
delete from employees_temp e1
where salary =
(select min(salary)
from employees_temp e2
where e2.job_id = e1.job_id)
;

--Using EXISTS
--Note that the synatx when using EXISTS is different. It's not expression = expression
select employee_id, first_name
from hr.employees e
where exists (
  select *
  from hr.departments d
  where d.department_id = e.department_id
)
;

--WITH Clause
-- Assign a name to the subquery then it can be referenced by that name anywhere in the query
with total_salaries as (
  select job_id
  , sum(salary) as total_salary
  from hr.employees
  group by job_id
)
select emp.first_name
, emp.last_name
, emp.job_id
, emp.salary
, total_salaries.total_salary as job_total_salary
from hr.employees emp
inner join total_salaries on total_salaries.job_id = emp.job_id
;

select emp.first_name
, emp.last_name
, emp.job_id
, emp.salary
, total_salaries.total_salary as job_total_salary
from hr.employees emp
inner join (select job_id
, sum(salary) as total_salary
from hr.employees
group by job_id) total_salaries on total_salaries.job_id = emp.job_id
;

--How would you include 2 with subqueries? Perhaps add another query selecting today's date to this query above.
with total_salaries as (
  select job_id
  , sum(salary) as total_salary
  from hr.employees
  group by job_id
)
, todays_date as (
  select total_salary 
  from total_salaries
)
select emp.first_name
, emp.last_name
, emp.job_id
, emp.salary
, total_salaries.total_salary as job_total_salary
from hr.employees emp
inner join total_salaries on total_salaries.job_id = emp.job_id
;


--ANY and ALL

--Find all employees with a salary greater than the average salary for employees
select employee_id
, job_id
, salary
from hr.employees
where salary > ANY (select avg(salary) from hr.employees group by job_id)
order by 3 desc
;
--Why does this return all rows in employee?


--Find all employees who make more than all of the people with FI_ACCOUNT job_ids
select employee_id
, job_id
, salary
from hr.employees
where salary > ALL (select salary 
  from hr.employees
  where job_id = 'FI_ACCOUNT')
;

