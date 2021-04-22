REM   Script: JSON in Oracle Database
REM   Examples of how to use SQL to store, query, and create JSON documents in Oracle Database.
REM   This exercise created by Chris Saxon and posted on LiveSQL at https://livesql.oracle.com/apex/livesql/file/content_HZ0745GCRAOQYKGBJBP3LUH47.html

--For full details on these statements, the associated blog post How to Store, Query, and Create JSON Documents in Oracle Database (https://blogs.oracle.com/sql/how-to-store-query-and-create-json-documents-in-oracle-database)

-- Create a Table to Store JSON
-- The recommended data type to store large JSON documents is BLOB.
create table departments_json (  
  department_id   integer not null primary key,  
  department_data blob not null  
);

-- Add an IS JSON constraint to the table
-- This stops you inserting any text you want in the JSON column.
alter table departments_json   
  add constraint dept_data_json   
  check ( department_data is json );

-- ...any attempts to do so throw an exception.
insert into departments_json   
  values ( 100, utl_raw.cast_to_raw ( 'Random junk' ) );

-- Inserting JSON in a BLOB
-- To insert text into a BLOB column, you need to convert it to binary. Calling utl_raw.cast_to_raw does this for you.
insert into departments_json   
  values ( 110, utl_raw.cast_to_raw ( '{  
  "department": "Accounting",  
  "employees": [  
    {  
      "name": "Higgins, Shelley",  
      "job": "Accounting Manager",  
      "hireDate": "2002-06-07T00:00:00"  
    },  
    {  
      "name": "Gietz, William",  
      "job": "Public Accountant",  
      "hireDate": "2002-06-07T00:00:00"  
    }  
  ]  
}' ));

rollback;


-- This loads the departments and their associated employees. There is one row/department with employee details in an array.
insert into departments_json (  
  department_id, department_data  
)  
  select d.department_id,  
         json_object (  
           'department' value d.department_name,  
           'employees'  value json_arrayagg (  
             json_object (  
               'name'     value last_name || ', ' || first_name,   
               'job'      value job_title,  
               'hireDate' value hire_date  
           ))  
           returning blob  
         )  
  from   hr.departments d, hr.employees e, hr.jobs j  
  where  d.department_id = e.department_id  
  and    e.job_id = j.job_id  
  group  by d.department_id, d.department_name;

commit;


-- Simple Dot-Notation Access
-- With the IS JSON constraint in place, you can access values by listing their path.
select d.department_data.department   
from   departments_json d;

-- Note you need to alias the column name to use dot-notation access. Or you'll get an ORA-00904 error.
select department_data.department   
from   departments_json d;

-- Simple Dot-Notation Access in Where
-- You can also use dot-notation in your where clause to find documents with given values.
select *  
from   departments_json d  
where  d.department_data.department = 'Accounting';

-- Simple Dot-Notation Access with Arrays
-- You can get values for array elements by stating their index with dot-notation.
select d.department_data.employees[0].name  
from   departments_json d  
where  department_id = 110;

-- Simple Dot-Notation Access with Arrays
-- Using asterisk for the array index returns all the matching value as an array.
select d.department_data.employees[*].name  
from   departments_json d  
where  department_id = 110;

alter table departments_json  
  drop constraint dept_data_json ;

-- TREAT ... AS JSON
-- If you don't have an IS JSON constraint on your data, you can still access values with dot-notation. To do this you first need to wrap the column in TREAT ... AS JSON function.

--This option was added in Oracle Database 18c.
with j_data as (  
  select treat (   
           d.department_data as json   
         ) as department_data  
  from   departments_json d  
  where  department_id = 110  
)  
  select j.department_data.department  
  from   j_data j  
  where  department_data is json;


alter table departments_json  
  add constraint dept_data_json  
  check ( department_data is json );

-- JSON_value
-- You can also use JSON_value to access values in your document. This has more formatting and error handling options than dot-notation.
select json_value (   
         department_data,   
         '$.employees[1].hireDate' returning date   
       ) hire_date  
from   departments_json d  
where  department_id = 110;

-- JSON_value Error Clause
-- By default the JSON* functions have the clause NULL ON ERROR.
select json_value (   
         department_data,   
         '$.nonExistentAttribute'  
       ) not_here  
from   departments_json d  
where  department_id = 110;

-- JSON_value Error Clause
-- To return an error instead, set this clause to ERROR ON ERROR.
select json_value (   
         department_data,   
         '$.nonExistentAttribute'  
           error on error  
       ) not_here  
from   departments_json d;

-- JSON_query
-- JSON_value can only return single-valued attributes. To return objects or arrays instead, use JSON_query.
select json_query (   
         department_data,   
         '$.employees[*]'  
           returning varchar2 pretty  
           with wrapper   
       ) employees  
from   departments_json d  
where  department_id = 110;

select json_query ( 
         department_data format json,  
         '$.employees[*].name' 
           returning varchar2 pretty 
           with wrapper  
       ) employee_names 
from   departments_json d 
where  department_id = 110;

-- JSON_table
-- You can convert JSON document to relational rows-and-columns using JSON_table.
select j.*   
from   departments_json d, json_table (  
         d.department_data, '$' columns (  
           department path '$.department',   
           nested path '$.employees[*]'  
           columns (  
             name path '$.name',   
             job  path '$.job'   
       ) ) ) j  
where  d.department_id = 110;

-- JSON_table Simplified
-- Oracle Database 18c simplified the syntax for JSON_table. As long as the names of the columns you're returning match the attribute names, just list the path to these.
select j.*   
from   departments_json d, json_table (  
         d.department_data, '$' columns (  
           department,   
           nested employees[*]  
           columns (  
             name,   
             job  
       ) ) ) j  
where  d.department_id = 110;

-- JSON_table Simplified with Extended
-- You can use both simplified and extended syntax in the same JSON_table call.
select j.*   
from   departments_json d, json_table (  
         d.department_data, '$' columns (  
           department,   
           nested employees[*]  
           columns (  
             name,   
             job,  
             hire_date date path '$.hireDate'  
       ) ) ) j  
where  d.department_id = 110;

-- Updating JSON
-- Before 19c, if you wanted to change a single value in a document, you had to replace the whole thing!

--This changes just the department to "Finance and Accounting".
update departments_json  
set    department_data = utl_raw.cast_to_raw (   
'{  
  "department": "Finance and Accounting",  
  "employees": [  
    {  
      "name": "Higgins, Shelley",  
      "job": "Accounting Manager",  
      "hireDate": "2002-06-07T00:00:00"  
    },  
    {  
      "name": "Gietz, William",  
      "job": "Public Accountant",  
      "hireDate": "2002-06-07T00:00:00"  
    }  
  ]  
}'  
)  
where  department_id = 110 ;

select d.department_data.department   
from   departments_json d  
where  department_id = 110 ;

rollback;


-- JSON_mergepatch
-- From 19c you can update a document using JSON_mergepatch. With this, you only need to specify the attributes you're changing.
update departments_json  
set    department_data = json_mergepatch (   
         department_data,  
         '{  
           "department" : "Finance and Accounting"  
         }'  
       )  
