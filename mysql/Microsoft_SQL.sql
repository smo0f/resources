-- @ Задача 1
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




SELECT MAX(LEN(CompanyName)) 
    FROM CompanyInformation;

SELECT LEN(CompanyName) AS 'Length', COUNT(*) AS 'Count' 
    FROM CompanyInformation 
GROUP BY LEN(CompanyName) ORDER BY LEN(CompanyName);



-- SQL for class
    SELECT * 
    FROM stockData;
    

    SELECT TickerSymbol, ST_Open, ST_Close, Volume 
    FROM stockData;

    SELECT TickerSymbol, ST_Open, ST_Close, Volume, TradeDate 
    FROM stockData
        WHERE TradeDate >= '1/1/2018' 
            AND TradeDate < '1/1/2019';

    SELECT TickerSymbol, ST_Open, ST_Close, Volume, TradeDate 
        FROM stockData
        WHERE TickerSymbol = 'AAPL' 
            AND YEAR(TradeDate) = 2019;

    SELECT TickerSymbol, ST_Open, ST_Close, Volume, TradeDate 
        FROM stockData
        WHERE TickerSymbol LIKE 'a%' 
            AND YEAR(TradeDate) = 2018;

    SELECT TickerSymbol, ST_Open, ST_Close, Volume, TradeDate 
        FROM stockData
        WHERE TickerSymbol NOT LIKE 'a%' 
            AND YEAR(TradeDate) = 2018;

    SELECT TickerSymbol, ST_Open, ST_Close, Volume, TradeDate 
        FROM stockData
        WHERE TickerSymbol NOT LIKE 'a%' 
            AND YEAR(TradeDate) = 2018
    ORDER BY ST_Open;

    SELECT TickerSymbol, ST_Open, ST_Close, Volume, TradeDate 
        FROM stockData
        WHERE TickerSymbol NOT LIKE 'a%' 
            AND YEAR(TradeDate) = 2018
    ORDER BY ST_Open DESC;

    SELECT TickerSymbol, ST_Open, ST_Close, Volume, TradeDate 
        FROM stockData
        WHERE TickerSymbol NOT LIKE 'a%' 
            AND YEAR(TradeDate) = 2018
    ORDER BY ST_Open DESC, ST_Close;

    SELECT TickerSymbol, ST_Open, ST_Close, Volume, TradeDate 
        FROM stockData
        WHERE Volume IS NULL;

    SELECT TickerSymbol, ST_Open, ST_Close, Volume, TradeDate 
        FROM stockData
        WHERE Volume IS NOT NULL;




-- @ Задача 2
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
    WHERE ST_Open = 0 OR ST_High = 0 OR ST_Low = 0 OR ST_Close = 0;


-- 9. Look for missing data by listing any rows in StockData that contain nulls.
SELECT *
    FROM StockData
    WHERE TickerSymbol IS NULL 
        OR Industry IS NULL 
        OR TradeDate IS NULL 
        OR ST_Open IS NULL 
        OR ST_High IS NULL 
        OR ST_Low IS NULL 
        OR ST_Close IS NULL 
        OR Volume IS NULL
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

    -- other answer
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
    WHERE (ST_High > 130 AND TradeDate < 'December 31, 2014')
        OR (TradeDate > 'December 31, 2018' AND ST_Low < 5)
ORDER BY ST_High DESC, ST_Low DESC;


-- 16. Return all attributes for stocks that have the MSFT ticker symbol and have a high stock price below 20 dollars or a low stock price above 50 dollars.  List the high and low stock prices in ascending order.
SELECT *
    FROM StockData
    WHERE TickerSymbol = 'MSFT' AND (ST_High < 20 OR ST_Low > 50) 
ORDER BY ST_High, ST_Low;


-- 17. List the Price ID and TradeDate and stock high of all stocks that were traded before October 3rd, 2018 and had a stock high over 125 dollars. List the stock highs in descending order.
SELECT PriceID, TradeDate, ST_High
    FROM StockData
    WHERE TradeDate < 'October 3, 2018' AND ST_High > 125
ORDER BY ST_High DESC;


-- 18. List the trading start date (first date) in StockData table.
SELECT MIN(TradeDate) AS StartDate
    FROM StockData;


-- 19. List the trading start date and end date for each ticker in StockData.
SELECT TickerSymbol, MIN(TradeDate) AS StartDate, MAX(TradeDate) AS EndDate
    FROM StockData
GROUP BY TickerSymbol;


-- 20. List the sum of all the low stock prices that are above 60 dollars.  Call it TotalLowStockPriceOfStocksUnder60.
SELECT SUM(ST_Low) AS TotalLowStockPriceOfStocksUnder60
    FROM StockData
    WHERE ST_Low > 60;


-- 21. List the earliest trade date of the stock that ended up having a high over 100 dollars.  Call it EarliestTradeDateWithHighOver100.
SELECT MIN(TradeDate) AS EarliestTradeDateWithHighOver100
    FROM StockData
    WHERE ST_High > 100;


-- 22. List each ticker symbol and the average daily trade volume for that stock. Order the list from highest to least daily trade volume.
SELECT TickerSymbol, AVG(Volume) AS AvgVolume
    FROM StockData
GROUP BY TickerSymbol
ORDER BY AvgVolume DESC;

    -- Need to work on mine
    SELECT TickerSymbol, AVG(CONVERT(bigint, Volume)) AS AvgVolume
        FROM StockData
    GROUP BY TickerSymbol
    ORDER BY AvgVolume DESC;


-- 23. List the highest high price of all the stocks that have been traded in 2018 and have a low price less than 100 dollars.
SELECT MAX(ST_High)
    FROM StockData
    WHERE YEAR(TradeDate) = 2018 AND ST_Low < 100;


-- 24. List the number of trade dates of stocks that were traded in the month of August in 2018.
SELECT COUNT(TradeDate) AS August2018TradeDateCount
    FROM StockData
    WHERE TradeDate BETWEEN 'August 1, 2018' AND 'August 31, 2018';


-- 25. List the number of stocks that have an opening price of 70 dollars and were traded in 2018.  Call it NumberOfOpeningPricesOf70In2018.
SELECT COUNT(ST_Open) AS NumberOfOpeningPricesOf70In2018
    FROM StockData
    WHERE ST_Open = 70 AND YEAR(TradeDate) = 2018;


-- ? https://www.w3resource.com/sql/aggregate-functions/count-with-distinct.php
-- 26. List the industry and the number of different companies in each industry.
SELECT Industry, COUNT(DISTINCT TickerSymbol) AS NumberOfCompanies
    FROM StockData
