-- Write queries to answer the following analytical questions:









-- @ List every pet adopted, the pet’s name, adopter’s name, pet type, breed, and a number indicating the order of the pet adopted by pet type and breed (i.e. this is the 9th Dog, Labrador Retriever adopted).
    -- # simple version
        -- gets information out, but is not searchable nor not as intuitive as one would like.
        DECLARE
            v_breed varchar2(50);
            v_typeOfAnimal varchar2(50);
            v_counter Number := 0;
            v_nth varchar2(10);
        BEGIN 
            -- loop through and get information
            FOR adoption IN ( 
                SELECT
                    ap.ADOPTABLE_PET_NAME,
                    ad.ADOPTERS_FIRST_NAME || ' ' || ad.ADOPTERS_LAST_NAME AS ADOPTERS_NAME,
                    toa.TYPE_OF_ANIMAL,
                    b.BREED_NAME
                FROM RMOORE.ADOPTIONS a
                    INNER JOIN RMOORE.ADOPTABLEPETS ap
                        ON a.ADOPTABLE_PET_ID = ap.ADOPTABLE_PET_ID
                    INNER JOIN RMOORE.ADOPTERS ad
                        ON a.ADOPTER_ID = ad.ADOPTER_ID
                    INNER JOIN RMOORE.BREEDS b
                        ON ap.BREED_ID = b.BREED_ID
                    INNER JOIN RMOORE.TYPEOFANIMALS toa
                        ON b.TYPE_OF_ANIMAL_ID = toa.TYPE_OF_ANIMAL_ID
                ORDER BY TYPE_OF_ANIMAL, BREED_NAME, ADOPTION_DATE
            ) LOOP 
                -- set up initial variables 
                IF v_counter = 0 THEN 
                    v_counter := 1;
                    v_typeOfAnimal := adoption.TYPE_OF_ANIMAL;
                    v_breed := adoption.BREED_NAME;
                END IF;

                -- check to see if we need to change the count
                IF v_breed <> adoption.BREED_NAME OR v_typeOfAnimal <> adoption.TYPE_OF_ANIMAL THEN 
                    v_counter := 1;
                    v_typeOfAnimal := adoption.TYPE_OF_ANIMAL;
                    v_breed := adoption.BREED_NAME;
                END IF;

                -- get correct number ending
                v_nth := TO_CHAR(v_counter);
                IF SUBSTR(v_nth, -1) = '1' AND v_counter <> 11 THEN 
                    v_nth := v_nth || 'st';
                ELSIF SUBSTR(v_nth, -1) = '2' AND v_counter <> 12 THEN
                    v_nth := v_nth || 'nd'; 
                ELSIF SUBSTR(v_nth, -1) = '3' AND v_counter <> 13 THEN
                    v_nth := v_nth || 'rd'; 
                ELSE 
                    v_nth := v_nth || 'th';
                END IF;

                DBMS_OUTPUT.PUT_LINE(
                    'Adopters Name = ' || adoption.ADOPTERS_NAME || 
                    ', Adopted Pets Name = ' || adoption.ADOPTABLE_PET_NAME  || 
                    ', Adopted Pets Animal Type = ' || adoption.TYPE_OF_ANIMAL || 
                    ', Adopted Pets Breed = ' || adoption.BREED_NAME || 
                    '. This is the ' || v_nth || ' ' || adoption.TYPE_OF_ANIMAL || ', ' || adoption.BREED_NAME || ' adopted'
                ); 

                -- increment the counter
                v_counter := v_counter + 1;
            END LOOP; 
        END; 


    -- # more complex version
        -- more robust for querying, more intuitive, ability to ask and answer questions more easily
        -- report stored in a table for further querying

        -- drop table command if needed
        DROP TABLE AdoptionReport1;

        -- table creatioon if needed 
        CREATE TABLE AdoptionReport1 (
            adoptable_pet_id NUMBER,
            adopter_id NUMBER,
            adopted_pet_name VARCHAR2(50 CHAR) NOT NULL,
            adopters_name VARCHAR2(50 CHAR) NOT NULL,
            type_of_animal VARCHAR2(25 CHAR) NOT NULL,
            breed_name VARCHAR2(50 CHAR) NOT NULL,
            adoption_description VARCHAR2(100 CHAR) NOT NULL,
            adoption_date DATE NOT NULL,
            adoption_cost NUMBER(6,2) NOT NULL,
            adoption_cost_difference NUMBER(6,2) NOT NULL, 
            adoption_number NUMBER DEFAULT NULL,
            primary key (adoptable_pet_id, adopter_id)
        );

        -- create the max_breed_cost function
        CREATE OR REPLACE FUNCTION max_breed_cost ( 
            p_breed IN varchar2 
        ) RETURN NUMBER AS
            v_maxCost NUMBER;
        BEGIN
            -- get Max cost for breed
            SELECT MAX(a.ADOPTION_COST)
            INTO v_maxCost
            FROM RMOORE.ADOPTIONS a
                INNER JOIN RMOORE.ADOPTABLEPETS ap
                    ON ap.ADOPTABLE_PET_ID = a.ADOPTABLE_PET_ID
                INNER JOIN RMOORE.BREEDS b
                    ON ap.BREED_ID = b.BREED_ID
            WHERE LOWER(BREED_NAME) = LOWER(p_breed);
            
            -- return data
            RETURN v_maxCost;
        END max_breed_cost;

        -- procedure to update and populate data
        CREATE OR REPLACE PROCEDURE update_adoption_report1 AS
            v_breed varchar2(50);
            v_typeOfAnimal varchar2(50);
            v_counter Number := 0;
            v_nth varchar2(10);
            v_maxBreedCost Number;
            v_breedCostDifference Number;
        BEGIN
            -- truncate AdoptionReport1 table
            EXECUTE IMMEDIATE 'TRUNCATE TABLE RMOORE.AdoptionReport1';

            -- look through, get all information, insert into AdoptionReport1
            FOR adoption IN ( 
                SELECT
                    a.ADOPTABLE_PET_ID,
                    a.ADOPTER_ID,
                    ap.ADOPTABLE_PET_NAME,
                    ad.ADOPTERS_FIRST_NAME || ' ' || ad.ADOPTERS_LAST_NAME AS ADOPTERS_NAME,
                    toa.TYPE_OF_ANIMAL,
                    b.BREED_NAME,
                    TO_CHAR(a.ADOPTION_DATE, 'YYYY-MM-DD') AS ADOPTION_DATE,
                    a.ADOPTION_COST
                FROM RMOORE.ADOPTIONS a
                    INNER JOIN RMOORE.ADOPTABLEPETS ap
                        ON a.ADOPTABLE_PET_ID = ap.ADOPTABLE_PET_ID
                    INNER JOIN RMOORE.ADOPTERS ad
                        ON a.ADOPTER_ID = ad.ADOPTER_ID
                    INNER JOIN RMOORE.BREEDS b
                        ON ap.BREED_ID = b.BREED_ID
                    INNER JOIN RMOORE.TYPEOFANIMALS toa
                        ON b.TYPE_OF_ANIMAL_ID = toa.TYPE_OF_ANIMAL_ID
                ORDER BY toa.TYPE_OF_ANIMAL, b.BREED_NAME, a.ADOPTION_DATE
            ) LOOP 
                -- set up initial variables 
                IF v_counter = 0 THEN 
                    v_counter := 1;
                    v_typeOfAnimal := adoption.TYPE_OF_ANIMAL;
                    v_breed := adoption.BREED_NAME;
                    -- get max breed cost
                    v_maxBreedCost := max_breed_cost(v_breed);
                END IF;

                -- check to see if we need to change the count
                IF v_breed <> adoption.BREED_NAME OR v_typeOfAnimal <> adoption.TYPE_OF_ANIMAL THEN 
                    v_counter := 1;
                    v_typeOfAnimal := adoption.TYPE_OF_ANIMAL;
                    v_breed := adoption.BREED_NAME;
                    -- get max breed cost
                    v_maxBreedCost := max_breed_cost(v_breed);
                END IF;

                -- get correct number ending
                v_nth := TO_CHAR(v_counter);
                IF SUBSTR(v_nth, -1) = '1' AND v_counter <> 11 THEN 
                    v_nth := v_nth || 'st';
                ELSIF SUBSTR(v_nth, -1) = '2' AND v_counter <> 12 THEN
                    v_nth := v_nth || 'nd'; 
                ELSIF SUBSTR(v_nth, -1) = '3' AND v_counter <> 13 THEN
                    v_nth := v_nth || 'rd'; 
                ELSE 
                    v_nth := v_nth || 'th';
                END IF;

                INSERT INTO RMOORE.AdoptionReport1 (
                    adoptable_pet_id, 
                    adopter_id, 
                    adopted_pet_name,
                    adopters_name, 
                    type_of_animal, 
                    breed_name, 
                    adoption_description, 
                    adoption_date,
                    adoption_cost,
                    adoption_cost_difference 
                )
                VALUES (
                    adoption.ADOPTABLE_PET_ID, 
                    adoption.ADOPTER_ID, 
                    adoption.ADOPTABLE_PET_NAME,
                    adoption.ADOPTERS_NAME,
                    adoption.TYPE_OF_ANIMAL,
                    adoption.BREED_NAME,
                    adoption.ADOPTABLE_PET_NAME || ' is the ' || v_nth || ' ' || adoption.TYPE_OF_ANIMAL || '-' || adoption.BREED_NAME || ' adopted from our shelters.',
                    TO_DATE(adoption.ADOPTION_DATE, 'YYYY-MM-DD'),
                    adoption.ADOPTION_COST,
                    v_maxBreedCost - adoption.ADOPTION_COST
                );

                -- increment the counter
                v_counter := v_counter + 1;
            END LOOP; 

            -- get records again, update report records by adoption number 1, 2, 3, 4, ...
            v_counter := 0;
            FOR adoption_order IN ( 
                SELECT
                    ADOPTABLE_PET_ID,
                    ADOPTER_ID
                FROM RMOORE.ADOPTIONS
                ORDER BY ADOPTION_DATE
            ) LOOP 
                -- increment counter
                v_counter := v_counter + 1; 
                -- update records in adoption order
                UPDATE RMOORE.AdoptionReport1
                SET adoption_number = v_counter
                WHERE adoptable_pet_id = adoption_order.ADOPTABLE_PET_ID
                    AND adopter_id = adoption_order.ADOPTER_ID;
            END LOOP; 
        END update_adoption_report1;

        -- call procedure
        CALL update_adoption_report1();

        -- query table to answer analytical question +
        SELECT 
            adopted_pet_name,
            adopters_name, 
            type_of_animal, 
            breed_name, 
            CASE
                WHEN SUBSTR(TO_CHAR(adoption_number), -1) = '1' AND adoption_number <> 11 THEN 
                    adoption_description || ' This is also the ' || adoption_number || 'st adoption from our shelters.'
                WHEN SUBSTR(TO_CHAR(adoption_number), -1) = '2' AND adoption_number <> 12 THEN 
                    adoption_description || ' This is also the ' || adoption_number || 'nd adoption from our shelters.'
                WHEN SUBSTR(TO_CHAR(adoption_number), -1) = '3' AND adoption_number <> 13 THEN 
                    adoption_description || ' This is also the ' || adoption_number || 'rd adoption from our shelters.'
                ELSE 
                    adoption_description || ' This is also the ' || adoption_number || 'th adoption from our shelters.'
            END AS adoption_description 
        FROM AdoptionReport1
        ORDER BY adoption_date;     

        -- query table, filtered query showing versatility of the reporting table versus the simple report
        SELECT 
            adopters_name,
            adopted_pet_name, 
            type_of_animal, 
            breed_name, 
            CASE
                WHEN SUBSTR(TO_CHAR(adoption_number), -1) = '1' AND adoption_number <> 11 THEN 
                    adoption_description || ' This is also the ' || adoption_number || 'st adoption from our shelters.'
                WHEN SUBSTR(TO_CHAR(adoption_number), -1) = '2' AND adoption_number <> 12 THEN 
                    adoption_description || ' This is also the ' || adoption_number || 'nd adoption from our shelters.'
                WHEN SUBSTR(TO_CHAR(adoption_number), -1) = '3' AND adoption_number <> 13 THEN 
                    adoption_description || ' This is also the ' || adoption_number || 'rd adoption from our shelters.'
                ELSE 
                    adoption_description || ' This is also the ' || adoption_number || 'th adoption from our shelters.'
            END AS adoption_description, 
            adoption_date,
            adoption_cost,
            adoption_number 
        FROM AdoptionReport1
        WHERE type_of_animal = 'Dog'
        ORDER BY adoption_date; 

    -- # orginal sql - don't turn in
        SELECT
            ap.ADOPTABLE_PET_NAME,
            ADOPTERS_FIRST_NAME || ' ' || ADOPTERS_LAST_NAME AS ADOPTERS_NAME,
            TYPE_OF_ANIMAL,
            BREED_NAME
        FROM RMOORE.ADOPTIONS a
            INNER JOIN RMOORE.ADOPTABLEPETS ap
                ON a.ADOPTABLE_PET_ID = ap.ADOPTABLE_PET_ID
            INNER JOIN RMOORE.ADOPTERS ad
                ON a.ADOPTER_ID = ad.ADOPTER_ID
            INNER JOIN RMOORE.BREEDS b
                ON ap.BREED_ID = b.BREED_ID
            INNER JOIN RMOORE.TYPEOFANIMALS toa
                ON b.TYPE_OF_ANIMAL_ID = toa.TYPE_OF_ANIMAL_ID
        ORDER BY TYPE_OF_ANIMAL, BREED_NAME, ADOPTION_DATE;

        -- Notes for version 3
            -- break out elements to more of the raw forms
                -- adoption description, break out the number of that breed adopted
            -- based off of business logic have that table update periodically
            -- create table that shows when specific report tables have been updated (may not be necessary)
            -- adding table and column notes for documentation purposes


