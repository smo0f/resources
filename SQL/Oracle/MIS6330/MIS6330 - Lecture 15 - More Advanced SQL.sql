/*MIS6330 Lecture 15 - More Advanced SQL */

/*******************************************************************
Support for Histograms

We have two options for preparing data for a histogram. We can build
as equi-height (NTILE) or equi-width (WIDTH_BUCKET). 
*******************************************************************/

/*******************************************************************
NTILE
NTILE is an analytic function. It divides an ordered data set into a 
number of buckets indicated by expr and assigns the appropriate 
bucket number to each row. 
*******************************************************************/
SELECT last_name
    , salary
    , NTILE(4) OVER (ORDER BY salary DESC) AS quartile 
FROM hr.employees
WHERE department_id = 100;

/*******************************************************************
Width Buckets
WIDTH_BUCKET lets you construct equiwidth histograms, in which the 
histogram range is divided into intervals that have identical size. 
(Compare this function with NTILE, which creates equiheight histograms.) 

WIDTH_BUCKET (expr, min_value, max_value, num_buckets)
Min is inclusive and max is not.
*******************************************************************/
SELECT last_name
    , salary
    , WIDTH_BUCKET(salary, 0, 15000, 4) quartile 
FROM hr.employees
WHERE department_id = 100;

/******************************************************************
Cross Join
A cartesian join.

Syntax:
SELECT
    column_list
FROM T1 
CROSS JOIN T2; 

Notice there is no ON clause in the join.
******************************************************************/
select *
from sh.customers
cross join sh.channels;

/******************************************************************
Pivot
Allows us to switch the data from rows to columns.

Syntax:
SELECT ....
FROM <table-expr>
   PIVOT
     (
      aggregate-function(<column>) AS <alias>
      FOR <pivot-column> IN (<value1>, <value2>,..., <valuen>)
        ) AS <alias>
WHERE .....
******************************************************************/
select *
from (select gender, 1 as quantity
      from retail.product_list)
pivot (sum(quantity) as num_products for (gender) in ('F' as female, 'M' as male, 'U' as unknown))
;

select count(*)
from retail.product_list;

select distinct gender
from retail.product_list;

select *
from (select gender, 1 as quantity
      from retail.product_list)
pivot (sum(quantity) as num_products for (gender) in ('F' as female, 'M' as male, 'U' as unknown, 'K' as kids, 'T' as toddler, 'G' as girls, 'B' as boys))
;

/******************************************************************
Un-Pivot
From columns to rows.
******************************************************************/
select *
from retail.product_list
unpivot (merch_id for merch_type in (merchdivisionid as 'MD', merchgroupid as 'MG', productgroupid as 'PG'));