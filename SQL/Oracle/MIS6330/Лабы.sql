-- @ Лаб Один
    -- * Exercise 1
    -- Using the CLASS_DATASETS.OE_ORDERS table, select the order_id and the order_total.
    -- Add a calculated column to your displayed results that categorizes an order into three categories based on the order total:
    -- $50,000 and up = Tier 1
    -- $25,000 - $49,999 = Tier 2
    -- $0 - $24,999 = Tier 3
    -- Others = Tier 4
    SELECT
        ORDER_ID,
        ORDER_TOTAL,
        CASE 
            WHEN ORDER_TOTAL >= 50000 THEN
                'Tier 1' 
            WHEN ORDER_TOTAL BETWEEN 25000 AND 49999 THEN
                'Tier 2'
            WHEN ORDER_TOTAL BETWEEN 0 AND 24999 THEN
                'Tier 3'
            ELSE 
                'Tier 4'
        END AS Tier
    FROM
        CLASS_DATASETS.OE_ORDERS;

    -- * Exercise 2
    -- Add to your Exercise 1 query to filter on order_date = 2008. Do not use between. Use to_char to get just the year to filter on.
    SELECT
        ORDER_ID,
        ORDER_TOTAL,
        to_char(ORDER_DATE, 'YYYY') AS "Date",
        CASE 
            WHEN ORDER_TOTAL >= 50000 THEN
                'Tier 1' 
            WHEN ORDER_TOTAL BETWEEN 25000 AND 49999 THEN
                'Tier 2'
            WHEN ORDER_TOTAL BETWEEN 0 AND 24999 THEN
                'Tier 3'
            ELSE 
                'Tier 4'
        END AS Tier
    FROM
        CLASS_DATASETS.OE_ORDERS
    WHERE to_char(ORDER_DATE, 'YYYY') = 2008;

    -- * Exercise 3  
    -- Using your query from Exercise 2, change the literal value of 2008 to a substitution variable.               
    DEFINE v_year = '2007';

    SELECT
        ORDER_ID,
        ORDER_TOTAL,
        to_char(ORDER_DATE, 'YYYY') AS "Date",
        CASE 
            WHEN ORDER_TOTAL >= 50000 THEN
                'Tier 1' 
            WHEN ORDER_TOTAL BETWEEN 25000 AND 49999 THEN
                'Tier 2'
            WHEN ORDER_TOTAL BETWEEN 0 AND 24999 THEN
                'Tier 3'
            ELSE 
                'Tier 4'
        END AS Tier
    FROM
        CLASS_DATASETS.OE_ORDERS
    WHERE to_char(ORDER_DATE, 'YYYY') = &v_year;


    -- * EXERCISE 4
    -- Display the total number of medals awarded by sport using the CLASS_DATASETS.OLYMPIC_MEDAL_WINNERS.
    SELECT sport, count(DISTINCT medals) as total_medals
        FROM class_datasets.olympic_medal_winners
    GROUP BY sport;