-- @ For every pet adopted, show the pet’s name, the cost of the adoption, and the difference in cost between this pet and the most expensive pet of that same breed.
        SELECT 
            adopted_pet_name,
            TO_CHAR(adoption_cost, '$99,999.99') AS adoption_cost,
            TO_CHAR(adoption_cost_difference, '$99,999.99') AS adoption_cost_difference
        FROM AdoptionReport1;

        -- test my thery
        SELECT 
            adopted_pet_name,
            breed_name,
            TO_CHAR(adoption_cost, '$99,999.99') AS adoption_cost,
            TO_CHAR(adoption_cost_difference, '$99,999.99') AS adoption_cost_difference
        FROM AdoptionReport1
        WHERE type_of_animal = 'Dog'
        ORDER BY breed_name, adoption_cost;

-- @ List the total costs received by the organization by pet type and breed. Also show the totals at the pet type level and for all adoptions.
    -- totals by pet type and breed 
    SELECT 
        type_of_animal, 
        breed_name,
        TO_CHAR(SUM(adoption_cost), '$99,999.99') AS revenue
    FROM AdoptionReport1
    GROUP BY type_of_animal, breed_name
    ORDER BY type_of_animal, breed_name;

    -- totals at the pet type level 
    SELECT 
        type_of_animal,
        TO_CHAR(SUM(adoption_cost), '$999,999.99') AS revenue
    FROM AdoptionReport1
    GROUP BY type_of_animal
    ORDER BY type_of_animal;

    -- totals all adoptions 
    SELECT TO_CHAR(SUM(adoption_cost), '$9,999,999.99') AS revenue_for_all_adoptions
    FROM AdoptionReport1;















