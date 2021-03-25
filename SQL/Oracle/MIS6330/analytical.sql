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

        -- procedure to update and populate data
        CREATE OR REPLACE PROCEDURE update_adoption_report1 AS
            v_breed varchar2(50);
            v_typeOfAnimal varchar2(50);
            v_counter Number := 0;
            v_nth varchar2(10);
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

                INSERT INTO RMOORE.AdoptionReport1 (
                    adoptable_pet_id, 
                    adopter_id, 
                    adopted_pet_name,
                    adopters_name, 
                    type_of_animal, 
                    breed_name, 
                    adoption_description, 
                    adoption_date,
                    adoption_cost
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
                    adoption.ADOPTION_COST
                );

                -- increment the counter
                v_counter := v_counter + 1;
            END LOOP ; 

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


-- @ For every pet adopted, show the pet’s name, the cost of the adoption, and the difference in cost between this pet and the most expensive pet of that same breed.


-- @ List the total costs received by the organization by pet type and breed. Also show the totals at the pet type level and for all adoptions.