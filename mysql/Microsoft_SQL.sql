-- # TickerSymbol
SELECT MAX(LEN(TickerSymbol)) FROM StockData;
-- 6

SELECT LEN(TickerSymbol) AS 'Length', COUNT(*) AS 'Count' FROM StockData GROUP BY LEN(TickerSymbol);
-- Length   Count
-- 3        9709
-- 6        2551
-- 4        15093

-- # MySQL
-- My assertion that a varchar(6) would be more accurate
-- char(6)
-- Length   Count   bytes
-- 3        9709    6
-- 6        2551    6
-- 4        15093   6
-- Total            164,118 bytes

-- varchar(6)
-- Length   Count   bytes
-- 3        9709    4
-- 6        2551    7
-- 4        15093   5
-- Total            132,158 bytes

-- # Microsoft SQL
-- My assertion that a varchar(6) would be more accurate
-- char(6)
-- Length   Count   bytes
-- 3        9709    6
-- 6        2551    6
-- 4        15093   6
-- Total            164,118 bytes

-- varchar(6)
-- Length   Count   bytes
-- 3        9709    5
-- 6        2551    8
-- 4        15093   6
-- Total            159,511 bytes

-- # Industry
SELECT MAX(LEN(Industry)) FROM StockData;
-- 17
-- According to this data set varchar(20)
-- A good question to ask is what is possible
-- Perhaps varchar(20) - varchar(30)

SELECT LEN(Industry) AS 'Length', COUNT(*) AS 'Count' FROM StockData GROUP BY LEN(Industry);
-- Length   Count
-- 9        2551
-- 6        4678
-- 7        5031
-- 4        10062
-- 17       5031

-- # Mysql
-- char(30)
-- Length   Count   bytes
-- 9        2551    30
-- 6        4678    30
-- 7        5031    30
-- 4        10062   30
-- 17       5031    30
-- Total            820,590 bytes

-- varchar(30)
-- Length   Count   bytes
-- 9        2551    10
-- 6        4678    7
-- 7        5031    8
-- 4        10062   5
-- 17       5031    18
-- Total            239,372 bytes

-- # Microsoft SQL
-- char(30)
-- Length   Count   bytes
-- 9        2551    30
-- 6        4678    30
-- 7        5031    30
-- 4        10062   30
-- 17       5031    30
-- Total            820,590 bytes

-- varchar(30)
-- Length   Count   bytes
-- 9        2551    11
-- 6        4678    8
-- 7        5031    9
-- 4        10062   6
-- 17       5031    19
-- Total            266,725 bytes

-- #ST_Open 
SELECT ST_Open FROM StockData WHERE RIGHT(ST_Open, 3) != 000;
-- (181 rows)
SELECT COUNT(*) FROM StockData WHERE ST_Open IS NOT NULL;
-- (27353 rows)

-- #ST_High 
SELECT ST_High FROM StockData WHERE RIGHT(ST_High, 3) != 000;
-- (224 rows)
SELECT COUNT(*) FROM StockData WHERE ST_High IS NOT NULL;
-- (27353 rows)

-- #ST_Low 
SELECT ST_Low FROM StockData WHERE RIGHT(ST_Low, 3) != 000;
-- (247 rows)
SELECT COUNT(*) FROM StockData WHERE ST_Low IS NOT NULL;
-- (27353 rows)

-- #ST_Close 
SELECT ST_Close FROM StockData WHERE RIGHT(ST_Close, 3) != 000;
-- (257 rows)
SELECT COUNT(*) FROM StockData WHERE ST_Close IS NOT NULL;
-- (27353 rows)

-- #Volume 
SELECT Volume FROM StockData WHERE RIGHT(Volume, 2) != 00;
-- (0 rows)
SELECT Volume FROM StockData WHERE RIGHT(Volume, 2) = 00;
-- (27353 rows)
SELECT COUNT(*) FROM StockData WHERE Volume IS NOT NULL;
-- (27353 rows)
SELECT MAX(Volume) FROM StockData;
-- (1855410200.00 max)
SELECT MAX(LEN(Volume)) FROM StockData;
-- (13 Length)
-- INT




SELECT MAX(LEN(CompanyName)) FROM CompanyInformation;