-- @ new way
-- # List every pet adopted, the pet’s name, adopter’s name, pet type, breed, and a number indicating the order of the pet adopted by pet type and breed (i.e. this is the 9th Dog, Labrador Retriever adopted.
    SELECT
        ADOPTABLE_PET_NAME,
        ADOPTERS_FIRST_NAME || ' ' || ADOPTERS_LAST_NAME AS ADOPTERS_NAME,
        TYPE_OF_ANIMAL,
        BREED_NAME,
        LOCATION_NAME,
        RANK() OVER (PARTITION BY TYPE_OF_ANIMAL, BREED_NAME ORDER BY ADOPTION_DATE) AS ADOPTION_ORDER_BY_ANIMAL_TYPE_BREED,
        RANK() OVER (ORDER BY ADOPTION_DATE) AS ADOPTION_ORDER_BY_DATE,
        RANK() OVER (PARTITION BY LOCATION_NAME ORDER BY ADOPTION_DATE) AS ADOPTION_ORDER_BY_LOCATION,
        ADOPTION_DATE
    FROM RMOORE.ADOPTIONS a
        INNER JOIN RMOORE.ADOPTABLEPETS ap
            ON a.ADOPTABLE_PET_ID = ap.ADOPTABLE_PET_ID
        INNER JOIN RMOORE.ADOPTERS ad
            ON a.ADOPTER_ID = ad.ADOPTER_ID
        INNER JOIN RMOORE.BREEDS b
            ON ap.BREED_ID = b.BREED_ID
        INNER JOIN RMOORE.TYPEOFANIMALS toa
            ON b.TYPE_OF_ANIMAL_ID = toa.TYPE_OF_ANIMAL_ID
        INNER JOIN RMOORE.LOCATIONS l
            ON a.LOCATION_ID = l.LOCATION_ID
    ORDER BY TYPE_OF_ANIMAL, BREED_NAME, ADOPTION_DATE;

    -- more refined/specific to the question
    WITH ANIMAL_REPORT AS (
        SELECT
            ADOPTABLE_PET_NAME,
            ADOPTERS_FIRST_NAME || ' ' || ADOPTERS_LAST_NAME AS ADOPTERS_NAME,
            TYPE_OF_ANIMAL,
            BREED_NAME,
            LOCATION_NAME,
            RANK() OVER (PARTITION BY TYPE_OF_ANIMAL, BREED_NAME ORDER BY ADOPTION_DATE) AS ADOPTION_ORDER_BY_ANIMAL_TYPE_BREED,
            RANK() OVER (ORDER BY ADOPTION_DATE) AS ADOPTION_ORDER_BY_DATE,
            RANK() OVER (PARTITION BY LOCATION_NAME ORDER BY ADOPTION_DATE) AS ADOPTION_ORDER_BY_LOCATION,
            ADOPTION_DATE
        FROM RMOORE.ADOPTIONS a
            INNER JOIN RMOORE.ADOPTABLEPETS ap
                ON a.ADOPTABLE_PET_ID = ap.ADOPTABLE_PET_ID
            INNER JOIN RMOORE.ADOPTERS ad
                ON a.ADOPTER_ID = ad.ADOPTER_ID
            INNER JOIN RMOORE.BREEDS b
                ON ap.BREED_ID = b.BREED_ID
            INNER JOIN RMOORE.TYPEOFANIMALS toa
                ON b.TYPE_OF_ANIMAL_ID = toa.TYPE_OF_ANIMAL_ID
            INNER JOIN RMOORE.LOCATIONS l
                ON a.LOCATION_ID = l.LOCATION_ID
    )
    SELECT 
        ADOPTABLE_PET_NAME,
        ADOPTERS_NAME,
        TYPE_OF_ANIMAL,
        BREED_NAME,
        CASE
            WHEN SUBSTR(TO_CHAR(ADOPTION_ORDER_BY_ANIMAL_TYPE_BREED), -1) = '1' AND ADOPTION_ORDER_BY_ANIMAL_TYPE_BREED <> 11 THEN 
                ADOPTABLE_PET_NAME || ' is the ' || ADOPTION_ORDER_BY_ANIMAL_TYPE_BREED || 'st ' || TYPE_OF_ANIMAL || '-' || BREED_NAME || ' adopted from all our shelters.'
            WHEN SUBSTR(TO_CHAR(ADOPTION_ORDER_BY_ANIMAL_TYPE_BREED), -1) = '2' AND ADOPTION_ORDER_BY_ANIMAL_TYPE_BREED <> 12 THEN 
                ADOPTABLE_PET_NAME || ' is the ' || ADOPTION_ORDER_BY_ANIMAL_TYPE_BREED || 'nd ' || TYPE_OF_ANIMAL || '-' || BREED_NAME || ' adopted from all our shelters.'
            WHEN SUBSTR(TO_CHAR(ADOPTION_ORDER_BY_ANIMAL_TYPE_BREED), -1) = '3' AND ADOPTION_ORDER_BY_ANIMAL_TYPE_BREED <> 13 THEN 
                ADOPTABLE_PET_NAME || ' is the ' || ADOPTION_ORDER_BY_ANIMAL_TYPE_BREED || 'rd ' || TYPE_OF_ANIMAL || '-' || BREED_NAME || ' adopted from all our shelters.'
            ELSE 
                ADOPTABLE_PET_NAME || ' is the ' || ADOPTION_ORDER_BY_ANIMAL_TYPE_BREED || 'th ' || TYPE_OF_ANIMAL || '-' || BREED_NAME || ' adopted from all our shelters.'
        END AS ADOPTION_DESCRIPTION 
    FROM ANIMAL_REPORT
    ORDER BY TYPE_OF_ANIMAL, BREED_NAME, ADOPTION_DATE;

