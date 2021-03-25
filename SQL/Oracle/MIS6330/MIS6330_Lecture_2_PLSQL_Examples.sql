REM   Script: Row-Level Trigger
REM   Creates a table of words and a trigger that strips leading and trailing blanks from each word that is inserted into the table.

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


/*----------------------------------------------------------------------*/
REM   Script: The Cursor FOR Loop
REM   An exploration into the very useful and elegant cursor FOR loop, in which we declaratively tell the PL/SQL engine "I want to do X for each row fetched by the cursor." But we leave it up to that fine engine to do all the administrative work for us (open, fetch, close) - PLUS this loop is automatically optimized to return 100 rows with each fetch!

-- Simplest Form - SELECT inside the loop
-- You can embed the SELECT directly inside the FOR loop. That's easiest, but that also means you cannot reuse the SELECT in another FOR loop, if you have that need.
BEGIN 
   FOR rec IN (SELECT * FROM hr.employees) 
   LOOP 
      DBMS_OUTPUT.put_line (rec.last_name); 
   END LOOP; 
END;
/

-- Cursor FOR Loop with Explicit Cursor
-- You can also declare the cursor explicitly and then reference that in the FOR loop. You can then use that same cursor in another context, such as another FOR loop.
DECLARE 
   CURSOR emps_cur 
   IS 
      SELECT * FROM hr.employees; 
BEGIN 
   FOR rec IN emps_cur 
   LOOP 
      DBMS_OUTPUT.put_line (rec.last_name); 
   END LOOP; 
 
   FOR rec IN emps_cur 
   LOOP 
      DBMS_OUTPUT.put_line (rec.salary); 
   END LOOP; 
END;
/

-- Parameterized Cursor FOR Loop
-- You can add a parameter list to a cursor, just like you can a function. You can only have IN parameters. Well, that makes sense, right?
DECLARE 
   CURSOR emps_cur (department_id_in IN INTEGER) 
   IS 
      SELECT * FROM hr.employees 
       WHERE department_id = department_id_in; 
BEGIN 
   FOR rec IN emps_cur (1700) 
   LOOP 
      DBMS_OUTPUT.put_line (rec.last_name); 
   END LOOP; 
 
   FOR rec IN emps_cur (50) 
   LOOP 
      DBMS_OUTPUT.put_line (rec.salary); 
   END LOOP; 
END;
/

-- Package Based Cursor
-- You can declare a cursor at the package level and then reference that cursor in multiple program units. Remember, though, that if you explicitly open a packaged cursor (as in OPEN emus_pkg.emps_cur), it will stay open until you close it explicitly (or disconnect). 
CREATE OR REPLACE PACKAGE emps_pkg 
IS 
   CURSOR emps_cur 
   IS 
      SELECT * FROM hr.employees; 
END;
/

-- Using a Package-based Cursor
BEGIN 
   FOR rec IN emps_pkg.emps_cur 
   LOOP 
      DBMS_OUTPUT.put_line (rec.last_name); 
   END LOOP; 
END;
/

-- Hide SELECT in Package-based Cursor
-- You can even hide the SELECT inside the package body in case you don't want developers to know the details of the query.
CREATE OR REPLACE PACKAGE emps_pkg 
IS 
   CURSOR emps_cur 
      RETURN hr.employees%ROWTYPE; 
END;
/

CREATE OR REPLACE PACKAGE BODY emps_pkg 
IS 
   CURSOR emps_cur RETURN hr.employees%ROWTYPE 
   IS 
      SELECT * FROM hr.employees; 
END;
/

BEGIN
   FOR rec IN emps_pkg.emps_cur
   LOOP
      DBMS_OUTPUT.put_line (rec.last_name);
   END LOOP;
END;
/


/*----------------------------------------------------------------------*/
REM   Script: Test Your PL/SQL Exception Handling Knowledge
REM   Don't just run this script! First: look at each statement and ask yourself "What will I see on the screen after execution?" 
REM    Then run the script and see how well you understand PL/SQL's exception handling architecture.

-- Oh My That's a Big String!
DECLARE 
   aname   VARCHAR2 (5); 
BEGIN 
   BEGIN 
      aname := 'Big String'; 
      DBMS_OUTPUT.put_line (aname); 
   EXCEPTION 
      WHEN VALUE_ERROR 
      THEN 
         DBMS_OUTPUT.put_line ('Inner block'); 
   END; 
 
   DBMS_OUTPUT.put_line (SQLCODE); 
    
   DBMS_OUTPUT.put_line ('What error?'); 
