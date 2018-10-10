-- @ logical operators

-- # !=
-- not equal
-- get all 
SELECT title, released_year 
FROM `books`;
+-----------------------------------------------------+---------------+
| title                                               | released_year | 
+-----------------------------------------------------+---------------+
| The Namesake                                        | 2003          | 
| Norse Mythology                                     | 2016          | 
| American Gods                                       | 2001          | 
| Interpreter of Maladies                             | 1996          |
... 

-- *** not equal
SELECT title, released_year 
FROM `books`
WHERE released_year != 2003;
+-----------------------------------------------------+---------------+
| title                                               | released_year | 
+-----------------------------------------------------+---------------+
| Norse Mythology                                     | 2016          | 
| American Gods                                       | 2001          | 
| Interpreter of Maladies                             | 1996          | 
| A Hologram for the King: A Novel                    | 2012          | 
...

-- # NOT LIKE
-- to find something not like
-- LIKE
SELECT title FROM books WHERE title LIKE 'w%';
+-----------------------------------------------------+
| title                                               | 
+-----------------------------------------------------+
| What We Talk About When We Talk About Love: Stories | 
| Where Im Calling From: Selected Stories             | 
| White Noise                                         | 
+-----------------------------------------------------+

-- *** NOT LIKE
SELECT title FROM books WHERE title NOT LIKE 'w%';
+-------------------------------------------+
| title                                     | 
+-------------------------------------------+
| The Namesake                              | 
| Norse Mythology                           | 
| American Gods                             | 
| Interpreter of Maladies                   | 
| A Hologram for the King: A Novel          | 
| The Circle                                | 
| The Amazing Adventures of Kavalier & Clay | 
...

-- # > greater than
-- selects rows that are greater than the column
SELECT title, pages
FROM `books`
WHERE pages > 300;
+-------------------------------------------+-------+
| title                                     | pages | 
+-------------------------------------------+-------+
| Norse Mythology                           | 304   | 
| American Gods                             | 465   | 
| A Hologram for the King: A Novel          | 352   | 
| The Circle                                | 504   | 
| The Amazing Adventures of Kavalier & Clay | 634   | 
| Just Kids                                 | 304   | 
| A Heartbreaking Work of Staggering Genius | 437   | 
| Where Im Calling From: Selected Stories   | 526   | 
| White Noise                               | 320   | 
| Oblivion: Stories                         | 329   | 
| Consider the Lobster                      | 343   | 
| fake_book                                 | 428   | 
| Lincoln In The Bardo                      | 367   | 
+-------------------------------------------+-------+

-- # < less than
-- selects rows that are less than the column
SELECT title, pages
FROM `books`
WHERE pages < 300;
+-----------------------------------------------------+-------+
| title                                               | pages | 
+-----------------------------------------------------+-------+
| The Namesake                                        | 291   | 
| Interpreter of Maladies                             | 198   | 
| Coraline                                            | 208   | 
| What We Talk About When We Talk About Love: Stories | 176   | 
| Cannery Row                                         | 181   | 
| 10% Happier                                         | 256   | 
+-----------------------------------------------------+-------+

-- # >= greater than or equal to
-- selects rows that are greater than or equal to the column
SELECT title, pages
FROM `books`
WHERE pages >= 504;
+-------------------------------------------+-------+
| title                                     | pages | 
+-------------------------------------------+-------+
| The Circle                                | 504   | 
| The Amazing Adventures of Kavalier & Clay | 634   | 
| Where Im Calling From: Selected Stories   | 526   | 
+-------------------------------------------+-------+

-- # <= less than or equal to
-- selects rows that are less than or equal to the column
SELECT title, pages
FROM `books`
WHERE pages <= 208;
+-----------------------------------------------------+-------+
| title                                               | pages | 
+-----------------------------------------------------+-------+
| Interpreter of Maladies                             | 198   | 
| Coraline                                            | 208   | 
| What We Talk About When We Talk About Love: Stories | 176   | 
| Cannery Row                                         | 181   | 
+-----------------------------------------------------+-------+

-- comparisons
100 > 5
-- true
 
-15 > 15
-- false
 
9 > -10
-- true
 
1 > 1
-- false
 
'a' > 'b'
-- false
 
'A' > 'a'
-- false
 
'A' >=  'a'
-- true

-- # AND or &&
-- AND = all conditions need to be true
SELECT title, released_year
FROM `books`
WHERE author_lname = 'Eggers'
    AND released_year > 2010
ORDER BY released_year ASC;
+----------------------------------+---------------+
| title                            | released_year | 
+----------------------------------+---------------+
| A Hologram for the King: A Novel | 2012          | 
| The Circle                       | 2013          | 
+----------------------------------+---------------+

-- &&
SELECT title, released_year
FROM `books`
WHERE author_lname = 'Eggers'
    && released_year > 2010
