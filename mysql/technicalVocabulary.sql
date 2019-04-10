-- @ technical vocabulary

-- ? database vs database management system
    -- database management system
        -- PostgreSQL
        -- MySQL
        -- SQLite
        -- Oracle database

-- ? SQL 
    -- structured query language

-- ? Primary Key 
    -- A unique identifier

-- ? foreign key
    -- linking identifier to another table, typically a primary key, reference to another table
    -- if enforced the foreign key ID needs to exist before it can be added to an adjacent table
        -- the foreign key in question has to have a live value for it to take place, if enforced
    -- *** foreign keys must match their reference exactly, INT(10) unsigned NOT NULL

-- ? CRUD
    -- Create
    -- Read
    -- Update
    -- Delete

-- ? order
    -- DESC = descending
    -- ACS = ascending

-- ? database relationships
    -- one-to-one relationship
        -- user a and user details
    -- one to many relationship
        -- customers and orders
        -- book and reviews
    -- many to many relationship
        -- authors and books
        -- users and projects
        -- blog posts and tags
        -- students and classes
            -- they tipicly have a join table or union table, 3 tables to conect the data

-- ? ACID (Atomicity, Consistency, Isolation, Durability)
    -- https://www.udemy.com/mysql-and-sql-from-beginner-to-advanced/learn/v4/t/lecture/5059262?start=18
    -- https://stackoverflow.com/questions/3740280/acid-and-database-transactions

    -- A transaction is a set of related changes which is used to achieve some of the ACID properties. Transactions are tools to achieve the ACID properties.

    -- Atomicity means that you can guarantee that all of a transaction happens, or none of it does; you can do complex operations as one single unit, all or nothing, and a crash, power failure, error, or anything else won't allow you to be in a state in which only some of the related changes have happened.

    -- Consistency means that you guarantee that your data will be consistent; none of the constraints you have on related data will ever be violated.

    -- Isolation means that one transaction cannot read data from another transaction that is not yet completed. If two transactions are executing concurrently, each one will see the world as if they were executing sequentially, and if one needs to read data that is written by another, it will have to wait until the other is finished.

    -- Durability means that once a transaction is complete, it is guaranteed that all of the changes have been recorded to a durable medium (such as a hard disk), and the fact that the transaction has been completed is likewise recorded.

    -- So, transactions are a mechanism for guaranteeing these properties; they are a way of grouping related actions together such that as a whole, a group of operations can be atomic, produce consistent results, be isolated from other operations, and be durably recorded.

    -- MySQL engines
        -- InnoDB (ACID compliant) (not as fast)
        -- MyISAM (not ACID compliant) (fast)