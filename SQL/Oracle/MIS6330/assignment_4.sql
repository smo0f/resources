-- Deliverables: Turn in a document with your sql queries.
-- Use the RETAIL schema tables and views. A data model can be found here.
-- @ Problem 1 (10 points)
-- # Display the first time each customer purchased from the Backcountry website. Show customer_id and first_order_date.
    SELECT
        CUSTOMER_ID,
        MIN(ORDER_DATE) AS FIRST_ORDER_DATE
    FROM
        RETAIL.ORDERS
    WHERE WEBSITE = 'Backcountry'
    GROUP BY CUSTOMER_ID
    ORDER BY FIRST_ORDER_DATE;

    -- * to verify
        SELECT
            COUNT(DISTINCT CUSTOMER_ID)
        FROM
            RETAIL.ORDERS
        WHERE WEBSITE = 'Backcountry';
        -- 5945

        WITH CUSTOMER_FIRST_PURCHASE AS (
            SELECT
                CUSTOMER_ID,
                MIN(ORDER_DATE) AS FIRST_ORDER_DATE
            FROM
                RETAIL.ORDERS
            WHERE WEBSITE = 'Backcountry'
            GROUP BY CUSTOMER_ID
        )
        SELECT COUNT(CUSTOMER_ID)
        FROM CUSTOMER_FIRST_PURCHASE;
        -- 5945

        SELECT
            COUNT(DISTINCT CUSTOMER_ID)
        FROM
            RETAIL.ORDERS;
        -- 9769
-- # Exclude order with a total of zero or less as these are returns.
    SELECT
        o.CUSTOMER_ID,
        MIN(o.ORDER_DATE) AS FIRST_ORDER_DATE,
        SUM(ol.PRICE) AS ORDER_TOTAL
    FROM RETAIL.ORDERS o
        INNER JOIN RETAIL.ORDERLINES ol
            ON ol.ORDER_NUMBER = o.ORDER_NUMBER
    WHERE o.WEBSITE = 'Backcountry'
    GROUP BY o.CUSTOMER_ID
    HAVING SUM(ol.PRICE) > 0
    ORDER BY FIRST_ORDER_DATE;

    -- * to verify
        WITH ORDER_TOTALS_BACKCOUNTRY AS (
            SELECT
                o.CUSTOMER_ID,
                MIN(o.ORDER_DATE) AS FIRST_ORDER_DATE,
                SUM(ol.PRICE) AS ORDER_TOTAL
            FROM RETAIL.ORDERS o
                INNER JOIN RETAIL.ORDERLINES ol
                    ON ol.ORDER_NUMBER = o.ORDER_NUMBER
            WHERE o.WEBSITE = 'Backcountry'
            GROUP BY o.CUSTOMER_ID
            HAVING SUM(ol.PRICE) > 0
        )
        SELECT COUNT(CUSTOMER_ID)
        FROM ORDER_TOTALS_BACKCOUNTRY;
        -- 3118

        -- confirming first date
        SELECT
            o.CUSTOMER_ID,
            MIN(o.ORDER_DATE) AS FIRST_ORDER_DATE,
            SUM(ol.PRICE) AS ORDER_TOTAL
        FROM RETAIL.ORDERS o
            INNER JOIN RETAIL.ORDERLINES ol
                ON ol.ORDER_NUMBER = o.ORDER_NUMBER
        WHERE o.WEBSITE = 'Backcountry'
        GROUP BY o.CUSTOMER_ID
        HAVING SUM(ol.PRICE) > 0
        ORDER BY o.CUSTOMER_ID;

        SELECT 
            o.CUSTOMER_ID, 
            LISTAGG(o.ORDER_DATE, ', ') WITHIN GROUP (ORDER BY o.ORDER_DATE) as PURCHASE_DATES,
            SUM(ol.PRICE) AS ORDER_TOTAL
        FROM RETAIL.ORDERS o
            INNER JOIN RETAIL.ORDERLINES ol
                ON ol.ORDER_NUMBER = o.ORDER_NUMBER
        WHERE o.WEBSITE = 'Backcountry'
        GROUP BY o.CUSTOMER_ID
        HAVING SUM(ol.PRICE) > 0
        ORDER BY o.CUSTOMER_ID;

        WITH ORDER_TOTALS_BACKCOUNTRY AS (
            SELECT
                DISTINCT ol.ORDER_NUMBER,
                o.CUSTOMER_ID,
                o.ORDER_DATE,
                FIRST_VALUE(o.ORDER_DATE) OVER (PARTITION BY o.CUSTOMER_ID ORDER BY o.ORDER_DATE) as FIRST_ORDER_DATE,
                SUM(ol.PRICE) OVER (PARTITION BY ol.ORDER_NUMBER) AS ORDER_TOTAL,
                SUM(ol.PRICE) OVER (PARTITION BY o.CUSTOMER_ID) AS CUSTOMER_ORDERS_TOTAL 
            FROM RETAIL.ORDERS o
                INNER JOIN RETAIL.ORDERLINES ol
                    ON ol.ORDER_NUMBER = o.ORDER_NUMBER
            WHERE o.WEBSITE = 'Backcountry'
        )
        SELECT  
            CUSTOMER_ID, 
            ORDER_NUMBER, 
            ORDER_DATE,
            FIRST_ORDER_DATE,
            ORDER_TOTAL,  
            CUSTOMER_ORDERS_TOTAL
        FROM ORDER_TOTALS_BACKCOUNTRY
        WHERE CUSTOMER_ORDERS_TOTAL > 0
        ORDER BY CUSTOMER_ID;


