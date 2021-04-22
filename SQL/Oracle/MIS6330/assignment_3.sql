-- @ Problem 1
    -- # Create a new table in your schema called REDFIN_PROPERTIES with the following columns:
        CREATE TABLE REDFIN_PROPERTIES (
            PROPERTY_TYPE VARCHAR2(50),
            ADDRESS VARCHAR2(150),
            CITY VARCHAR2(30),
            STATE VARCHAR2(2),
            ZIP NUMBER,
            PRICE NUMBER NOT NULL,
            BEDS NUMBER,
            BATHS NUMBER,
            LOCATION VARCHAR2(30),
            SQ_FT NUMBER,
            LOT_SIZE NUMBER,
            YEAR_BUILT NUMBER,
            DAYS_ON_MARKET NUMBER,
            PRICE_PER_SQ_FT NUMBER,
            HOA_MONTHLY_FEE NUMBER,
            STATUS VARCHAR2(20),
            NEXT_OPEN_HOUSE_START_TIME DATE,
            NEXT_OPEN_HOUSE_END_TIME DATE,
            URL VARCHAR2(400),
            SOURCE VARCHAR2(15),
            MLS_NUMBER NUMBER PRIMARY KEY,
            LATITUDE NUMBER(7,5), -- max 90.00000
            LONGITUDE NUMBER(6,3) -- max 180.000
        );

    -- # Using the Import Data functionality in SQL Developer’s right-click menu (when you right-click on the table name in the Connections window on the left), import the data from this spreadsheet  downloadinto your new table.
        -- We had a team meeting 4/8/21, Connor let me know that you are able to upload individual CFCs directly to the tables by right clicking on the table in the left-hand menu versus the generic uploading data. I left my code and process in here so that if there was something different, that my process might explain it.
        
        -- Couldn't find a way to directly download the information. Could not see any apparent way to download into an existing table. I decided to upload the CSV into a new table and then merge that table with the table I created.
        -- On upload of the CSV It said that there were four records that could not be uploaded, an error occurred.
        MERGE INTO REDFIN_PROPERTIES rp
        USING REDFIN_PROPERTIES_TEMP rpt 
        ON (rp.MLS_NUMBER = rpt.MLS_NUMBER)
            -- there should be no matches as REDFIN_PROPERTIES has no data
            WHEN MATCHED THEN
                UPDATE SET rp.STATUS = rp.STATUS
                WHERE rp.MLS_NUMBER = rpt.MLS_NUMBER
            WHEN NOT MATCHED THEN
                INSERT (
                    PROPERTY_TYPE,
                    ADDRESS,
                    CITY,
                    STATE,
                    ZIP,
                    PRICE,
                    BEDS,
                    BATHS,
                    LOCATION,
                    SQ_FT,
                    LOT_SIZE,
                    YEAR_BUILT,
                    DAYS_ON_MARKET,
                    PRICE_PER_SQ_FT,
                    HOA_MONTHLY_FEE,
                    STATUS,
                    NEXT_OPEN_HOUSE_START_TIME,
                    NEXT_OPEN_HOUSE_END_TIME,
                    URL,
                    SOURCE,
                    MLS_NUMBER,
                    LATITUDE,
                    LONGITUDE
                )
                values(
                    rpt.PROPERTY_TYPE,
                    rpt.ADDRESS,
                    rpt.CITY,
                    rpt.STATE_OR_PROVINCE,
                    rpt.ZIP_OR_POSTAL_CODE,
                    rpt.PRICE,
                    rpt.BEDS,
                    rpt.BATHS,
                    rpt.LOCATION,
                    rpt.SQUARE_FEET,
                    rpt.LOT_SIZE,
                    rpt.YEAR_BUILT,
                    rpt.DAYS_ON_MARKET,
                    rpt.PRICE_SQUARE_FEET,
                    rpt.HOA_MONTH,
                    rpt.STATUS,
                    rpt.NEXT_OPEN_HOUSE_START_TIME,
                    rpt.NEXT_OPEN_HOUSE_END_TIME,
                    rpt.URL,
                    rpt.SOURCE,
                    rpt.MLS_NUMBER,
                    rpt.LATITUDE,
                    rpt.LONGITUDE
                )
        ;

    -- # Write a merge statement to add data from the CLASS_DATASETS.PARK_CITY_REAL_ESTATE table using MLS_NUMBER as your primary key. If the record is new, add all of the columns to your table. If the column already exists, update the PRICE and STATUS columns.
        -- hit an error, location size was not large enough
        -- ran the described call on CLASS_DATASETS.PARK_CITY_REAL_ESTATE
            DESCRIB CLASS_DATASETS.PARK_CITY_REAL_ESTATE;
            -- found that location was set at
                -- LOCATION VARCHAR2(150)
        -- Found out what the longest text field is in location
            SELECT
                MAX(LENGTH(LOCATION))
            FROM
                CLASS_DATASETS.PARK_CITY_REAL_ESTATE;
            -- max = 31
        -- decided to expand location to 35
        ALTER TABLE REDFIN_PROPERTIES
        MODIFY LOCATION VARCHAR2(35);

        MERGE INTO REDFIN_PROPERTIES rp
        USING CLASS_DATASETS.PARK_CITY_REAL_ESTATE re 
        ON (rp.MLS_NUMBER = re.MLS_NUMBER)
            WHEN MATCHED THEN
                UPDATE SET rp.PRICE = re.PRICE,
                    rp.STATUS = re.STATUS
                WHERE rp.MLS_NUMBER = re.MLS_NUMBER
            WHEN NOT MATCHED THEN
                INSERT (
                    PROPERTY_TYPE,
                    ADDRESS,
                    CITY,
                    STATE,
                    ZIP,
                    PRICE,
                    BEDS,
                    BATHS,
                    LOCATION,
                    SQ_FT,
                    LOT_SIZE,
                    YEAR_BUILT,
                    DAYS_ON_MARKET,
                    PRICE_PER_SQ_FT,
                    HOA_MONTHLY_FEE,
                    STATUS,
                    NEXT_OPEN_HOUSE_START_TIME,
                    NEXT_OPEN_HOUSE_END_TIME,
                    URL,
                    SOURCE,
                    MLS_NUMBER,
                    LATITUDE,
                    LONGITUDE
                )
                values(
                    re.PROPERTY_TYPE,
                    re.ADDRESS,
                    re.CITY,
                    re.STATE,
                    re.ZIP_CODE,
                    re.PRICE,
                    re.BEDS,
                    re.BATHS,
                    re.LOCATION,
                    re.SQUARE_FEET,
                    re.LOT_SIZE,
                    re.YEAR_BUILT,
                    re.DAYS_ON_MARKET,
                    re.PRICE_PER_SQ_FT,
                    re.HOA_PER_MONTH,
                    re.STATUS,
                    re.NEXT_OPEN_HOUSE_START_TIME,
                    re.NEXT_OPEN_HOUSE_END_TIME,
                    re.URL,
                    re.SOURCE,
                    re.MLS_NUMBER,
                    re.LATITUDE,
                    re.LONGITUDE
                )
        ;
        -- 350 rows merged

    -- # Commit your changes.
        COMMIT;

    -- # Add a new record with fake data.
        INSERT INTO RMOORE.REDFIN_PROPERTIES (
            PROPERTY_TYPE,
            ADDRESS,
            CITY,
            STATE,
            ZIP,
            PRICE,
            BEDS,
            BATHS,
            LOCATION,
            SQ_FT,
            LOT_SIZE,
            YEAR_BUILT,
            DAYS_ON_MARKET,
            PRICE_PER_SQ_FT,
            HOA_MONTHLY_FEE,
            STATUS,
            NEXT_OPEN_HOUSE_START_TIME,
            NEXT_OPEN_HOUSE_END_TIME,
            URL,
            SOURCE,
            MLS_NUMBER,
            LATITUDE,
            LONGITUDE
        ) VALUES (
            'Condo/Co-op',	
            '1476 Newpark Blvd #302',	
            'Park City',	
            'UT',
            84098,
            498000,
            4,
            3,
            'NEWPARK HOTEL',
            1500,
            NULL,
            2005,
            18,
            425,
            908,
            'Active',
            NULL,
            NULL,
            'http://www.redfin.com/UT/Park-City/1476-Newpark-Blvd-84098/unit-302/home/86386978',
            'WFRMLS',
            172929021,
            40.72233,
            -111.539
        );

    -- # Write a SELECT statement to find this new record.
        SELECT *
        FROM RMOORE.REDFIN_PROPERTIES
        WHERE MLS_NUMBER = 172929021;

    -- # Rollback your latest change.
        ROLLBACK;

    -- # Run your SELECT statement again. You should return no records this time.
        SELECT *
        FROM RMOORE.REDFIN_PROPERTIES
        WHERE MLS_NUMBER = 172929021;

    -- # Change the PROPERTY_TYPE column to not allow nulls.
        ALTER TABLE REDFIN_PROPERTIES
        MODIFY PROPERTY_TYPE NOT NULL; 

    -- # Update the record with MLS_NUMBER of 1725133 to change the price to NULL.
        UPDATE RMOORE.REDFIN_PROPERTIES
        SET PRICE = NULL
        WHERE MLS_NUMBER = 1725133;

    -- # Explain why you received the results you did to this query.
        -- There is a constraint on the price column that will not allow NULLs. Therefore in attempting to update the price column to a NULL results in a system error.
 