ORDER BY released_year DESC;
+----------------------------------+---------------+
| title                            | released_year | 
+----------------------------------+---------------+
| The Circle                       | 2013          | 
| A Hologram for the King: A Novel | 2012          | 
+----------------------------------+---------------+

-- AND comparisons
1 < 5 && 7 = 9
-- false
 
-10 > -20 && 0 <= 0
-- true
 
-40 <= 0 AND 10 > 40
--false
 
54 <= 54 && 'a' = 'A'
-- true

-- # OR or ||
-- OR = one of the statements must be true
SELECT title, released_year
FROM `books`
WHERE author_lname = 'Eggers'
    OR released_year > 2010
ORDER BY released_year DESC;
+-------------------------------------------+---------------+
| title                                     | released_year | 
+-------------------------------------------+---------------+
| Lincoln In The Bardo                      | 2017          | 
| Norse Mythology                           | 2016          | 
| 10% Happier                               | 2014          | 
| The Circle                                | 2013          | 
| A Hologram for the King: A Novel          | 2012          | 
| A Heartbreaking Work of Staggering Genius | 2001          | 
+-------------------------------------------+---------------+

-- ||
SELECT title, released_year
FROM `books`
WHERE author_lname = 'Eggers'
    || released_year > 2010
ORDER BY released_year;
+-------------------------------------------+---------------+
| title                                     | released_year | 
+-------------------------------------------+---------------+
| A Heartbreaking Work of Staggering Genius | 2001          | 
| A Hologram for the King: A Novel          | 2012          | 
| The Circle                                | 2013          | 
| 10% Happier                               | 2014          | 
| Norse Mythology                           | 2016          | 
| Lincoln In The Bardo                      | 2017          | 
+-------------------------------------------+---------------+

-- comparisons
SELECT 40 <= 100 || -2 > 0;
-- true
 
SELECT 10 > 5 || 5 = 5;
-- true
 
SELECT 'a' = 5 || 3000 > 2000;
-- true

-- # BETWEEN
-- selected given criteria BETWEEN x AND y  
SELECT title, released_year FROM books 
WHERE released_year BETWEEN 2004 AND 2015;
+----------------------------------+---------------+
| title                            | released_year | 
+----------------------------------+---------------+
| A Hologram for the King: A Novel | 2012          | 
| The Circle                       | 2013          | 
| Just Kids                        | 2010          | 
| Oblivion: Stories                | 2004          | 
| Consider the Lobster             | 2005          | 
| 10% Happier                      | 2014          | 
+----------------------------------+---------------+

-- # NOT BETWEEN
-- selected given criteria NOT BETWEEN x AND y 
SELECT title, released_year FROM books 
WHERE released_year NOT BETWEEN 2004 AND 2015;
+-----------------------------------------------------+---------------+
| title                                               | released_year | 
+-----------------------------------------------------+---------------+
| The Namesake                                        | 2003          | 
| Norse Mythology                                     | 2016          | 
| American Gods                                       | 2001          | 
| Interpreter of Maladies                             | 1996          | 
| The Amazing Adventures of Kavalier & Clay           | 2000          | 
| A Heartbreaking Work of Staggering Genius           | 2001          | 
| Coraline                                            | 2003          | 
| What We Talk About When We Talk About Love: Stories | 1981          | 
| Where Im Calling From: Selected Stories             | 1989          | 
| White Noise                                         | 1985          | 
| Cannery Row                                         | 1945          | 
| fake_book                                           | 2001          | 
| Lincoln In The Bardo                                | 2017          | 
+-----------------------------------------------------+---------------+


-- # IN 
-- select all that have at lest one of these
-- similar to the statement
    -- WHERE author_lname='Carver'
        -- OR author_lname='Lahiri'
        -- OR author_lname='Smith';
-- exact matches, not unlike statement
SELECT title, author_lname FROM books
WHERE author_lname IN ('Carver', 'Lahiri', 'Smith');
+-----------------------------------------------------+--------------+
| title                                               | author_lname | 
+-----------------------------------------------------+--------------+
| The Namesake                                        | Lahiri       | 
| Interpreter of Maladies                             | Lahiri       | 
| Just Kids                                           | Smith        | 
| What We Talk About When We Talk About Love: Stories | Carver       | 
| Where Im Calling From: Selected Stories             | Carver       | 
+-----------------------------------------------------+--------------+

-- # NOT IN 
-- select all that do not have these
SELECT title, released_year FROM books
WHERE released_year >= 2000
AND released_year NOT IN 
(2000,2002,2004,2006,2008,2010,2012,2014,2016)
ORDER BY released_year;
+-------------------------------------------+---------------+
| title                                     | released_year | 
+-------------------------------------------+---------------+
| American Gods                             | 2001          | 
| A Heartbreaking Work of Staggering Genius | 2001          | 
| fake_book                                 | 2001          | 
| The Namesake                              | 2003          | 
| Coraline                                  | 2003          | 
| Consider the Lobster                      | 2005          | 
| The Circle                                | 2013          | 
| Lincoln In The Bardo                      | 2017          | 
+-------------------------------------------+---------------+