-- @ Problem 2 (20 points)
-- Use your query from Problem 1 as a subquery to display more info about the first time each customer purchased.
-- # Show customer_id, first_order_date, and first_order_total.
    SELECT  
        CUSTOMER_ID, 
        FIRST_ORDER_DATE,
        ORDER_TOTAL  
    FROM (
         SELECT
            DISTINCT ol.ORDER_NUMBER,
            o.CUSTOMER_ID,
            o.ORDER_DATE,
            FIRST_VALUE(o.ORDER_DATE) OVER (PARTITION BY o.CUSTOMER_ID ORDER BY o.ORDER_DATE) as FIRST_ORDER_DATE,
            SUM(ol.PRICE) OVER (PARTITION BY ol.ORDER_NUMBER) AS ORDER_TOTAL,
            SUM(ol.PRICE) OVER (PARTITION BY o.CUSTOMER_ID) AS CUSTOMER_ORDERS_TOTAL 
        FROM RETAIL.ORDERS o
            INNER JOIN RETAIL.ORDERLINES ol
                ON ol.ORDER_NUMBER = o.ORDER_NUMBER
        WHERE o.WEBSITE = 'Backcountry'
    )
    WHERE CUSTOMER_ORDERS_TOTAL > 0
        AND ORDER_DATE = FIRST_ORDER_DATE
    ORDER BY CUSTOMER_ID, ORDER_DATE;

    -- or

    WITH ORDER_TOTALS_BACKCOUNTRY AS (
        SELECT
            DISTINCT ol.ORDER_NUMBER,
            o.CUSTOMER_ID,
            o.ORDER_DATE,
            FIRST_VALUE(o.ORDER_DATE) OVER (PARTITION BY o.CUSTOMER_ID ORDER BY o.ORDER_DATE) as FIRST_ORDER_DATE,
            SUM(ol.PRICE) OVER (PARTITION BY ol.ORDER_NUMBER) AS ORDER_TOTAL,
            SUM(ol.PRICE) OVER (PARTITION BY o.CUSTOMER_ID) AS CUSTOMER_ORDERS_TOTAL 
        FROM RETAIL.ORDERS o
            INNER JOIN RETAIL.ORDERLINES ol
                ON ol.ORDER_NUMBER = o.ORDER_NUMBER
        WHERE o.WEBSITE = 'Backcountry'
    )
    SELECT  
        CUSTOMER_ID, 
        FIRST_ORDER_DATE,
        ORDER_TOTAL  
    FROM ORDER_TOTALS_BACKCOUNTRY
    WHERE CUSTOMER_ORDERS_TOTAL > 0
        AND ORDER_DATE = FIRST_ORDER_DATE
    ORDER BY CUSTOMER_ID, ORDER_DATE;

