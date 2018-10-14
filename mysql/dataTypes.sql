-- @ Data types 
    -- https://dev.mysql.com/doc/refman/8.0/en/data-types.html
    -- https://www.w3schools.com/sql/sql_datatypes.asp

-- * INT
    -- whole numbers with a max of 4294967295

-- * VARCHAR
    -- a string typically between 1 and 255 characters

-- # Numeric data types
    TINYINT
        -- whole numbers
    SMALLINT
    MEDIUMINT
    INT
    BIGINT
    FLOAT
        -- take less space, last reliability/precision in numbers
    DOUBLE
        -- more space then float, more reliability/precision then float
        -- take less space, last reliability/precision in numbers
    Numeric
    DECIMAL
        -- allows for decimal points
        -- DECIMAL(5,2), DECIMAL(max digits, including decimal points,how many decimal points) = 999.99
    BIT
    -- full list https://www.w3schools.com/sql/sql_datatypes.asp

-- # Text data types
    CHAR
        -- fixed length, it will truncate or add spaces, CHAR(10), 1234567890, 123       .
        -- they are faster retrieval then VARCHAR
        -- examples
        -- state abbreviations: CA, NY
        -- yes no questions: Y/N
        -- Sex: M/F
    VARCHAR
        -- 
    TINYTEXT
    TEXT
    BLOB
    MEDIUMTEXT
    MEDIUMBLOB
    LONGTEXT
    LONGBLOB
    ENUM
    SET
    DECIMAL
    -- full list https://www.w3schools.com/sql/sql_datatypes.asp

-- # Date data types
-- https://dev.mysql.com/doc/refman/8.0/en/datetime.html
    DATE
        -- stores dates with no time
        -- date format'YYYY-MM-DD'
    DATETIME
        -- larger to store
        -- stores dates and a time
        -- format 'YYYY-MM-DD HH:MM:SS' 
        -- date range available '1000-01-01 00:00:00' to '9999-12-31 23:59:59'
    TIMESTAMP
        -- smaller to store
        -- stores dates and a time
        -- format 'YYYY-MM-DD HH:MM:SS'
        -- date range available '1970-01-01 00:00:01' UTC to '2038-01-19 03:14:07' UTC 
    TIME
        -- stores time no date 
        -- time format'HH:MM:SS'
    YEAR
    -- full list https://www.w3schools.com/sql/sql_datatypes.asp


-- # NULL 
    NULL -- no entry or value exists, or never given a value