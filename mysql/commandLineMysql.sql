-- @ Command line MySQL

    -- log in
    mysql -u USERNAME -p
    mysql -u root -p

    -- help
    help

    -- show previous warning, has to be last comand
    SHOW WARNINGS;

    --  exit mysql
    exit

    -- Show databases
    SHOW DATABASES;

    -- shows you the selected database
    SELECT database();

    -- Use database 
    USE db_name; 

    -- Show tables
    SHOW TABLES;

    -- show table columns
    SHOW COLUMNS FROM tablename;
    -- or
    DESC tablename;

    -- Create New user, Permissions only on that Database 
    GRANT ALL PRIVILEGES ON db_name.*
    TO 'username'@'localhost'
    IDENTIFIED BY 'password';
    -- Show credentials for user 
    SHOW GRANTS FOR 'username'@'localhost';

-- @ Creat and drop Instructions
    -- # Create a new database 
    CREATE DATABASE db_name;

    -- # Drop database 
    DROP DATABASE db_name;
    DROP DATABASE IF EXISTS db_name;

    -- # Create a new table 
    -- tables have
        -- column = heading or field name
        -- rows = section of data containing entries from all columns
    -- Create table (name in Plural)
    CREATE TABLE table_name (
        column_name1 definition,
        column_name2 definition,
        column_name3 definition,
        options
    );

    -- Example 
    CREATE TABLE Subjects (
        id INT(10) unsigned NOT NULL AUTO_INCREMENT,
        menu_name VARCHAR(255),
        position INT(3),
        visible TINYINT(1),
        PRIMARY KEY (id)
    ) ENGINE=MyISAM DEFAULT CHARSET=latin1;
    -- Example 2
    CREATE TABLE Subjects (
        id INT(10) unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
        menu_name VARCHAR(255),
        position INT(3),
        visible TINYINT(1)
    ) ENGINE=MyISAM DEFAULT CHARSET=latin1;
    -- Example, ColdFusion no ; 
    CREATE TABLE afb_rules_coupons_logic (
        coupon_id int(10) unsigned NOT NULL AUTO_INCREMENT,
        corp_id int(10) unsigned NOT NULL DEFAULT '1',
        coupon_amount decimal(5,2) NOT NULL DEFAULT 0.00,
        coupon_code varchar(50) DEFAULT NULL,
        coupon_description varchar(150) DEFAULT NULL,
        coupon_name varchar(50) DEFAULT NULL,
        coupon_qty int(10) unsigned NOT NULL DEFAULT '0',
        coupon_status tinyint(1) unsigned NOT NULL DEFAULT '1',
        coupon_type tinyint(1) unsigned NOT NULL DEFAULT '1',
        coupon_usage tinyint(1) unsigned NOT NULL DEFAULT '1',
        coupon_web_qty_used int(10) unsigned NOT NULL DEFAULT '0',
        cust_list text DEFAULT NULL,
        limit_cust tinyint(1) unsigned NOT NULL DEFAULT '0',
        minimum_value_activity decimal(5,2) NOT NULL DEFAULT 0.00,
        purchase_type tinyint(1) unsigned NOT NULL DEFAULT '0',
        purchase_type_amount int(10) unsigned NOT NULL DEFAULT '0',
        purchase_type_id int(10) unsigned NOT NULL DEFAULT '0',
        specific_item int(10) unsigned NOT NULL DEFAULT '0',
        PRIMARY KEY (coupon_id),
        KEY corp_id (corp_id)
    ) ENGINE=MyISAM DEFAULT CHARSET=latin1

    -- Example 4, foreign key
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
        FOREIGN KEY(customer_id) REFERENCES customers(id) ON DELETE CASCADE
    );

    -- double primary key, restricts individuals from liking the same picture more than once
    CREATE TABLE likes (
        user_id INTEGER NOT NULL,
        photo_id INTEGER NOT NULL,
        created_at TIMESTAMP DEFAULT NOW(),
        FOREIGN KEY(user_id) REFERENCES users(id),
        FOREIGN KEY(photo_id) REFERENCES photos(id),
        PRIMARY KEY(user_id, photo_id)
    );

    -- ON DELETE CASCADE 
    -- this refers to whenever a customer (primary key) is deleted the corresponding orders (foreign key constraint) will also be deleted.

    -- # Drop table 
    DROP TABLE table_name;
    DROP TABLE IF EXISTS table_name;

-- @ Alter 
    -- # Alter table, add index 
    ALTER TABLE table_name
    ADD COLUMN column_name varchar(50) DEFAULT NULL,
    -- first = first column position
    ADD COLUMN column_name int(10) DEFAULT '0' first,
    -- after = place after specified column name
    ADD COLUMN column_name int(10) DEFAULT '0' after column_name,
    ADD INDEX index_name(column_name);

    -- indexing
    -- adding an index can speed up the query significantly, takes up disk space for performance
    -- ADD INDEX index_name(column_name1, column_name2)
    -- speeds up query for column_name1, and  column_name1, column_name2, but not for column_name2 alone
    -- https://www.udemy.com/mysql-and-sql-from-beginner-to-advanced/learn/v4/t/lecture/5056732?start=0

    -- # CONSTRAINT
    ALTER TABLE table_name
    ADD CONSTRAINT constraint_name FOREIGN KEY(column_name) REFERENCES table_name(column_name);

    -- # DROP CONSTRAINT
    ALTER TABLE table_name
    DROP CONSTRAINT constraint_name;

    -- # DROP COLUMN
    ALTER TABLE table_name
    DROP COLUMN column_name;