-- # If they have not purchased on Backcountry, show zero for the order total and null for the order date.
    WITH ORDER_TOTALS_BACKCOUNTRY AS (
        SELECT
            DISTINCT ol.ORDER_NUMBER,
            o.CUSTOMER_ID,
            o.ORDER_DATE,
            o.WEBSITE,
            FIRST_VALUE(o.ORDER_DATE) OVER (PARTITION BY o.CUSTOMER_ID ORDER BY o.ORDER_DATE) as FIRST_ORDER_DATE,
            SUM(ol.PRICE) OVER (PARTITION BY ol.ORDER_NUMBER) AS ORDER_TOTAL,
            SUM(ol.PRICE) OVER (PARTITION BY o.CUSTOMER_ID) AS CUSTOMER_ORDERS_TOTAL 
        FROM RETAIL.ORDERS o
            INNER JOIN RETAIL.ORDERLINES ol
                ON ol.ORDER_NUMBER = o.ORDER_NUMBER
    )
    SELECT  
        CUSTOMER_ID, 
        CASE
            WHEN  WEBSITE <> 'Backcountry' THEN NULL
            ELSE  FIRST_ORDER_DATE
        END AS  FIRST_ORDER_DATE, 
        CASE
            WHEN  WEBSITE <> 'Backcountry' THEN 0
            ELSE  ORDER_TOTAL
        END AS  ORDER_TOTAL  
    FROM ORDER_TOTALS_BACKCOUNTRY
    WHERE CUSTOMER_ORDERS_TOTAL > 0
        AND ORDER_DATE = FIRST_ORDER_DATE
    ORDER BY CUSTOMER_ID, ORDER_DATE;

-- @ Problem 3 (15 points)
-- # Add to your query from Problem 2 to add a column to show the customer's order total over their lifetime, not just that first order or just on Backcountry. Call this column the lifetime_order_total.
    WITH ORDER_TOTALS_BACKCOUNTRY AS (
        SELECT
            DISTINCT ol.ORDER_NUMBER,
            o.CUSTOMER_ID,
            o.ORDER_DATE,
            WEBSITE,
            FIRST_VALUE(o.ORDER_DATE) OVER (PARTITION BY o.CUSTOMER_ID ORDER BY o.ORDER_DATE) as FIRST_ORDER_DATE,
            SUM(ol.PRICE) OVER (PARTITION BY ol.ORDER_NUMBER) AS ORDER_TOTAL,
            SUM(ol.PRICE) OVER (PARTITION BY o.CUSTOMER_ID) AS LIFETIME_ORDER_TOTAL 
        FROM RETAIL.ORDERS o
            INNER JOIN RETAIL.ORDERLINES ol
                ON ol.ORDER_NUMBER = o.ORDER_NUMBER
    )
    SELECT  
        CUSTOMER_ID, 
        CASE
            WHEN  WEBSITE <> 'Backcountry' THEN NULL
            ELSE  FIRST_ORDER_DATE
        END AS  FIRST_ORDER_DATE, 
        CASE
            WHEN  WEBSITE <> 'Backcountry' THEN 0
            ELSE  ORDER_TOTAL
        END AS  ORDER_TOTAL,
        LIFETIME_ORDER_TOTAL  
    FROM ORDER_TOTALS_BACKCOUNTRY
    WHERE LIFETIME_ORDER_TOTAL > 0
        AND ORDER_DATE = FIRST_ORDER_DATE
    ORDER BY CUSTOMER_ID, ORDER_DATE;

-- @ Problem 4 (45 points)
-- # Display total sales for each day in November 2012 from RETAIL.ORDER_SUMMARY. However, not every day is in that table so you'll need to show the missing dates with $0 in sales. Also show the buyer zip codes of all customers who purchased that day, separated by commas, in one column. Your query should only return one row per day.
    -- query one
    SELECT
        TO_CHAR(ORDER_DATE, 'MON-DD-YYYY') AS ORDER_DATE,
        SUM(ORDER_TOTAL) AS DAYLY_ORDER_TOTAL,
        LISTAGG(BUYER_ZIP, ', ') WITHIN GROUP (ORDER BY BUYER_ZIP) as BUYER_ZIPS
    FROM
        RETAIL.ORDER_SUMMARY
    WHERE TO_CHAR(ORDER_DATE, 'MONTH YYYY') = TO_CHAR(TO_DATE('November 2012', 'MONTH YYYY'), 'MONTH YYYY')
    GROUP BY TO_CHAR(ORDER_DATE, 'MON-DD-YYYY')
    ORDER BY ORDER_DATE;

    -- query to
    SELECT (level-1) + TO_DATE('November 2012', 'MONTH YYYY') DATE_OF_MONTH
    FROM DUAL
    CONNECT BY LEVEL <= TO_NUMBER(TO_CHAR(LAST_DAY(TO_DATE('November 2012', 'MONTH YYYY')),'DD'));

    -- joint query
    WITH DATES_OF_MONTH AS (
        SELECT TO_CHAR((level-1) + TO_DATE('November 2012', 'MONTH YYYY'), 'MON-DD-YYYY') AS DATE_OF_MONTH
        FROM DUAL 
        CONNECT BY LEVEL <= TO_NUMBER(TO_CHAR(LAST_DAY(TO_DATE('November 2012', 'MONTH YYYY')),'DD'))
    ), ORDERS AS (
        SELECT
            TO_CHAR(ORDER_DATE, 'MON-DD-YYYY') AS ORDER_DATE,
            SUM(ORDER_TOTAL)  AS DAYLY_ORDER_TOTAL,
            LISTAGG(BUYER_ZIP, ', ') WITHIN GROUP (ORDER BY BUYER_ZIP) as BUYER_ZIPS
        FROM
            RETAIL.ORDER_SUMMARY
        WHERE TO_CHAR(ORDER_DATE, 'MONTH YYYY') = TO_CHAR(TO_DATE('November 2012', 'MONTH YYYY'), 'MONTH YYYY')
        GROUP BY TO_CHAR(ORDER_DATE, 'MON-DD-YYYY')
        ORDER BY ORDER_DATE
    )
    SELECT 
        DATE_OF_MONTH,
        CASE
            WHEN ORDER_DATE IS NULL THEN '*no purchases made*'
            ELSE ORDER_DATE
        END AS ORDER_DATE,
        CASE
            WHEN DAYLY_ORDER_TOTAL IS NULL THEN 0
            ELSE DAYLY_ORDER_TOTAL
        END AS DAYLY_ORDER_TOTAL,
        CASE
            WHEN BUYER_ZIPS IS NULL THEN '*no zip codes available*'
            ELSE BUYER_ZIPS
        END AS BUYER_ZIPS
    FROM DATES_OF_MONTH d
        LEFT JOIN ORDERS o
            ON d.DATE_OF_MONTH = o.ORDER_DATE
    ORDER BY d.DATE_OF_MONTH;
