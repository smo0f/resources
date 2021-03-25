/**************************************************
Function Example -
A function to check if a value is a number or not
**************************************************/

CREATE FUNCTION is_number (p_string IN VARCHAR2)
   RETURN INT
IS
   v_new_num NUMBER;
BEGIN
   v_new_num := TO_NUMBER(p_string);
   RETURN 1;
EXCEPTION
WHEN VALUE_ERROR THEN
   RETURN 0;
END is_number;
/

SELECT is_number('123') FROM dual;


SELECT is_number('123b') FROM dual;


SELECT instructor.is_number('-+1..8++-') FROM dual;

/**************************************************
Trigger Example -
Let's audit changes to the employees table
**************************************************/
CREATE TABLE employees_copy AS
SELECT * FROM HR.EMPLOYEES;

CREATE TABLE employees_audit 
(employee_id number
, edit_type varchar2(15)
, new_salary number
, old_salary number
, change_date date
, username varchar2(30)
);

--When new employees are added, run this trigger
CREATE OR REPLACE TRIGGER emp_after_insert
AFTER INSERT
   ON employees_copy
   FOR EACH ROW

DECLARE
   v_username varchar2(30);
   
BEGIN
   -- Find username of person performing the INSERT into the table
   SELECT user INTO v_username
   FROM dual;

   -- Insert record into audit table
   INSERT INTO employees_audit
   ( employee_id
    , edit_type
    , new_salary
    , change_date 
    , username )
   VALUES
   ( :new.employee_id,
     'New Employee',
     :new.salary,
     sysdate,
     v_username );

END;
/

--When an employee's salary changes, run this trigger
CREATE OR REPLACE TRIGGER emp_after_update
AFTER UPDATE
   ON employees_copy
   FOR EACH ROW

DECLARE
   v_username varchar2(30);
   
BEGIN
   -- Find username of person performing the INSERT into the table
   SELECT user INTO v_username
   FROM dual;

   IF :new.salary <> :old.salary THEN
       -- Insert record into audit table
       INSERT INTO employees_audit
       ( employee_id
        , edit_type
        , new_salary
        , old_salary
        , change_date 
        , username )
       VALUES
       ( :new.employee_id,
         'Salary Change',
         :new.salary,
         :old.salary,
         sysdate,
         v_username );
    END IF;
    
END;
/

--Try it
INSERT INTO employees_copy VALUES
    (199, 'Mickey', 'Mouse', 'mickey@disney.com', '123.456.7890', sysdate-1, 1, 10, 0, 1, 1);
    
SELECT *
FROM employees_audit;

UPDATE employees_copy SET
 salary = 10000
WHERE employee_id = 199;

SELECT *
FROM employees_audit;

UPDATE employees_copy SET
 manager_id = 100
WHERE employee_id = 199;

SELECT *
FROM employees_audit;

CALL emp_after_update;


--Clean up
drop table employees_copy;
drop table employees_audit;


/*----------------------------------------------------------------------
Script: Row-Level Trigger
Creates a table of words and a trigger that strips leading and trailing blanks from each word that is inserted into the table.
----------------------------------------------------------------------*/

-- Create table of words.
create table words (word varchar2(10));

-- Create trigger that strips leading and trailing blanks from words before they are inserted into table.
create or replace trigger trim_word  
before insert on words  
for each row  
begin  
  :new.word := trim(:new.word);  
end; 

/

-- Insert word with leading and trailing blanks.
insert into words (word) values (' Hello ');

-- Insert another word with leading and trailing blanks.
insert into words (word) values ('  World  ');

-- Display words and their lengths.
select word, length(word) from words;

--Clean up
drop table words;