-- # For every pet adopted, show the pet’s name, the cost of the adoption, and the difference in cost between this pet and the most expensive pet of that same breed.
    WITH ANIMAL_REPORT AS (
        SELECT
            ADOPTABLE_PET_NAME,
            ADOPTERS_FIRST_NAME || ' ' || ADOPTERS_LAST_NAME AS ADOPTERS_NAME,
            TYPE_OF_ANIMAL,
            BREED_NAME,
            LOCATION_NAME,
            RANK() OVER (PARTITION BY TYPE_OF_ANIMAL, BREED_NAME ORDER BY ADOPTION_DATE) AS ADOPTION_ORDER_BY_ANIMAL_TYPE_BREED,
            RANK() OVER (ORDER BY ADOPTION_DATE) AS ADOPTION_ORDER_BY_DATE,
            RANK() OVER (PARTITION BY LOCATION_NAME ORDER BY ADOPTION_DATE) AS ADOPTION_ORDER_BY_LOCATION,
            ADOPTION_DATE,
            ADOPTION_COST,
            MAX(ADOPTION_COST) OVER (PARTITION BY b.BREED_ID) AS MAX_COST_BREED
        FROM RMOORE.ADOPTIONS a
            INNER JOIN RMOORE.ADOPTABLEPETS ap
                ON a.ADOPTABLE_PET_ID = ap.ADOPTABLE_PET_ID
            INNER JOIN RMOORE.ADOPTERS ad
                ON a.ADOPTER_ID = ad.ADOPTER_ID
            INNER JOIN RMOORE.BREEDS b
                ON ap.BREED_ID = b.BREED_ID
            INNER JOIN RMOORE.TYPEOFANIMALS toa
                ON b.TYPE_OF_ANIMAL_ID = toa.TYPE_OF_ANIMAL_ID
            INNER JOIN RMOORE.LOCATIONS l
                ON a.LOCATION_ID = l.LOCATION_ID
    )
    SELECT 
        ADOPTABLE_PET_NAME,
        BREED_NAME,
        ADOPTION_COST,
        MAX_COST_BREED,
        MAX_COST_BREED - ADOPTION_COST AS DIFFERENCE_IN_COST
    FROM ANIMAL_REPORT
    ORDER BY TYPE_OF_ANIMAL, BREED_NAME, ADOPTION_COST;



