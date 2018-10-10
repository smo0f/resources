-- @ functions 



-- @ string functions 
    -- https://dev.mysql.com/doc/refman/8.0/en/string-functions.html

    -- # CONCAT() 
    -- concatenates columns
    SELECT CONCAT(author_fname, ' ',  author_lname) AS full_name
    FROM books;

    +----------------------+
    | full_name            | 
    +----------------------+
    | Jhumpa Lahiri        | 
    | Neil Gaiman          | 
    | Neil Gaiman          | 
    | Jhumpa Lahiri        | 
    ...

    -- * example in group by section in adv_select.sql

    -- # CONCAT_WS() 
    -- contacts with predefined separator
    SELECT CONCAT_WS(' - ', title, author_fname, author_lname) AS book
    FROM `books`;

    +------------------------------------------------------------------------+
    | book                                                                   | 
    +------------------------------------------------------------------------+
    | The Namesake - Jhumpa - Lahiri                                         | 
    | Norse Mythology - Neil - Gaiman                                        | 
    | American Gods - Neil - Gaiman                                          | 
    | Interpreter of Maladies - Jhumpa - Lahiri                              | 
    ...

    -- # SUBSTRING() or SUBSTR() 
    -- SUBSTRING('hello world', 1, 5) = "hello" - SUBSTRING('string/column string', start, end) 
    -- or 
    -- SUBSTRING('hello world', 7) = "world" SUBSTRING('string/column string', start to end)
    -- or 
    -- SUBSTRING('hello world', -3) = "rld" SUBSTRING('string/column string', end to start)
    -- you can also use SUBSTR()
    SELECT SUBSTRING(title, 1, 10) AS 'Short Title' FROM `books`;

    +-------------+
    | Short Title | 
    +-------------+
    | The Namesa  | 
    | Norse Myth  | 
    | American G  |  
    ...

    SELECT CONCAT(SUBSTRING(title, 1, 10), '...') AS 'Short Title'  FROM books;

    +---------------+
    | Short Title   | 
    +---------------+
    | The Namesa... | 
    | Norse Myth... | 
    | American G... |
    ...

    -- # REPLACE()
    -- REPLACE('Hello World', 'Hell', '%$#@') REPLACE('string/column string', 'string to replace', 'replace with string')
    -- it is case sensitive
    SELECT REPLACE(title, 'e', '3') AS 'new titles' FROM `books`

    +-----------------------------------------------------+
    | new titles                                          | 
    +-----------------------------------------------------+
    | Th3 Nam3sak3                                        | 
    | Nors3 Mythology                                     | 
    | Am3rican Gods                                       | 
    ...

    -- # REVERSE()
    -- reverses a given string
    SELECT REVERSE('Hello World');

    +------------------------+
    | REVERSE('Hello World') | 
    +------------------------+
    | dlroW olleH            | 
    +------------------------+

    -- # CHAR_LENGTH()
    -- gets the links of a string
    SELECT title, CHAR_LENGTH(title) AS 'title length' FROM `books`

    +-----------------------------------------------------+--------------+
    | title                                               | title length | 
    +-----------------------------------------------------+--------------+
    | The Namesake                                        | 12           | 
    | Norse Mythology                                     | 15           | 
    | American Gods                                       | 13           | 
    | Interpreter of Maladies                             | 23           | 
    | A Hologram for the King: A Novel                    | 32           |
    ...

    -- # UPPER()
    -- caps all the letters in a string
    SELECT UPPER('Hello World');

    +----------------------+
    | UPPER('Hello World') | 
    +----------------------+
    | HELLO WORLD          | 
    +----------------------+

    -- # LOWER()
    -- lowercase all the letters in a string
    SELECT LOWER('Hello World');

    +----------------------+
    | LOWER('Hello World') | 
    +----------------------+
    | hello world          | 
    +----------------------+

    -- # MIN() and MAX()
    -- define minimum and maximum values with your table
    SELECT MIN(released_year) FROM `books`;
    -- 0 to 10 limit 1
    +--------------------+
    | MIN(released_year) | 
    +--------------------+
    | 1945               | 
    +--------------------+

    SELECT MIN(title) FROM `books`;
    -- a to z limit 1
    +-------------+
    | MIN(title)  | 
    +-------------+
    | 10% Happier | 
    +-------------+

    SELECT MAX(released_year) FROM `books`;
    -- 10 to 0 limit 1
    +--------------------+
    | MAX(released_year) | 
    +--------------------+
    | 2017               | 
    +--------------------+

    SELECT MAX(title) FROM `books`;
    -- z to a limit 1
    +-------------+
    | MAX(title)  | 
    +-------------+
    | White Noise | 
    +-------------+

    -- using sub query to select the book with the least amount of pages
    SELECT title, pages 
    FROM `books`
    WHERE pages = (SELECT MIN(pages) FROM `books`);
    -- SELECT title, pages 
    -- FROM `books`
    -- WHERE pages = (this query runs first = (176), then run the other query);
    -- but here's a faster query
    -- SELECT title, pages FROM books 
    -- ORDER BY pages ASC LIMIT 1;
    +-----------------------------------------------------+-------+
    | title                                               | pages | 
    +-----------------------------------------------------+-------+
    | What We Talk About When We Talk About Love: Stories | 176   | 
    +-----------------------------------------------------+-------+

    -- using sub query to select the book with the most amount of pages
    SELECT title, pages 
    FROM `books`
    WHERE pages = (SELECT MAX(pages) FROM `books`);
    +-------------------------------------------+-------+
    | title                                     | pages | 
    +-------------------------------------------+-------+
    | The Amazing Adventures of Kavalier & Clay | 634   | 
    +-------------------------------------------+-------+

    -- * example in group by section in adv_select.sql

