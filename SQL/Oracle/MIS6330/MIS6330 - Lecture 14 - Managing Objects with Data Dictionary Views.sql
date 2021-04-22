/*
Lecture 14 - Managing Objects with Data Dictionary Views
MIS6330
*/

/*
The data dictionary is a collection of database tables and views. 
- Automatically built and populated by the Oracle database. 
- Includes the full description of all the database objects you create as part of your application, including tables, views, indexes, constraints, sequences, and more.

Structure
SYS owns the data dictionary. To provide abstraction, we have access to views over the tables.
These tables have public synonyms for us to access them.

Every DDL statement run causes an automatic update of the data dictionary.

*/

--To start, the dictionary table gives us info about all of the data dictionary views
select * from dictionary;

select *
from user_tables;
--USER_ prefix shows us the tables that this user owns
select *
from all_tables;
--ALL_ prefix shows the same information but for table the current user has privileges on, regardless of owner
select *
from dba_tables;
--DBA_ prefix show same information for the entire database

/*
Commonly used tables in the data dictionary
(run this query because it looks better as a table)
*/
select 'USER_CATALOG' as "Suffix", 'All tables, views, synonyms, and sequences owned by USER' as "Description" from dual union all
select 'USER_COL_PRIVS', 'Grants on columns of tables owned by USER' from dual union all
select 'USER_CONSTRAINTS', 'Constraints on tables owned by USER' from dual union all
select 'USER_CONS_COLUMNS', 'Accessible columns in constraint definitions for tables owned by USER' from dual union all
select 'USER_DEPENDENCIES', 'Dependencies to and from a user''s objects' from dual union all
select 'USER_ERRORS', 'Current errors on stored objects owned by USER' from dual union all
select 'USER_INDEXES', 'Indexes owned by USER' from dual union all
select 'USER_IND_COLUMNS', 'Columns in user tables used in indexes owned by USER' from dual union all
select 'USER_OBJECTS', 'Objects owned by USER' from dual union all
select 'USER_SEQUENCES', 'Sequences owned by USER' from dual union all
select 'USER_SYNONYMS', 'Private synonyms owned by USER (public synonyms are displayed in ALL_SYNONYMS and DBA_SYNONYMS)' from dual union all
select 'USER_TABLES', 'Tables owned by USER' from dual union all
select 'USER_TAB_COLUMNS', 'Columns in USER''s own tables and views' from dual union all
select 'USER_TAB_PRIVS', 'Grants on objects owned by USER' from dual union all
select 'USER_VIEWS', 'Views owned by USER' from dual;

/*
Dynamic Performance Views
These views show you current database activity in real time.
Dynamic Performance Views start with V$.
Only simple select statements (not complex joins) should be performed on these views.
*/

select * from v$database;
select * from v$instance;
select * from v$parameter;
select * from v$session;
select * from v$reserved_words;
select * from v$object_usage;
select * from v$timezone_names;

/*
Comments

Data Architects & Admins can store comments about tables and columns to provide information about the table or column itself.
This is stored as a big text field. It can be used however you'd like.
*/

select * from all_tab_comments where comments is not null;
select * from all_col_comments where comments is not null;

--You can add comments with the following syntax
--  COMMENT ON objectType fullObjectName IS c1;
COMMENT ON TABLE CONTACTS IS 'This table was created in MIS6330 Lecture 13';
COMMENT ON TABLE MEMBERS IS 'This table was created in MIS6330 Lecture 13';

--You cannot delete comments. Instead you would need to update the comment with a blank string.