-- # List the total costs received by the organization by pet type and breed. Also show the totals at the pet type level and for all adoptions.
    WITH ANIMAL_REPORT AS (
        SELECT
            TYPE_OF_ANIMAL,
            BREED_NAME,
            LOCATION_NAME,
            RANK() OVER (PARTITION BY TYPE_OF_ANIMAL, BREED_NAME ORDER BY ADOPTION_DATE) AS ADOPTION_ORDER_BY_ANIMAL_TYPE_BREED,
            RANK() OVER (ORDER BY ADOPTION_DATE) AS ADOPTION_ORDER_BY_DATE,
            RANK() OVER (PARTITION BY LOCATION_NAME ORDER BY ADOPTION_DATE) AS ADOPTION_ORDER_BY_LOCATION,
            ADOPTION_DATE,
            ADOPTION_COST,
            MAX(ADOPTION_COST) OVER (PARTITION BY b.BREED_ID) AS MAX_COST_BREED,
            SUM(ADOPTION_COST) OVER (PARTITION BY toa.TYPE_OF_ANIMAL_ID, b.BREED_ID) AS TOTAL_COST_ANIMAL_TYPE_BREED,
            SUM(ADOPTION_COST) OVER (PARTITION BY toa.TYPE_OF_ANIMAL_ID) AS TOTAL_COST_ANIMAL_TYPE,
            SUM(ADOPTION_COST) OVER () AS TOTAL_COST_ALL_LOCATIONS
        FROM RMOORE.ADOPTIONS a
            INNER JOIN RMOORE.ADOPTABLEPETS ap
                ON a.ADOPTABLE_PET_ID = ap.ADOPTABLE_PET_ID
            INNER JOIN RMOORE.ADOPTERS ad
                ON a.ADOPTER_ID = ad.ADOPTER_ID
            INNER JOIN RMOORE.BREEDS b
                ON ap.BREED_ID = b.BREED_ID
            INNER JOIN RMOORE.TYPEOFANIMALS toa
                ON b.TYPE_OF_ANIMAL_ID = toa.TYPE_OF_ANIMAL_ID
            INNER JOIN RMOORE.LOCATIONS l
                ON a.LOCATION_ID = l.LOCATION_ID
    )
    SELECT 
        TYPE_OF_ANIMAL,
        BREED_NAME,
        TOTAL_COST_ANIMAL_TYPE_BREED,
        TOTAL_COST_ANIMAL_TYPE,
        TOTAL_COST_ALL_LOCATIONS
    FROM ANIMAL_REPORT
    GROUP BY TYPE_OF_ANIMAL, BREED_NAME, TOTAL_COST_ANIMAL_TYPE_BREED, TOTAL_COST_ANIMAL_TYPE, TOTAL_COST_ALL_LOCATIONS
    ORDER BY TYPE_OF_ANIMAL, BREED_NAME;