-- @ aggregate functions

    -- # COUNT()
    -- counts what you ask it to
    SELECT COUNT(*) FROM `books`;
    +----------+
    | COUNT(*) | 
    +----------+
    | 19       | 
    +----------+

    -- a distinct count of authors first name
    SELECT COUNT(DISTINCT author_fname) AS 'author count' FROM `books`;
    +--------------+
    | author count | 
    +--------------+
    | 12           | 
    +--------------+

    SELECT COUNT(title) AS 'title count' FROM `books` WHERE title LIKE '%the%';
    +-------------+
    | title count | 
    +-------------+
    | 6           | 
    +-------------+

    -- * example in group by section in adv_select.sql
    
    -- # SUM()
    -- sums up the elements/columns selected
    -- works with numbers
    SELECT SUM(pages) FROM `books`;
    +------------+
    | SUM(pages) | 
    +------------+
    | 6623       | 
    +------------+

    -- this is what happens when you try to sum a string
    SELECT SUM(author_fname) FROM `books`;
    +-------------------+
    | SUM(author_fname) | 
    +-------------------+
    | 0                 | 
    +-------------------+

    -- * example in group by section in adv_select.sql

    -- # AVG()
    -- creates an average of the element/column selected
    -- works with numbers
    SELECT AVG(pages) FROM `books`;
    -- all books average the pages
    +------------+
    | AVG(pages) | 
    +------------+
    | 348.5789   | 
    +------------+

    -- * example in group by section in adv_select.sql