GROUP BY Industry;

    -- Cali's team
    SELECT Industry, COUNT(TickerSymbol) AS 'Number of Companies'
        FROM CompanyInformation
    GROUP BY Industry;

    -- Examples to make sure it's working, testing
    SELECT TickerSymbol
        FROM StockData
        WHERE Industry = 'Food'
    GROUP BY TickerSymbol;
    -- (3 rows affected) 
    SELECT TickerSymbol
        FROM StockData
        WHERE Industry = 'Tech'
    GROUP BY TickerSymbol;
    -- (22 rows affected) 
    SELECT TickerSymbol
        FROM StockData
        WHERE Industry = 'Healthcare'
    GROUP BY TickerSymbol;
    -- (17 rows affected) 


-- 27. List the industry and the number of different companies in each industry. Put the answer in order of most stocks to least stocks.
-- teachers Answer
SELECT Industry, COUNT(DISTINCT TickerSymbol) AS NumberOfStocks
    FROM StockData
GROUP BY Industry
ORDER BY NumberOfStocks DESC;

    -- my answer
    SELECT Industry, COUNT(DISTINCT TickerSymbol) AS 'Number of Companies', SUM(CONVERT(bigint, Volume)) AS 'Number of Stocks'
        FROM StockData
    GROUP BY Industry
    ORDER BY 'Number of stocks' DESC;

    -- ? https://stackoverflow.com/questions/2421388/using-group-by-on-multiple-columns


-- 28. List the ten most common closing prices along with the number of times each occurs.
SELECT TOP 10 ST_Close, COUNT(ST_Close) AS NumberOfOccurrences
    FROM StockData
GROUP BY ST_Close
ORDER BY NumberOfOccurrences DESC;


-- 29. List the largest single-day stock price increase for Ford (between the market opening and closing).
SELECT MAX(ST_Open - ST_Close) AS GreatestIncreaseAmount
    FROM StockData
    WHERE TickerSymbol = 'F';
    
    -- Examples to make sure it's working, testing
    SELECT TOP 10 ST_Open, ST_Close, (ST_Open - ST_Close) AS 'Difference'
    FROM StockData;

    SELECT MAX(ST_Open - ST_Close) AS 'Greatest Increase Amount'
    FROM (
        SELECT TOP 10 ST_Open, ST_Close, (ST_Open - ST_Close) AS 'Difference'
            FROM StockData
    ) AS StockData;

    -- ST_Open               ST_Close                 Difference
    -- --------------------- ------------------------ ---------------------------------------
    -- 3.7455360000000       3.9977680000000          -0.2522320000000
    -- 3.8660710000000       3.6607140000000          0.2053570000000
    -- 3.7053570000000       3.7142860000000          -0.0089290000000
    -- 3.7901790000000       3.3928570000000          0.3973220000000
    -- 3.4464290000000       3.5535710000000          -0.1071420000000
    -- 3.6428570000000       3.4910710000000          0.1517860000000
    -- 3.4263390000000       3.3125000000000          0.1138390000000
    -- 3.3928570000000       3.1138390000000          0.2790180000000
    -- 3.3744390000000       3.4553570000000          -0.0809180000000
    -- 3.5714290000000       3.5870540000000          -0.0156250000000

    -- (10 rows affected)

    -- Greatest Increase Amount
    -- ---------------------------------------
    -- 0.3973220000000

    -- (1 row affected)


-- 30. List the lowest opening price for Ford stock in 2015.
SELECT MIN(ST_Open) AS LowestOpeningPriceForFordIn2015
    FROM StockData
    WHERE TickerSymbol = 'F' AND YEAR(TradeDate) = 2015;


-- 31. List the highest closing price for Ford in 2018.
SELECT MAX(ST_Close) AS HighestClosingPriceForFordIn2018
    FROM StockData
    WHERE TickerSymbol = 'F' AND YEAR(TradeDate) = 2018;


-- ? https://www.w3resource.com/sql/aggregate-functions/count-with-distinct.php
-- 32. List the number of days in the table when a trade occurred (when the trade volume for any stock wasn’t zero).
SELECT COUNT(DISTINCT TradeDate) AS DaysTradeOccurred 
    FROM StockData
    WHERE Volume <> 0;

    -- other queries in the process of getting to the one above
    SELECT COUNT(DISTINCT TradeDate) AS 'Days Trade Occurred'
        FROM StockData
        WHERE Volume > 0
    GROUP BY TradeDate;

    SELECT COUNT(TradeDate) AS 'Days Trade Occurred'
        FROM StockData
        WHERE Volume > 0
    GROUP BY TradeDate;

    SELECT SUM(CountData) AS 'Days Trade Occurred'
    FROM (
        SELECT CONVERT(int, COUNT(DISTINCT TradeDate)) AS CountData
            FROM StockData
            WHERE Volume > 0
        GROUP BY TradeDate
    ) AS StockData;

    SELECT COUNT(DISTINCT TradeDate ) AS "Days Trade Occurred" 
        FROM StockData
        WHERE Volume > 0;


-- 33. List the number of days in the table when a trade occurred (when the trade volume for any stock wasn’t zero) for each ticker symbol.
SELECT TickerSymbol, COUNT(DISTINCT TradeDate) AS DaysTradeOccurred 
    FROM StockData
    WHERE Volume <> 0
GROUP BY TickerSymbol;


-- 34. List the 10 Ticker Symbol that have the longest trading history in StockData table.
SELECT TOP 10 TickerSymbol, DATEDIFF(day, MIN(TradeDate), MAX(TradeDate)) AS LongestTradingHistoryInDays
    FROM StockData
GROUP BY TickerSymbol
ORDER BY LongestTradingHistoryInDays DESC;

    -- ! teacher, different answer
    SELECT TOP 10 TickerSymbol, COUNT(DISTINCT TradeDate) AS DaysWithTrade
        FROM StockData
        WHERE Volume > 0
    GROUP BY TickerSymbol
    ORDER BY DaysWithTrade DESC, TickerSymbol;

    -- Cali's Team, needs DESC
    SELECT TOP 10 TickerSymbol
        FROM StockData
    GROUP BY TickerSymbol
    ORDER BY MAX(TradeDate)-MIN(TradeDate);


-- 35. List the industries in alphabetical order and the number of companies in each industry in the table.
SELECT Industry, COUNT(DISTINCT TickerSymbol) AS NumberOfCompanies
    FROM StockData
GROUP BY Industry
ORDER BY Industry;

    -- Cali's Team
    SELECT Industry, COUNT(TickerSymbol)
        FROM CompanyInformation
    GROUP BY Industry
    ORDER BY Industry;


