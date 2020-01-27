CREATE DATABASE pastry_shop;


CREATE TABLE pastries (
    id int(10) unsigned NOT NULL AUTO_INCREMENT,
    name varchar(50) DEFAULT NULL,
    quantity int(10) unsigned NOT NULL DEFAULT '0',
    PRIMARY KEY (id)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

INSERT INTO pastries (name, quantity)
VALUES ('soso2', 2234);

SELECT * FROM pastries;


INSERT INTO pastries (name, quantity)
VALUES ('soso2', 3),
('sgogo', 2),
('ddddd', 34),
('sosffffo2', 6),
('soggggggso2', 7),
('soshhhhhhho2', 8);

SELECT post_id, post_title, post_date, post_image  FROM `posts`;

SELECT comment_author, comment_date FROM `comments`;

SELECT cat_id, cat_title FROM `categories`;

SELECT post_id, post_title, post_status FROM `posts`;

INSERT INTO posts (post_title, post_date)
VALUES ("soso", '914892308491');





CREATE DATABASE shop;

USE shop; 

CREATE TABLE employees (
    id int(10) unsigned NOT NULL AUTO_INCREMENT,
    first_name varchar(50) NOT NULL,
    last_name varchar(50) NOT NULL,
    middle_name varchar(50) DEFAULT NULL,
    age tinyint unsigned NOT Null,
    current_Status varchar(50) NOT Null DEFAULT "Employed",    
    PRIMARY KEY (id)
);

DESC employees;

INSERT INTO employees (first_name, last_name, age)
VALUES ('Isoso', 'Yong', 44),
('Ping', 'Yong', 55),
('Gon', 'Goodson', 33),
('Done', 'Yong', 22),
('Soso', 'Yong', 11),
('Gogo', 'Yong', 66);

SELECT * FROM employees;

SELECT *
FROM table_name
WHERE column_name = 'some_text'
    AND column_name = 'some_text'
    OR column_name = some_number
ORDER BY column_name ASC;

UPDATE posts
SET post_title = 'soso'
    post_image = 'dkslkjadlks.png'
    WHERE id = 33;


UPDATE `employees`
SET first_name = 'skjadkljfaslkjfk'
    age = 44
WHERE id = 55;

DELETE FROM `employees`
WHERE column_name = column_value;


UPDATE `employees`
SET id = 22
    first_name = 'klsdjkjaskl'
WHERE id = 22 LIMIT 1;

DELETE FROM `employees`
WHERE id = 33 LIMIT 1;

SELECT * FROM `employees`;

DELETE FROM `employees`
WHERE id = 5 LIMIT 1;

CREATE DATABASE shirts_db;

USE shirts_db;

SELECT database();

CREATE TABLE shirts (
    shirt_id INT unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
    article varchar(100),
    color varchar(100),
    shirt_size varchar(100),
    last_worn INT
);

DESC shirts;

INSERT INTO `shirts` (article, color, shirt_size, last_worn)
VALUES ('t-shirt', 'white', 'S', 10),
('t-shirt', 'green', 'S', 200),
('polo shirt', 'black', 'M', 10),
('tank top', 'blue', 'S', 50),
('t-shirt', 'pink', 'S', 0),
('polo shirt', 'red', 'M', 5),
('tank top', 'white', 'S', 200),
('tank top', 'blue', 'M', 15);

SELECT * FROM `shirts`;

INSERT INTO `shirts` (article, color, shirt_size, last_worn)
VALUES ('polo shirt', 'purple', 'M', 50 );

SELECT article, color FROM `shirts`;

SELECT article, color, last_worn, shirt_size
FROM `shirts`
WHERE shirt_size = 'm';

SELECT *
FROM `shirts`
WHERE article = 'polo shirt';

UPDATE `shirts`
SET shirt_size = 'L'
WHERE article = 'polo shirt';

SELECT *
FROM `shirts`
WHERE shirt_id = 8;

UPDATE `shirts`
SET last_worn = 0
WHERE last_worn = 15 LIMIT 1;

SELECT *
FROM `shirts`
WHERE color = 'off white';

UPDATE `shirts`
SET color = 'off white',
    shirt_size = 'XS'
WHERE color = 'white';

SELECT *
FROM `shirts`;

DELETE FROM `shirts`
WHERE last_worn = 200;

SELECT *
FROM `shirts`
WHERE article = 'tank top';

DELETE FROM `shirts`
WHERE article = 'tank top';

DELETE FROM `shirts`;

SHOW TABLES;

DROP TABLE IF EXISTS shirts;

SHOW TABLES;

SHOW DATABASES;

DROP DATABASE shop;
DROP DATABASE pastry_shop;
DROP DATABASE shirts_db;


CREATE DATABASE book_shop;

USE book_shop;

CREATE TABLE books 
    (
        book_id INT NOT NULL AUTO_INCREMENT,
        title VARCHAR(100),
        author_fname VARCHAR(100),
        author_lname VARCHAR(100),
        released_year INT,
        stock_quantity INT,
        pages INT,
        PRIMARY KEY(book_id)
    );
 
INSERT INTO books (title, author_fname, author_lname, released_year, stock_quantity, pages)
VALUES
('The Namesake', 'Jhumpa', 'Lahiri', 2003, 32, 291),
('Norse Mythology', 'Neil', 'Gaiman',2016, 43, 304),
('American Gods', 'Neil', 'Gaiman', 2001, 12, 465),
('Interpreter of Maladies', 'Jhumpa', 'Lahiri', 1996, 97, 198),
('A Hologram for the King: A Novel', 'Dave', 'Eggers', 2012, 154, 352),
('The Circle', 'Dave', 'Eggers', 2013, 26, 504),
('The Amazing Adventures of Kavalier & Clay', 'Michael', 'Chabon', 2000, 68, 634),
('Just Kids', 'Patti', 'Smith', 2010, 55, 304),
('A Heartbreaking Work of Staggering Genius', 'Dave', 'Eggers', 2001, 104, 437),
('Coraline', 'Neil', 'Gaiman', 2003, 100, 208),
('What We Talk About When We Talk About Love: Stories', 'Raymond', 'Carver', 1981, 23, 176),
("Where I'm Calling From: Selected Stories", 'Raymond', 'Carver', 1989, 12, 526),
('White Noise', 'Don', 'DeLillo', 1985, 49, 320),
('Cannery Row', 'John', 'Steinbeck', 1945, 95, 181),
('Oblivion: Stories', 'David', 'Foster Wallace', 2004, 172, 329),
('Consider the Lobster', 'David', 'Foster Wallace', 2005, 92, 343);

DESC books;
 
SELECT * FROM books;

SELECT CONCAT(author_fname, ' ',  author_lname) AS 'full name'
FROM `books`;

SELECT CONCAT_WS(' - ', title, author_fname, author_lname) AS book
FROM `books`;

SELECT SUBSTRING('hello world', 1, 4);

SELECT CONCAT(SUBSTRING(title, 1, 10), '...') AS 'Short Title'  FROM `books`;

SELECT REPLACE('Hello World', 'hell', '%$#@') AS 'New Word';

SELECT REPLACE(title, 'e', '3') AS 'new titles' FROM `books`;

SELECT REVERSE('Hello World');

SELECT title, CHAR_LENGTH(title) AS 'title length' FROM `books`;

SELECT UPPER('Hello World');

SELECT UPPER(REVERSE('Hello World'));

SELECT REPLACE(title, ' ', '->') AS title FROM `books`;

SELECT author_lname AS forwards, 
    REVERSE(author_lname) AS backwards 
FROM `books`;

SELECT UPPER(CONCAT(author_fname, ' ', author_lname)) AS 'full name in caps' FROM `books`;

SELECT CONCAT(title, ' was released in ', released_year) AS blurb FROM `books`;

SELECT title, CHAR_LENGTH(title) AS 'character count' FROM `books`;

SELECT CONCAT(SUBSTRING(title, 1, 10), '...') AS 'short title',
    CONCAT_WS(',', author_lname, author_fname) AS author,  
    CONCAT(stock_quantity, ' in stock') AS 'quantity'
FROM `books`;

INSERT INTO books
    (title, author_fname, author_lname, released_year, stock_quantity, pages)
    VALUES ('10% Happier', 'Dan', 'Harris', 2014, 29, 256), 
           ('fake_book', 'Freida', 'Harris', 2001, 287, 428),
           ('Lincoln In The Bardo', 'George', 'Saunders', 2017, 1000, 367);
 
 
SELECT title FROM books;

SELECT DISTINCT author_lname FROM books;

SELECT DISTINCT CONCAT(author_fname, ' ', author_lname) AS 'full name' FROM books;


SELECT title FROM `books` WHERE title LIKE '%stories%';

SELECT title, pages FROM `books` WHERE pages ORDER BY 2 DESC LIMIT 1;

SELECT CONCAT_WS(' - ', title, released_year) AS summary
FROM `books`
ORDER BY released_year DESC LIMIT 3;

SELECT title, author_lname FROM `books` WHERE author_lname LIKE '% %';

SELECT title, released_year, stock_quantity
FROM `books`
ORDER BY stock_quantity, title LIMIT 3;

SELECT title, author_lname FROM `books` ORDER BY author_lname, title;

SELECT UPPER(
        CONCAT(
            'My favorite author is ', 
            author_fname, 
            ' ', 
            author_lname, 
            '!'
        )
) AS yell
FROM `books` ORDER BY author_lname;

SELECT COUNT(*) FROM `books`;

SELECT released_year, COUNT(*) FROM `books` GROUP BY released_year;

SELECT SUM(stock_quantity) FROM `books`;

SELECT CONCAT(author_fname, ' ', author_lname) AS author, AVG(released_year) FROM `books` GROUP BY author_lname, author_fname;

SELECT CONCAT(author_fname, ' ', author_lname) AS author, pages FROM books 
ORDER BY pages DESC LIMIT 1;

SELECT released_year AS year, COUNT(*) AS '# books', AVG(pages) AS 'avg pages'  FROM `books` GROUP BY released_year;

SELECT title, released_year
FROM `books`
WHERE released_year < 1980
ORDER BY released_year;

SELECT title, CONCAT(author_fname, ' ', author_lname) AS author
FROM `books`
WHERE author_lname = 'Eggers'
    OR author_lname = 'Chabon'
ORDER BY author_lname ASC;

SELECT title, author_lname 
FROM `books` 
WHERE author_lname IN ('Eggers','Chabon')
ORDER BY author_lname ASC;

SELECT title, author_lname, released_year
FROM `books`
WHERE author_lname = 'Lahiri'
    AND released_year > 2000
ORDER BY released_year;

SELECT title, pages 
FROM `books`
WHERE pages BETWEEN 100 AND 200
ORDER BY pages;

SELECT title, author_lname 
FROM `books`     
WHERE author_lname LIKE 'c%'
    OR author_lname LIKE 's%';

SELECT title, author_lname,
    CASE
        WHEN title LIKE '%stories%' THEN 'Short Story'
        WHEN title IN ('Just Kids', 'A Heartbreaking Work of Staggering Genius') THEN 'Memoir'
        ELSE 'Novel'
    END AS type
FROM `books`;

SELECT title, author_lname,
    CASE
        WHEN COUNT(*) > 1 THEN CONCAT(COUNT(*), ' books')
        ELSE '1 book'
    END AS 'count'
FROM `books`
GROUP BY author_lname, author_fname;


CREATE DATABASE customers_and_orders;

USE customers_and_orders;

CREATE TABLE customers(
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE orders(
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE,
    amount DECIMAL(8,2),
    customer_id INT,
    FOREIGN KEY(customer_id) REFERENCES customers(id)
);

INSERT INTO customers (first_name, last_name, email) 
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');
       
INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016/02/10', 99.99, 1),
       ('2017/11/11', 35.50, 1),
       ('2014/12/12', 800.67, 2),
       ('2015/01/03', 12.50, 2),
       ('1999/04/11', 450.25, 5);

SELECT * FROM `customers`;

SELECT * 
FROM `customers`
INNER JOIN `orders`
    ON customers.id = orders.customer_id;

SELECT * 
FROM `customers`
LEFT JOIN `orders`
    ON customers.id = orders.customer_id;

SELECT * 
FROM `customers`
RIGHT JOIN `orders`
    ON customers.id = orders.customer_id; 










CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100)
);
 
 
CREATE TABLE papers (
    title VARCHAR(100),
    grade INT,
    student_id INT,
    FOREIGN KEY (student_id) 
        REFERENCES students(id)
        ON DELETE CASCADE
);

