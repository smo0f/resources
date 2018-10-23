-- @ challenge question one
-- want to reward our users who have been around the longest
-- find the five oldest users
SELECT *
FROM `users`
ORDER BY created_at LIMIT 5;
+----+------------------+--------------------------+
| id | username         | created_at               | 
+----+------------------+--------------------------+
| 80 | Darby_Herzog     | Fri May 06 2016 00:14:21 | 
| 67 | Emilio_Bernier52 | Fri May 06 2016 13:04:30 | 
| 63 | Elenor88         | Sun May 08 2016 01:30:41 | 
| 95 | Nicole71         | Mon May 09 2016 17:30:22 | 
| 38 | Jordyn.Jacobson2 | Sat May 14 2016 07:56:26 | 
+----+------------------+--------------------------+

-- @ challenge question two
-- what day of the week do most users register on
-- we need to figure out what day to schedule our ad campaign
SELECT DATE_FORMAT(created_at, '%W the %D, %M %Y') AS date, 
    DAYNAME(created_at) AS day, 
    COUNT(*) AS count
FROM `users`
GROUP BY day
ORDER BY count DESC;
+----------------------------------+-----------+-------+
| date                             | day       | count | 
+----------------------------------+-----------+-------+
| Sunday the 2nd, April 2017       | Sunday    | 16    | 
| Thursday the 16th, February 2017 | Thursday  | 16    | 
| Friday the 24th, June 2016       | Friday    | 15    | 
| Tuesday the 21st, February 2017  | Tuesday   | 14    | 
| Monday the 12th, December 2016   | Monday    | 14    | 
| Wednesday the 7th, December 2016 | Wednesday | 13    | 
| Saturday the 13th, August 2016   | Saturday  | 12    | 
+----------------------------------+-----------+-------+

-- @ challenge question three
-- we want to target our inactive users with an e-mail campaign
-- find the users who have never posted a photo
SELECT username, DATE_FORMAT(users.created_at, '%M %Y') AS date, COUNT(photos.user_id) AS count
FROM `users`
LEFT JOIN `photos`
    ON users.id = photos.user_id
WHERE photos.user_id IS NULL
GROUP BY users.id;
+---------------------+----------------+-------+
| username            | date           | count | 
+---------------------+----------------+-------+
| Aniya_Hackett       | December 2016  | 0     | 
| Kasandra_Homenick   | December 2016  | 0     | 
| Jaclyn81            | February 2017  | 0     | 
| Rocio33             | January 2017   | 0     | 
| Maxwell.Halvorson   | April 2017     | 0     | 
| Tierra.Trantow      | October 2016   | 0     | 
| Pearl7              | July 2016      | 0     | 
| Ollie_Ledner37      | August 2016    | 0     | 
| Mckenna17           | July 2016      | 0     | 
| David.Osinski47     | February 2017  | 0     | 
| Morgan.Kassulke     | October 2016   | 0     | 
| Linnea59            | February 2017  | 0     | 
| Duane60             | December 2016  | 0     | 
| Julien_Schmidt      | February 2017  | 0     | 
| Mike.Auer39         | July 2016      | 0     | 
| Franco_Keebler64    | November 2016  | 0     | 
| Nia_Haag            | May 2016       | 0     | 
| Hulda.Macejkovic    | January 2017   | 0     | 
| Leslie67            | September 2016 | 0     | 
| Janelle.Nikolaus81  | July 2016      | 0     | 
| Darby_Herzog        | May 2016       | 0     | 
| Esther.Zulauf61     | January 2017   | 0     | 
| Bartholome.Bernhard | November 2016  | 0     | 
| Jessyca_West        | September 2016 | 0     | 
| Esmeralda.Mraz57    | March 2017     | 0     | 
| Bethany20           | June 2016      | 0     | 
+---------------------+----------------+-------+

-- or
-- solution answer
SELECT username
FROM users
LEFT JOIN photos
    ON users.id = photos.user_id