-- @ new way Final
-- # List every pet adopted, the pet’s name, adopter’s name, pet type, breed, and a number indicating the order of the pet adopted by pet type and breed (i.e. this is the 9th Dog, Labrador Retriever adopted.
    WITH ANIMAL_REPORT AS (
        SELECT
            ADOPTABLE_PET_NAME,
            ADOPTERS_FIRST_NAME || ' ' || ADOPTERS_LAST_NAME AS ADOPTERS_NAME,
            TYPE_OF_ANIMAL,
            BREED_NAME,
            RANK() OVER (PARTITION BY TYPE_OF_ANIMAL, BREED_NAME ORDER BY ADOPTION_DATE) AS ADOPTION_ORDER_BY_ANIMAL_TYPE_BREED
        FROM RMOORE.ADOPTIONS a
            INNER JOIN RMOORE.ADOPTABLEPETS ap
                ON a.ADOPTABLE_PET_ID = ap.ADOPTABLE_PET_ID
            INNER JOIN RMOORE.ADOPTERS ad
                ON a.ADOPTER_ID = ad.ADOPTER_ID
            INNER JOIN RMOORE.BREEDS b
                ON ap.BREED_ID = b.BREED_ID
            INNER JOIN RMOORE.TYPEOFANIMALS toa
                ON b.TYPE_OF_ANIMAL_ID = toa.TYPE_OF_ANIMAL_ID
    )
    SELECT 
        ADOPTABLE_PET_NAME,
        ADOPTERS_NAME,
        TYPE_OF_ANIMAL,
        BREED_NAME,
        CASE
            WHEN SUBSTR(TO_CHAR(ADOPTION_ORDER_BY_ANIMAL_TYPE_BREED), -1) = '1' AND ADOPTION_ORDER_BY_ANIMAL_TYPE_BREED <> 11 THEN 
                ADOPTABLE_PET_NAME || ' is the ' || ADOPTION_ORDER_BY_ANIMAL_TYPE_BREED || 'st ' || TYPE_OF_ANIMAL || '-' || BREED_NAME || ' adopted from all our shelters.'
            WHEN SUBSTR(TO_CHAR(ADOPTION_ORDER_BY_ANIMAL_TYPE_BREED), -1) = '2' AND ADOPTION_ORDER_BY_ANIMAL_TYPE_BREED <> 12 THEN 
                ADOPTABLE_PET_NAME || ' is the ' || ADOPTION_ORDER_BY_ANIMAL_TYPE_BREED || 'nd ' || TYPE_OF_ANIMAL || '-' || BREED_NAME || ' adopted from all our shelters.'
            WHEN SUBSTR(TO_CHAR(ADOPTION_ORDER_BY_ANIMAL_TYPE_BREED), -1) = '3' AND ADOPTION_ORDER_BY_ANIMAL_TYPE_BREED <> 13 THEN 
                ADOPTABLE_PET_NAME || ' is the ' || ADOPTION_ORDER_BY_ANIMAL_TYPE_BREED || 'rd ' || TYPE_OF_ANIMAL || '-' || BREED_NAME || ' adopted from all our shelters.'
            ELSE 
                ADOPTABLE_PET_NAME || ' is the ' || ADOPTION_ORDER_BY_ANIMAL_TYPE_BREED || 'th ' || TYPE_OF_ANIMAL || '-' || BREED_NAME || ' adopted from all our shelters.'
        END AS ADOPTION_DESCRIPTION 
    FROM ANIMAL_REPORT
    ORDER BY TYPE_OF_ANIMAL, BREED_NAME;