-- 36. Suppose we have a theory that stocks dropped in value after September 11, 2001. List the minimum closing price of Ford stock in September 2001 before September 11.
SELECT MIN(ST_Close) AS MinimumClosingPriceBeforeSeptember11
    FROM StockData
    WHERE TickerSymbol = 'F' AND TradeDate BETWEEN 'September 1, 2001' AND 'September 10, 2001';
    -- 18.7600000000000


-- 37. Now list the minimum closing price of Ford stock in September 2001 after September 11.
SELECT MIN(ST_Close) AS MinimumClosingPriceAfterSeptember11
    FROM StockData
    WHERE TickerSymbol = 'F' AND TradeDate BETWEEN 'September 12, 2001' AND 'September 30, 2001';
    -- 15.3400000000000


-- 38. List the all the ticker symbols containing the letter S and their average closing price in 2018.
SELECT TickerSymbol, AVG(ST_Close) AS AverageClosingPriceIn2018 
    FROM StockData
    WHERE TickerSymbol LIKE '%S%' AND YEAR(TradeDate) = 2018
GROUP BY TickerSymbol;


-- 39. List the ticker symbols and the average price multiplied by volume for each ticker symbol in 2018. Use the closing price of as the price for the entire day. List the ticker symbol with the highest average price times volume first.
SELECT TickerSymbol, (AVG(ST_Close) * SUM(Volume)) AS AverageClosingPrice 
    FROM StockData
    WHERE YEAR(TradeDate) = 2018
GROUP BY TickerSymbol
ORDER BY AverageClosingPrice DESC;

    -- Need for Mine to work
    SELECT TickerSymbol, (AVG(ST_Close) * SUM(CONVERT(bigint, Volume))) AS AverageClosingPrice 
        FROM StockData
        WHERE YEAR(TradeDate) = 2018
    GROUP BY TickerSymbol
    ORDER BY AverageClosingPrice DESC;


-- 40. List the number of times you could have made at least a 10% profit by purchasing stocks at its lowest price for the day and selling the stock at its highest price for the day.
SELECT COUNT(*) AS NumberOfTimes
    FROM StockData
    WHERE ST_High >= (ST_Low * 1.1);


-- 41. List the relevant ticker symbols and the number of times you could have made at least a 10% profit on that stock by purchasing the stock at its lowest price for the day and selling the stock at its highest price for the day. List the ticker symbol for which this occurs most frequently first.
-- Teacher
SELECT TickerSymbol, COUNT(*) AS NumberOfTimes
    FROM StockData
    WHERE ST_High >= (ST_Low * 1.1)
GROUP BY TickerSymbol
ORDER BY COUNT(*) DESC;

    -- Mine
    SELECT TickerSymbol, COUNT(*) AS 'Times You Could Have Made At Least A 10% Profit'
        FROM StockData
        WHERE ((ST_High - ST_Low) / ST_Low) >= .1
    GROUP BY TickerSymbol
    ORDER BY COUNT(*) DESC;


-- 42. List the relevant ticker symbols and the number of times you could have had at least a 10% loss on that stock by purchasing the stock at its highest price for the day and selling the stock at its lowest price for the day. List the ticker symbol for which this occurs most frequently first.
--  Teacher 
SELECT TickerSymbol, COUNT(*) AS NumberOfTimes
    FROM StockData
    WHERE ((ST_High - ST_Low) / ST_High) >= .1
GROUP BY TickerSymbol
ORDER BY COUNT(*) DESC;


-- ? https://www.sqlservertutorial.net/sql-server-basics/sql-server-create-table/
-- 43. Create a Toys table (ToyID, ToyName) and a Colors Table (ColorID, ColorName) and put six tuples(rows) in each table. Use CREATE statements to make the tables.  
CREATE TABLE Toys (
    ToyID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    ToyName VARCHAR(50)
);

INSERT INTO Toys 
VALUES ('Buzz Lightyear'),('Sheriff Woody'),('Jessie'),('Bo Peep'),('Mr. Potato Head'),('Rex');

CREATE TABLE Colors (
    ColorID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    ColorName VARCHAR(50)
); 

INSERT INTO Colors 
    VALUES ('Red'),('Yellow'),('Blue'),('Purple'),('Green'),('Gray');


-- 44. Add a new row to the Stock Data table.  This stock should have the Microsoft ticker symbol (MSFT) in the Tech Industry.  The stock was traded on May 5, 2017.  It had an opening price of 68.90, a high price of 69.03, a low price of 68.48, a closing price of 69, and a volume of 19,128,782.
-- Teachers Answer
INSERT INTO StockData 
    VALUES ('MSFT', 'Tech', 'May 5, 2017', 68.90, 69.03, 68.48, 69, 19128782);

    -- Mine
    INSERT INTO StockData (TickerSymbol, Industry, TradeDate, ST_Open, ST_High, ST_Low, ST_Close, Volume)
        VALUES ('MSFT', 'Tech', 'May 5, 2017', 68.90, 69.03, 68.48, 69, 19128782);


-- 45. It’s January 30, 2017 and you need to add information to the Stock Data table for Microsoft on that date.  You have to wait until the end of the day before you can put any of the prices because you don't know the closing price yet.  For now just add Microsoft's trade date, Industry, and ticker symbol to the table.
INSERT INTO StockData (TickerSymbol, Industry, TradeDate)
    VALUES ('MSFT', 'Tech', '1-30-2017');


-- 46. Remove all the rows of stocks that were traded before January 1st, 2001 for Microsoft.
DELETE 
FROM StockData
    WHERE TickerSymbol = 'MSFT' AND TradeDate < 'January 1, 2001';

    -- Teachers Answer
    DELETE 
    FROM StockData
        WHERE TradeDate < '1/1/2001' AND TickerSymbol = 'MSFT';


-- 47. Remove all the rows of stocks of Microsoft that were traded during the month of October in the year 2018.
DELETE FROM StockData
    WHERE TickerSymbol = 'MSFT' AND YEAR(TradeDate) = 2018 AND MONTH(TradeDate) = 10;

    -- Cali Team
    DELETE FROM StockData
	    WHERE TickerSymbol = 'MSFT' AND TradeDate BETWEEN '10-1-2018' AND '10-31-2018';


-- 48 Make a change for the Microsoft row for April 1st, 2018.  Change the opening stock price to 55.1, the high price to 56.26, the low price to 55.55, and the closing stock price to 55.95, and the volume to 24,298,620.
UPDATE StockData
SET ST_Open = 55.1,
    ST_High = 56.26,
    ST_Low = 55.55,
    ST_Close = 55.95,
    Volume = 24298620
    WHERE TradeDate = '4-1-2018' AND TickerSymbol = 'MSFT';


-- 49. Set any opening stock prices that are zero to null.
UPDATE StockData
SET ST_Open = NULL
    WHERE ST_Open = 0;


