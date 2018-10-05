
--  AS with a space 
SELECT CONCAT(author_fname, ' ',  author_lname) AS 'full name'
FROM `books`

+----------------------+
| full name            | 
+----------------------+
| Jhumpa Lahiri        | 
| Neil Gaiman          | 
...