-- @ date functions
-- works with dates and datetimes
-- https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html
   
    -- # CURDATE()
    -- gives current date
    SELECT CURDATE();
    +------------------------------------------------------------+
    | CURDATE()                                                  | 
    +------------------------------------------------------------+
    | Mon Oct 08 2018 00:00:00 GMT-0600 (Mountain Daylight Time) | 
    +------------------------------------------------------------+

    -- # CURTIME()
    -- gives current time
    SELECT CURTIME();
    +-----------+
    | CURTIME() | 
    +-----------+
    | 13:54:01  | 
    +-----------+

    -- # NOW()
    -- gives current date time
    SELECT NOW();
    +------------------------------------------------------------+
    | NOW()                                                      | 
    +------------------------------------------------------------+
    | Mon Oct 08 2018 13:54:54 GMT-0600 (Mountain Daylight Time) | 
    +------------------------------------------------------------+

    -- # DAY()
    -- selects the given day
    SELECT DAY(NOW());
    -- 2018-08-10
    +------------+
    | DAY(NOW()) | 
    +------------+
    | 8          | 
    +------------+

    -- # DAYNAME()
    -- selects the given days name
    -- 2018-08-10
    SELECT DAYNAME(NOW());
    +----------------+
    | DAYNAME(NOW()) | 
    +----------------+
    | Monday         | 
    +----------------+

    -- # DAYOFWEEK()
    -- selects the given day of the week
    -- 2018-09-10
    SELECT DAYOFWEEK(NOW());
    +------------------+
    | DAYOFWEEK(NOW()) | 
    +------------------+
    | 3                | 
    +------------------+

    -- # DAYOFYEAR()
    -- selects the given day of the year
    -- 2018-09-10
    SELECT DAYOFYEAR(NOW());
    +------------------+
    | DAYOFYEAR(NOW()) | 
    +------------------+
    | 282              | 
    +------------------+

    -- # MONTH()
    -- selects the given month 
    -- 2018-09-10
    SELECT MONTH(NOW());
    +--------------+
    | MONTH(NOW()) | 
    +--------------+
    | 10           | 
    +--------------+

    -- # MONTHNAME()
    -- selects the given month name
    -- 2018-09-10
    SELECT MONTHNAME(NOW());
    +------------------+
    | MONTHNAME(NOW()) | 
    +------------------+
    | October          | 
    +------------------+

    -- # QUARTER()
    -- selects the given quarter
    -- 2018-09-10
    SELECT QUARTER(NOW());
    +----------------+
    | QUARTER(NOW()) | 
    +----------------+
    | 4              | 
    +----------------+

    -- # DATE_FORMAT()
    -- allows you to format the date
    -- https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_date-format
    SELECT DATE_FORMAT('2009-10-04 22:23:00', '%W %M %Y');
    +------------------------------------------------+
    | DATE_FORMAT('2009-10-04 22:23:00', '%W %M %Y') | 
    +------------------------------------------------+
    | Sunday October 2009                            | 
    +------------------------------------------------+

    -- another format
    SELECT DATE_FORMAT('2009-10-04 22:23:00', '%W-%M-%Y');
    +------------------------------------------------+
    | DATE_FORMAT('2009-10-04 22:23:00', '%W-%M-%Y') | 
    +------------------------------------------------+
    | Sunday-October-2009                            | 
    +------------------------------------------------+

    -- another format
    SELECT DATE_FORMAT('2009-10-04 22:23:00', '%W the %D, %M %Y');
    +--------------------------------------------------------+
    | DATE_FORMAT('2009-10-04 22:23:00', '%W the %D, %M %Y') | 
    +--------------------------------------------------------+
    | Sunday the 4th, October 2009                           | 
    +--------------------------------------------------------+

    -- # DATEDIFF()
    -- allows you to find the difference between a given date
    SELECT DATEDIFF('2010-12-31','2010-11-30 23:59:59');
    +----------------------------------------------+
    | DATEDIFF('2010-12-31','2010-11-30 23:59:59') | 
    +----------------------------------------------+
    | 31                                           | 
    +----------------------------------------------+

    -- selecting the difference going forward
    SELECT DATEDIFF('2010-11-30 23:59:59','2010-12-31');
    +----------------------------------------------+
    | DATEDIFF('2010-11-30 23:59:59','2010-12-31') | 
    +----------------------------------------------+
    | -31                                          | 
    +----------------------------------------------+

    -- # DATE_ADD()
    -- adds a particular amount of time to a given date
    SELECT DATE_ADD('2010-12-31 23:59:59', INTERVAL 1 DAY);
    +-------------------------------------------------+
    | DATE_ADD('2010-12-31 23:59:59', INTERVAL 1 DAY) | 
    +-------------------------------------------------+
    | 2011-01-01 23:59:59                             | 
    +-------------------------------------------------+

    -- different syntax for adding and subtracting
        SELECT '2010-12-31 23:59:59' + INTERVAL 1 DAY;
        +----------------------------------------+
        | '2010-12-31 23:59:59' + INTERVAL 1 DAY | 
        +----------------------------------------+
        | 2011-01-01 23:59:59                    | 
        +----------------------------------------+

        SELECT '2010-12-31 23:59:59' - INTERVAL 1 DAY;
        +----------------------------------------+
        | '2010-12-31 23:59:59' - INTERVAL 1 DAY | 
        +----------------------------------------+
        | 2010-12-30 23:59:59                    | 
        +----------------------------------------+

    -- using date_add with date_format
    SELECT DATE_FORMAT(DATE_ADD('2010-12-31 23:59:59', INTERVAL 1 DAY), '%W the %D, %M %Y') AS 'date';
    +--------------------------------+
    | date                           | 
    +--------------------------------+
    | Saturday the 1st, January 2011 | 
    +--------------------------------+

    -- using date_add with date_format, different syntax for adding and subtracting
    SELECT DATE_FORMAT('2010-12-31 23:59:59' + INTERVAL 1 DAY, '%W the %D, %M %Y') AS 'date';
    +--------------------------------+
    | date                           | 
    +--------------------------------+
    | Saturday the 1st, January 2011 | 
    +--------------------------------+

    -- chaining interval amounts
    SELECT DATE_FORMAT('2010-12-29 23:59:59' + INTERVAL 1 MONTH + INTERVAL 1 DAY, '%W the %D, %M %Y') AS 'date';
    +-------------------------------+
    | date                          | 
    +-------------------------------+
    | Sunday the 30th, January 2011 | 
    +-------------------------------+


