-- @ Procedures
    -- ? https://bookshelf.vitalsource.com/#/books/9780071799362/cfi/6/40!/4/562/2/2@0:96.2
    -- # Creating a Procedure
        CREATE OR REPLACE PROCEDURE update_product_price(
            p_product_id    IN products.product_id%TYPE, 
            p_factor	    IN NUMBER
        ) AS
        v_product_count INTEGER;
        BEGIN
            -- count the number of products with the supplied product_id 
            -- (the count will be 1 if the product exists)
            SELECT COUNT(*)
            INTO v_product_count FROM products
            WHERE product_id = p_product_id;

            -- if the product exists (v_product_count = 1) then 
            -- update that product's price 
            IF v_product_count = 1 THEN 
                UPDATE products 
                SET price = price * p_factor 
                WHERE product_id = p_product_id;
                COMMIT;
            END IF;
        EXCEPTION
            WHEN OTHERS THEN 
                ROLLBACK;
        END update_product_price;
        /

    -- # Calling a Procedure
        CALL update_product_price(1, 1.5);
        -- using named notation
        CALL update_product_price(p_factor => 1.3, p_product_id => 2);
        -- Tip: Named notation makes your code easier to read and maintain because the parameters are explicitly shown.

    -- # Getting Information on Procedures
        -- ? https://bookshelf.vitalsource.com/#/books/9780071799362/cfi/6/40!/4/690/2/2@0:0

    -- # Dropping a Procedure
        DROP PROCEDURE update_product_price;

    -- # Viewing Errors in a Procedure
        -- ? https://bookshelf.vitalsource.com/#/books/9780071799362/cfi/6/40!/4/716/2/2@0:0

-- @ Functions
    -- ? https://bookshelf.vitalsource.com/#/books/9780071799362/cfi/6/40!/4/730/2@0:100
    -- # Creating a Function
        CREATE OR REPLACE FUNCTION circle_area ( 
            p_radius IN NUMBER 
        ) RETURN NUMBER AS
            v_pi NUMBER := 3.1415926;
            v_area NUMBER;
        BEGIN
            -- circle area is pi multiplied by the radius squared 
            v_area := v_pi * POWER(p_radius, 2);
            RETURN v_area;
        END circle_area;
        /
        -- other example
        CREATE FUNCTION average_product_price ( 
            p_product_type_id IN INTEGER 
        ) RETURN NUMBER AS
            v_average_product_price NUMBER;
        BEGIN
            SELECT AVG(price)
            INTO v_average_product_price 
            FROM products
            WHERE product_type_id = p_product_type_id; 
            RETURN v_average_product_price;
        END average_product_price;
        /

    -- # Calling a Function
        circle_area(2)
        -- use named notation
        circle_area(p_radius => 4) 

    -- # Getting Information on Functions
        -- ? https://bookshelf.vitalsource.com/#/books/9780071799362/cfi/6/40!/4/810/2@0:0

    -- # Dropping a Function 
        DROP FUNCTION circle_area;

-- @ Packages
    -- ? https://bookshelf.vitalsource.com/#/books/9780071799362/cfi/6/40!/4/826/2@0:0
    -- # Creating a Package Specification
        CREATE OR REPLACE PACKAGE product_package AS 
            TYPE t_ref_cursor IS REF CURSOR;
            FUNCTION get_products_ref_cursor RETURN t_ref_cursor 
            PROCEDURE update_product_price (
                p_product_id    IN products.product_id%TYPE, 
                p_factor	    IN NUMBER
            );
        END product_package;
        /
    
    -- # Creating a Package Body
        -- ? https://bookshelf.vitalsource.com/#/books/9780071799362/cfi/6/40!/4/872/2/2@0:94.1

    -- # Other Information on Packages
        -- ?-- ? https://bookshelf.vitalsource.com/#/books/9780071799362/cfi/6/40!/4/826/2@0:0

-- @ Triggers
    -- ? https://bookshelf.vitalsource.com/#/books/9780071799362/cfi/6/40!/4/934/2@0:0
    -- # Creating a Trigger
        CREATE OR REPLACE TRIGGER before_product_price_update 
        BEFORE UPDATE OF price 
        ON products
        FOR EACH ROW WHEN (new.price < old.price * 0.75)
        BEGIN
            dbms_output.put_line('product_id = ' || :old.product_id); 
            dbms_output.put_line('Old price = ' || :old.price); 
            dbms_output.put_line('New price = ' || :new.price); 
            dbms_output.put_line('The price reduction is more than 25%');
            -- insert row into the product_price_audit table 
            INSERT INTO product_price_audit(product_id, old_price, new_price ) 
            VALUES (
                :old.product_id, :old.price, :new.price
            );
        END before_product_price_update;
        /
        -- ? https://bookshelf.vitalsource.com/#/books/9780071799362/cfi/6/40!/4/992/2/14@0:44.1

        -- example
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

        -- revised from teachers example
        CREATE OR REPLACE TRIGGER after_travels_copy_update 
        AFTER UPDATE 
            ON travels_copy
            FOR EACH Row
        BEGIN
            INSERT INTO travels_log
            VALUES (
                :old.TRAVEL_ID, 
                :old.travel_price, 
                :new.travel_price, 
                CASE WHEN :new.travel_price > :old.travel_price THEN 'Y' ELSE 'N' END
            );
        END after_travels_copy_update;
        /




-- @ questions
    -- * INTO
        -- located: Creating a Procedure
        SELECT COUNT(*)
        INTO v_product_count FROM products
        WHERE product_id = p_product_id;
    -- * row-level trigger VS statement-level trigger
        -- ? https://bookshelf.vitalsource.com/#/books/9780071799362/cfi/6/40!/4/936/2/10@0:100
    -- * vaccine type
    -- * Constraints and code or constraints in database
