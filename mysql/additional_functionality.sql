-- @ additional functionality

    -- # ON UPDATE
    -- when the row updates trigger event
    CREATE TABLE comments2 (
        content VARCHAR(100),
        changed_at TIMESTAMP DEFAULT NOW() ON UPDATE CURRENT_TIMESTAMP
    );

    -- # Views
    -- https://www.udemy.com/mysql-and-sql-from-beginner-to-advanced/learn/v4/t/lecture/5057026?start=0
    -- just wanted to add and view for practice purposes

    --  algorithm=undefined, defalt, then swiches to the best one, algorithm=merge or algorithm=temptable

    -- algorithm=undefined to algorithm=temptable
    -- algorithm=temptable, biuld and then drop, because it has something that cannot be in algorithm=merge, like aggregate functions like or group by or other things like that
    -- https://www.udemy.com/mysql-and-sql-from-beginner-to-advanced/learn/v4/t/lecture/5057092?start=0
    CREATE VIEW potential_bots AS
    SELECT users.username, COUNT(likes.user_id) AS count
    FROM users
    INNER JOIN likes
        ON likes.user_id = users.id
    GROUP BY likes.user_id
    HAVING count = (SELECT COUNT(*) FROM `photos`);

    SELECT * FROM potential_bots;
    +--------------------+-------+
    | username           | count | 
    +--------------------+-------+
    | Aniya_Hackett      | 257   | 
    | Jaclyn81           | 257   | 
    | Rocio33            | 257   | 
    | Maxwell.Halvorson  | 257   | 
    | Ollie_Ledner37     | 257   | 
    | Mckenna17          | 257   | 
    | Duane60            | 257   | 
    | Julien_Schmidt     | 257   | 
    | Mike.Auer39        | 257   | 
    | Nia_Haag           | 257   | 
    | Leslie67           | 257   | 
    | Janelle.Nikolaus81 | 257   | 
    | Bethany20          | 257   | 
    +--------------------+-------+

    -- algorithm=merge
    CREATE VIEW Kenton_Kirlin_photos AS
    SELECT image_url, created_at 
    FROM `photos`
    WHERE user_id = 1;

    SELECT * FROM Kenton_Kirlin_photos;
    +----------------------+------------------------------------------------------------+
    | image_url            | created_at                                                 | 
    +----------------------+------------------------------------------------------------+
    | http://elijah.biz    | Wed Oct 17 2018 13:17:54 GMT-0600 (Mountain Daylight Time) | 
    | https://shanon.org   | Wed Oct 17 2018 13:17:54 GMT-0600 (Mountain Daylight Time) | 
    | http://vicky.biz     | Wed Oct 17 2018 13:17:54 GMT-0600 (Mountain Daylight Time) | 
    | http://oleta.net     | Wed Oct 17 2018 13:17:54 GMT-0600 (Mountain Daylight Time) | 
    | https://jennings.biz | Wed Oct 17 2018 13:17:54 GMT-0600 (Mountain Daylight Time) | 
    +----------------------+------------------------------------------------------------+

    -- show tables, it also shows our view kenton_kirlin_photos, but not potential_bots because potential_bots is built on the fly and then deleted
    SHOW TABLES;
    +----------------------+
    | Tables_in_ig_clone   | 
    +----------------------+
    | comments             | 
    | follows              | 
    | kenton_kirlin_photos | 
    | likes                | 
    | photo_tags           | 
    | photos               | 
    | potential_bots       | 
    | tags                 | 
    | users                | 
    +----------------------+

    -- show which tables views
    SHOW FULL TABLES;
    +----------------------+------------+
    | Tables_in_ig_clone   | Table_type | 
    +----------------------+------------+
    | comments             | BASE TABLE | 
    | follows              | BASE TABLE | 
    | kenton_kirlin_photos | VIEW       | 
    | likes                | BASE TABLE | 
    | photo_tags           | BASE TABLE | 
    | photos               | BASE TABLE | 
    | potential_bots       | VIEW       | 
    | tags                 | BASE TABLE | 
    | users                | BASE TABLE | 
    +----------------------+------------+

    -- to drop view
    DROP VIEW kenton_kirlin_photos;

    -- VIEW
    -- can't add indexs to a view
    -- sometimes based on how the view is constructed, you cannot add records to view.

    -- With Check Option
    -- https://www.udemy.com/mysql-and-sql-from-beginner-to-advanced/learn/v4/t/lecture/5057108?start=0

    -- # LOCK & UNLOCK TABLE 
    -- https://www.udemy.com/mysql-and-sql-from-beginner-to-advanced/learn/v4/t/lecture/5057154?start=0
    -- ig_clone Database
    -- lockdown table so that others cannot write or change its structure
    -- LOCK TABLES users WRITE; locks all tables
    -- LOCK TABLES users WRITE, comments WRITE; locks only users and comments
    LOCK TABLE users WRITE;
        -- alter table or add data
    UNLOCK TABLES;
    -- UNLOCK TABLES = unlocks all tables 
    -- other queriess will have to wait until table is unlocked

    -- read lock 
    -- https://www.udemy.com/mysql-and-sql-from-beginner-to-advanced/learn/v4/t/lecture/5057180?start=0

    -- example
    -- https://www.udemy.com/mysql-and-sql-from-beginner-to-advanced/learn/v4/t/lecture/5059260?start=0
    -- I do not have the database for this example
    -- locking peoples so we can put data in without any unexpected authorizations
    -- allow all people only to read the sales table, only allow me the ability to write, or read to sales_history table
    LOCK TABLES sales READ, sales_history WRITE; 
    -- set variable 
    select @total := sum(transaction_value) from sales; 
    -- make new sales_history record
    insert into sales_history (recorded, total) values (now(), @total); 
    -- unlocks all tables
    UNLOCK TABLES; 

    -- read lock: users can read but not write to the row
    -- write lock: users can read or write to the row

    -- # mysql variables
    -- variables stay in mysql
    -- set variable
    SET @num1 = 22;
    SET @num2 = 33;

    -- output variables
    SELECT @num1 + @num2;
    +---------------+
    | @num1 + @num2 | 
    +---------------+
    | 55            | 
    +---------------+

    -- output variable
    SELECT @num1;
    +-------+
    | @num1 | 
    +-------+
    | 22    | 
    +-------+

    -- set variables with selects
    SELECT @total_users := COUNT(*) FROM `users`;
    SELECT @oldist_users := CONCAT(username, '-', id), MIN(id) FROM `users`;

    SELECT @total_users;
    +--------------+
    | @total_users | 
    +--------------+
    | 100          | 
    +--------------+

    SELECT @oldist_users;
    +-----------------+
    | @oldist_users   | 
    +-----------------+
    | Kenton_Kirlin-1 | 
    +-----------------+

    -- example of using a variable
    -- I do not have the database for this example
    select @total := sum(transaction_value) from sales;
    insert into sales_history (recorded, total) values (now(), @total);

    select * from sales_history;

    -- with out variable. explain will explain what is happening in the query
    explain insert into sales_history (recorded, total) values (now(), (select sum(transaction_value) from sales));