-- # For every pet adopted, show the pet’s name, the cost of the adoption, and the difference in cost between this pet and the most expensive pet of that same breed.
    WITH ANIMAL_REPORT AS (
        SELECT
            ADOPTABLE_PET_NAME,
            TYPE_OF_ANIMAL,
            BREED_NAME,
            ADOPTION_COST,
            MAX(ADOPTION_COST) OVER (PARTITION BY b.BREED_ID) AS MAX_COST_BREED
        FROM RMOORE.ADOPTIONS a
            INNER JOIN RMOORE.ADOPTABLEPETS ap
                ON a.ADOPTABLE_PET_ID = ap.ADOPTABLE_PET_ID
            INNER JOIN RMOORE.BREEDS b
                ON ap.BREED_ID = b.BREED_ID
            INNER JOIN RMOORE.TYPEOFANIMALS toa
                ON b.TYPE_OF_ANIMAL_ID = toa.TYPE_OF_ANIMAL_ID
    )
    SELECT 
        ADOPTABLE_PET_NAME,
        BREED_NAME,
        ADOPTION_COST,
        MAX_COST_BREED,
        MAX_COST_BREED - ADOPTION_COST AS DIFFERENCE_IN_COST
    FROM ANIMAL_REPORT
    ORDER BY TYPE_OF_ANIMAL, BREED_NAME, ADOPTION_COST;