-- @ Problem 2
    -- # Create a view over your REDFIN_PROPERTIES table named ACTIVE_REDFIN_PROPERTIES. Only show properties with a STATUS of “Active”. Your view should have the following columns:
    -- MLS_NUMBER
    -- ADDRESS
    -- PRICE
    -- SQ_FT
    CREATE OR REPLACE VIEW ACTIVE_REDFIN_PROPERTIES AS
        SELECT
            MLS_NUMBER,
            ADDRESS,
            PRICE,
            SQ_FT,
            NEXT_OPEN_HOUSE_START_TIME -- needed for question below
        FROM
            RMOORE.REDFIN_PROPERTIES
        WHERE STATUS = 'Active';



-- @ Problem 3
    -- # Create a new table in your schema by copying the structure and data from the CLASS_DATASETS.PARK_CITY_REAL_ESTATE table, using a “Create table as select” query and calling the table PARK_CITY_REAL_ESTATE.
        CREATE TABLE PARK_CITY_REAL_ESTATE AS SELECT * FROM CLASS_DATASETS.PARK_CITY_REAL_ESTATE;

    -- # Give the INSTRUCTOR user the rights to be able to view and add records to this table.
        GRANT SELECT, INSERT ON RMOORE.PARK_CITY_REAL_ESTATE TO INSTRUCTOR;

    -- # Explain why you are able to name the table the same name as the table in the CLASS_DATASETS schema.
        -- This is because they are in separate schemas, each user has their own schema. Therefore I could create that table in my schema because I didn't have it before hand.
        -- When labeled under the schema, we can see that these are tables are distinct.
            -- RMOORE.PARK_CITY_REAL_ESTATE
            -- CLASS_DATASETS.PARK_CITY_REAL_ESTATE
 