EXCEPTION 
   WHEN VALUE_ERROR 
   THEN 
      DBMS_OUTPUT.put_line ('Outer block'); 
END;
/

-- That's STILL a Big String!
DECLARE 
   aname VARCHAR2(5); 
BEGIN 
   DECLARE 
      aname VARCHAR2(5) := 'Big String'; 
   BEGIN 
      DBMS_OUTPUT.PUT_LINE (aname); 
 
   EXCEPTION 
      WHEN VALUE_ERROR 
      THEN 
         DBMS_OUTPUT.PUT_LINE ('Inner block'); 
   END; 
    
   DBMS_OUTPUT.put_line (SQLCODE); 
   DBMS_OUTPUT.PUT_LINE ('What error?'); 
EXCEPTION 
   WHEN VALUE_ERROR 
   THEN 
      DBMS_OUTPUT.PUT_LINE ('Outer block'); 
END; 
/

CREATE TABLE employees AS SELECT * FROM hr.employees;

-- No Room for Justice in This World (Block)
DECLARE 
   aname VARCHAR2(5); 
BEGIN 
   DECLARE 
      aname VARCHAR2(5) := 'Justice'; 
      loc INTEGER := 1; 
   BEGIN 
      loc := 2; 
      DBMS_OUTPUT.PUT_LINE (aname); 
 
      loc := 3; 
      DELETE FROM employees; 
 
   EXCEPTION 
      WHEN VALUE_ERROR 
      THEN 
         DBMS_OUTPUT.PUT_LINE ('Got as far as ' || loc); 
         ROLLBACK; 
   END; 
 
   DBMS_OUTPUT.PUT_LINE ('What error?'); 
   ROLLBACK; 
EXCEPTION 
   WHEN VALUE_ERROR 
   THEN 
      DBMS_OUTPUT.PUT_LINE ('Outer block'); 
      ROLLBACK; 
END;
/

-- Did You Know You Can Name Nested Blocks?
BEGIN 
   <<outer>> 
   DECLARE 
      aname   VARCHAR2 (5); 
   BEGIN 
      <<inner>> 
      DECLARE 
         aname   VARCHAR2 (20); 
      BEGIN 
         OUTER.aname := 'Big String'; 
      EXCEPTION 
         WHEN VALUE_ERROR 
         THEN 
            RAISE NO_DATA_FOUND; 
			 
         WHEN NO_DATA_FOUND 
         THEN 
            DBMS_OUTPUT.put_line ('Inner block'); 
      END INNER; 
   EXCEPTION 
      WHEN NO_DATA_FOUND 
      THEN 
         DBMS_OUTPUT.put_line ('Outer block'); 
   END OUTER; 
END; 
/

-- And the Winner Is....
DECLARE 
   v_totsal NUMBER; 
   v_ename employees.last_name%TYPE; 
BEGIN 
   /* There are no rows with department_id = -15 */ 
   SELECT SUM (salary) INTO v_totsal 
     FROM employees  
    WHERE department_id = -15; 
 
   DBMS_OUTPUT.PUT_LINE ('Total salary: ' || v_totsal); 
 
   SELECT last_name INTO v_ename 
     FROM employees 
    WHERE salary = 
       (SELECT MAX (salary) 
          FROM employees WHERE department_id = -15); 
           
   DBMS_OUTPUT.PUT_LINE ( 
      'The winner is: ' || v_ename); 
EXCEPTION 
   WHEN NO_DATA_FOUND 
   THEN 
      DBMS_OUTPUT.PUT_LINE ('Outer block'); 
END; 
/

-- Another Winner?
DECLARE 
   PLS_INTEGER    VARCHAR2 (1); 
   NO_DATA_FOUND   EXCEPTION; 
BEGIN 
   SELECT dummy 
     INTO PLS_INTEGER 
     FROM DUAL 
    WHERE 1 = 2; 
 
   IF PLS_INTEGER IS NULL 
   THEN 
      RAISE NO_DATA_FOUND; 
   END IF; 
EXCEPTION 
   WHEN NO_DATA_FOUND 
   THEN 
      DBMS_OUTPUT.put_line ('No dummy!'); 
END; 
/