where  department_id = 110 ;

select d.department_data.department  
from   departments_json d ;

rollback;


-- JSON_mergepatch with Arrays
-- If you want to update part of an array, you still need to replace the whole thing!
update departments_json  
set    department_data = json_mergepatch (   
         department_data,  
         '{ "employees" :  
  [ {  
      "name" : "Gietz, William",  
      "job" : "Public Accountant",  
      "hireDate" : "2002-06-07T00:00:00"  
    },  
    {  
      "name" : "Higgins, Shelley",  
      "job" : "Accounting Manager",  
      "hireDate" : "2002-06-07T00:00:00"  
    },  
    {  
      "name" : "Chen, John",  
      "job" : "Accountant",  
      "hireDate" : "2005-09-28T00:00:00"  
    },  
    {  
      "name" : "Greenberg, Nancy",  
      "job" : "Finance Manager",  
      "hireDate" : "2002-08-17T00:00:00"  
    },  
    {  
      "name" : "Urman, Jose Manuel",  
      "job" : "Accountant",  
      "hireDate" : "2006-03-07T00:00:00"  
    }  
  ]  
}'  
       )  
where  department_id = 110 ;

select d.department_data.employees[*] 
from   departments_json d  
where  department_id = 110 ;

rollback;


-- JSON Function-based Indexes
-- You can create indexes using JSON functions. This allows you to efficiently search for documents with given values.
create index dept_department_name_i on   
  departments_json (   
    json_value (   
      department_data, '$.department'   
        error on error  
        null on empty  
    )   
  );

-- Enable Execution Plan Stats for the Queries
alter session set statistics_level = all;

-- Run the query to see how the database uses in the index in the plan.
select *  
from   departments_json d  
where  json_value (   
         department_data,   
         '$.department' error on error null on empty   
) = 'Accounting';

