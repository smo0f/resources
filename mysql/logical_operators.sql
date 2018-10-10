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