-- 50. Any suggestions for this assignment?
-- Nope










-- @ Oil and Gas in class
    -- Team Names
        -- Russell Moore
        -- Matt Cheney
        -- Dylan Jensen
-- 5.
CREATE TABLE SpotPrices( TradeDate DATETIME NOT NULL PRIMARY KEY, BCSpotPrice DECIMAL(21,13),WTISpotPrice DECIMAL(21,13));
-- 7.
INSERT INTO SpotPrices (TradeDate)
SELECT observation_date
    FROM Brent;
-- 8.
UPDATE SpotPrices
SET BCSpotPrice = bc.DCOILBRENTEU
FROM Brent AS bc JOIN SpotPrices AS sp ON 
    (bc.observation_date = sp.TradeDate);
-- 9.
UPDATE SpotPrices
SET WTISpotPrice = WTI.DCOILWTICO
FROM WTI JOIN SpotPrices AS sp ON 
    (WTI.observation_date = sp.TradeDate);
-- 10.
SELECT MAX(BCSpotPrice) AS BrentCrude, MAX(WTISpotPrice) AS WTI
    FROM SpotPrices;
-- 11.



-- JOINS
-- 5 types
    -- inner join/ join
    -- left join
    -- right join
    -- full join
    -- cross join









-- @ Задача 3
-- 1. List the price ID and the high stock price of the stocks with the high stock price is less than $100. Order the list by the highest to least daily high stock price.
SELECT PriceID, ST_High
    FROM StockData
    WHERE ST_High < 100
ORDER BY ST_High DESC;

-- 2. List the price ID and the high stock price of the two stocks with the most expensive high prices that are still less than $ 100.
SELECT TOP 2 PriceID, ST_High
    FROM StockData
    WHERE ST_High < 100
ORDER BY ST_High DESC;

-- 3. List the records on which you could have made at least a 10% profit by purchasing stocks at its lowest price for the day and selling the stock at its highest price for the day.
SELECT *
    FROM StockData
    WHERE ST_High >= (ST_Low * 1.1);

-- 4. List the ten largest differences (from greatest to least) between a daily high and low stock price along with the accompanying TickerSymbol, Industry, and TradeDate.
SELECT TOP 10 TickerSymbol, Industry, TradeDate, (ST_High - ST_Low) AS GreatestDifference
    FROM StockData
ORDER BY GreatestDifference DESC;

-- 5. List the five rows with the highest price multiplied by volume. Use the closing price of as the price for the entire day.
SELECT TOP 5 *, (ST_Close * Volume) AS HighestPrice
    FROM StockData
ORDER BY HighestPrice DESC;

-- 6. List the five rows with the highest ratio of daily high stock price to daily low stock price.
SELECT TOP 5 *, (ST_High / ST_Low) AS GreatestRatio
    FROM StockData
ORDER BY GreatestRatio DESC;

-- 7. List the total selling price of the shares above if you sold them at the daily high price on the same day.
-- * teacher
SELECT SUM(Volume * ST_High) AS TotalSellingPrice
    FROM (SELECT TOP 5 *
            FROM StockData
            ORDER BY (ST_High / ST_Low) DESC) AS st;

    -- mine
    SELECT TOP 5 TickerSymbol, (ST_High / ST_Low) AS GreatestRatio, (ST_High - ST_Low) AS totalSellingPrice
        FROM StockData
    ORDER BY GreatestRatio DESC;

-- 8. List the Price IDs and stock highs over 130 dollars rounded to the nearest penny.
-- teacher ok-ed
SELECT PriceID, CAST(ROUND(ST_High, 2) AS NUMERIC(10,2)) AS ST_High
    FROM StockData
    WHERE ST_High > 130
ORDER BY ROUND(ST_High, 2) DESC;

    -- Similar answer
    SELECT PriceID, ROUND(ST_High, 2) AS 'ST_High'
        FROM StockData
        WHERE ST_High > 130
    ORDER BY ROUND(ST_High, 2) DESC;

-- 9. Please list the first three characters of the TickerSymbol attribute for the CompanyInformation table.
SELECT LEFT(TickerSymbol, 3) AS FirstThreeCharactersOFTickerSymbol
    FROM CompanyInformation;

-- 10. What is today’s date?
SELECT CONVERT(date, GETDATE()) AS TodaysDate;

-- 11. How many minutes difference is there between the oldest and youngest members of your group?
SELECT DATEDIFF(minute, '10/27/1987', '09/07/1993') AS AgeDifferenceInMinutes;

-- 12. How much older is Rasputin (‘1/01/1869’) than Tommy Lee, '10/03/1962') in seconds? 
-- teacher ok-ed
SELECT DATEDIFF_BIG(second, '1/01/1869', '10/03/1962');

-- ? https://docs.microsoft.com/en-us/sql/t-sql/functions/datename-transact-sql?view=sql-server-ver15
-- 13. List every date that falls on a Friday from the Calendar table regardless of whether there are matching rows from the Stock Data table.
SELECT TickerSymbol, ActualDate, TradeDate
    FROM Calendar
    LEFT JOIN StockData
        ON (ActualDate = TradeDate)
    WHERE [DayOfWeek] = 'Friday';

    -- testing 
    SELECT TickerSymbol, ActualDate, TradeDate
        FROM Calendar
        LEFT JOIN StockData
            ON (ActualDate = TradeDate)
        WHERE DATENAME(weekday, ActualDate) = 'Friday';

-- 14. On October 9, 2012, you think the stock market is healthy and you decide to purchase your 200 shares of each stock back. How much will this cost?
SELECT CONCAT('$', CAST(ROUND(SUM(ST_Open) * 200, 2) AS NUMERIC(15,2))) AS CostToBuyBack
    FROM StockData
    WHERE TradeDate = 'October 9, 2012';

    -- testing
    SELECT TickerSymbol, ST_Close
        FROM StockData
        WHERE TradeDate = 'October 9, 2012'
    ORDER BY TickerSymbol;

-- 15. List each ticker symbol and the average daily trade volume for that stock on Fridays. Order the list from highest to least daily trade volume.
SELECT TickerSymbol, AVG(CONVERT(bigint, Volume)) AS AverageFridayTradeVolume
    FROM StockData
    WHERE DATENAME(weekday, TradeDate) = 'Friday'
GROUP BY TickerSymbol
ORDER BY AverageFridayTradeVolume DESC;

-- or

SELECT sd.TickerSymbol, AVG(CONVERT(bigint, Volume)) AS AverageFridayTradeVolume 
	FROM StockData AS sd 
    INNER JOIN Calendar AS c 
        ON (sd.TradeDate = c.ActualDate)
	WHERE  [DayOfWeek] = 'Friday'
