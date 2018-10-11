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

