-- @ advanced selects 

    -- # DISTINCT
    -- gets distinct records
    -- distinct last names whether or not multiple authors have the same last name
    SELECT DISTINCT author_lname FROM books
    +----------------+
    | author_lname   | 
    +----------------+
    | Lahiri         | 
    | Gaiman         | 
    | Eggers         | 
    | Chabon         | 
    | Smith          | 
    | Carver         | 
    | DeLillo        | 
    | Steinbeck      | 
    | Foster Wallace | 
    | Harris         | 
    | Saunders       | 
    +----------------+

    -- distinct concatenation gives the true number of authors 
    SELECT DISTINCT CONCAT(author_fname, ' ', author_lname) AS 'full name' FROM books
    +----------------------+
    | full name            | 
    +----------------------+
    | Jhumpa Lahiri        | 
    | Neil Gaiman          | 
    | Dave Eggers          | 
    | Michael Chabon       | 
    | Patti Smith          | 
    | Raymond Carver       | 
    | Don DeLillo          | 
    | John Steinbeck       | 
    | David Foster Wallace | 
    | Dan Harris           | 
    | Freida Harris        | 
    | George Saunders      | 
    +----------------------+

    -- same as above just without concatenation, MySQL makes the columns together distinct
    -- makes combination of columns distinct
    SELECT DISTINCT author_fname, author_lname FROM books
    +--------------+----------------+
    | author_fname | author_lname   | 
    +--------------+----------------+
    | Jhumpa       | Lahiri         | 
    | Neil         | Gaiman         | 
    | Dave         | Eggers         | 
    | Michael      | Chabon         | 
    | Patti        | Smith          | 
    | Raymond      | Carver         | 
    | Don          | DeLillo        | 
    | John         | Steinbeck      | 
    | David        | Foster Wallace | 
    | Dan          | Harris         | 
    | Freida       | Harris         | 
    | George       | Saunders       | 
    +--------------+----------------+

    -- # ORDER BY
    -- ascending by default ASC
    -- works with strings or numbers
    SELECT author_lname FROM `books` ORDER BY author_lname;
    +----------------+
    | author_lname   | 
    +----------------+
    | Carver         | 
    | Carver         | 
    | Chabon         |
    ...

    SELECT author_lname FROM `books` ORDER BY author_lname DESC;
    +----------------+
    | author_lname   | 
    +----------------+
    | Steinbeck      | 
    | Smith          | 
    | Saunders       |
    ...

    -- sorts first by author's last name, then by pages, then by author first name
    SELECT author_fname, author_lname, pages FROM `books` ORDER BY author_lname, pages, author_fname;
    +--------------+----------------+-------+
    | author_fname | author_lname   | pages | 
    +--------------+----------------+-------+
    | Raymond      | Carver         | 176   | 
    | Raymond      | Carver         | 526   | 
    | Michael      | Chabon         | 634   | 
    | Don          | DeLillo        | 320   | 
    | Dave         | Eggers         | 352   | 
    | Dave         | Eggers         | 437   | 
    | Dave         | Eggers         | 504   | 
    | David        | Foster Wallace | 329   | 
    | David        | Foster Wallace | 343   | 
    | Neil         | Gaiman         | 208   | 
    | Neil         | Gaiman         | 304   | 
    | Neil         | Gaiman         | 465   | 
    | Dan          | Harris         | 256   | 
    | Freida       | Harris         | 428   | 
    | Jhumpa       | Lahiri         | 198   | 
    | Jhumpa       | Lahiri         | 291   | 
    | George       | Saunders       | 367   | 
    | Patti        | Smith          | 304   | 
    | John         | Steinbeck      | 181   | 
    +--------------+----------------+-------+

    -- sorts by the third (3)=pages selecting option
    -- SELECT 1, 2, 3 FROM `books` ORDER BY 3;
    SELECT author_fname, author_lname, pages FROM `books` ORDER BY 3;
    +--------------+----------------+-------+
    | author_fname | author_lname   | pages | 
    +--------------+----------------+-------+
    | Raymond      | Carver         | 176   | 
    | John         | Steinbeck      | 181   | 
    | Jhumpa       | Lahiri         | 198   | 
    | Neil         | Gaiman         | 208   | 
    | Dan          | Harris         | 256   |
    ...


    -- # LIMIT
    SELECT author_fname, author_lname, pages FROM `books` ORDER BY 3 LIMIT 2;
    +--------------+--------------+-------+
    | author_fname | author_lname | pages | 
    +--------------+--------------+-------+
    | Raymond      | Carver       | 176   | 
    | John         | Steinbeck    | 181   | 
    +--------------+--------------+-------+

    -- LIMIT start row (0 index),how many more rows;
    SELECT author_fname, author_lname, pages FROM `books` ORDER BY 3 LIMIT 1,2;
    +--------------+--------------+-------+
    | author_fname | author_lname | pages | 
    +--------------+--------------+-------+
    | John         | Steinbeck    | 181   | 
    | Jhumpa       | Lahiri       | 198   | 
    +--------------+--------------+-------+

    -- start at a particular row and go to the very end of all your rows
    -- number must be bigger than the amount of rows that you have!
    -- SELECT * FROM tbl LIMIT 95,18446744073709551615;
    SELECT title FROM books LIMIT 10, 50;
    +-----------------------------------------------------+
    | title                                               | 
    +-----------------------------------------------------+
    | What We Talk About When We Talk About Love: Stories | 
    | Where Im Calling From: Selected Stories             | 
    | White Noise                                         | 
    | Cannery Row                                         | 
    | Oblivion: Stories                                   | 
    | Consider the Lobster                                | 
    | 10% Happier                                         | 
    | fake_book                                           | 
    | Lincoln In The Bardo                                | 
    +-----------------------------------------------------+

    -- # LIKE
    -- % = wildcard, can represent any character including spaces
    SELECT author_fname FROM `books` WHERE author_fname LIKE '%da%';
    +--------------+
    | author_fname | 
    +--------------+
    | Dave         | 
    | Dave         | 
    | Dave         | 
    | David        | 
    | David        | 
    | Dan          | 
    | Freida       | 
    +--------------+

    SELECT author_fname FROM `books` WHERE author_fname LIKE 'da%';
    +--------------+
    | author_fname | 
    +--------------+
    | Dave         | 
    | Dave         | 
    | Dave         | 
    | David        | 
    | David        | 
    | Dan          | 
    +--------------+

    -- '____' four wildcards, each _ wildcard represents one character in length
    SELECT stock_quantity FROM `books` WHERE stock_quantity LIKE '____';
    +----------------+
    | stock_quantity | 
    +----------------+
    | 1000           | 
    +----------------+

    SELECT stock_quantity FROM `books` WHERE stock_quantity LIKE '1__';
    +----------------+
    | stock_quantity | 
    +----------------+
    | 154            | 
    | 104            | 
    | 100            | 
    | 172            | 
    +----------------+

    -- escape character \ looking for %
    SELECT title FROM `books` WHERE title LIKE '%\%%';
    +-------------+
    | title       | 
    +-------------+
    | 10% Happier | 
    +-------------+

    -- escape character \ looking for _
    SELECT title FROM `books` WHERE title LIKE '%\_%';
    +-----------+
    | title     | 
    +-----------+
    | fake_book | 
    +-----------+

    -- # GROUP BY
    -- group by summarizes or aggregates identical data into single rows
    SELECT author_lname, COUNT(*) AS 'number of books by author' FROM `books` GROUP BY author_lname;

    +----------------+---------------------------+
    | author_lname   | number of books by author | 
    +----------------+---------------------------+
    | Carver         | 2                         | 
    | Chabon         | 1                         | 
    | DeLillo        | 1                         | 
    | Eggers         | 3                         | 
    | Foster Wallace | 2                         | 
    | Gaiman         | 3                         | 
    | Harris         | 2                         | 
    | Lahiri         | 2                         | 
    | Saunders       | 1                         | 
    | Smith          | 1                         | 
    | Steinbeck      | 1                         | 
    +----------------+---------------------------+

    SELECT COUNT(*) AS 'number of books by author' FROM `books` GROUP BY author_lname;
    +---------------------------+
    | number of books by author | 
    +---------------------------+
    | 2                         | 
    | 1                         | 
    | 1                         | 
    | 3                         | 
    | 2                         | 
    | 3                         | 
    ...

    SELECT author_fname, author_lname, COUNT(*) AS 'number of books by author' FROM `books` GROUP BY author_lname, author_fname;
    -- group by full authors name to make sure all are accounted for
    +--------------+----------------+---------------------------+
    | author_fname | author_lname   | number of books by author | 
    +--------------+----------------+---------------------------+
    | Raymond      | Carver         | 2                         | 
    | Michael      | Chabon         | 1                         | 
    | Don          | DeLillo        | 1                         | 
    | Dave         | Eggers         | 3                         | 
    | David        | Foster Wallace | 2                         | 
    | Neil         | Gaiman         | 3                         | 
    | Dan          | Harris         | 1                         | 
    | Freida       | Harris         | 1                         | 
    | Jhumpa       | Lahiri         | 2                         | 
    | George       | Saunders       | 1                         | 
    | Patti        | Smith          | 1                         | 
    | John         | Steinbeck      | 1                         | 
    +--------------+----------------+---------------------------+

    SELECT CONCAT('In ', released_year, ' ', COUNT(*), ' book(s) released') AS year FROM books GROUP BY released_year;
    +----------------------------+
    | year                       | 
    +----------------------------+
    | In 1945 1 book(s) released | 
    | In 1981 1 book(s) released | 
    | In 1985 1 book(s) released | 
    | In 1989 1 book(s) released | 
    | In 1996 1 book(s) released | 
    | In 2000 1 book(s) released | 
    | In 2001 3 book(s) released | 
    | In 2003 2 book(s) released | 
    | In 2004 1 book(s) released | 
    | In 2005 1 book(s) released | 
    | In 2010 1 book(s) released | 
    | In 2012 1 book(s) released | 
    | In 2013 1 book(s) released | 
    | In 2014 1 book(s) released | 
    | In 2016 1 book(s) released | 
    | In 2017 1 book(s) released | 
    +----------------------------+

    -- the first book in author wrote
    SELECT author_fname, 
        author_lname,
        MIN(released_year) AS 'year of first book'
    FROM `books`
    GROUP BY author_lname, author_fname;
    +--------------+----------------+--------------------+
    | author_fname | author_lname   | year of first book | 
    +--------------+----------------+--------------------+
    | Raymond      | Carver         | 1981               | 
    | Michael      | Chabon         | 2000               | 
    | Don          | DeLillo        | 1985               | 
    | Dave         | Eggers         | 2001               | 
    | David        | Foster Wallace | 2004               | 
    | Neil         | Gaiman         | 2001               | 
    | Dan          | Harris         | 2014               | 
    | Freida       | Harris         | 2001               | 
    | Jhumpa       | Lahiri         | 1996               | 
    | George       | Saunders       | 2017               | 
    | Patti        | Smith          | 2010               | 
    | John         | Steinbeck      | 1945               | 
    +--------------+----------------+--------------------+

    -- one this book the author wrote, pages
    SELECT
        CONCAT(author_fname, ' ', author_lname) AS author,
        MAX(pages) AS 'longest book'
    FROM books
    GROUP BY author_lname,
            author_fname;
    +----------------------+--------------+
    | author               | longest book | 
    +----------------------+--------------+
    | Raymond Carver       | 526          | 
    | Michael Chabon       | 634          | 
    | Don DeLillo          | 320          | 
    | Dave Eggers          | 504          | 
    | David Foster Wallace | 343          | 
    | Neil Gaiman          | 465          | 
    | Dan Harris           | 256          | 
    | Freida Harris        | 428          | 
    | Jhumpa Lahiri        | 291          | 
    | George Saunders      | 367          | 
    | Patti Smith          | 304          | 
    | John Steinbeck       | 181          | 
    +----------------------+--------------+

    -- SUM() up all the authors pages
    SELECT
        CONCAT(author_fname, ' ', author_lname) AS author,
        SUM(pages) AS 'pages'
    FROM books
    GROUP BY author_lname,
            author_fname;
    +----------------------+-------+
    | author               | pages | 
    +----------------------+-------+
    | Raymond Carver       | 702   | 
    | Michael Chabon       | 634   | 
    | Don DeLillo          | 320   | 
    | Dave Eggers          | 1293  | 
    | David Foster Wallace | 672   | 
    | Neil Gaiman          | 977   | 
    | Dan Harris           | 256   | 
    | Freida Harris        | 428   | 
    | Jhumpa Lahiri        | 489   | 
    | George Saunders      | 367   | 
    | Patti Smith          | 304   | 
    | John Steinbeck       | 181   | 
    +----------------------+-------+

    -- get the average pages per author
    SELECT
        CONCAT(author_fname, ' ', author_lname) AS author,
        AVG(pages) AS 'average book length'
    FROM books
    GROUP BY author_lname,
            author_fname;
    +----------------------+---------------------+
    | author               | average book length | 
    +----------------------+---------------------+
    | Raymond Carver       | 351                 | 
    | Michael Chabon       | 634                 | 
    | Don DeLillo          | 320                 | 
    | Dave Eggers          | 431                 | 
    | David Foster Wallace | 336                 | 
    | Neil Gaiman          | 325.6667            | 
    | Dan Harris           | 256                 | 
    | Freida Harris        | 428                 | 
    | Jhumpa Lahiri        | 244.5               | 
    | George Saunders      | 367                 | 
    | Patti Smith          | 304                 | 
    | John Steinbeck       | 181                 | 
    +----------------------+---------------------+