-- @ Лаб Два
    -- Write a query that return the count of employees by region, country, state and department from the HR.EMP_DETAILS_VIEW view.
    -- Order the results by the region, country, state and department
    -- Remember that if you do not know the columns of a table or view you can do DESC HR.EMP_DETAILS_VIEW
    SELECT
        COUNT(*) AS EmployeeCount,
        REGION_NAME,
        COUNTRY_NAME,
        STATE_PROVINCE,
        DEPARTMENT_NAME
    FROM
        HR.EMP_DETAILS_VIEW
    GROUP BY REGION_NAME, COUNTRY_NAME, STATE_PROVINCE, DEPARTMENT_NAME
    ORDER BY REGION_NAME, COUNTRY_NAME, STATE_PROVINCE, DEPARTMENT_NAME;

    -- Write a PL/SQL Block that loops through the results of Problem 1 and outputs to the screen department and the count.
    BEGIN 
        FOR department IN ( 
            SELECT
                COUNT(*) AS EmployeeCount,
                REGION_NAME,
                COUNTRY_NAME,
                STATE_PROVINCE,
                DEPARTMENT_NAME
            FROM
                HR.EMP_DETAILS_VIEW
            GROUP BY REGION_NAME, COUNTRY_NAME, STATE_PROVINCE, DEPARTMENT_NAME
            ORDER BY REGION_NAME, COUNTRY_NAME, STATE_PROVINCE, DEPARTMENT_NAME
        ) LOOP 
            DBMS_OUTPUT.PUT_LINE('Department Name = ' || department.DEPARTMENT_NAME || ', Employee Count = ' || department.EmployeeCount); 
        END LOOP; 
    END; 

    -- Modify your code from Problem 3 to use a variable where you'll pass in the Region_name to filter your query on. 
    -- For testing, default this parameter to 'Americas'.
    DECLARE
        v_region_name HR.EMP_DETAILS_VIEW.REGION_NAME%TYPE := 'Americas';
    BEGIN 
        FOR department IN ( 
            SELECT
                COUNT(*) AS EmployeeCount,
                REGION_NAME,
                COUNTRY_NAME,
                STATE_PROVINCE,
                DEPARTMENT_NAME
            FROM
                HR.EMP_DETAILS_VIEW
            WHERE REGION_NAME = '&v_region_name'
            GROUP BY REGION_NAME, COUNTRY_NAME, STATE_PROVINCE, DEPARTMENT_NAME
            ORDER BY REGION_NAME, COUNTRY_NAME, STATE_PROVINCE, DEPARTMENT_NAME
        ) LOOP 
            DBMS_OUTPUT.PUT_LINE('Department Name = ' || department.DEPARTMENT_NAME || ', Employee Count = ' || department.EmployeeCount); 
        END LOOP; 
    END; 

-- @ Лаб Три
    /************************************************
    MIS6330 - Lecture 3 - PL/SQL Functions & Triggers
    ************************************************/
    /* Problem 1 */
    -- Build a PL/SQL block with a nested for loop.
    -- With two variables: x and y both from 1 to 5
    -- The loop should display the equation of "x * y = " substituting x & y in the display
    -- then the loop needs to show the result of x * y which has been stored into a variable called result.
    DECLARE
        v_result NUMBER;
    BEGIN 
        FOR x IN 1..5 LOOP
            FOR y IN 1..5 LOOP
                v_result := x * y;
                DBMS_OUTPUT.PUT_LINE(x || ' * ' || y || ' = ' || v_result); 
            END LOOP;
        END LOOP;
    END;
    /

    /* Problem 2 */
    -- First run these statements to create a copy of the travels table and a log table
    DROP TABLE travels_copy;
    CREATE TABLE travels_copy AS 
    SELECT * FROM instantride.travels;
    
    CREATE TABLE travels_log (
        travel_id number, 
        old_travel_price number, 
        new_travel_price number, 
        price_increase_flag varchar2(1)
    );
    -- Build a PL/SQL trigger to run after any update on your travels_copy table. 
    -- This trigger will add a row to the travels_log table. 
    -- Insert into this table the travel_id, the travel_price before the update, travel_price after the update, and then 
    -- a flag of Y if the new price is greater than the old price, otherwise an N.
    CREATE OR REPLACE TRIGGER after_travels_copy_update 
    AFTER UPDATE ON travels_copy
    FOR EACH ROW
    DECLARE
        v_price_increase_flag varchar2(1 CHAR);
    BEGIN
        -- set v_price_increase_flag
        IF :new.travel_price > :old.travel_price 
            THEN
                v_price_increase_flag := 'Y';   
            ELSE
                v_price_increase_flag := 'N';
        END IF;
        -- perform insert statement
        INSERT INTO travels_log (travel_id, old_travel_price, new_travel_price, price_increase_flag)
        VALUES (:old.TRAVEL_ID, :old.travel_price, :new.travel_price, v_price_increase_flag);
    END after_travels_copy_update;
    /
    
    -- Update your travels_copy table for the travel_id row of 5010. Pick a new travel_price.
    UPDATE travels_copy
    SET travel_price = 98.98
    WHERE travel_id = 5010;
    COMMIT;

    
    -- Query your travels_log table to see the new log record.
    SELECT *
    FROM travels_log;
    
    --Drop your new trigger & tables
    DROP TRIGGER after_travels_copy_update;
    DROP TABLE travels_copy;
    DROP TABLE travels_log;