SELECT LEN(CompanyName) AS 'Length', COUNT(*) AS 'Count' 
FROM CompanyInformation 
GROUP BY LEN(CompanyName) ORDER BY LEN(CompanyName);




-- Asignment 2

-- 1. List all columns and all rows from the StockData table.
SELECT * 
    FROM StockData;

-- 2 List 1000 rows of the table to see what the data look like. (On a production server, you would not select the entire table, but a limited number of rows. Otherwise you risk slowing down the server, particularly if the table is very large.)
SELECT TOP 1000 *
    FROM StockData;

-- 3. List the TickerSymbol, Industry, TradeDate and the Volume columns from the StockData table.  List all rows.
SELECT TickerSymbol, Industry, TradeDate, Volume
    FROM StockData;

-- 4. List all company information attributes for companies incorporated in Texas. 
SELECT *
    FROM CompanyInformation
    WHERE [State] = 'TX';

-- 5. List the TickerSymbol, Industry, TradeDate and the Volume columns from the StockData table.  List only the rows that have a volume of more than thirty million shares traded.  Arrange the answer in TickerSymbol order and then in TradeDate order.  This means that for a given stock, trading days should appear in chronological order.
SELECT TickerSymbol, Industry, TradeDate, Volume
    FROM StockData
    WHERE Volume > 30000000
ORDER BY TickerSymbol, TradeDate;

-- 6. List the price ID, opening price, and closing price of all stocks who have an opening price smaller than 120 dollars and a closing price greater than 120 dollars.  List the opening and closing prices in ascending order.
SELECT PriceID, ST_Open, ST_Close
    FROM StockData
    WHERE ST_Open < 120 AND ST_Close > 120
ORDER BY ST_Open, ST_Close;

-- 7. List the price ID, stock high and stock low of all stocks that have a stock high above 130. Also list the same information for all stocks that have a stock low below 5.  List the high and low stocks by ascending order.
SELECT PriceID, ST_High, ST_Low
    FROM StockData
    WHERE ST_High > 130 OR ST_Low < 5
ORDER BY ST_High, ST_Low;

-- 8. List all rows where any of the stock prices are zero.
SELECT *
    FROM StockData
    WHERE ST_High = 0 OR ST_Low = 0;

-- 9. Look for missing data by listing any rows in StockData that contain nulls.
SELECT *
    FROM StockData
    WHERE TickerSymbol IS NULL OR Industry IS NULL 
        OR TradeDate IS NULL OR ST_Open IS NULL 
        OR ST_High IS NULL OR ST_Low IS NULL 
        OR ST_Close IS NULL OR Volume IS NULL
        OR PriceID IS NULL;

-- 10. List all rows where the high stock price for the day is not at least as high as the low for that day. There should not be any rows where this is the case.
SELECT *
    FROM StockData
    WHERE ST_High < ST_Low;

-- 11. List the TickerSymbol, Industry, TradeDate, the opening stock price and the closing stock price.  List only those trading days that occurred in the year 2018.  Arrange the answer in order of the trade dates which means that for a given stock, trading days should appear in chronological order.
SELECT TickerSymbol, Industry, TradeDate, ST_Open, ST_Close
    FROM StockData
    WHERE YEAR(TradeDate) = 2018
ORDER BY TradeDate;

-- 12. List the TickerSymbol, Industry, TradeDate, the opening stock price and the closing stock price.  List only stocks that include the word "oil" in the industry description.  Arrange the answer in order of the industry, the ticker symbol, and then by the trade dates.
SELECT TickerSymbol, Industry, TradeDate, ST_Open, ST_Close
    FROM StockData
    WHERE Industry LIKE '%oil%'
ORDER BY Industry, TickerSymbol, TradeDate;

-- 13. List all of the ticker symbols containing the letter S.
SELECT TickerSymbol
    FROM StockData
    WHERE TickerSymbol LIKE '%S%';

-- 14. List the TickerSymbol, TradeDate and the closing stock price.  List only Microsoft tuples that occurred between January 1, 2005 and June 1, 2018.  Arrange the answer in order of the ticker symbol, trade dates and then the closing price.
SELECT TickerSymbol, TradeDate, ST_Close
    FROM StockData
    WHERE TickerSymbol = 'MSFT' AND TradeDate BETWEEN 'January 1, 2005' AND 'June 1, 2018' 
