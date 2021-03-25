-- @ Assignment 1
-- MIS6330 Spring 2021

    -- # Problem 1 (10 points)
        -- Write a query that selects all players who weigh more than 200 pounds. Show the players’ first name (FNAME), a space, then their last name (LNAME). This column should be called FULL_NAME. Display their full name as uppercase. Also display their POSITION. Sort by their JERSEY number with the highest numbers first.
        SELECT
            UPPER(FNAME || ' ' || LNAME) AS FULL_NAME,
            POSITION
        FROM
            BASEBALL.PLAYERS
        WHERE WEIGHT > 200
        ORDER BY JERSEY DESC;

        -- ! to verify 
        SELECT
            UPPER(FNAME || ' ' || LNAME) AS FULL_NAME,
            POSITION,
            JERSEY,
            WEIGHT
        FROM
            BASEBALL.PLAYERS
        WHERE WEIGHT > 200
        ORDER BY JERSEY DESC;

    -- # Problem 2 (10 points)
        -- Which last names (LNAME) show up multiple times in the players list? How often do they show up? Show the most frequent last names first.
        SELECT
            LNAME,
            COUNT(LNAME) AS LNAME_COUNT
        FROM
            BASEBALL.PLAYERS
        GROUP BY LNAME
        HAVING COUNT(LNAME) > 1
        ORDER BY LNAME_COUNT DESC;


        -- ! to verify
        SELECT
            LNAME
        FROM
            BASEBALL.PLAYERS
        ORDER BY LNAME;

    -- # Problem 3 (50 points)
        -- Write a function called TEAM_LOOKUP. This function will accept two parameters as input: first name and last name. It then will look up in the BASEBALL schema tables to find the team name of the first name and last name that was passed in. The function will return a string of the team name. Use an exception to output a message if the person is not found in the PLAYERS table.
        -- Next, write a select query on the PLAYERS table. Show the player’s last name and then call your function to get their team name.
        -- Lastly, write one more select query as SELECT … FROM DUAL, calling your function with a name that does not exist in our table to show the exception output working.
        -- Turn In:
        -- • The function create SQL script
        -- • The two SELECT SQL queries
        -- • A screenshot of the two SELECT query outputs
        CREATE OR REPLACE FUNCTION TEAM_LOOKUP ( 
            p_fname IN varchar2, 
            p_lname IN varchar2 
        ) RETURN varchar2 AS
            v_team_name varchar2(50);
        BEGIN
            -- get team name
            SELECT
                t.NAME
            INTO v_team_name
            FROM
                BASEBALL.PLAYERS p
            INNER JOIN BASEBALL.TEAMS t 
                        ON p.TEAM_ID = t.ID
            WHERE upper(FNAME) = upper(p_fname) AND upper(LNAME) = upper(p_lname);

            -- return data 
            RETURN v_team_name;
        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('An error has occurred: No data was found for parameters passed in!');
                DBMS_OUTPUT.PUT_LINE (SQLERRM);
                DBMS_OUTPUT.PUT_LINE ('SQLCODE: ' || SQLCODE);
                RETURN NULL;
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('An error has occurred:');
                DBMS_OUTPUT.PUT_LINE('Some type of other error has occurred, Please contact your database administrator');
                DBMS_OUTPUT.PUT_LINE (SQLERRM);
                DBMS_OUTPUT.PUT_LINE ('SQLCODE: ' || SQLCODE);
                RETURN NULL;
        END TEAM_LOOKUP;
        /

        -- full player roster
        SELECT 
            LNAME,
            TEAM_LOOKUP(FNAME,LNAME) AS TEAM_NAME
        FROM BASEBALL.PLAYERS;

        -- single player
        SELECT TEAM_LOOKUP('Moises', 'Sierra') FROM DUAL;

        -- runs exception
        SELECT 
            1+1 AS num,
            TEAM_LOOKUP('Darth','Vader') AS TEAM_NAME
        FROM DUAL;

        -- ! to verify
        SELECT t.NAME
        FROM
            BASEBALL.PLAYERS p
        INNER JOIN BASEBALL.TEAMS t 
            ON p.TEAM_ID = t.ID
        WHERE upper(p.FNAME) = upper('Moises') AND upper(p.LNAME) LIKE upper('Sierra');

    -- # Problem 4 (50 points)
        -- Write a PL/SQL block with a FOR loop that iterates through the numbers 1 – 30. If the number is even, print it to the output window with the text “This number is even: “ then the number. Hint: for finding even numbers, get the remainder when dividing by 2 (no remainder means it’s an even number).
        -- Enclose this FOR loop in a Procedure that traps any errors and outputs them to the output window. Allow the user to pass in a number for how high of a number to loop until. This number will replace 30 in your loop. If the user does not pass a parameter, default to 30.
        -- Call your procedure and monitor the output to ensure it is working.
        -- Turn In:
        -- • The procedure create statement
        -- • A screenshot of your output window when you execute the procedure
        CREATE OR REPLACE PROCEDURE SHOW_EVEN_NUMBERS(
            p_uper_range IN VARCHAR2 DEFAULT '30'
        ) AS
            v_num NUMBER;
        BEGIN
            -- make a number
            v_num := TO_NUMBER(p_uper_range);
            -- loop over and get evens
            FOR num IN 1..v_num LOOP
                IF MOD(num,2) = 0 THEN
                    DBMS_OUTPUT.PUT_LINE('This number is even: ' || num); 
                END IF;
            END LOOP;
        EXCEPTION
            WHEN VALUE_ERROR THEN 
                DBMS_OUTPUT.PUT_LINE('A value error has occurred: This procedure requires a number to be passed in.');
                DBMS_OUTPUT.PUT_LINE (SQLERRM);
                DBMS_OUTPUT.PUT_LINE ('SQLCODE: ' || SQLCODE);
            WHEN OTHERS THEN 
                DBMS_OUTPUT.PUT_LINE('An error has occurred: This procedure requires a number to be passed in.');
                DBMS_OUTPUT.PUT_LINE (SQLERRM);
                DBMS_OUTPUT.PUT_LINE ('SQLCODE: ' || SQLCODE);
        END SHOW_EVEN_NUMBERS;
        /

        -- calling the procedure
        CALL SHOW_EVEN_NUMBERS();
        CALL SHOW_EVEN_NUMBERS(50);

        -- raising an exception
        CALL SHOW_EVEN_NUMBERS('jim');

        -- ! to verify
        BEGIN 
            FOR num IN 1..30 LOOP
                IF MOD(num,2) = 0 THEN
                    DBMS_OUTPUT.PUT_LINE('This number is even: ' || num); 
                END IF;
            END LOOP;
        END;
        /