WHERE photos.id IS NULL;
+---------------------+
| username            | 
+---------------------+
| Aniya_Hackett       | 
| Kasandra_Homenick   | 
| Jaclyn81            | 
| Rocio33             | 
| Maxwell.Halvorson   | 
| Tierra.Trantow      | 
| Pearl7              | 
| Ollie_Ledner37      | 
| Mckenna17           | 
| David.Osinski47     | 
| Morgan.Kassulke     | 
| Linnea59            | 
| Duane60             | 
| Julien_Schmidt      | 
| Mike.Auer39         | 
| Franco_Keebler64    | 
| Nia_Haag            | 
| Hulda.Macejkovic    | 
| Leslie67            | 
| Janelle.Nikolaus81  | 
| Darby_Herzog        | 
| Esther.Zulauf61     | 
| Bartholome.Bernhard | 
| Jessyca_West        | 
| Esmeralda.Mraz57    | 
| Bethany20           | 
+---------------------+
-- count
SELECT COUNT(*) AS count
FROM `users`
LEFT JOIN `photos`
    ON users.id = photos.user_id
WHERE photos.user_id IS NULL;
+-------+
| count | 
+-------+
| 26    | 
+-------+

-- @ challenge question four
-- We are running a competition to see who can get the most likes on a single photo
-- Who won?
SELECT users.id AS 'user id', 
    users.username, 
    COUNT(photo_id) AS 'number of likes', 
    photos.id AS 'photo id', 
    photos.image_url AS 'photo url'
FROM `users`
INNER JOIN `photos`
    ON users.id = photos.user_id
INNER JOIN `likes`
    ON photos.id = likes.photo_id
GROUP BY photos.id
ORDER BY COUNT(photo_id) DESC;
+---------+-----------------------+-----------------+----------+------------------------+
| user id | username              | number of likes | photo id | photo url              | 
+---------+-----------------------+-----------------+----------+------------------------+
| 52      | Zack_Kemmer93         | 48              | 145      | https://jarret.name    | 
| 46      | Malinda_Streich       | 43              | 127      | https://celestine.name | 
| 65      | Adelle96              | 43              | 182      | https://dorcas.biz     | 
| 44      | Seth46                | 42              | 123      | http://shannon.org     | 
| 20      | Delpha.Kihn           | 41              | 61       | https://dejon.name     | 
| 55      | Meggie_Doyle          | 41              | 147      | https://adela.com      | 
| 10      | Presley_McClure       | 41              | 30       | http://kenny.com       | 
| 16      | Annalise.McKenzie16   | 41              | 52       | https://hershel.com    | 
| 72      | Kathryn80             | 41              | 192      | https://anahi.info     | 
| 100     | Javonte83             | 41              | 256      | https://kaela.name     | 
| 63      | Elenor88              | 41              | 174      | https://delbert.net    |
...

-- or video solution
SELECT 
    username,
    photos.id,
    photos.image_url, 
    COUNT(*) AS total
FROM photos
INNER JOIN likes
    ON likes.photo_id = photos.id
INNER JOIN users
    ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total DESC
LIMIT 1;
+---------------+-----+---------------------+-------+
| username      | id  | image_url           | total | 
+---------------+-----+---------------------+-------+
| Zack_Kemmer93 | 145 | https://jarret.name | 48    | 
+---------------+-----+---------------------+-------+

-- @ challenge question five
-- Our investors want to know
-- How many times does the average user post
-- ! didn't get it
-- solution from video
SELECT 
    (SELECT Count(*) FROM photos) / (SELECT Count(*) FROM users) AS avg;
+------+
| avg  | 
+------+
| 2.57 | 
+------+

-- other examples, not mine
SELECT
    (
        COUNT(photos.id)/
        COUNT(DISTINCT username)   
    ) AS 'AVERAGE NUMBER OF POST PER USER'
FROM users
LEFT JOIN photos
    ON users.id = photos.user_id;