ORDER BY TickerSymbol, TradeDate, ST_Close;

OR

SELECT TickerSymbol, TradeDate, ST_Close
    FROM StockData
    WHERE TickerSymbol = 'MSFT' AND TradeDate >= 'January 1, 2005' AND TradeDate <= 'June 1, 2018' 
ORDER BY TickerSymbol, TradeDate, ST_Close;

    -- Examples to make sure it's working
    SELECT TickerSymbol, TradeDate, ST_Close
        FROM StockData
        WHERE TickerSymbol = 'AAPL' AND TradeDate BETWEEN 'January 1, 2005' AND 'June 1, 2018' 
    ORDER BY TickerSymbol, TradeDate, ST_Close;
    -- (3377 rows affected)

    SELECT TickerSymbol, TradeDate, ST_Close
        FROM StockData
        WHERE TickerSymbol = 'AAPL' AND TradeDate >= 'January 1, 2005' AND TradeDate <= 'June 1, 2018' 
    ORDER BY TickerSymbol, TradeDate, ST_Close;
    -- (3377 rows affected)

-- 15. List the trade dates, stock highs and stock lows of all stocks that either had a stock high over 130 dollars and were traded before December 31st, 2014, or stocks that were traded after December 31st, 2018 and had a stock low below 5 dollars.  List the stock highs and lows in descending order.
SELECT TradeDate, ST_High, ST_Low
    FROM StockData
    WHERE ST_High > 130 AND TradeDate < 'December 31, 2014'
        OR TradeDate > 'December 31, 2018' AND ST_Low < 5
ORDER BY ST_High DESC, ST_Low DESC;

-- 16. Return all attributes for stocks that have the MSFT ticker symbol and have a high stock price below 20 dollars or a low stock price above 50 dollars.  List the high and low stock prices in ascending order.
SELECT *
    FROM StockData
    WHERE TickerSymbol = 'MSFT' AND (ST_High < 20 OR ST_Low > 50) 
ORDER BY ST_High, ST_Low;

-- 17. List the Price ID and TradeDate and stock high of all stocks that were traded before October 3rd, 2018 and had a stock high over 125 dollars. List the stock highs in descending order.
SELECT PriceID ,TradeDate, ST_High
    FROM StockData
    WHERE TradeDate < 'October 3, 2018' AND ST_High > 125
ORDER BY ST_High DESC;

-- 18. List the trading start date in StockData table.
SELECT TickerSymbol, MIN(TradeDate) AS 'Start Date'
    FROM StockData
    GROUP BY TickerSymbol;

-- 19. List the trading start date and end date for each ticker in StockData.
SELECT TickerSymbol, MIN(TradeDate) AS 'Start Date', MAX(TradeDate) AS 'End Date'
    FROM StockData
    GROUP BY TickerSymbol;

-- 20. List the sum of all the low stock prices that are above 60 dollars.  Call it TotalLowStockPriceOfStocksUnder60.
SELECT SUM(ST_Low) AS 'TotalLowStockPriceOfStocksUnder60'
    FROM StockData
    WHERE ST_Low > 60;

-- 21. List the earliest trade date of the stock that ended up having a high over 100 dollars.  Call it EarliestTradeDateWithHighOver100.
SELECT MIN(TradeDate) AS 'EarliestTradeDateWithHighOver100'
    FROM StockData
    WHERE ST_High > 100;

-- ! start Here *********************************************************************************
-- 22. List each ticker symbol and the average daily trade volume for that stock. Order the list from highest to least daily trade volume.
SELECT TickerSymbol, AVG(Volume) AS 'The average daily trade volume'
    FROM StockData
    GROUP BY TickerSymbol
ORDER BY AVG(Volume) DESC;




-- 48 (check)
UPDATE StockData
SET ST_Open = 55.1,
    ST_High = 56.26,
    ST_Low = 55.55,
    ST_Close = 55.95,
    Volume = 24298620,
WHERE TradeDate = '4//1/2018' AND TickerSymbol = 'MSFT';