-- # % modulo
-- can help you select all even or odd numbers
-- this is a little bit faster performance than the one above, in the one above, it has to compare if it is in any of the values contained in the list, that is why it is faster
SELECT title, released_year FROM books
WHERE released_year >= 2000 AND
released_year % 2 != 0 
ORDER BY released_year;
+-------------------------------------------+---------------+
| title                                     | released_year | 
+-------------------------------------------+---------------+
| American Gods                             | 2001          | 
| A Heartbreaking Work of Staggering Genius | 2001          | 
| fake_book                                 | 2001          | 
| The Namesake                              | 2003          | 
| Coraline                                  | 2003          | 
| Consider the Lobster                      | 2005          | 
| The Circle                                | 2013          | 
| Lincoln In The Bardo                      | 2017          | 
+-------------------------------------------+---------------+

-- # CASE STATEMENTS
-- select based off of case statements
-- always has a CASE, WHEN, THEN, ELSE, and END
SELECT title, released_year,
       CASE 
         WHEN released_year >= 2000 THEN 'Modern Lit'
         ELSE '20th Century Lit'
       END AS GENRE
FROM books;
+-----------------------------------------------------+---------------+------------------+
| title                                               | released_year | GENRE            | 
+-----------------------------------------------------+---------------+------------------+
| The Namesake                                        | 2003          | Modern Lit       | 
| Norse Mythology                                     | 2016          | Modern Lit       | 
| American Gods                                       | 2001          | Modern Lit       | 
| Interpreter of Maladies                             | 1996          | 20th Century Lit | 
| A Hologram for the King: A Novel                    | 2012          | Modern Lit       | 
| The Circle                                          | 2013          | Modern Lit       | 
| The Amazing Adventures of Kavalier & Clay           | 2000          | Modern Lit       | 
| Just Kids                                           | 2010          | Modern Lit       | 
| A Heartbreaking Work of Staggering Genius           | 2001          | Modern Lit       | 
| Coraline                                            | 2003          | Modern Lit       | 
| What We Talk About When We Talk About Love: Stories | 1981          | 20th Century Lit | 
...

-- another example
SELECT title, stock_quantity,
    CASE 
        WHEN stock_quantity BETWEEN 0 AND 50 THEN '*'
        WHEN stock_quantity BETWEEN 51 AND 100 THEN '**'
        WHEN stock_quantity BETWEEN 101 AND 150 THEN '***'
        ELSE '****'
    END AS STOCK
FROM books;
+-----------------------------------------------------+----------------+-------+
| title                                               | stock_quantity | STOCK | 
+-----------------------------------------------------+----------------+-------+
| The Namesake                                        | 32             | *     | 
| Norse Mythology                                     | 43             | *     | 
| American Gods                                       | 12             | *     | 
| Interpreter of Maladies                             | 97             | **    | 
| A Hologram for the King: A Novel                    | 154            | ****  | 
| The Circle                                          | 26             | *     | 
| The Amazing Adventures of Kavalier & Clay           | 68             | **    | 
| Just Kids                                           | 55             | **    | 
| A Heartbreaking Work of Staggering Genius           | 104            | ***   | 
| Coraline                                            | 100            | **    | 
| What We Talk About When We Talk About Love: Stories | 23             | *     | 
...

-- an optimized version of the one just before, taking advantage of order of operation
    -- check to see if lower than 50
    -- check to see if lower than 100, but already has checked 50 and below
    -- check to see if lower than 150, but has already checked 100 and below 
SELECT title, stock_quantity,
    CASE 
        WHEN stock_quantity <= 50 THEN '*'
        WHEN stock_quantity <= 100 THEN '**'
        WHEN stock_quantity <= 150 THEN '***'
        ELSE '****'
    END AS STOCK
FROM books; 
+-----------------------------------------------------+----------------+-------+
| title                                               | stock_quantity | STOCK | 
+-----------------------------------------------------+----------------+-------+
| The Namesake                                        | 32             | *     | 
| Norse Mythology                                     | 43             | *     | 
| American Gods                                       | 12             | *     | 
| Interpreter of Maladies                             | 97             | **    | 
| A Hologram for the King: A Novel                    | 154            | ****  | 
| The Circle                                          | 26             | *     | 
| The Amazing Adventures of Kavalier & Clay           | 68             | **    | 
| Just Kids                                           | 55             | **    | 
| A Heartbreaking Work of Staggering Genius           | 104            | ***   | 
| Coraline                                            | 100            | **    | 
| What We Talk About When We Talk About Love: Stories | 23             | *     | 
...