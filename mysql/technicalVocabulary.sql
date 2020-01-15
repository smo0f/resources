-- @ technical vocabulary

-- ? database vs database management system
    -- database management system
        -- PostgreSQL
        -- MySQL
        -- SQLite
        -- Oracle database

-- ? Types of Databases
    -- single-user database (desktop database) Only one user can use it at a time 
    -- multiuser database, 2-50 users
    -- Enterprise database, usually more than 50 users across many departments

    -- Centralized database, a database that supports data located at a single site/location
    -- Distributed database, A database that supports the distribution of data over several sites/locations

    -- cloud database, AWS in the cloud, then distributed 

    -- General-purpose databases, contain a wide variety of data used in multiple disciplines
    -- Discipline specific databases contains data focused on specific subject areas, like academics or research purposes

    -- Operational database aka, online transactional processing database (OLTP), Transactional database, production database, Records day-to-day activities

    -- analytical database, focuses primarily on storing historical data and  business metrics used exclusively for tactical or strategic decision making. Such analysis  typically requires extensive “data massaging” (data manipulation) to produce information on which to base pricing decisions, sales forecasts, market strategies, and so on.  Analytical databases allow the end user to perform advanced analysis of business data  using sophisticated tools. 
    -- (siting refrence) Coronel, Carlos. Database Systems: Design, Implementation, & Management (p. 10). Cengage Learning. Kindle Edition. 

        -- Analyticall databases are often constructed with an analytical processing front and in a database warehouse
    
    -- Extensible markup language (XML) databases, Supports storage and management of semi structured XML data

    -- ? other information
    -- Online analytical processing (OLAP), Tools to help retrieve process and model data from a database warehouse falls under the discipline of business intelligence

    -- Unstructured data, Original or raw state, does not lend itself to further processing
    -- Structured data, Formatted data to allow processing more quickly and more easily
    -- Semistructured data, has been processed to some extent
    
-- ? SQL 
    -- structured query language

-- ? Acronyyms
    -- database management system (DBMS)
    -- structured query language (SQL)
    -- Online analytical processing (OLAP)

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