-- @ Лаб Четыре
    




-- @ Лаб Пять

-- @ Лаб Семь
-- Turn in your sql for the following:

-- Create a table called Lab7 with 4 columns: id, description, employee_id, and name
-- Put a primary key out of line constraint on this table on the id column and a not null in line constraint on the description column.
CREATE TABLE Lab7 (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    name VARCHAR2(25 CHAR),
    description VARCHAR2(500 CHAR) NOT NULL,
    employee_id NUMBER,
    CONSTRAINT lab7_pk PRIMARY KEY (id)
);

-- to see progress
DESCRIBE Lab7;

-- Drop the name column from your Lab7 table.
ALTER TABLE Lab7
DROP COLUMN name;

-- to see progress
DESCRIBE Lab7;

-- Alter your table to change employee_id to be a foreign key to the HR.EMPLOYEES table.
-- Switched tables due to permission restrictions
CREATE TABLE employees AS SELECT * FROM HR.EMPLOYEES;
ALTER TABLE employees MODIFY employee_id PRIMARY KEY;
ALTER TABLE Lab7
ADD FOREIGN KEY (employee_id) REFERENCES employees(employee_id);

-- Create a view over your Lab7 table called Lab7_View with the three columns but restrict to only records having employee_id greater than 50.
CREATE VIEW Lab7_View AS
    SELECT id, description, employee_id
    FROM Lab7
    WHERE id > 50;

-- Drop your table and view.
DROP VIEW Lab7_View;
DROP TABLE Lab7;
DROP TABLE employees;






-- @ Лаб Восемь и Девять
--Run the following to create a table that we'll use for this lab.
    CREATE TABLE RMOORE.lab8 (
    product_id number generated always as identity
    , product_name varchar2(35 char)
    , price number
    );

--Give your partner access to query your table.
    GRANT SELECT, INSERT, UPDATE, DELETE ON lab8 TO choiland;

--Insert two records into your lab8 table. You can make up information for the product name and price. The id will be autogenerated.
    INSERT INTO RMOORE.LAB8 (PRODUCT_NAME, PRICE) 
    VALUES ('Ham', 12.99);

    INSERT INTO RMOORE.LAB8 (PRODUCT_NAME, PRICE) 
    VALUES ('12 Eggs', 1.99);

--Ask your partner to query your table.
    SELECT
        PRODUCT_ID,
        PRODUCT_NAME,
        PRICE
    FROM
        choiland.lab8;

--Did they get any records? Probably not because you didn't commit. Run a commit and have them run their query again.
    -- yes
    COMMIT;

--Add one more record to your table.
    INSERT INTO RMOORE.LAB8 (PRODUCT_NAME, PRICE) 
    VALUES ('13 Eggs', 1.99);

--Now run a select query against the table yourself. You should get 3 records.
    SELECT
        PRODUCT_ID,
        PRODUCT_NAME,
        PRICE
    FROM
        RMOORE.LAB8;

--Run a ROLLBACK.
    ROLLBACK; -- this didn't work on its own because of the web's autocommit

    -- But if you run these altogether at tthe same time it does work
    INSERT INTO RMOORE.LAB8 (
        PRODUCT_NAME,
        PRICE
    ) VALUES (
        '14 Eggs',
        1.99
    );
    ROLLBACK;
    SELECT
        PRODUCT_ID,
        PRODUCT_NAME,
        PRICE
    FROM
        RMOORE.LAB8;

--Run your select query again. You should get 2 records.
    SELECT
        PRODUCT_ID,
        PRODUCT_NAME,
        PRICE
    FROM
        RMOORE.LAB8;

--Update the record with product_id of 1 to change the product name.
    UPDATE RMOORE.LAB8
    SET PRODUCT_NAME = 'Hammmm!'
    WHERE PRODUCT_ID = 1;

--Have your partner query again. What product name do they see?
    SELECT
        PRODUCT_ID,
        PRODUCT_NAME,
        PRICE
    FROM
        choiland.lab8;
    -- all of them