GROUP BY TickerSymbol
ORDER BY AverageFridayTradeVolume DESC;

-- 16. List each ticker symbol, day of the week, and the average daily trade volume for that stock on each day of the week. Order the list by ticker symbol and then by highest to least daily trade volume.
SELECT TickerSymbol, DATENAME(weekday, TradeDate) AS DayOFTheWeek, AVG(CONVERT(bigint, Volume)) AS AverageDailyTradeVolume
    FROM StockData
GROUP BY TickerSymbol, DATENAME(weekday, TradeDate)
ORDER BY TickerSymbol, AverageDailyTradeVolume DESC;

-- or

SELECT TickerSymbol, [DayOfWeek], AVG(CONVERT(bigint, Volume)) AS AverageDailyTradeVolume
	FROM StockData AS sd 
    INNER JOIN Calendar AS c
	    ON (sd.TradeDate = c.ActualDate)
GROUP BY TickerSymbol, [DayOfWeek]
ORDER By TickerSymbol, AverageDailyTradeVolume DESC;

    -- * teacher
    SELECT TickerSymbol, DATENAME(weekday, TradeDate) AS DayOFWeek, AVG(CONVERT(bigint, Volume)) AS AverageVolume
        FROM StockData
    GROUP BY TickerSymbol, DATENAME(weekday, TradeDate)
    ORDER BY TickerSymbol, AVG(CONVERT(bigint, Volume)) DESC;

-- 17. List the months of the year and their corresponding average closing prices of Ford stock. List the months with the lowest average closing prices first.
SELECT DATENAME(month, TradeDate) AS AggregatedMonths, AVG(ST_Close) AS AverageClosingPrices
    FROM StockData
    WHERE TickerSymbol = 'F'
GROUP BY DATENAME(month, TradeDate)
ORDER BY AverageClosingPrices;

-- or

SELECT DATENAME(month, TradeDate) AS MonthOfYear, AVG(St_Close) AS AvgClosingStockPrice
	FROM Stockdata AS sd 
	INNER JOIN CompanyInformation AS c 
		ON (sd.TickerSymbol = c.TickerSymbol)
	WHERE CompanyName = 'Ford Motor Company'
GROUP BY DATENAME(month, TradeDate)
ORDER BY AvgClosingStockPrice;

    -- * teachers
    SELECT DATENAME(month, TradeDate) AS MonthOfYear, AVG(ST_Close) AS AverageClosingPrices
        FROM StockData
        WHERE TickerSymbol = 'F'
    GROUP BY DATENAME(month, TradeDate)
    ORDER BY AVG(ST_Close);

-- 18. List the number of trade days in each month of 2018. Sort the list from least to greatest number of trade days.
SELECT DATENAME(month, TradeDate) AS AggregatedMonths, COUNT(DISTINCT TradeDate) AS TradeDayPerMonth
    FROM StockData
    WHERE YEAR(TradeDate) = 2018
GROUP BY DATENAME(month, TradeDate)
ORDER BY TradeDayPerMonth, AggregatedMonths;

-- or

SELECT [MonthName], COUNT(DISTINCT sd.TradeDate) AS TradeDayPerMonth 
	FROM StockData AS sd LEFT JOIN Calendar AS c ON
	(sd.TradeDate = c.ActualDate)
	WHERE YEAR(TradeDate) = 2018
GROUP BY [MonthName]
ORDER BY TradeDayPerMonth, [MonthName];

-- 19. List the number of trade days in each month of 2018. Also include the average trade volume for each month. Sort the list from least to greatest number of trade days.
SELECT DATENAME(month, TradeDate) AS AggregatedMonths, COUNT(DISTINCT TradeDate) AS TradeDayPerMonth, AVG(CONVERT(bigint, Volume)) AS AverageTradeVolume
    FROM StockData
    WHERE YEAR(TradeDate) = 2018
GROUP BY DATENAME(month, TradeDate)
ORDER BY TradeDayPerMonth, AggregatedMonths;

-- or

SELECT [MonthName], COUNT(DISTINCT s.TradeDate) AS TradeDayPerMonth, AVG(CONVERT(bigint, Volume)) AS AverageTradeVolume
	FROM StockData AS s RIGHT JOIN Calendar AS c ON
	(s.TradeDate = c.ActualDate)
	WHERE YEAR(TradeDate) = 2018
GROUP BY [MonthName]
ORDER BY COUNT(DISTINCT s.TradeDate), [MonthName];

-- 20. List the industries in alphabetical order and the number of companies in each industry in the table. Also include the ratio of unique dates to the range of dates for each industry.
-- teacher ok-ed
SELECT Industry, COUNT(DISTINCT TickerSymbol) AS NumberOfCompanies, COUNT(DISTINCT TradeDate) * 1.0 / DATEDIFF(day, MIN(TradeDate), MAX(TradeDate)) AS RatioOfUniqueDates
    FROM StockData
GROUP BY Industry
ORDER BY Industry;

-- 21. List the industries in alphabetical order and the number of companies in each industry in the table. Also include the range of dates and the number of unique dates for each industry.
SELECT Industry, 
    COUNT(DISTINCT TickerSymbol) AS NumberOfCompanies, 
    COUNT(DISTINCT TradeDate) AS UniqueDates, 
    DATEDIFF(day, MIN(TradeDate), MAX(TradeDate)) AS RangeOfDatesInDays,
    CONCAT(CAST(MIN(TradeDate) AS DATE), ' - ', CAST(MAX(TradeDate) AS DATE)) AS RangeOfDates
    FROM StockData
GROUP BY Industry
ORDER BY Industry;

    -- testing
    SELECT Industry, 
        COUNT(DISTINCT TickerSymbol) AS NumberOfCompanies, 
        COUNT(DISTINCT TradeDate) AS UniqueDates, 
        DATEDIFF(day, MIN(TradeDate), MAX(TradeDate)) AS RangeOfDatesInDays,
        MIN(TradeDate) AS RangeOfDates_MinDate,
        MAX(TradeDate) AS RangeOfDates_MaxDate
        FROM StockData
    GROUP BY Industry
    ORDER BY Industry;

-- 22. List the ticker symbol, year, and the average price multiplied by volume for each year for Apple stock. Use the closing price of as the price for the entire day. 
SELECT TickerSymbol, YEAR(TradeDate) AS TradeDateYear, (AVG(ST_Close) * SUM(CONVERT(bigint, Volume))) AS AverageClosingPrice
    FROM StockData
    WHERE TickerSymbol = 'AAPL'
GROUP BY TickerSymbol, YEAR(TradeDate)
ORDER BY TradeDateYear;

