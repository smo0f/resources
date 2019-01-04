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