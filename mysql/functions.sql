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
    