-- 23. List the industry and the number of different companies in each industry for only those industries that have more than three companies.
SELECT Industry, COUNT(DISTINCT TickerSymbol) AS NumberOfCompanies
    FROM StockData
GROUP BY Industry
HAVING COUNT(DISTINCT TickerSymbol) > 3
ORDER BY Industry;

-- or

SELECT Industry, COUNT(TickerSymbol) AS NumberOfCompanies
	FROM CompanyInformation
GROUP BY Industry
HAVING COUNT(TickerSymbol) > 3
ORDER BY Industry;

-- 24. From the stock data table please list the ticker symbol, date, opening and closing stock prices, and day type of all stocks that were traded on a Holiday in 2018.  
SELECT TickerSymbol, TradeDate, ST_Open, ST_Close, DayType
    FROM StockData
    INNER JOIN Calendar
        ON (TradeDate = ActualDate)
    WHERE DayType = 'Holiday' AND YEAR(TradeDate) = 2018
ORDER BY TickerSymbol;

    -- testing, I'm assuming he wants it the way above, not this way, but this was fun
    SELECT  TickerSymbol, TradeDate, ST_Open, ST_Close, 
        CASE
            WHEN MONTH(TradeDate) = 1  AND DAY(TradeDate) = 1 THEN 'New Year'
            WHEN MONTH(TradeDate) = 5  AND DAY(TradeDate) >= 25 AND DATENAME(weekday, TradeDate) = 'Monday' THEN 'Memorial Day'
            WHEN MONTH(TradeDate) = 7  AND DAY(TradeDate) = 4 THEN 'Independence Day'
            WHEN MONTH(TradeDate) = 9  AND DAY(TradeDate) <= 7 AND DATENAME(weekday, TradeDate) = 'Monday' THEN 'Labor Day'
            WHEN MONTH(TradeDate) = 11 AND DAY(TradeDate) BETWEEN 22 AND 28 AND DATENAME(weekday, TradeDate) = 'Thursday' THEN 'Thanksgiving Day'
            WHEN MONTH(TradeDate) = 12 AND DAY(TradeDate) = 25 THEN 'Christmas Day'
            ELSE 'Normal day'
        END AS DayType
        FROM StockData
        WHERE 
            CASE
                WHEN MONTH(TradeDate) = 1  AND DAY(TradeDate) = 1 THEN 'New Year'
                WHEN MONTH(TradeDate) = 5  AND DAY(TradeDate) >= 25 AND DATENAME(weekday, TradeDate) = 'Monday' THEN 'Memorial Day'
                WHEN MONTH(TradeDate) = 7  AND DAY(TradeDate) = 4 THEN 'Independence Day'
                WHEN MONTH(TradeDate) = 9  AND DAY(TradeDate) <= 7 AND DATENAME(weekday, TradeDate) = 'Monday' THEN 'Labor Day'
                WHEN MONTH(TradeDate) = 11 AND DAY(TradeDate) BETWEEN 22 AND 28 AND DATENAME(weekday, TradeDate) = 'Thursday' THEN 'Thanksgiving Day'
                WHEN MONTH(TradeDate) = 12 AND DAY(TradeDate) = 25 THEN 'Christmas Day'
                ELSE 'Normal day'
            END != 'Normal day'
            AND YEAR(TradeDate) = 2018
    ORDER BY TickerSymbol, TradeDate;

-- 25. From the stock data table please list the ticker symbol, industry, trade date, opening, closing, high, and low stock prices, and volume of all stocking that the company is from CA.
SELECT s.TickerSymbol, s.Industry, TradeDate, ST_Open, ST_Close, ST_High, ST_Low, Volume, [State]
    FROM StockData AS s
    INNER JOIN CompanyInformation AS c
        ON (s.TickerSymbol = c.TickerSymbol)
    WHERE [State] = 'CA'
ORDER BY TickerSymbol;

-- 26. List all the columns and rows from StockData, Calendar, and CompanyInformation tables.
SELECT *
    FROM StockData AS s
    FULL JOIN Calendar AS c
        ON (TradeDate = ActualDate)
    FULL JOIN CompanyInformation AS ci
        ON (s.TickerSymbol = ci.TickerSymbol);

-- 27.List the day of week and every date that falls on a weekend from the Calendar table and all rows from the Stock Data table.
SELECT [DayOfWeek], ActualDate, s.* 
    FROM StockData AS s
    FULL JOIN Calendar AS c
        ON (TradeDate = ActualDate)
    WHERE [DayOfWeek] IN('Saturday', 'Sunday');
    -- (15757 rows affected)

-- or

SELECT [DayOfWeek], ActualDate, s.* 
    FROM StockData AS s
    FULL JOIN Calendar AS c
        ON (TradeDate = ActualDate)
    WHERE DayType = 'Weekend';
    -- (15629 rows affected)

-- 28. Please return all combinations of Toys and Colors.  
SELECT * 
    FROM Toys CROSS JOIN Colors;

    -- teacher
    SELECT * 
        FROM Colors CROSS JOIN Toys;

-- ! no IDs higher than 12
-- 29. Please return all combinations of Toys and Colors.  Include only those toys with an ID larger than 12 and please exclude colors that begin with the letter ‘B’.  
SELECT * 
    FROM Toys AS t
    CROSS JOIN Colors AS c
    WHERE ToyID > 12 AND ColorName NOT LIKE 'B%';

    -- testing 
    SELECT * 
        FROM Toys AS t
        CROSS JOIN Colors AS c
        WHERE ToyID > 3 AND ColorName NOT LIKE 'B%';

-- ? https://www.w3resource.com/sql/subqueries/understanding-sql-subqueries.php
-- 30. List the ticker symbol and the percentage of each ticker symbol's total number of trading days to the total number of days for all stocks.
-- * teacher
SELECT TickerSymbol, 
    CAST(COUNT(*) AS DECIMAL(21,13)) /
        (SELECT CAST(COUNT(*) AS DECIMAL(21,13)) 
            FROM StockData) AS PercentOfTotal
    FROM StockData