--Delete the record with product_id = 1;
    DELETE FROM RMOORE.LAB8
    WHERE PRODUCT_ID = 1;

--Run your select query again. You should get 1 record this time.
    SELECT
        PRODUCT_ID,
        PRODUCT_NAME,
        PRICE
    FROM
        RMOORE.LAB8;

--How many rows does your partner get?
    -- 1, because of the web autocommit

--Truncate the table.
    TRUNCATE TABLE RMOORE.LAB8;

--Remove your partner's access to your table.
    REVOKE ALL ON RMOORE.LAB8_RUSSELL FROM choiland; 


-- @ Лаб 10

/* MIS6330 Lab 10
WITH, Subqueries, and Set Operations
*/

--Exercise 1
-- Using the tables created in the lecture, display the first name and last name of all people who 
-- are members but not contacts
SELECT
    FIRST_NAME,
    LAST_NAME
FROM
    MEMBERS
WHERE
    EMAIL_ADDRESS IN (
        SELECT EMAIL_ADDRESS
        FROM MEMBERS
        MINUS
        SELECT EMAIL
        FROM CONTACTS
    )
;


--Exercise 2
-- Using the HR.EMPLOYEES table, find all employees who make (SALARY) less than all of the people with 
-- FI_ACCOUNT job_ids
SELECT
    EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME,
    SALARY
FROM
    HR.EMPLOYEES
WHERE SALARY < ALL (
        SELECT SALARY
        FROM HR.EMPLOYEES
        WHERE JOB_ID = 'FI_ACCOUNT'
    )
;



--Exercise 3
-- Use a WITH statement to averge the salaries by job_id in the HR.EMPLOYEES 
-- table. Then display each employee's last name, individual salary, and 
-- job salary total. Filter where salary is greater then the average for that job.






-- @ Лаб 11
/* MIS6330 Lab 11 */
/* Analytic Functions */

--This lab uses the MIS6330_DATASETS.MMS table. This table lists m&m candy data. 
--  It has 4 columns: MM_ID, COLOR, CANDY_TYPE, QUANTITY


--Problem 1
-- Select all columns and rows from the MMS table. Add a column to the end of the output showing the 
--   total quantity of M&Ms by summing the QUANTITY column - name this column TOTAL_MMS.
    SELECT 
        MM_ID, 
        COLOR, 
        CANDY_TYPE, 
        QUANTITY,
        SUM(QUANTITY) OVER () AS TOTAL_MMS
    FROM CLASS_DATASETS.MMS;
    
    -- validate
    SELECT
        SUM(QUANTITY) AS TOTAL_MMS
    FROM CLASS_DATASETS.MMS;

--Problem 2
-- Add to your query above but group the total_mms column by the color of the M&Ms so that it shows
--  only the total count of m&ms with the same color as the current row.
    SELECT 
        MM_ID, 
        COLOR, 
        CANDY_TYPE, 
        QUANTITY,
        SUM(QUANTITY) OVER (PARTITION BY COLOR ORDER BY COLOR) AS TOTAL_MMS_BY_COLOR
    FROM CLASS_DATASETS.MMS;
    
    -- TODO: validate
    SELECT
        SUM(QUANTITY) AS TOTAL_MMS
    FROM CLASS_DATASETS.MMS;

--Problem 3
-- Modify your query from problem 2 to show a rolling sum instead of the total sum for each color.
--   Order your results by color so that you can check your results.
    SELECT 
        MM_ID, 
        COLOR, 
        CANDY_TYPE, 
        QUANTITY,
        SUM(QUANTITY) OVER (PARTITION BY COLOR ORDER BY COLOR ROWS UNBOUNDED PRECEDING) AS TOTAL_MMS_BY_COLOR
    FROM CLASS_DATASETS.MMS;

--Problem 4
-- Display all of the columns & rows from the MMS table. Add a column to rank the candy based on 
--   the quantity of pieces of candy. Create a separate rank order for each candy_type.
    SELECT 
        MM_ID, 
        COLOR, 
        CANDY_TYPE, 
        QUANTITY,
        DENSE_RANK() OVER (PARTITION BY CANDY_TYPE ORDER BY QUANTITY) AS RANK_CANDY_TYPE
    FROM CLASS_DATASETS.MMS;
 