-- JSON_value Index Plan
-- The function-based index enabled nice efficient access of this document, using just 3 consistent gets.
with plan_table as (  
  select * from v$sql_plan_statistics_all  
  where sql_id = '7q6v5ky2j7y3d'  
)  
select id "Id",  
  rpad(  
  lpad(' ',2*level) || operation || ' ' || options , 40 ) "Operation",  
  object_name "Name",  
  last_starts "Starts",  
  cardinality "E-Rows",   
  LAST_OUTPUT_ROWS "A-Rows",  
  LAST_CR_BUFFER_GETS+LAST_CU_BUFFER_GETS "Buffers"  
from plan_table  
connect by prior id = parent_id   
start with id = 0


-- Remove the index to see how it compares to a JSON search index.
drop index dept_department_name_i;

-- JSON Search Index
-- Added in 12.2, a JSON search index support "any" query against your document. So you can use this for ad-hoc queries.
create search index dept_json_i on   
  departments_json ( department_data )  
  for json;

exec dbms_stats.gather_table_stats ( null, 'DEPARTMENTS_JSON' );


select * 
from   departments_json d 
where  json_value (  
         department_data,  
         '$.department' 
) = 'Accounting';

-- The function-based index is much more effective than a search index. To find the Accounting department, the search index needed 30 consistent gets.

The JSON_value index needed just 3!
with plan_table as (  
  select * from v$sql_plan_statistics_all  
  where sql_id = 'dyp69gwj7q9fa'  
)  
select id "Id",  
  rpad(  
  lpad(' ',2*level) || operation || ' ' || options , 40 ) "Operation",  
  object_name "Name",  
  last_starts "Starts",  
  cardinality "E-Rows",   
  LAST_OUTPUT_ROWS "A-Rows",  
  LAST_CR_BUFFER_GETS+LAST_CU_BUFFER_GETS "Buffers"  
from plan_table  
connect by prior id = parent_id   
start with id = 0;


select sql_id, sql_text from v$sql 
where  sql_text like '%json_textcontains%' 
and    sql_text not like '%not this%';

select json_serialize ( department_data returning varchar2 pretty ) 
from   departments_json d 
where  json_textcontains ( department_data, '$', 'Public' ) ;

with plan_table as ( 
  select * from v$sql_plan_statistics_all 
  where sql_id = '8txzkvt3paf5q' 
) 
select id "Id", 
  rpad( 
  lpad(' ',2*level) || operation || ' ' || options , 40 ) "Operation", 
  object_name "Name", 
  last_starts "Starts", 
  cardinality "E-Rows",  
  LAST_OUTPUT_ROWS "A-Rows", 
  LAST_CR_BUFFER_GETS+LAST_CU_BUFFER_GETS "Buffers" 
from plan_table 
connect by prior id = parent_id  
start with id = 0;


-- JSON_exists
-- JSON_exists enables you to find all the documents that contain a given attribute. This searches for documents that have hireDate within an employee object.
select department_id   
from   departments_json d  
where  json_exists (  
  department_data,   
  '$.employees.hireDate'  
);

-- JSON_exists
-- There are no documents that have a salary attribute under employees.
select *   
from   departments_json d  
where  json_exists (  
  department_data,   
  '$.employees.salary'  
);

-- JSON Data Guide
-- Creating a JSON search index with the parameters DATAGUIDE ON enables the JSON Data Guide. You can rebuild existing indexes if you want to add this.
alter index dept_json_i   
  rebuild parameters ( 'dataguide on' );

-- JSON Data Guide
-- With the data guide in place, you can expose scalar attributes as virtual columns. 
exec dbms_json.add_virtual_columns ( 'departments_json', 'department_data' )


-- DEPARTMENT_DATA$department is a virtual column. This returns values for the attributes $.department.
select column_name from user_tab_columns 
where  table_name = 'DEPARTMENTS_JSON';

-- The generated columns are case-sensitive. So you need to wrap the virtual columns in quotes to access them.
select "DEPARTMENT_DATA$department" department_name  
from   departments_json  
where  department_id = 110;

-- Rename Data Guide Columns
-- You can give data guide columns "friendly" names by calling dbms_json.rename_column. You need to re-generate the virtual columns afterwards for this to come into effect.
begin   
  dbms_json.rename_column (   
    'departments_json', 'department_data',   
    '$.department', dbms_json.type_string,   
    'DEPARTMENT_NAME'  
  );  
    
  dbms_json.add_virtual_columns (   
    'departments_json', 'department_data'   
  );  
end; 
/

-- The virtual column now has the "friendly" name, DEPARTMENT_NAME.
select column_name from user_tab_columns 
where  table_name = 'DEPARTMENTS_JSON';