GROUP BY TickerSymbol
ORDER BY PercentOfTotal DESC;

    -- mine
    SELECT TickerSymbol, 
        CONCAT(CAST(ROUND((COUNT(DISTINCT TradeDate) * 1.0 / 
            (SELECT COUNT(DISTINCT TradeDate) 
                FROM StockData)
        ) * 100, 2) AS NUMERIC(10,2)), '%') AS PercentageOfDays
        FROM StockData
    GROUP BY TickerSymbol
    ORDER BY PercentageOfDays DESC;

    -- mine trying to get closer to the teachers answer
    SELECT TickerSymbol, 
        CONCAT(CAST(ROUND((COUNT(TradeDate) * 1.0 / 
            (SELECT COUNT(TradeDate) 
                FROM StockData)
        ) * 100, 2) AS NUMERIC(10,2)), '%') AS PercentageOfDays
        FROM StockData
    GROUP BY TickerSymbol
    ORDER BY PercentageOfDays DESC;
    
    -- testing
    SELECT TickerSymbol, 
        COUNT(DISTINCT TradeDate) AS TradeDate,
        COUNT(ActualDate) AS ActualDate,
        (SELECT COUNT(DISTINCT TradeDate) FROM StockData) AS DaysForAll,
        CONCAT(COUNT(DISTINCT TradeDate) / (SELECT COUNT(DISTINCT TradeDate) FROM StockData) * 100.0, '%') AS PercentageOfDays
        FROM StockData
        RIGHT JOIN Calendar
            ON TradeDate = ActualDate
    GROUP BY TickerSymbol;

    SELECT COUNT(*) FROM Calendar;
    -- 55152

    SELECT DATEDIFF(day, MIN(TradeDate), MAX(TradeDate)) FROM StockData;
    -- 7302

    SELECT COUNT(DISTINCT TradeDate) FROM StockData;
    -- 5189

    SELECT TickerSymbol, 
        COUNT(DISTINCT TradeDate) AS TradeDate,
        (SELECT COUNT(DISTINCT TradeDate) FROM StockData) AS DaysForAllStocks,
        CONCAT(COUNT(DISTINCT TradeDate) * 1.0 / (SELECT COUNT(DISTINCT TradeDate) FROM StockData) * 100, '%') AS PercentageOfDays
        FROM StockData
    GROUP BY TickerSymbol
    ORDER BY PercentageOfDays;

    SELECT TickerSymbol, CONCAT((COUNT(DISTINCT TradeDate) * 1.0 / (SELECT COUNT(DISTINCT TradeDate) FROM StockData)) * 100, '%') AS PercentageOfDays
        FROM StockData
    GROUP BY TickerSymbol
    ORDER BY PercentageOfDays DESC;

    -- Declare the variable to be used.
    DECLARE @AllDaysForStocks int;
    -- Initialize the variable.
    SET @AllDaysForStocks = (SELECT COUNT(DISTINCT TradeDate) FROM StockData);
    SELECT TickerSymbol, CONCAT((COUNT(DISTINCT TradeDate) * 1.0 / @AllDaysForStocks) * 100, '%') AS PercentageOfDays, @AllDaysForStocks AS AllDays
        FROM StockData
    GROUP BY TickerSymbol
    ORDER BY PercentageOfDays DESC;

    DECLARE @AllDaysForStocks int; -- Declare the variable to be used.
    SET @AllDaysForStocks = (SELECT COUNT(DISTINCT TradeDate) FROM StockData); -- Initialize the variable.
    SELECT TickerSymbol, CONCAT(CAST(ROUND((COUNT(DISTINCT TradeDate) * 1.0 / @AllDaysForStocks) * 100, 2) AS NUMERIC(10,2)), '%') AS PercentageOfDays
        FROM StockData
    GROUP BY TickerSymbol
    ORDER BY PercentageOfDays DESC, TickerSymbol;

-- 31. List the trade dates in descending order and open price in ascending order of all the stocks that open with a price greater than the average open price.
SELECT TradeDate, ST_Open
    FROM StockData
    WHERE ST_Open > 
        (SELECT AVG(ST_Open) 
            FROM StockData)
ORDER BY TradeDate DESC, ST_Open;

    -- testing
    SELECT TradeDate, ST_Open
        FROM StockData
        WHERE ST_Open > 
            (SELECT AVG(ST_Open) 
                FROM StockData)
    ORDER BY TradeDate DESC, ST_Open;

    DECLARE @AvgStockPrice NUMERIC(15,5); -- Declare the variable to be used.
    SET @AvgStockPrice = (SELECT AVG(ST_Open) FROM StockData); -- Initialize the variable.
    SELECT TradeDate, ST_Open
        FROM StockData
        WHERE ST_Open > @AvgStockPrice
    ORDER BY TradeDate DESC, ST_Open;

-- 32. List the number of stocks that have a greater than average high price that were traded on March 9th, 2018.  Call it NumberOfStocksAboveAverageHighIn2018.
SELECT COUNT(*) AS NumberOfStocksAboveAverageHighIn2018
    FROM StockData
    WHERE TradeDate = '3/9/2018' AND ST_High > 
        (SELECT AVG(ST_High) 
            FROM StockData);

    -- testing
    SELECT COUNT(*) AS NumberOfStocksAboveAverageHighIn2018
        FROM StockData
        WHERE TradeDate = '3/9/2018' AND ST_High > 
            (SELECT AVG(ST_High) 
                FROM StockData);

    DECLARE @AvgStockPrice NUMERIC(15,5); -- Declare the variable to be used.
    SET @AvgStockPrice = (SELECT AVG(ST_High) FROM StockData); -- Initialize the variable.
    SELECT COUNT(*) AS NumberOfStocksAboveAverageHighIn2018
        FROM StockData
        WHERE ST_High > @AvgStockPrice AND TradeDate = '3/9/2018';

-- 33. List the ticker symbol and the average closing for a stock that has the largest average closing price.
SELECT TOP 1 TickerSymbol, AVG(ST_Close) AS AverageClosingPrice 
    FROM StockData 
GROUP BY TickerSymbol
ORDER BY AverageClosingPrice DESC 

-- 34. List the number of shares (including fractions of shares) you could have purchased with $2000 at the low price on the day when the high to low price ratio was highest.
-- * teacher 
SELECT TOP 1 2000/ST_Low AS SharesPurchased
    FROM StockData
    WHERE TradeDate IN(
        SELECT TOP 1 TradeDate
            FROM StockData
        ORDER BY ST_High/ST_Low DESC
    )
ORDER BY ST_Low;

    -- mine
    SELECT ST_Low, (2000 / ST_Low ) AS NumberOfShares
    FROM StockData
    WHERE (ST_High / ST_Low) = 
        (SELECT MAX(ST_High / ST_Low)
            FROM StockData);

    -- testing
    SELECT (ST_High / ST_Low) AS HighestRatio
        FROM StockData
    ORDER BY HighestRatio DESC;

    SELECT MAX(ST_High / ST_Low) AS HighestRatio
        FROM StockData;

    SELECT TickerSymbol, ST_Low, (2000 / ST_Low ) AS NumberOfShares
        FROM StockData
        WHERE (ST_High / ST_Low) = 
            (SELECT MAX(ST_High / ST_Low)
                FROM StockData);

    SELECT ST_Low, (ST_High / ST_Low) AS ratio, (2000 / ST_Low ) AS NumberOfShares
    FROM StockData
    WHERE (ST_High / ST_Low) = 
        (SELECT MAX(ST_High / ST_Low)
            FROM StockData);

