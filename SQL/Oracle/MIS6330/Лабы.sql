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
-- Exercise 1
-- Using the tables created in the lecture, display the first name and last name of all people who 
-- are members but not contacts
    SELECT
        FIRST_NAME,
        LAST_NAME
    FROM
        MEMBERS
    WHERE EMAIL_ADDRESS NOT IN (
        SELECT EMAIL
        FROM CONTACTS
        WHERE EMAIL IS NOT NULL
    );

    -- or

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



-- Exercise 2
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



-- Exercise 3
-- Use a WITH statement to averge the salaries by job_id in the HR.EMPLOYEES 
-- table. Then display each employee's last name, individual salary, and 
-- job salary total. Filter where salary is greater then the average for that job.
    WITH AVERAGE_SALARY_BY_JOB_ID AS (
        SELECT 
            AVG(SALARY) AS JOB_AVERAGE_SALARY, 
            JOB_ID
        FROM HR.EMPLOYEES
        GROUP BY JOB_ID
    ), SALARY_TOTAL_BY_JOB_ID AS (
        SELECT 
            SUM(SALARY) AS JOB_SALARY_TOTAL, 
            JOB_ID
        FROM HR.EMPLOYEES
        GROUP BY JOB_ID
    )
    SELECT 
        e.LAST_NAME,
        e.SALARY,
        s.JOB_SALARY_TOTAL
    FROM HR.EMPLOYEES e
        INNER JOIN SALARY_TOTAL_BY_JOB_ID s
            ON e.JOB_ID = s.JOB_ID
        INNER JOIN AVERAGE_SALARY_BY_JOB_ID a
            ON e.JOB_ID = a.JOB_ID
    WHERE e.SALARY > a.JOB_AVERAGE_SALARY
    ORDER BY e.JOB_ID;





-- @ Лаб 11
/* MIS6330 Lab 11 */
/* Analytic Functions */
--This lab uses the CLASS_DATASETS.MMS table. This table lists m&m candy data. 
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
    
    -- validate
    SELECT
        COLOR,
        SUM(QUANTITY) AS TOTAL_MMS_BY_COLOR
    FROM CLASS_DATASETS.MMS
    GROUP BY COLOR;

--Problem 3
-- Modify your query from problem 2 to show a rolling sum instead of the total sum for each color.
--   Order your results by color so that you can check your results.
    SELECT 
        MM_ID, 
        COLOR, 
        CANDY_TYPE, 
        QUANTITY,
        SUM(QUANTITY) OVER (PARTITION BY COLOR ORDER BY COLOR ROWS UNBOUNDED PRECEDING) AS ROLLING_SUM_BY_COLOR
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
    FROM CLASS_DATASETS.MMS
    ORDER BY CANDY_TYPE;
 

