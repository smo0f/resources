-- # TickerSymbol
SELECT MAX(LEN(TickerSymbol)) FROM StockData;
-- 6

SELECT LEN(TickerSymbol) AS 'Length', COUNT(*) AS 'Count' FROM StockData GROUP BY LEN(TickerSymbol);
-- Length   Count
-- 3        9709
-- 6        2551
-- 4        15093

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