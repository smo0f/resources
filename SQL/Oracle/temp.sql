-- @ Лаб 15
--Problem 1
--Using PIVOT, show how many customers are at each income level for each state. Only show the states of UT, CA, NY, and WA. 
--The columns displayed in your query should be CUST_INCOME_LEVEL, UT, CA, NY, WA. I've started your query for you below.
SELECT * FROM (
   SELECT cust_income_level
   , cust_state_province
   FROM sh.customers c
)
pivot (
    count(*) FOR cust_state_province IN (
        'UT' AS UT, 
        'CA' AS CA, 
        'NY' AS NY, 
        'WA' AS WA)
)
ORDER BY cust_income_level;