INSERT INTO students (first_name) VALUES 
('Caleb'), 
('Samantha'), 
('Raj'), 
('Carlos'), 
('Lisa');
 
INSERT INTO papers (student_id, title, grade ) VALUES
(1, 'My First Book Report', 60),
(1, 'My Second Book Report', 75),
(2, 'Russian Lit Through The Ages', 94),
(2, 'De Montaigne and The Art of The Essay', 98),
(4, 'Borges and Magical Realism', 89);

SHOW TABLES;

SELECT * FROM students;
SELECT * FROM `students`;

SELECT * FROM `papers`;

SELECT students.first_name, papers.title, papers.grade
FROM `students`
INNER JOIN `papers`
    ON students.id = papers.student_id
ORDER BY papers.grade DESC;

SELECT students.first_name, papers.title, papers.grade
FROM `students`, `papers`
WHERE students.id = papers.student_id
ORDER BY papers.grade DESC;

SELECT students.first_name, papers.title, papers.grade
FROM `students`
LEFT JOIN `papers`
    ON students.id = papers.student_id;

SELECT students.first_name, IFNULL(papers.title, 'Missing') AS title, IFNULL(papers.grade, 0) AS grade
FROM `students`
LEFT JOIN `papers`
    ON students.id = papers.student_id;