-- Data Guide Documents-to-Rows
-- The data guide doesn't add columns for array attributes. To display these, you can build a view on the column. 

--This explodes the document into relational rows-and-columns, just like JSON_table.
begin   
  dbms_json.create_view (   
    'department_employees', 'departments_json',   
    'department_data',   
    dbms_json.get_index_dataguide (  
      'departments_json',  
      'department_data',  
      dbms_json.format_hierarchical  
    )   
  );  
end; 
/

-- As with the virtual columns, by default the view's JSON attributes have columns named "JSONCOL$attrname".
select * from department_employees  
where  department_id = 110;

-- JSON_dataguide
-- The JSON_dataguide function returns the "schema" for the JSON documents stored in a column. This allows you to see what the attributes are and their data types.
select json_dataguide ( department_data )   
from   departments_json;

-- Generate JSON
-- Added in 12.2, you can create JSON documents using JSON_object, JSON_array, JSON_objectagg, and JSON_arrayagg. This query returns:

--* A document per department_name (from the GROUP BY)
--* This contains an array of the employees in each department (JSON_arrayagg)
--* Each employee has their details in a JSON object within the array, created using JSON_object
select json_object (  
         'department' value d.department_name,  
         'employees' value json_arrayagg (  
           json_object (  
             'name'     value first_name || ', ' || last_name,   
             'job'      value job_title,  
             'hireDate' value hire_date  
           )  
         )  
       )  
from   hr.departments d  
join   hr.employees e  
on     d.department_id = e.department_id  
join   hr.jobs j  
on     e.job_id = j.job_id  
where  d.department_id = 110  
group  by d.department_name;

-- JSON_object Simplified
-- From 19c, you can pass * (asterisk) to JSON_object. This returns a document using all the table's columns.
select json_query ( json_object ( * ) , '$' pretty )  
from   hr.departments  
where  department_id = 110;

-- Comparing JSON Documents
-- You need to ignore whitespace and attribute order when comparing JSON documents. So to see if two documents are the same, you had to first convert them to traditional rows-and-columns. Then use set operations to see if all the attributes and values match.
with doc1_rows as (  
  select t.*   
  from   departments_json, json_table (  
    department_data  
    columns  
      department,   
      nested employees[*]  
        columns (  
          name , job   
        )  
      ) t  
  where  department_id = 110  
), doc2_rows as (  
  select *   
  from   json_table ( '{  
  "employees" :  
  [ {  
      "name" : "Gietz, William",  
      "job" : "Public Accountant",  
      "hireDate" : "2002-06-07T00:00:00"  
    },  
    {  
      "hireDate" : "2002-06-07T00:00:00",  
      "name" : "Higgins, Shelley",  
      "job" : "Accounting Manager"  
    }  
  ],  
  "department" : "Accounting"  
}' columns  
    department,   
    nested employees[*]  
    columns (  
      name , job   
    )  
  )   
), all_rows as (   
  select d.*, -1 tab  
  from   doc1_rows d  
  union  all  
  select d.*, 1 tab  
  from   doc2_rows d  
)  
  select department, name, job  
  from   all_rows  
  group  by department, name, job  
  having sum ( tab ) <> 0;


-- Simplified JSON Comparison with JSON_equal
-- 18c made document comparison easier by adding JSON_equal. Just pass the two documents to this. It will then return true if they're the same, false if they're not.
select case   
        when json_equal ( department_data,  
'{"employees" :  
  [  
    {  
      "name" : "Gietz, William",  
      "job" : "Public Accountant",  
      "hireDate" : "2002-06-07T00:00:00"  
    },  
    {  
      "hireDate" : "2002-06-07T00:00:00",  
      "name" : "Higgins, Shelley",  
      "job" : "Accounting Manager"  
    }  
  ],  
  "department" : "Accounting"  
}' ) then 'EQUAL' else 'DIFFERENT' end matching  
from   departments_json  
where  department_id = 110;

-- Pretty-Printing Documents
-- You can use the PRETTY clause of JSON_query to return a pretty-printed document.
select json_query (   
         department_data, '$' pretty  
       )   
from   departments_json  
where  department_id = 110;

-- JSON_serialize
-- Starting in Oracle Database 19c, you can use JSON_serialize to convert documents between VARCHAR2, CLOB, and BLOB.

This also has a PRETTY clause, which returns pretty-printed documents.
select json_serialize (   
         department_data returning varchar2(10000) pretty   
       )   
from   departments_json  
where  department_id = 110;

