-- @ Problem 1
    -- Write a function where a user can pass in a date, the name of a state, and a county and it will return the total number of case reports that day for that state and county.

    -- If the user only passes in a name of a state and a date, it will return the total number of case reports for that state. For totaling up the cases for the entire state, build a loop that will iterate through each county’s data for that state and day and will add to a variable that’s tracking the state totals (yes I know this would be easier to do with summing in SQL but I want you to practice loops).

    -- If the user enters a date that is not in our COVID cases table, return a message to the user that it is an invalid date.

    -- If the user enters a county that is in our table but there is no data for that date, return zero for the case count.

    -- Turn in the following:

    -- The function create statement
    CREATE OR REPLACE FUNCTION COVID_CASES ( 
        p_date IN varchar2,
        p_state IN varchar2 DEFAULT NULL, 
        p_county IN varchar2 DEFAULT NULL
    ) RETURN NUMBER AS
        v_count NUMBER := 0;
        v_row_counter NUMBER;
        v_county_counter NUMBER;
        v_state_counter NUMBER;
        v_date_counter NUMBER;
        invalid_county EXCEPTION;
        invalid_state EXCEPTION;
        data_not_provided EXCEPTION;
        invalid_date EXCEPTION;
    BEGIN
        -- # some initial function error handling start
            
            -- check for date, exception (NO_DATA_FOUND) will be thrown if no data is found 
            SELECT COUNT(REPORTED_DATE) INTO v_date_counter FROM COVID.COUNTY_DAILY_CASES WHERE REPORTED_DATE = TO_DATE(p_date, 'YYYY-MM-DD');
            IF v_date_counter = 0 THEN RAISE invalid_date; END IF;
DBMS_OUTPUT.PUT_LINE('got here1');
            -- check to see if county exsists
            IF p_county IS NOT NULL THEN
                SELECT COUNT(COUNTY) INTO v_county_counter FROM COVID.COUNTY_DAILY_CASES WHERE LOWER(COUNTY) = LOWER(p_county);
                IF v_county_counter = 0 THEN RAISE invalid_county; END IF;
            END IF;
            -- check to see if state exsists
            IF p_state IS NOT NULL THEN
                SELECT COUNT(STATE) INTO v_state_counter FROM COVID.COUNTY_DAILY_CASES WHERE LOWER(STATE) = LOWER(p_state);
                IF v_state_counter = 0 THEN RAISE invalid_state; END IF;
            END IF;
        -- # some initial function error handling end 
        
        -- check to see if were given a state and county
        IF p_state IS NOT NULL AND p_county IS NOT NULL THEN 
            -- check if there is a zero row count
            SELECT COUNT(DAILY_CASES) INTO v_row_counter FROM COVID.COUNTY_DAILY_CASES WHERE LOWER(STATE) = LOWER(p_state) AND LOWER(COUNTY) = LOWER(p_county) AND REPORTED_DATE = TO_DATE(p_date, 'YYYY-MM-DD');
            IF v_row_counter = 0 THEN RETURN v_count; END IF;

            -- sql statment
            FOR RECORD IN ( 
                SELECT
                    DAILY_CASES
                FROM
                    COVID.COUNTY_DAILY_CASES
                WHERE LOWER(STATE) = LOWER(p_state) AND LOWER(COUNTY) = LOWER(p_county) AND REPORTED_DATE = TO_DATE(p_date, 'YYYY-MM-DD')
            ) LOOP 
                v_count := v_count + RECORD.DAILY_CASES;
            END LOOP;
        ELSIF p_state IS NOT NULL THEN 
            -- check if there is a zero row count
            SELECT COUNT(DAILY_CASES) INTO v_row_counter FROM COVID.COUNTY_DAILY_CASES WHERE LOWER(STATE) = LOWER(p_state) AND REPORTED_DATE = TO_DATE(p_date, 'YYYY-MM-DD');
            IF v_row_counter = 0 THEN RETURN v_count; END IF;

            -- sql statment
            FOR RECORD IN ( 
                SELECT
                    DAILY_CASES
                FROM
                    COVID.COUNTY_DAILY_CASES
                WHERE LOWER(STATE) = LOWER(p_state) AND REPORTED_DATE = TO_DATE(p_date, 'YYYY-MM-DD')
            ) LOOP 
                v_count := v_count + RECORD.DAILY_CASES;
            END LOOP; 
        ELSE 
            RAISE data_not_provided;
        END IF;

        -- return data 
        RETURN v_count;
    EXCEPTION
        WHEN data_not_provided THEN
            DBMS_OUTPUT.PUT_LINE('The parameters state or county were not provided. The state and date parameters are required!');
            RETURN NULL;
        WHEN invalid_county THEN
            DBMS_OUTPUT.PUT_LINE('The county of "' || p_county || '" does not exist, invalid county!');
            RETURN NULL;
        WHEN invalid_state THEN
            DBMS_OUTPUT.PUT_LINE('The state of "' || p_state || '" does not exist, invalid state!');
            RETURN NULL;
        WHEN invalid_date THEN
            DBMS_OUTPUT.PUT_LINE('The date of "' || p_date || '" does not exist, invalid date!');
            DBMS_OUTPUT.PUT_LINE (SQLERRM);
            DBMS_OUTPUT.PUT_LINE ('SQLCODE: ' || SQLCODE);
            RETURN NULL;
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('The date (YYYY-MM-DD) and state parameters are required! The county parameter is optional.');
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
            DBMS_OUTPUT.PUT_LINE ('SQLCODE: ' || SQLCODE);
            RETURN NULL;
    END COVID_CASES;

    -- A SELECT query, pulling from the COVID.US_COUNTIES table as defined below. This query should return one row per county. It should call the function you built to pull the case counts reported for each county on June 1, 2020. Pay attention to case differences between this table and the other COVID schema table that we are using.
    SELECT
        STATE_FULL,
        COUNTY,
        COVID_CASES('2020-06-01', STATE_FULL, COUNTY) AS COVID_CASES_IN_COUNTY
    FROM
        COVID.US_COUNTIES
    GROUP BY COUNTY, STATE_FULL
    OFFSET 0 ROWS FETCH NEXT 30 ROWS ONLY;

    -- ! I realized after I made the function it is not very proficient :( but at least it does what the question asked for :)


