-- @ Data types 
    -- https://dev.mysql.com/doc/refman/8.0/en/data-types.html
    -- https://www.w3schools.com/sql/sql_datatypes.asp

-- * INT
    -- whole numbers with a max of 4294967295

-- * VARCHAR
    -- a string typically between 1 and 255 characters

-- storage requirements
-- https://dev.mysql.com/doc/refman/8.0/en/storage-requirements.html#data-types-storage-reqs-strings

-- # Numeric data types
    BIT
        -- https://stackoverflow.com/questions/488811/tinyint-vs-bit
        -- this statement below might just work for Microsoft SQL not MySQL
        -- When you add a bit column to your table it will occupy a whole byte in each record, not just a single bit. When you add a second bit column it will be stored in the same byte. The ninth bit column will require a second byte of storage. Tables with 1 bit column will not gain any storage benefit. Tinyint and bit can both be made to work, I have used both successfully and have no strong preference

        -- other reference
        -- https://dev.mysql.com/doc/refman/5.7/en/storage-requirements.html
    TINYINT
        -- whole numbers
    BOOL
    BOOLEAN
    SMALLINT
    MEDIUMINT
    INT
    INTEGER
    BIGINT
    FLOAT
        -- take less space, last reliability/precision in numbers
    DOUBLE
        -- more space then float, more reliability/precision then float
        -- take less space, last reliability/precision in numbers
    Numeric
    DECIMAL
    DEC
        -- allows for decimal points
        -- DECIMAL(5,2), DECIMAL(max digits, including decimal points,how many decimal points) = 999.99
    
    -- full list https://www.w3schools.com/sql/sql_datatypes.asp

-- # Text data types
    CHAR
        -- fixed length, it will truncate or add spaces, CHAR(10), 1234567890, 123       .
        -- they are faster retrieval then VARCHAR
        -- examples
        -- state abbreviations: CA, NY
        -- yes no questions: Y/N
        -- Sex: M/F
        -- CHAR(0-255) min-max 
        -- https://dev.mysql.com/doc/refman/8.0/en/char.html
    VARCHAR
        -- VARCHAR(255) Variable length, Adds an extra bite or two depending on the count of characters
        -- The effective maximum length of a VARCHAR is subject to the maximum row size (65,535 bytes, which is shared among all columns) and the character set used
        -- In contrast to CHAR, VARCHAR values are stored as a 1-byte or 2-byte length prefix plus data. The length prefix indicates the number of bytes in the value. A column uses one length byte if values require no more than 255 bytes, two length bytes if values may require more than 255 bytes.
        -- good table on the link below***
        -- VARCHAR(0-65535) min-max 
        -- https://dev.mysql.com/doc/refman/8.0/en/char.html 
    BINARY
    VARBINARY
    TINYBLOB
        -- 255 bytes
        -- For BLOBs (Binary Large OBjects). Max length: 255 bytes
    TINYTEXT 
        -- 255 bytes
        -- Holds a string with a maximum length of 255 characters
    TEXT 
        -- 65,535 bytes ~64kb
        -- Holds a string with a maximum length of 65,535 bytes
    BLOB
        -- 65,535 bytes
        -- For BLOBs (Binary Large OBjects). Holds up to 65,535 bytes of data
    MEDIUMTEXT 
        -- 16,777,215 bytes ~16MB
        -- Holds a string with a maximum length of 16,777,215 characters
    MEDIUMBLOB
        -- 16,777,215 bytes
        -- For BLOBs (Binary Large OBjects). Holds up to 16,777,215 bytes of data
    LONGTEXT 
        -- 4,294,967,295 bytes ~4GB
        -- Holds a string with a maximum length of 4,294,967,295 characters
    LONGBLOB
        -- 4,294,967,295 bytes
        -- For BLOBs (Binary Large OBjects). Holds up to 4,294,967,295 bytes of data
    ENUM
        -- ENUM(val1, val2, val3, ...)
        -- A string object that can have only one value, chosen from a list of possible values. You can list up to 65535 values in an ENUM list. If a value is inserted that is not in the list, a blank value will be inserted. The values are sorted in the order you enter them
    SET
        -- SET(val1, val2, val3, ...)
        -- A string object that can have 0 or more values, chosen from a list of possible values. You can list up to 64 values in a SET list
    -- full list https://www.w3schools.com/sql/sql_datatypes.asp

-- # Date data types
-- https://dev.mysql.com/doc/refman/8.0/en/datetime.html
    DATE
        -- stores dates with no time
        -- date format'YYYY-MM-DD'
        -- '1000-01-01' to '9999-12-31'
    DATETIME
        -- 8 bytes
        -- larger to store
        -- stores dates and a time
        -- format 'YYYY-MM-DD HH:MM:SS' 
        -- Can-do fractional seconds
        -- date range available '1000-01-01 00:00:00' to '9999-12-31 23:59:59'
    datetime2
        -- 6-8 bytes
        -- From January 1, 0001 to December 31, 9999 with an accuracy of 100 nanoseconds
    smalldatetime	
        -- 4 bytes
        -- From January 1, 1900 to June 6, 2079 with an accuracy of 1 minute
    TIMESTAMP
        -- smaller to store
        -- stores dates and a time
        -- format 'YYYY-MM-DD HH:MM:SS'
        -- Can-do fractional seconds
        -- MySQL converts TIMESTAMP values from the current time zone to UTC for storage, and back from UTC to the current time zone for retrieval. 
        -- date range available '1970-01-01 00:00:01' UTC to '2038-01-19 03:14:07' UTC 
    TIME
        -- stores time no date 
        -- time format'HH:MM:SS'
    YEAR
    -- full list https://www.w3schools.com/sql/sql_datatypes.asp


-- # NULL 
    NULL -- no entry or value exists, or never given a value