-- 35. Any suggestions of this assignment?
-- More HAVING clause problems.
-- It would be really nice to have a result set, to verify our queries on.












-- @ in class, 2/18/2020
-- 1 on the board
-- teachers way
SELECT sd.TickerSymbol, ST_Open, ST_Close, [state] AS 'US State'
    FROM stockData AS sd JOIN CompanyInformation AS ci ON (sd.TickerSymbol = ci.TickerSymbol)
    WHERE YEAR(TradeDate) = 2018;
-- mine
SELECT sd.TickerSymbol, ST_Open, ST_Close, [state] AS 'US State'
    FROM stockData AS sd
    INNER JOIN CompanyInformation AS ci
        ON sd.TickerSymbol = ci.TickerSymbol
    WHERE YEAR(TradeDate) = 2018;

-- 2 on the board
SELECT TickerSymbol, AVG(ST_Close) AS AverageClosingPrice
    FROM StockData
GROUP BY TickerSymbol;

-- 1) List TickerSymbol, company name, industry, trading date, stock closing price, volume.
SELECT sd.TickerSymbol, CompanyName, Industry, TradeDate, ST_Close, Volume
    FROM StockData AS sd 
    INNER JOIN CompanyInformation AS ci
        ON (sd.TickerSymbol = ci.TickerSymbol);

SELECT *
FROM table_name
INNER JOIN table_name
    ON column_name = column_name;
 
-- 2) List TickerSymbol, company name, industry, and the total amount of volume.
SELECT sd.TickerSymbol, CompanyName, sd.Industry, SUM(CONVERT(bigint, Volume)) AS TotalAmountOfVolume
    FROM StockData AS sd 
    INNER JOIN CompanyInformation AS ci
        ON (sd.TickerSymbol = ci.TickerSymbol)
GROUP BY sd.TickerSymbol, CompanyName, sd.Industry
ORDER BY sd.TickerSymbol, CompanyName, sd.Industry

-- 3) List any dates from 2000 to 2019 with the day name that don’t have trade on that day.
SELECT c.ActualDate, c.DayOFWeek
    FROM StockData AS s
    RIGHT JOIN Calendar AS c
        ON (TradeDate = ActualDate)
    WHERE TradeDate IS NULL AND ActualDate BETWEEN '1/1/2000' AND '12/31/2019'
ORDER BY ActualDate;

-- Cali
SELECT ActualDate, DayOfWeek
	FROM StockData a RIGHT JOIN Calendar b ON (a.TradeDate = b.ActualDate)
	WHERE ActualDate BETWEEN '1-1-2000' AND '12-31-2019' AND TradeDate IS NULL;


-- 4) List PriceID, TickerSymbol, Industry, TradeDate, all stock price, volume, day of week, day type, company name and the state that the company is located in.

-- Practice
-- 1) List TickerSymbol, company name, industry, trading date, stock closing price, volume.
SELECT A.TickerSymbol, CompanyName, A.Industry, TradeDate, ST_Close, Volume
	FROM StockData A JOIN CompanyInformation B ON (A.TickerSymbol = B.TickerSymbol)
    
-- 2) List TickerSymbol, company name, industry, and the total amount of volume.
SELECT a.TickerSymbol, CompanyName, a.Industry, SUM(Volume) AS TotalVolume
	FROM StockData a JOIN CompanyInformation b ON (A.TickerSymbol=B.TickerSymbol)
GROUP BY a.TickerSymbol, CompanyName, a.Industry;

-- 3) List any dates from 2000 to 2019 with the day name that don’t have trade on that day.
SELECT ActualDate, DayOfWeek
	FROM StockData a RIGHT JOIN Calendar b ON (a.TradeDate = b.ActualDate)
	WHERE ActualDate BETWEEN '1-1-2000' AND '12-31-2019' AND TradeDate IS NULL;

-- 4) List PriceID, TickerSymbol, Industry, TradeDate, all stock price, volume, day of week, day type, company name and the state that the company is located in.
SELECT PriceID, a.TickerSymbol, a.Industry, TradeDate, ST_Open,ST_Close, ST_High, ST_Low, Volume, [DayOfWeek], DayType, CompanyName, [State]
	FROM StockData a JOIN CompanyInformation b ON (a.TickerSymbol = b.TickerSymbol) JOIN Calendar c ON (a.TradeDate = c.ActualDate)











-- @ in class, 2/20/2020
-- Team
-- Russell Moore, Jason Hunsaker, Matt Cheney

-- 1) List TickerSymbol in alphabetical order and their average stock closing price.
SELECT TickerSymbol, AVG(ST_Close)
    FROM StockData
GROUP BY TickerSymbol
ORDER BY TickerSymbol;

-- 2) List TickerSymbol, company name, and average stock closing price. List the ticker symbol with the highest average price first.
SELECT s.TickerSymbol, CompanyName, AVG(ST_Close) AS AverageStockClosingPrice
    FROM StockData AS s
    INNER JOIN CompanyInformation AS c
        ON s.TickerSymbol = c.TickerSymbol
GROUP BY s.TickerSymbol, CompanyName
ORDER BY AverageStockClosingPrice DESC;

-- 3) Based on previous question, please only list the ticker symbol with the average price that is larger than 100. 
SELECT s.TickerSymbol, CompanyName, AVG(ST_Close) AS AverageStockClosingPrice
    FROM StockData AS s
    INNER JOIN CompanyInformation AS c
        ON (s.TickerSymbol = c.TickerSymbol)
GROUP BY s.TickerSymbol, CompanyName
HAVING AVG(ST_Close) > 100
ORDER BY AverageStockClosingPrice DESC;












-- @ Задача 4
-- 1.	List the Year(current year), TickerSymbol, the previous year closing price, the current year closing price, the annual rate of return between 2000 and 2018. Order by TickerSymbol and the current year.


-- 2.	List the year, month, ticker symbol, previous month closing, current month closing, monthly return percent between 2000 and 2018. Order by TickerSymbol, year and month. 
 

-- 3.	List the year, week, ticker symbol, previous week closing, current week closing, weekly return percent between 2000 and 2018. Order by TickerSymbol, the current year and week. 
 

-- 4.	Write a question and a query that uses the view and query approach.


-- 5.	Write the same query with the derived tables approach.


-- 6.	Write the same query with the CTE approach. 


-- 7.	Write a question or a problem and solve it using a trigger.


-- 8.	Write a question and the stored procedure that solves the question.


-- 9.	Write a question and the stored procedure that solves the question using two input parameters.


-- 10.	Write a stored procedure that is a full INSERT statement. 