+---------------------------------+
| AVERAGE NUMBER OF POST PER USER | 
+---------------------------------+
| 2.57                            | 
+---------------------------------+

-- other
SELECT
    (
        COUNT(photos.id)/
        COUNT(DISTINCT users.id)    
    ) AS 'AVERAGE NUMBER OF POST PER USER'
FROM users
LEFT JOIN photos
    ON users.id = photos.user_id;
+---------------------------------+
| AVERAGE NUMBER OF POST PER USER | 
+---------------------------------+
| 2.57                            | 
+---------------------------------+

-- Average posts per user of those who post, I think
SELECT COUNT(DISTINCT user_id) AS 'Users that have post',  
    COUNT(id) AS 'photo count', 
    (COUNT(id) / COUNT(DISTINCT user_id)) AS 'avg post per user'
FROM `photos`;
+----------------------+-------------+-------------------+
| Users that have post | photo count | avg post per user | 
+----------------------+-------------+-------------------+
| 74                   | 257         | 3.473             | 
+----------------------+-------------+-------------------+

-- @ challenge question six
-- a brand wants to know which hashtags to use in a post
-- what are the top five most commonly used hash tags 
SELECT COUNT(photo_tags.tag_id) AS count, tags.tag_name
FROM `photo_tags`
INNER JOIN `tags`
    ON photo_tags.tag_id = tags.id
GROUP BY photo_tags.tag_id
ORDER BY count DESC
LIMIT 5;
+-------+----------+
| count | tag_name | 
+-------+----------+
| 59    | smile    | 
| 42    | beach    | 
| 39    | party    | 
| 38    | fun      | 
| 24    | lol      | 
+-------+----------+

-- @ challenge question seven
-- we have a small problem with bots on our site
-- find users who have liked every single photo on the site
SELECT users.username, COUNT(likes.user_id) AS count
FROM users
INNER JOIN likes
    ON likes.user_id = users.id
-- WHERE  COUNT(likes.user_id) = (SELECT COUNT(*) FROM `photos`)
GROUP BY likes.user_id
ORDER BY count DESC;
+-----------------------+-------+
| username              | count | 
+-----------------------+-------+
| Jaclyn81              | 257   | 
| Duane60               | 257   | 
| Leslie67              | 257   | 
| Janelle.Nikolaus81    | 257   | 
| Ollie_Ledner37        | 257   | 
| Julien_Schmidt        | 257   | 
| Rocio33               | 257   | 
| Mckenna17             | 257   | 
| Aniya_Hackett         | 257   | 
| Bethany20             | 257   | 
| Maxwell.Halvorson     | 257   | 
| Mike.Auer39           | 257   | 
| Nia_Haag              | 257   | 
| Annalise.McKenzie16   | 103   | 
| Keenan.Schamberger60  | 98    | 
| Karley_Bosco          | 97    | 
| Adelle96              | 96    | 
| Andre_Purdy85         | 94    | 
...
-- found them but can't limit it, the where clause doesn't work

-- solution from video
SELECT users.username, COUNT(likes.user_id) AS count
FROM users
INNER JOIN likes
    ON likes.user_id = users.id
GROUP BY likes.user_id
HAVING count = (SELECT COUNT(*) FROM `photos`);
+--------------------+-------+
| username           | count | 
+--------------------+-------+
| Jaclyn81           | 257   | 
| Duane60            | 257   | 
| Leslie67           | 257   | 
| Janelle.Nikolaus81 | 257   | 
| Ollie_Ledner37     | 257   | 
| Julien_Schmidt     | 257   | 
| Rocio33            | 257   | 
| Mckenna17          | 257   | 
| Aniya_Hackett      | 257   | 
| Bethany20          | 257   | 
| Maxwell.Halvorson  | 257   | 
| Mike.Auer39        | 257   | 
| Nia_Haag           | 257   | 
+--------------------+-------+