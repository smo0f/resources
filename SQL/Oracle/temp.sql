-- @ Lab Three
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