SELECT students.first_name, IFNULL(AVG(papers.grade), 0) AS average
FROM `students` 
LEFT JOIN `papers`
    ON students.id = papers.student_id
GROUP BY students.id
ORDER BY average DESC;

SELECT students.first_name, 
IFNULL(AVG(papers.grade), 0) AS average,
CASE
    WHEN AVG(papers.grade) IS NULL THEN 'FAILING'
    WHEN AVG(papers.grade) >= 75 THEN 'PASSING'
    ELSE 'FAILING'
END AS 'passing_status'
FROM `students` 
LEFT JOIN `papers`
    ON students.id = papers.student_id
GROUP BY students.id
ORDER BY average DESC;



CREATE DATABASE tv_review_app;

USE tv_review_app;

CREATE TABLE reviewers (
    id int(10) unsigned NOT NULL AUTO_INCREMENT,
    first_name varchar(100) DEFAULT NULL,
    last_name varchar(100) DEFAULT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE series (
    id int(10) unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
    title varchar(100),
    released_year YEAR(4),
    genre varchar(100)
);

SHOW TABLES;

INSERT INTO series (title, released_year, genre) VALUES
    ('Archer', 2009, 'Animation'),
    ('Arrested Development', 2003, 'Comedy'),
    ("Bob's Burgers", 2011, 'Animation'),
    ('Bojack Horseman', 2014, 'Animation'),
    ("Breaking Bad", 2008, 'Drama'),
    ('Curb Your Enthusiasm', 2000, 'Comedy'),
    ("Fargo", 2014, 'Drama'),
    ('Freaks and Geeks', 1999, 'Comedy'),
    ('General Hospital', 1963, 'Drama'),
    ('Halt and Catch Fire', 2014, 'Drama'),
    ('Malcolm In The Middle', 2000, 'Comedy'),
    ('Pushing Daisies', 2007, 'Comedy'),
    ('Seinfeld', 1989, 'Comedy'),
    ('Stranger Things', 2016, 'Drama');
 
 
INSERT INTO reviewers (first_name, last_name) VALUES
    ('Thomas', 'Stoneman'),
    ('Wyatt', 'Skaggs'),
    ('Kimbra', 'Masters'),
    ('Domingo', 'Cortes'),
    ('Colt', 'Steele'),
    ('Pinkie', 'Petit'),
    ('Marlon', 'Crafford');


SELECT * FROM `reviewers`;
SELECT * FROM `series`;



CREATE TABLE reviews (
    id int(10) unsigned NOT NULL AUTO_INCREMENT,
    rating decimal(2, 1),
    series_id int(10) unsigned NOT NULL,
    reviewer_id int(10) unsigned NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY(series_id) REFERENCES series(id),
    FOREIGN KEY(reviewer_id) REFERENCES reviewers(id)
);

INSERT INTO reviews(series_id, reviewer_id, rating) VALUES
    (1,1,8.0),(1,2,7.5),(1,3,8.5),(1,4,7.7),(1,5,8.9),
    (2,1,8.1),(2,4,6.0),(2,3,8.0),(2,6,8.4),(2,5,9.9),
    (3,1,7.0),(3,6,7.5),(3,4,8.0),(3,3,7.1),(3,5,8.0),
    (4,1,7.5),(4,3,7.8),(4,4,8.3),(4,2,7.6),(4,5,8.5),
    (5,1,9.5),(5,3,9.0),(5,4,9.1),(5,2,9.3),(5,5,9.9),
    (6,2,6.5),(6,3,7.8),(6,4,8.8),(6,2,8.4),(6,5,9.1),
    (7,2,9.1),(7,5,9.7),
    (8,4,8.5),(8,2,7.8),(8,6,8.8),(8,5,9.3),
    (9,2,5.5),(9,3,6.8),(9,4,5.8),(9,6,4.3),(9,5,4.5),
    (10,5,9.9),
    (13,3,8.0),(13,4,7.2),
    (14,2,8.5),(14,3,8.9),(14,4,8.9);

SELECT series.title, reviews.rating FROM `series`
INNER JOIN `reviews`
    ON series.id = reviews.series_id
ORDER BY reviews.rating DESC;

SELECT series.title, AVG(reviews.rating) AS avg_rating FROM `series`
INNER JOIN `reviews`
    ON series.id = reviews.series_id
GROUP BY series.id
ORDER BY avg_rating;

SELECT reviewers.first_name, reviewers.last_name, reviews.rating
FROM `reviewers`
INNER JOIN `reviews`
    ON reviewers.id = reviews.reviewer_id;

SELECT series.title AS unreviewed_series
FROM `series`
LEFT JOIN `reviews`
    ON series.id = reviews.series_id
WHERE reviews.rating IS NULL;

SELECT series.genre, ROUND(AVG(reviews.rating), 2) AS avg_rating
FROM `series`
INNER JOIN `reviews`
    ON series.id = reviews.series_id
GROUP BY series.genre;

SELECT reviewers.first_name, 
    reviewers.last_name, 
    COUNT(reviews.rating) AS COUNT,
    IFNULL(MIN(reviews.rating), 0) AS MIN,
    IFNULL(MAX(reviews.rating), 0) AS MAX,
    IFNULL(AVG(reviews.rating), 0) AS AVG,
    CASE
        WHEN reviews.rating IS NOT NULL THEN 'ACTIVE'
        ELSE 'INACTIVE'
    END AS 'STATUS'
FROM `reviewers`
LEFT JOIN `reviews`
    ON reviewers.id = reviews.reviewer_id
GROUP BY reviewers.id;

SELECT reviewers.first_name, 
    reviewers.last_name, 
    COUNT(reviews.rating) AS COUNT,
    IFNULL(MIN(reviews.rating), 0) AS MIN,
    IFNULL(MAX(reviews.rating), 0) AS MAX,
    IFNULL(AVG(reviews.rating), 0) AS AVG,
    IF(reviews.rating IS NOT NULL, 'ACTIVE', 'INACTIVE') AS 'STATUS'
FROM `reviewers`
LEFT JOIN `reviews`
    ON reviewers.id = reviews.reviewer_id
GROUP BY reviewers.id;

SELECT s.title, r.rating, CONCAT(rs.first_name, ' ', rs.last_name) AS reviewer
FROM `reviewers` AS rs
INNER JOIN `reviews` AS r
    ON rs.id = r.series_id
INNER JOIN `series` AS s
    ON s.id = r.reviewer_id;



SHOW TABLES;
DESCRIBE comments;
DESCRIBE follows;
DESCRIBE likes;
DESCRIBE photo_tags;
DESCRIBE photos;

ALTER TABLE grades
    MODIFY date DATE NOT NULL DEFAULT "0001-01-01";

    CREATE TABLE table_name (
        id int(10) unsigned NOT NULL AUTO_INCREMENT,
        column_name1 data_type,
        PRIMARY KEY (id),
        KEY column_name (column_name),
        FOREIGN KEY(column_name) REFERENCES table_name(column_name) ON DELETE CASCADE
    ) ENGINE=MyISAM DEFAULT CHARSET=latin1;





    CREATE TABLE table_name (
        coupon_id int(10) unsigned NOT NULL AUTO_INCREMENT,
        corp_id int(10) unsigned NOT NULL DEFAULT '1',
        coupon_amount decimal(5,2) NOT NULL DEFAULT 0.00,
        coupon_code varchar(50) DEFAULT NULL,
        cust_list text DEFAULT NULL,
        limit_cust tinyint(1) unsigned NOT NULL DEFAULT '0',
        PRIMARY KEY (id),
        KEY corp_id (corp_id)
    ) ENGINE=MyISAM DEFAULT CHARSET=latin1;


    SELECT * FROM `users`;

    CREATE DATABASE db_name;

    SHOW CREATE TABLE posts;
    SHOW COLUMNS FROM `posts`;


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
