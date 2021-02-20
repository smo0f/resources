-- @ Assignment 1
-- MIS6330 Spring 2021

    -- Problem 1 (10 points)
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

    -- Problem 2 (10 points)
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
        RETURN v_team_name;
    END TEAM_LOOKUP;
    /

    -- ! to verify
    SELECT
    t.NAME
	FROM
    	BASEBALL.PLAYERS p
	INNER JOIN BASEBALL.TEAMS t 
    	ON p.TEAM_ID = t.ID
	WHERE upper(p.FNAME) = upper('Moises') AND upper(p.LNAME) LIKE upper('Sierra');






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