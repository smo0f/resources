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

    -- order by alias (average)
    SELECT students.first_name, IFNULL(AVG(papers.grade), 0) AS average
    FROM `students` 
    LEFT JOIN `papers`
        ON students.id = papers.student_id
    GROUP BY students.id
    ORDER BY average DESC;
    +------------+---------+
    | first_name | average | 
    +------------+---------+
    | Samantha   | 96      | 
    | Carlos     | 89      | 
    | Caleb      | 67.5    | 
    | Lisa       | 0       | 
    | Raj        | 0       | 
    +------------+---------+

    -- other example (average)
    SELECT series.title, AVG(reviews.rating) AS avg_rating FROM `series`
    INNER JOIN `reviews`
        ON series.id = reviews.series_id
    GROUP BY series.id
    ORDER BY avg_rating;

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

    SELECT COUNT(orders.id) AS 'order count',
        AVG( orders.amount) AS 'average order amount', 
        CONCAT(customers.first_name, ' ', customers.last_name) AS customer
    FROM `orders`, `customers`
    WHERE orders.customer_id = customers.id
    GROUP BY orders.customer_id
    ORDER BY customers.first_name, customers.last_name;
    +-------------+----------------------+----------------+
    | order count | average order amount | customer       | 
    +-------------+----------------------+----------------+
    | 1           | 450.25               | Bette Davis    | 
    | 2           | 67.745               | Boy George     | 
    | 2           | 406.585              | George Michael | 
    +-------------+----------------------+----------------+

    -- # JOINS
    -- https://www.w3schools.com/sql/sql_join.asp
    -- Joins two tables to gether
    -- implicit join, cross join
    SELECT *
    FROM `customers`, `orders`;
    -- output to big

        -- # INNER JOIN
        -- gets all intersecting data, excludes any non-matches
        -- explicit inner join
        -- examples
        SELECT * FROM customers
        JOIN orders -- JOIN Implies INNER JOIN
            ON customers.id = orders.customer_id;
        -- output to big

        SELECT orders.id AS 'order id', 
            orders.customer_id, 
            orders.amount, 
            CONCAT(customers.first_name, ' ', customers.last_name) AS customer,
            customers.id AS 'customer id'
        FROM customers
        INNER JOIN orders
            ON customers.id = orders.customer_id;
        +----------+-------------+--------+----------------+-------------+
        | order id | customer_id | amount | customer       | customer id | 
        +----------+-------------+--------+----------------+-------------+
        | 1        | 1           | 99.99  | Boy George     | 1           | 
        | 2        | 1           | 35.5   | George Michael | 2           | 
        | 3        | 2           | 800.67 | David Bowie    | 3           | 
        | 4        | 2           | 12.5   | Blue Steele    | 4           | 
        | 5        | 5           | 450.25 | Bette Davis    | 5           | 
        +----------+-------------+--------+----------------+-------------+

        -- implicit inner join
        -- examples
        SELECT orders.id AS 'order id', 
            orders.customer_id, 
            orders.amount, 
            CONCAT(customers.first_name, ' ', customers.last_name) AS customer,
            customers.id AS 'customer id'
        FROM `orders`, `customers`
        WHERE orders.customer_id = customers.id
        ORDER BY customers.first_name, customers.last_name;
        +----------+-------------+--------+----------------+-------------+
        | order id | customer_id | amount | customer       | customer id | 
        +----------+-------------+--------+----------------+-------------+
        | 5        | 5           | 450.25 | Bette Davis    | 5           | 
        | 2        | 1           | 35.5   | Boy George     | 1           | 
        | 1        | 1           | 99.99  | Boy George     | 1           | 
        | 4        | 2           | 12.5   | George Michael | 2           | 
        | 3        | 2           | 800.67 | George Michael | 2           | 
        +----------+-------------+--------+----------------+-------------+
        
        SELECT COUNT(orders.id) AS 'order count',
            AVG( orders.amount) AS 'average order amount', 
            CONCAT(customers.first_name, ' ', customers.last_name) AS customer
        FROM `orders`, `customers`
        WHERE orders.customer_id = customers.id
        GROUP BY orders.customer_id
        ORDER BY customers.first_name, customers.last_name;
        +-------------+----------------------+----------------+
        | order count | average order amount | customer       | 
        +-------------+----------------------+----------------+
        | 1           | 450.25               | Bette Davis    | 
        | 2           | 67.745               | Boy George     | 
        | 2           | 406.585              | George Michael | 
        +-------------+----------------------+----------------+

        -- # LEFT JOIN
        -- selects all data from the left table and also shows applicable matches from the right table
        SELECT *
        FROM customers
        LEFT JOIN orders
            ON customers.id = orders.customer_id;
        -- output to big

        -- shows all data from customers even if no join data is available
        -- left = customers right = orders
        SELECT orders.id AS 'order id', 
            orders.customer_id, 
            orders.amount, 
            CONCAT(customers.first_name, ' ', customers.last_name) AS customer,
            customers.id AS 'customer id'
        FROM customers
        LEFT JOIN orders
            ON customers.id = orders.customer_id;
        +----------+-------------+--------+----------------+-------------+
        | order id | customer_id | amount | customer       | customer id | 
        +----------+-------------+--------+----------------+-------------+
        | 1        | 1           | 99.99  | Boy George     | 1           | 
        | 2        | 1           | 35.5   | Boy George     | 1           | 
        | 3        | 2           | 800.67 | George Michael | 2           | 
        | 4        | 2           | 12.5   | George Michael | 2           | 
        | 5        | 5           | 450.25 | Bette Davis    | 5           | 
        | null     | null        | null   | David Bowie    | 3           | 
        | null     | null        | null   | Blue Steele    | 4           | 
        +----------+-------------+--------+----------------+-------------+

        -- why would I do this?
            -- if I wanted to know all the high spending customers and send them a thank you
            -- and if I wanted to know all the customers that haven't bought anything and send them a coupon
            -- example below
        SELECT COUNT(orders.id) AS 'order count',
            IFNULL(AVG(orders.amount), 0) AS 'average order amount',
            IFNULL(SUM(orders.amount), 0)  AS 'total spent',
            CONCAT(customers.first_name, ' ', customers.last_name) AS customer,
            CASE
                WHEN COUNT(orders.id) >= 1 THEN 'thank them'
                ELSE 'send a coupon'
            END AS 'action'
        FROM customers
        LEFT JOIN orders
            ON customers.id = orders.customer_id
        GROUP BY customers.id
        ORDER BY customers.first_name, customers.last_name;
        +-------------+----------------------+-------------+----------------+---------------+
        | order count | average order amount | total spent | customer       | action        | 
        +-------------+----------------------+-------------+----------------+---------------+
        | 1           | 450.25               | 450.25      | Bette Davis    | thank them    | 
        | 0           | 0                    | 0           | Blue Steele    | send a coupon | 
        | 2           | 67.745               | 135.49      | Boy George     | thank them    | 
        | 0           | 0                    | 0           | David Bowie    | send a coupon | 
        | 2           | 406.585              | 813.17      | George Michael | thank them    | 
        +-------------+----------------------+-------------+----------------+---------------+

        -- # RIGHT JOIN
        -- selects all data from the right table and also shows applicable matches from the left table
        -- shows all data from customers even if no join data is available
        -- left = customers right = orders
        SELECT orders.id AS 'order id', 
            orders.customer_id, 
            orders.amount, 
            CONCAT(customers.first_name, ' ', customers.last_name) AS customer,
            customers.id AS 'customer id'
        FROM customers
        RIGHT JOIN orders
            ON customers.id = orders.customer_id;
        +----------+-------------+--------+----------------+-------------+
        | order id | customer_id | amount | customer       | customer id | 
        +----------+-------------+--------+----------------+-------------+
        | 1        | 1           | 99.99  | Boy George     | 1           | 
        | 2        | 1           | 35.5   | Boy George     | 1           | 
        | 3        | 2           | 800.67 | George Michael | 2           | 
        | 4        | 2           | 12.5   | George Michael | 2           | 
        | 5        | 5           | 450.25 | Bette Davis    | 5           | 
        +----------+-------------+--------+----------------+-------------+

        -- # double join
        -- joining three tables together
        -- also referencing tables as aliases
        SELECT s.title, 
            r.rating, 
            CONCAT(rs.first_name, ' ', rs.last_name) AS reviewer
        FROM reviewers AS rs
        INNER JOIN reviews AS r
            ON rs.id = r.series_id
        INNER JOIN series AS s
            ON s.id = r.reviewer_id;
        +----------------------+--------+-----------------+
        | title                | rating | reviewer        | 
        +----------------------+--------+-----------------+
        | Archer               | 8      | Thomas Stoneman | 
        | Arrested Development | 7.5    | Thomas Stoneman | 
        | Bobs Burgers         | 8.5    | Thomas Stoneman | 
        | Bojack Horseman      | 7.7    | Thomas Stoneman | 
        | Breaking Bad         | 8.9    | Thomas Stoneman | 
        | Archer               | 8.1    | Wyatt Skaggs    | 
        | Bojack Horseman      | 6      | Wyatt Skaggs    | 
        | Bobs Burgers         | 8      | Wyatt Skaggs    | 
        | Curb Your Enthusiasm | 8.4    | Wyatt Skaggs    | 
        | Breaking Bad         | 9.9    | Wyatt Skaggs    | 
        | Archer               | 7      | Kimbra Masters  | 
        | Curb Your Enthusiasm | 7.5    | Kimbra Masters  | 
        | Bojack Horseman      | 8      | Kimbra Masters  | 
        | Bobs Burgers         | 7.1    | Kimbra Masters  | 
        | Breaking Bad         | 8      | Kimbra Masters  | 
        | Archer               | 7.5    | Domingo Cortes  | 
        ...

    -- # UNION
    -- UNION, Removes duplicates, combines queries
    -- less efficient because it removes duplicates
    SELECT * FROM users WHERE id >= 5 AND id <= 22
    UNION
    SELECT * FROM users WHERE id >= 0 AND id <= 16 ORDER BY id DESC;
    -- id	username	            created_at
    -- 22	Kenneth64	            2016-12-27T16:48:17.000Z
    -- 21	Rocio33	                2017-01-23T18:51:15.000Z
    -- 20	Delpha.Kihn	            2016-08-31T08:42:30.000Z
    -- 19	Hailee26	            2017-04-30T00:53:40.000Z
    -- 18	Odessa2	                2016-10-22T00:16:56.000Z
    -- 17	Norbert_Carroll35	    2017-02-07T05:05:43.000Z
    -- 16	Annalise.McKenzie16	    2016-08-03T03:32:46.000Z
    -- 15	Billy52	                2016-10-05T20:10:20.000Z
    -- 14	Jaclyn81	            2017-02-07T06:29:16.000Z
    -- 13	Alexandro35	            2017-03-29T23:09:02.000Z
    -- 12	Dereck65	            2017-01-19T08:34:14.000Z
    -- 11	Justina.Gaylord27	    2017-05-04T22:32:16.000Z
    -- 10	Presley_McClure	        2016-08-07T22:25:49.000Z
    -- 9	Gus93	                2016-06-25T01:36:31.000Z
    -- 8	Tabitha_Schamberger11	2016-08-20T08:19:46.000Z
    -- 7	Kasandra_Homenick	    2016-12-12T13:50:08.000Z
    -- 6	Travon.Waters	        2017-04-30T19:26:14.000Z
    -- 5	Aniya_Hackett	        2016-12-07T08:04:39.000Z
    -- 4	Arely_Bogan63	        2016-08-13T07:28:43.000Z
    -- 3	Harley_Lind18	        2017-02-21T18:12:33.000Z
    -- 2	Andre_Purdy85	        2017-04-02T23:11:21.000Z
    -- 1	Kenton_Kirlin	        2017-02-17T01:22:11.000Z

    -- SQL injection using the union
    -- https://www.udemy.com/course/mysql-and-sql-from-beginner-to-advanced/learn/lecture/5054228#overview
    SELECT title, authorName, imageName, createdDate FROM posts 
    UNION (SELECT 1,2,3,4 FROM dual);

    SELECT title, authorName, imageName, createdDate FROM posts WHERE title Like '%ani%'
    UNION (SELECT TABLE_NAME, TABLE_SCHEMA, 3, 4 FROM information_schema.tables);

    SELECT title, authorName, imageName, createdDate FROM posts WHERE title Like '%ani%'
    UNION (SELECT username, emailAddress, phoneNumber, 'password' FROM users);

    -- works in phpMyadmin
    SELECT title, authorName, imageName, createdDate FROM posts WHERE title Like '%ani%'
    UNION (SELECT username, emailAddress, phoneNumber, hashPass FROM users);

    -- # UNION ALL
    -- Union All, dose not removes duplicates, combines queries
    SELECT * FROM users WHERE id >= 5 AND id <= 22
    UNION ALL
    SELECT * FROM users WHERE id >= 0 AND id <= 16 ORDER BY id DESC;
    -- id	username                created_at
    -- 22   Kenneth64               2016-12-27T16:48:17.000Z
    -- 21   Rocio33                 2017-01-23T18:51:15.000Z
    -- 20   Delpha.Kihn             2016-08-31T08:42:30.000Z
    -- 19   Hailee26                2017-04-30T00:53:40.000Z
    -- 18   Odessa2                 2016-10-22T00:16:56.000Z
    -- 17   Norbert_Carroll35       2017-02-07T05:05:43.000Z
    -- 16   Annalise.McKenzie16     2016-08-03T03:32:46.000Z
    -- 16   Annalise.McKenzie16     2016-08-03T03:32:46.000Z
    -- 15   Billy52                 2016-10-05T20:10:20.000Z
    -- 15   Billy52                 2016-10-05T20:10:20.000Z
    -- 14   Jaclyn81                2017-02-07T06:29:16.000Z
    -- 14   Jaclyn81                2017-02-07T06:29:16.000Z
    -- 13   Alexandro35             2017-03-29T23:09:02.000Z
    -- 13   Alexandro35             2017-03-29T23:09:02.000Z
    -- 12   Dereck65                2017-01-19T08:34:14.000Z
    -- 12   Dereck65                2017-01-19T08:34:14.000Z
    -- 11   Justina.Gaylord27       2017-05-04T22:32:16.000Z
    -- 11   Justina.Gaylord27       2017-05-04T22:32:16.000Z
    -- 10   Presley_McClure         2016-08-07T22:25:49.000Z
    -- 10   Presley_McClure         2016-08-07T22:25:49.000Z
    -- 9    Gus93                   2016-06-25T01:36:31.000Z
    -- 9    Gus93                   2016-06-25T01:36:31.000Z
    -- 8    Tabitha_Schamberger11   2016-08-20T08:19:46.000Z
    -- 8    Tabitha_Schamberger11   2016-08-20T08:19:46.000Z
    -- 7    Kasandra_Homenick       2016-12-12T13:50:08.000Z
    -- 7    Kasandra_Homenick       2016-12-12T13:50:08.000Z
    -- 6    Travon.Waters           2017-04-30T19:26:14.000Z
    -- 6    Travon.Waters           2017-04-30T19:26:14.000Z
    -- 5    Aniya_Hackett           2016-12-07T08:04:39.000Z
    -- 5    Aniya_Hackett           2016-12-07T08:04:39.000Z
    -- 4    Arely_Bogan63           2016-08-13T07:28:43.000Z
    -- 3    Harley_Lind18           2017-02-21T18:12:33.000Z
    -- 2    Andre_Purdy85           2017-04-02T23:11:21.000Z
    -- 1    Kenton_Kirlin           2017-02-17T01:22:11.000Z

    -- # PROJECT
    -- TODO: how to do???
    PROJECT username FROM users;

    -- INTERSECT
    -- TODO: how to do???
    SELECT id FROM users WHERE id >= 5 AND id <= 22
    INTERSECT
    SELECT id FROM users WHERE id >= 0 AND id <= 16;

    -- TODO: how to do???
    DIFFERENCE
    