--Problem 5
-- Modify your query from Problem 4 to only display the rows that rank #1.
    WITH RANK_CANDY_BY_QUANTITY AS (
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
    FROM RANK_CANDY_BY_QUANTITY
    WHERE RANK_CANDY_TYPE = 1
    ORDER BY CANDY_TYPE, COLOR;
 

--Problem 6
-- Modify your query from Problem 4 so that any ties cause the next rank number to be skipped.
    SELECT 
        MM_ID, 
        COLOR, 
        CANDY_TYPE, 
        QUANTITY,
        RANK() OVER (PARTITION BY CANDY_TYPE ORDER BY QUANTITY) AS RANK_CANDY_TYPE
    FROM CLASS_DATASETS.MMS
    ORDER BY CANDY_TYPE;
    
 

--Problem 7
-- Modify your query from Problem 4 to add another column that displays the color of the candy
--  with the highest quantity for each candy_type. Call this column the top_color.
    WITH RANK_CANDY_BY_QUANTITY AS (
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
    FROM RANK_CANDY_BY_QUANTITY
    ORDER BY CANDY_TYPE, QUANTITY DESC;

 

--Problem 8
-- Display all of the columns & rows from the MMS table. Add a column to show the quantity of 
--  the row prior, within the same color ordered by candy_type. Call this column previous_quantity.
    SELECT 
        MM_ID, 
        COLOR, 
        CANDY_TYPE, 
        QUANTITY,
        LAG(QUANTITY, 1, 0) OVER (PARTITION BY COLOR ORDER BY CANDY_TYPE) AS PREVIOUS_QUANTITY
    FROM CLASS_DATASETS.MMS;
 
 

--Problem 9
-- Modify your query from Problem 8 to add a column that displays the difference between the previous
--   row's quantity and the current row's quantity.
    SELECT 
        MM_ID, 
        COLOR, 
        CANDY_TYPE, 
        QUANTITY,
        LAG(QUANTITY, 1, 0) OVER (PARTITION BY COLOR ORDER BY CANDY_TYPE) AS PREVIOUS_QUANTITY,
        QUANTITY - LAG(QUANTITY, 1, 0) over (PARTITION BY COLOR ORDER BY CANDY_TYPE) AS QUANTITY_DIFFERENCE
    FROM CLASS_DATASETS.MMS;

 

--Problem 10
-- Display all of the columns & rows from the MMS table. Add a column that displays the percentage
--  of the total quantity each row is compared to the candy_type. Call this column PERCENT_OF_TOTAL_TYPE.
    SELECT 
        MM_ID, 
        COLOR, 
        CANDY_TYPE, 
        QUANTITY,
        ROUND(RATIO_TO_REPORT(QUANTITY) over (partition by CANDY_TYPE) * 100, 1) AS PERCENT_OF_TOTAL_TYPE
    FROM CLASS_DATASETS.MMS;



-- @ Лаб 13
/* Problem 1
What day of the week was the day after Jan 1, 2000? Use the next_day function to find the day after Jan 1, 2000.
*/
    SELECT TO_CHAR(NEXT_DAY(TO_DATE('Jan 1, 2000', 'MON DD, YYYY'), + 1), 'DAY')
    FROM dual;

/* Problem 2
Using rollup, show the number of employees that report to each manager.
*/
    SELECT e.MANAGER_ID, COUNT(e.EMPLOYEE_ID)
    FROM HR.EMPLOYEES e
    GROUP BY ROLLUP(e.MANAGER_ID);

    -- verify 
    SELECT
        COUNT(MANAGER_ID)
    FROM
        HR.EMPLOYEES
    WHERE MANAGER_ID = 100;

    SELECT
        COUNT(MANAGER_ID)
    FROM
        HR.EMPLOYEES
    WHERE MANAGER_ID = 101;

    -- more resorses 
    -- ? https://docs.oracle.com/en/database/oracle/oracle-database/19/dwhsg/sql-aggregation-data-warehouses.html#GUID-BBC76574-0B15-46CB-B989-2F9E0230CD16

/* Problem 3
Return a dataset that includes each department name and a list of the job titles in that department, as a comma separated list
You'll use the Departments, Jobs and Employees tables for this query
*/
    -- answer
    WITH dep AS (
        SELECT
            DISTINCT j.JOB_TITLE,
            e.JOB_ID,
            e.DEPARTMENT_ID,
            d.DEPARTMENT_NAME
        FROM HR.EMPLOYEES e
            INNER JOIN HR.DEPARTMENTS d
                ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
            INNER JOIN HR.JOBS j
                ON e.JOB_ID = j.JOB_ID
    )
    SELECT 
        DEPARTMENT_NAME, 
        LISTAGG(JOB_TITLE, ', ') WITHIN GROUP (ORDER BY JOB_TITLE) as JOB_TITLES_IN_DEPARTMENT
    FROM dep
    group by DEPARTMENT_NAME
    ORDER BY DEPARTMENT_NAME;

    -- all others are just work process
        -- first one, had lots of duplicates
        SELECT 
            d.DEPARTMENT_NAME, 
            LISTAGG(j.JOB_TITLE, ', ') WITHIN GROUP (ORDER BY j.JOB_TITLE) as JOB_TITLES_IN_DEPARTMENT
        FROM HR.EMPLOYEES e
            INNER JOIN HR.DEPARTMENTS d
                ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
            INNER JOIN HR.JOBS j
                ON e.JOB_ID = j.JOB_ID
        group by d.DEPARTMENT_NAME
        ORDER BY d.DEPARTMENT_NAME;
        
        -- verify
            -- duplicate files
            SELECT
                e.JOB_ID,
                e.DEPARTMENT_ID,
                d.DEPARTMENT_NAME,
                j.JOB_TITLE
            FROM HR.EMPLOYEES e
                INNER JOIN HR.DEPARTMENTS d
                    ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
                INNER JOIN HR.JOBS j
                    ON e.JOB_ID = j.JOB_ID
            ORDER BY d.DEPARTMENT_NAME;

            -- distinct
            SELECT
                DISTINCT j.JOB_TITLE,
                e.JOB_ID,
                e.DEPARTMENT_ID,
                d.DEPARTMENT_NAME
            FROM HR.EMPLOYEES e
                INNER JOIN HR.DEPARTMENTS d
                    ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
                INNER JOIN HR.JOBS j
                    ON e.JOB_ID = j.JOB_ID
            ORDER BY d.DEPARTMENT_NAME;

            -- distinct + count 
            SELECT
                DISTINCT j.JOB_TITLE,
                e.JOB_ID,
                e.DEPARTMENT_ID,
                d.DEPARTMENT_NAME,
                COUNT(j.JOB_TITLE) AS DUPLICATE_COUNT 
            FROM HR.EMPLOYEES e
                INNER JOIN HR.DEPARTMENTS d
                    ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
                INNER JOIN HR.JOBS j
                    ON e.JOB_ID = j.JOB_ID
            GROUP BY e.DEPARTMENT_ID, e.JOB_ID, d.DEPARTMENT_NAME, j.JOB_TITLE
            ORDER BY d.DEPARTMENT_NAME;

/* Problem 4
Explore the summary stats of the PRICE column in the CLASS_DATASETS.PARK_CITY_REAL_ESTATE table.
*/

SET SERVEROUTPUT ON;
DECLARE
sigma number := 3;
S DBMS_STAT_FUNCS.summaryType;
item number;
cnt number;
BEGIN
DBMS_STAT_FUNCS.SUMMARY ('CLASS_DATASETS', 'PARK_CITY_REAL_ESTATE', 'PRICE', sigma, S);
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


-- @ Лаб 14
--Problem 1
-- Using the ALL_TAB_COLUMNS table, display all of the columns in the HR.EMPLOYEES table
    SELECT *
    FROM ALL_TAB_COLUMNS
    WHERE OWNER = 'HR'
        AND TABLE_NAME = 'EMPLOYEES';

--Problem 2
-- Compare the results of the ALL_TABLES view to the USER_TABLES view. What tables
--  are in ALL_TABLES that are not in USER_TABLES?
    SELECT TABLE_NAME
    FROM ALL_TABLES
    MINUS
    SELECT TABLE_NAME
    FROM USER_TABLES;


-- @ Лаб 15
--Problem 1
--Using PIVOT, show how many customers are at each income level for each state. Only show the states of UT, CA, NY, and WA. 
--The columns displayed in your query should be CUST_INCOME_LEVEL, UT, CA, NY, WA. I've started your query for you below.
SELECT * FROM (
   SELECT cust_income_level
   , cust_state_province
   FROM sh.customers c
)
pivot (
    count(*) FOR cust_state_province IN (
        'UT' AS UT, 
        'CA' AS CA, 
        'NY' AS NY, 
        'WA' AS WA)
)
ORDER BY cust_income_level;