-- @ Problem 4
    -- # Write a select query from your REDFIN_PROPERTIES view. Display the MLS_NUMBER and the NEXT_OPEN_HOUSE_START_DATE columns. Display the next open house start date in this format: Jan-01-2021 23:59:59. Only return the rows that have an open house start date on February 18, 2021.
        SELECT
            MLS_NUMBER,
            TO_CHAR(NEXT_OPEN_HOUSE_START_TIME, 'MON-DD-YYYY HH24:MI:SS') AS NEXT_OPEN_HOUSE_START_TIME
        FROM
            RMOORE.ACTIVE_REDFIN_PROPERTIES
        WHERE TO_CHAR(NEXT_OPEN_HOUSE_START_TIME, 'MONTH DD, YYYY') = TO_CHAR(TO_DATE('February 18, 2021', 'MONTH DD, YYYY'), 'MONTH DD, YYYY');


 

-- @ Problem 5
    -- # Objective: Write a query using a WITH statement that shows for each listing the difference between the average price per square foot of all listings compared to this listing.
    -- # Steps:
    -- # Write a query that returns the average price per sq foot of all records in the CLASS_DATASETS.PARK_CITY_REAL_ESTATE table.
        SELECT 
            AVG(PRICE_PER_SQ_FT)
        FROM CLASS_DATASETS.PARK_CITY_REAL_ESTATE
    -- # Put this query into a WITH statement as a subquery.
        WITH LISTINGS_AVG_PRICE AS (
            SELECT 
                MLS_NUMBER,
                PRICE_PER_SQ_FT,
                (
                    SELECT 
                        AVG(PRICE_PER_SQ_FT)
                    FROM 
                        CLASS_DATASETS.PARK_CITY_REAL_ESTATE
                ) AS AVG_PRICE_OF_LISTINGS
            FROM CLASS_DATASETS.PARK_CITY_REAL_ESTATE
        )
    -- # Select each row of the CLASS_DATASETS.PARK_CITY_REAL_ESTATE table. Return the MLS_NUMBER, the price_per_sq_ft and then difference between the result of the subquery and this record’s price_per_sq_ft.
        WITH LISTINGS_AVG_PRICE AS (
            SELECT 
                MLS_NUMBER,
                PRICE_PER_SQ_FT,
                (
                    SELECT 
                        AVG(PRICE_PER_SQ_FT)
                    FROM 
                        CLASS_DATASETS.PARK_CITY_REAL_ESTATE
                ) AS AVG_PRICE_OF_LISTINGS
            FROM CLASS_DATASETS.PARK_CITY_REAL_ESTATE
        )
        SELECT 
            MLS_NUMBER,
            PRICE_PER_SQ_FT,
            AVG_PRICE_OF_LISTINGS,
            PRICE_PER_SQ_FT - AVG_PRICE_OF_LISTINGS AS PRICE_DIFFERENCE
        FROM LISTINGS_AVG_PRICE
        ORDER BY MLS_NUMBER;

        -- to verify
        WITH LISTINGS_AVG_PRICE AS (
            SELECT 
                MLS_NUMBER,
                PRICE_PER_SQ_FT,
                AVG(PRICE_PER_SQ_FT) OVER () AS AVG_PRICE_OF_LISTINGS
            FROM CLASS_DATASETS.PARK_CITY_REAL_ESTATE
        )
        SELECT 
            MLS_NUMBER,
            PRICE_PER_SQ_FT,
            AVG_PRICE_OF_LISTINGS,
            PRICE_PER_SQ_FT - AVG_PRICE_OF_LISTINGS AS PRICE_DIFFERENCE
        FROM LISTINGS_AVG_PRICE
        ORDER BY MLS_NUMBER;