--Problem 5
-- Modify your query from Problem 4 to only display the rows that rank #1.
    WITH candy AS (
        SELECT 
            MM_ID, 
            COLOR, 
            CANDY_TYPE, 
            QUANTITY,
            DENSE_RANK() OVER (PARTITION BY CANDY_TYPE ORDER BY QUANTITY) AS RANK_CANDY_TYPE
        FROM CLASS_DATASETS.MMS
    )

    SELECT 
        MM_ID, 
        COLOR, 
        CANDY_TYPE, 
        QUANTITY,
        RANK_CANDY_TYPE
    FROM candy
    WHERE RANK_CANDY_TYPE = 1;
 

--Problem 6
-- Modify your query from Problem 4 so that any ties cause the next rank number to be skipped.
    WITH candy AS (
        SELECT 
            MM_ID, 
            COLOR, 
            CANDY_TYPE, 
            QUANTITY,
            RANK() OVER (PARTITION BY CANDY_TYPE ORDER BY QUANTITY) AS RANK_CANDY_TYPE
        FROM CLASS_DATASETS.MMS
    )

    SELECT 
        MM_ID, 
        COLOR, 
        CANDY_TYPE, 
        QUANTITY,
        RANK_CANDY_TYPE
    FROM candy
    WHERE RANK_CANDY_TYPE = 1;
 

--Problem 7
-- Modify your query from Problem 4 to add another column that displays the color of the candy
--  with the highest quantity for each candy_type. Call this column the top_color.
    WITH candy AS (
        SELECT 
            MM_ID, 
            COLOR, 
            CANDY_TYPE, 
            QUANTITY,
            DENSE_RANK() OVER (PARTITION BY CANDY_TYPE ORDER BY QUANTITY) AS MMS_Rank,
            FIRST_VALUE(COLOR) over (PARTITION BY CANDY_TYPE ORDER BY QUANTITY DESC) AS TOP_COLOR
        FROM CLASS_DATASETS.MMS
    )
    SELECT 
        MM_ID, 
        COLOR, 
        CANDY_TYPE, 
        QUANTITY,
        MMS_RANK,
        TOP_COLOR
    FROM candy
    ORDER BY CANDY_TYPE, QUANTITY DESC;

 

--Problem 8
-- Display all of the columns & rows from the MMS table. Add a column to show the quantity of 
--  the row prior, within the same color ordered by candy_type. Call this column previous_quantity.
    
    
    
    
    
    -- ???
    -- SELECT     
    --     MM_ID, 
    --     COLOR, 
    --     CANDY_TYPE, 
    --     QUANTITY, 
    --     lag(quantity, 1, NULL) over (partition by color order by candy_type) as previous_quantity
    -- FROM CLASS_DATASETS.MMS;

 

--Problem 9
-- Modify your query from Problem 8 to add a column that displays the difference between the previous
--   row's quantity and the current row's quantity.
    
    
    
    
    
    
    -- ??? 
    -- SELECT     
    --     MM_ID, 
    --     COLOR, 
    --     CANDY_TYPE, 
    --     QUANTITY, 
    --     lag(quantity, 1, NULL) over (partition by color order by candy_type) as previous_quantity,
    --     quantity - lag(quantity, 1, NULL) over (partition by color order by candy_type) as previous_quantity_diff
    -- FROM CLASS_DATASETS.MMS;

 

--Problem 10
-- Display all of the columns & rows from the MMS table. Add a column that displays the percentage
--  of the total quantity each row is compared to the candy_type. Call this column PERCENT_OF_TOTAL_TYPE.




    -- ???
    -- SELECT     
    --     MM_ID, 
    --     COLOR, 
    --     CANDY_TYPE, 
    --     QUANTITY,
    --     round(ratio_to_report(quantity) over (partition by candy_type) * 100, 1) AS PERCENT_OF_TOTAL_TYPE
    -- FROM CLASS_DATASETS.MMS;