-- # List the total costs received by the organization by pet type and breed. Also show the totals at the pet type level and for all adoptions.
    WITH ANIMAL_REPORT AS (
        SELECT
            TYPE_OF_ANIMAL,
            BREED_NAME,
            SUM(ADOPTION_COST) OVER (PARTITION BY toa.TYPE_OF_ANIMAL_ID, b.BREED_ID) AS TOTAL_COST_ANIMAL_TYPE_BREED,
            SUM(ADOPTION_COST) OVER (PARTITION BY toa.TYPE_OF_ANIMAL_ID) AS TOTAL_COST_ANIMAL_TYPE,
            SUM(ADOPTION_COST) OVER () AS TOTAL_COST_ALL_LOCATIONS
        FROM RMOORE.ADOPTIONS a
            INNER JOIN RMOORE.ADOPTABLEPETS ap
                ON a.ADOPTABLE_PET_ID = ap.ADOPTABLE_PET_ID
            INNER JOIN RMOORE.BREEDS b
                ON ap.BREED_ID = b.BREED_ID
            INNER JOIN RMOORE.TYPEOFANIMALS toa
                ON b.TYPE_OF_ANIMAL_ID = toa.TYPE_OF_ANIMAL_ID
    )
    SELECT 
        TYPE_OF_ANIMAL,
        BREED_NAME,
        TOTAL_COST_ANIMAL_TYPE_BREED,
        TOTAL_COST_ANIMAL_TYPE,
        TOTAL_COST_ALL_LOCATIONS
    FROM ANIMAL_REPORT
    GROUP BY TYPE_OF_ANIMAL, BREED_NAME, TOTAL_COST_ANIMAL_TYPE_BREED, TOTAL_COST_ANIMAL_TYPE, TOTAL_COST_ALL_LOCATIONS
    ORDER BY TYPE_OF_ANIMAL, BREED_NAME;



























-- add partition breed_name
-- minus INNER JOIN PetStatus pt
-- WHERE pet_status = 'Adopted'
-- query one conner
SELECT pet_status, adoptable_pet_name as PetName, adopters_first_name ||' '|| adopters_last_name as Adopters_Name, 
 type_of_animal, breed_name , dense_rank() over (partition by type_of_animal order by adoption_date asc) as AdoptionRank
FROM adoptablepets ap
INNER JOIN adoptions ad
    ON ap.adoptable_pet_id = ad.adoptable_pet_id
INNER JOIN  breeds bd
    ON bd.breed_id = ap.breed_id
INNER JOIN adopters adt
    ON adt.adopter_id = ad.adopter_id
INNER JOIN TypeOfAnimals toa
    on bd.type_of_animal_id = toa.type_of_animal_id
INNER JOIN PetStatus pt
    on pt.pet_status_id = ap.pet_status_id
WHERE pet_status = 'Adopted'
ORDER BY type_of_animal;

SELECT
    ADOPTABLE_PET_NAME AS PETNAME,
    ADOPTERS_FIRST_NAME || ' ' || ADOPTERS_LAST_NAME AS ADOPTERS_NAME,
    TYPE_OF_ANIMAL,
    BREED_NAME,
    DENSE_RANK() OVER(PARTITION BY BD.BREED_ID ORDER BY ADOPTION_DATE ASC) AS ANIMALADOPTIONRANK
FROM
    ADOPTABLEPETS AP
    INNER JOIN ADOPTIONS AD 
        ON AP.ADOPTABLE_PET_ID = AD.ADOPTABLE_PET_ID
    INNER JOIN BREEDS BD 
        ON BD.BREED_ID = AP.BREED_ID
    INNER JOIN ADOPTERS ADT 
        ON ADT.ADOPTER_ID = AD.ADOPTER_ID
    INNER JOIN TYPEOFANIMALS TOA 
        ON BD.TYPE_OF_ANIMAL_ID = TOA.TYPE_OF_ANIMAL_ID
ORDER BY TYPE_OF_ANIMAL, BREED_NAME, ADOPTION_DATE;




-- Brie
WITH ADOPTION_INFO AS (
    SELECT
        B.ADOPTABLE_PET_NAME,
        C.ADOPTION_COST,
        A.BREED_NAME,
        MAX(C.ADOPTION_COST) OVER (PARTITION BY A.BREED_ID) AS MAX_ADOPTION_COST
    FROM BREEDS A
        INNER JOIN ADOPTABLEPETS B 
            ON A.BREED_ID = B.BREED_ID
        INNER JOIN ADOPTIONS C 
            ON C.ADOPTABLE_PET_ID = B.ADOPTABLE_PET_ID
)
SELECT
    ADOPTABLE_PET_NAME,
    BREED_NAME,
    ADOPTION_COST,
    MAX_ADOPTION_COST,
    ( MAX_ADOPTION_COST - ADOPTION_COST ) AS DIFFERENCE_IN_COST
FROM ADOPTION_INFO
ORDER BY BREED_NAME, ADOPTION_COST;





