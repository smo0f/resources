-- @ Block Structure
    -- The SET SERVEROUTPUT ON command turns on the server output so you can see the lines produced by DBMS_OUTPUT.PUT_LINE() on the screen when you run the script in SQL*Plus.
    SET SERVEROUTPUT ON
    DECLARE
        v_width INTEGER; 
        v_height INTEGER := 2; 
        v_area INTEGER := 6;
    BEGIN
        -- set the width equal to the area divided by the height v_width := v_area / v_height;
        v_width := v_area / v_height;
        DBMS_OUTPUT.PUT_LINE('v_width = ' || v_width>;
    EXCEPTION
        WHEN ZERO_DIVIDE THEN
            DBMS_OUTPUT.PUT_LINE('Division by zero');
    END;
    /
    -- A PL/SQL block is terminated using the forward slash (/) character.
    -- ? https://bookshelf.vitalsource.com/#/books/9780071799362/cfi/6/40!/4/48@0:34.9

    -- # Variable Declarations
        v_product_id INTEGER;
        v_product_type_id INTEGER; 
        v_name VARCHAR2(30);
        v_description VARCHAR2(50);
        v_price NUMBER(5. 2);

        -- You can also specify a variable’s type using the %TYPE keyword, which tells PL/SQL to use the same type as a specified column in a table
        v_product_price products.price%TYPE;

    -- # Conditional Logic
        IF conditionl THEN 
            statements1
        ELSIF condition2 THEN 
            statements2 
        ELSE 
            statements3
        END IF;

        -- other example
        IF v_count > 0 THEN
            v_message := 'v_count is positive';
            IF v_area > 0 THEN
                v_message := 'v_count and v_area are positive';
            END IF
        ELSIF v_count = 0 THEN
            v_message := 'v_count is zero';
        ELSE
            v_message := 'v_count is negative';
        END IF;
        -- ? https://bookshelf.vitalsource.com/#/books/9780071799362/cfi/6/40!/4/116@0:15.4

    -- # Loops
        -- There are three types of loops in PL/SQL:
        -- Simple loops run until you explicitly end the loop.
        -- WHILE loops run until a specified condition occurs.
        -- FOR loops run a predetermined number of times.

        -- * Simple Loops
            LOOP
                statements
            END LOOP;
            -- To end the loop, you use either an EXIT or an EXIT WHEN statement. The EXIT statement ends a loop immediately. The EXIT WHEN statement ends a loop when a specified condition occurs.
            v_counter := 0;
            LOOP
                v_counter := v_counter + 1;
                EXIT WHEN v_counter = 5;
            END LOOP;

        -- * CONTINUE
            -- In Oracle Database 11g and above, you can also end the current iteration of a loop using the CONTINUE or CONTINUE WHEN statement. The CONTINUE statement ends the current iteration of the loop unconditionally and continues with the next iteration. The CONTINUE WHEN statement ends the current iteration of the loop when a specified condition occurs and then continues with the next iteration. The following example shows the use of the CONTINUE statement:
                v_counter := O;
                LOOP
                    -- after the CONTINUE statement is executed, control returns here 
                    v_counter := v_counter + 1;
                    IF v_counter = 3 THEN
                        CONTINUE; -- end current iteration unconditionally 
                    END IF;
                    EXIT WHEN v_counter = 5;
                END LOOP;
                -- or
                v_counter := O;
                LOOP
                    -- after the CONTINUE statement is executed, control returns here 
                    v_counter := v_counter + 1;
                    CONTINUE WHEN v_counter = 3; -- end current iteration unconditionally 
                    EXIT WHEN v_counter = 5;
                END LOOP;
                -- NOTE: A CONTINUE or CONTINUE WHEN statement cannot cross a procedure, function, or method boundary

        -- * WHILE Loops
            WHILE condition LOOP
                statements
            END LOOP;
            -- example
            v_counter := O;
            WHILE v_counter < 6 LOOP
                v_counter := v_counter + 1;
            END LOOP;

        -- * FOR Loops
            FOR loop_variable IN [REVERSE] lower_bound..upper_bound LOOP 
                statements
            END LOOP;
            -- example
            -- Notice that the variable v_counter2 isn’t explicitly declared—so the FOR loop automatically creates a new INTEGER variable named v_counter2.
            FOR v_counter2 IN 1..5 LOOP
                DBMS_OUTPUT.PUT_LINE(v_counter2); 
            END LOOP;
            -- or
            FOR v_counter2 IN REVERSE 1..5 LOOP
                DBMS_OUTPUT.PUT_LINE(v_counter2); 
            END LOOP;
            -- ? https://bookshelf.vitalsource.com/#/books/9780071799362/cfi/6/40!/4/206/2/2@0:54.2

    -- # Cursors
        -- ? https://bookshelf.vitalsource.com/#/books/9780071799362/cfi/6/40!/4/246/2@0:0
        -- * Step 1: Declare the Variables to Store the Column Values
            DECLARE
                v_product_id    products.product_id%TYPE;
                v_name          products.name%TYPE;
                v_price         products.price%TYPE;
        -- * Step 2: Declare the Cursor
            CURSOR cursor_name IS
                SELECT_statement;

            CURSOR v_product_cursor IS
                SELECT product_id, name, price
                FROM products
                ORDER BY product_id;
        -- * Step 3: Open the Cursor
            OPEN v_product_cursor;
        -- * Step 4: Fetch the Rows from the Cursor
            FETCH v_product_cursor
            INTO v_product_id, v_name, v_price

            -- Because a cursor can contain many rows, you need a loop to read them. To determine when to end the loop, you can use the Boolean variable v_product_cursor%NOTFOUND. This variable is true when there are no more rows to read in v_product_cursor. The following example shows a loop:
            LOOP
                -- fetch the rows from the cursor
                FETCH v_product_cursor
                INTO v_product_id, v_name, v_price;

                -- exit the loop when there are no more rows, as indicated by
                -- the Boolean variable v_product_cursor%NOTFOUND (= true when
                -- there are no more rows)
                EXIT WHEN v_product_cursor%NOTFOUND;

                -- use DBMSJDUTPUT.PUT_LINE() to display the variables
                DBMS_OUTPUT.PUT_LINE(
                    'v_product_id = ' || v_product_id || ', v_name = ' || v_name ||
                    ', v_price = ' || v_price
                );
            END LOOP;
        -- * Step 5: Close the Cursor
            CLOSE v_product_cursor;

        -- * Complete Example: product_cursor.sql
            -- This script displays the product_id, name, and price columns 
            -- from the products table using a cursor

            SET SERVEROUTPUT ON

            DECLARE
                -- step 1: declare the variables 
                v_product_id    products.product_id%TYPE; 
                v_name	        products.name%TYPE;
                v_price	        products.price%TYPE;
                -- step 2: declare the cursor 
                CURSOR v_product_cursor IS
                    SELECT product_id, name, price
                        FROM products
                    ORDER BY product_id;
            BEGIN
                -- step 3: open the cursor 
                OPEN v_product_cursor;

                LOOP
                    -- step 4: fetch the rows from the cursor
                    FETCH v_product_cursor
                    INTO v_product_id, v_name, v_price;

                    -- exit the loop when there are no more rows, as indicated by -- the Boolean variable v product cursor%NOTFOUND (= true when -- there are no more rows)
                    EXIT WHEN v_product_cursor%NOTFOUND;

                    -- use DBMS_OUTPUT.PUT_LINE() to display the variables 
                    DBMS_OUTPUT.PUT_LINE(
                        'v_product_id = ' || v_product_id || ', v_name = ' || v_name ||
                        ', v_price = ' || v_price
                    );
                END LOOP;
            
                -- step 5: close the cursor 
                CLOSE v_product_cursor;
            END;
            /

        -- * Cursors and FOR Loops
            -- You can use a FOR loop to access the rows in a cursor. When you do this, you don’t have to explicitly open and close the cursor—the FOR loop does this automatically for you. The following product_cursor2.sql script uses a FOR loop to access the rows in v_product_cursor:
            -- This script displays the product_id, name, and price columns 
            -- from the products table using a cursor and a FOR loop
                SET SERVEROUTPUT ON
                
                DECLARE
                    CURSOR v_product_cursor IS
                        SELECT product_id, name, price
                            FROM products
                        ORDER BY product_id;
                BEGIN
                    FOR v_product IN v_product_cursor LOOP 
                        DBMS_OUTPUT.PUT_LINE(
                            'product_id = ' || v_product.product_id || ', name = ' || v_product.name ||
                            ', price = ' || v_product.price
                        );
                    END LOOP;
                END;
                /
                -- ? https://bookshelf.vitalsource.com/#/books/9780071799362/cfi/6/40!/4/384/2/2@0:98.5

        -- * OPEN-FOR Statement
            -- ? https://bookshelf.vitalsource.com/#/books/9780071799362/cfi/6/40!/4/398/2/2@0:0 

        -- * Unconstrained Cursors
            -- the ability to use one or more queries with one cursor
            -- ? https://bookshelf.vitalsource.com/#/books/9780071799362/cfi/6/40!/4/468/2@0:0

    -- # Exceptions
        SET SERVEROUTPUT ON
        DECLARE
            v_width INTEGER; 
            v_height INTEGER := 2; 
            v_area INTEGER := 6;
        BEGIN
            -- set the width equal to the area divided by the height v_width := v_area / v_height;
            v_width := v_area / v_height;
            DBMS_OUTPUT.PUT_LINE('v_width = ' || v_width>;
        EXCEPTION
            WHEN ZERO_DIVIDE THEN
                DBMS_OUTPUT.PUT_LINE('Division by zero');
        END;
        /
        -- other exceptions
        -- ? https://bookshelf.vitalsource.com/#/books/9780071799362/cfi/6/40!/4/500/2/2@0:91.1
 





 