-- Tips: Write two separate queries to start. One query should pull the total sales and buyer zips by day. Keep in mind that the order_date field includes times. Second query should pull a list of each day in the month of November. Use levels to do this. Here's a hint: If you start by selecting the date of Nov 1, 2012 from dual, add the first level value to it, and subtract 1, you'll get Nov 1. Keep doing that for each day in November. You'll need 30 levels to span all of November. Lastly, join your two queries together to get each day in November with the total sales for that day and the buyer zips.

-- @ Problem 5 (30 points)
-- # Write a query from the class_datasets.olympic_medal_winners table, showing the total medals awarded for each country (NOC is the country column). Display one row per country by using PIVOT. Show one column for each medal type: Gold, Silver, and Bronze. Sort by gold medals with the highest first and display the top 5 countries. Show this query.
    SELECT * FROM (
        SELECT
            MEDAL,
            NOC,
            COUNT(MEDAL) OVER (PARTITION BY NOC) AS TOTAL_METALS
        FROM
            CLASS_DATASETS.OLYMPIC_MEDAL_WINNERS
    )
    pivot (
        count(*) FOR MEDAL IN (
            'Gold' AS Gold, 
            'Silver' AS Silver, 
            'Bronze' AS Bronze
        )
    )
    ORDER BY Gold DESC
    FETCH NEXT 5 ROWS ONLY;

    -- validate
        SELECT
            NOC,
            MEDAL,
            COUNT(MEDAL)
        FROM
            CLASS_DATASETS.OLYMPIC_MEDAL_WINNERS
        WHERE NOC IN ('CHN','GBR','RUS','GER','BRA')
        GROUP BY NOC, MEDAL
        ORDER BY NOC, MEDAL;

        -- analytical query
        SELECT DISTINCT
            NOC,
            MEDAL,
            COUNT(MEDAL) OVER (PARTITION BY NOC) AS TOTAL_METALS,
            COUNT(MEDAL) OVER (PARTITION BY NOC, MEDAL) AS TOTAL_METALS_BY_TYPE
        FROM
            CLASS_DATASETS.OLYMPIC_MEDAL_WINNERS
        WHERE NOC IN ('CHN','GBR','RUS','GER','BRA')
        ORDER BY NOC, MEDAL;

-- # Then modify your query to add a column for the total medals for each country. Sort by this total column with the highest first and filter to the top 5 countries by total medals awarded. Show this query also.
    SELECT * FROM (
        SELECT
            MEDAL,
            NOC,
            COUNT(MEDAL) OVER (PARTITION BY NOC) AS TOTAL_METALS
        FROM
            CLASS_DATASETS.OLYMPIC_MEDAL_WINNERS
    )
    pivot (
        count(*) FOR MEDAL IN (
            'Gold' AS Gold, 
            'Silver' AS Silver, 
            'Bronze' AS Bronze
        )
    )
    ORDER BY TOTAL_METALS DESC
    FETCH NEXT 5 ROWS ONLY;