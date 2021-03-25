-- @ Crearing tables
    -- # create table
    CREATE TABLE order_status2 (
        id INTEGER CONSTRAINT order_status2_pk PRIMARY KEY,
        status VARCHAR2(10),
        last modified DATE DEFAULT SYSDATE
    );

    -- # Getting Information on Tables
    DESCRIBE table_name;

    SELECT table_name, tablespacename, temporary 
    FROM usertables
    WHERE tablename IN ('ORDER_STATUS2', 'ORDER_STATUS_TEMP');
    
    -- NOTE: You can retrieve information on all the tables you have access to by querying the all_tables view.
    -- ? https://bookshelf.vitalsource.com/#/books/9780071799362/cfi/6/38!/4/100/8/2/2@0:25.9

    -- # Altering a Table
    ALTER TABLE order_status2 
    ADD modifled_by INTEGER;

    -- # Adding a Virtual Column
    -- Oracle Database 11g introduced virtual columns. A virtual column is a column that refers only to other columns already in the table. For example, the following ALTER TABLE statement adds a virtual column named average_salary to the salary_grades table:
    ALTER TABLE salary_grades
    ADD (average_salary AS ((low_salary + hlgh_salary)/2));
    -- ? https://bookshelf.vitalsource.com/#/books/9780071799362/cfi/6/38!/4/154/2/2@0:13.4

    -- # Changing the Size of a Column   
    -- The following ALTER TABLE statement increases the maximum length of the status column to 15 characters:
    ALTER TABLE order_status2 
    MODIFY status VARCHAR2(15);
    -- ? https://bookshelf.vitalsource.com/#/books/9780071799362/cfi/6/38!/4/186/2@0:0
    -- If the table is empty or the column contains null values, then you can change the column to any data type (including a data type that is shorter). Otherwise, you can change the data type of a column only to a compatible data type. For example, you can change a VARCHAR2 to CHAR (and vice versa) as long as you don’t make the column shorter. You cannot change a DATE to a NUMBER.

    -- # Dropping a Column
    ALTER TABLE order_fltatus2 
    DROP COLUMN initially_created;

    -- # Adding a CHECK Constraint
    ALTER TABLE order_status2
    ADD CONSTRAINT order_status2_status_ck
    CHECK (status IN ('PLACED', 'PENDING', 'SHIPPED'))
    -- When adding a constraint, the existing rows in the table must satisfy the constraint. For example, if the order_status2 table had rows in it, then the id column for the rows would need to be greater than zero.
    -- NOTE: There are exceptions to the rule requiring that existing rows satisfy the constraint. You can disable a constraint when you initially add it, and you can set a constraint to apply only to new data, by specifying ENABLE NOVALIDATE. You’ll learn more about this later.

    ALTER TABLE order_status2
    ADD CONSTRAINT order_status2_id_ck CHECK (id > 0);

    ALTER TABLE order_status2
    MODIFY status CONSTRAINT order_status2_status_nn NOT NULL;
    -- TIP: Always specify a meaningful name to your constraints. That way, when a constraint error occurs, you can easily identify the problem.

    -- # Adding a FOREIGN KEY Constraint
    -- ? https://bookshelf.vitalsource.com/#/books/9780071799362/cfi/6/38!/4/312/2/2/2/2/2/2@0:68.4
    ALTER TABLE order_status2 
    DROP COLUMN modified_by;

    ALTER TABLE order_status2
    ADD CONSTRAINT order_status2_modified_by_fk
    modified_by REFERENCES employees(employee_id) ON DELETE CASCADE

    ALTER TABLE order_status2
    ADD CONSTRAINT order_status2_modified_by_fk
    modified_by REFERENCES employees(employee_id) ON DELETE SET NULL

    -- # Dropping a Constraint
    ALTER TABLE order_status2
    DROP CONSTRAINT order_status2_status_uq;

    -- # Disabling a Constraint
    ALTER TABLE order_status2
    ADD CONSTRAINT order_status2_status_uq UNIQUE (status) DISABLE;

    ALTER TABLE order_status2
    DISABLE CONSTRAINT order_status2_status_nn;

    -- # Enabling a Constraint
    ALTER TABLE order_status2
    ENABLE NOVALIDATE CONSTRAINT order_status2_status_uq;
    -- NOTE: The default is ENABLE VALIDATE, which means existing rows must pass the constraint check.

    -- # Deferring a Constraint
    -- A deferred constraint is one that is enforced when a transaction is committed. You use the DEFERRABLE clause when you initially add the constraint. Once you’ve added a constraint, you cannot change it to DEFERRABLE. Instead, you must drop and re-create the constraint.
    -- When you add a DEFERRABLE constraint, you can mark it as INITIALLY IMMEDIATE or INITIALLY DEFERRED. Marking as INITIALLY IMMEDIATE specifies that the constraint is checked whenever you add, update, or delete rows from a table (this is the same as the default behavior of a constraint). INITIALLY DEFERRED specifies that the constraint is only checked when a transaction is committed. Let’s take a look at an example.
    -- The following statement drops the order_status2_status_uq constraint:
    ALTER TABLE order_status2
    ADD CONSTRAINT order_status2_status_uq UNIQUE (status) DEFERRABLE INITIALLY DEFERRED;

    -- # Getting Information on Constraints
    -- You can retrieve information on your constraints by querying the user_constraints view. Table 11-4 describes some of the columns in user_constraints.
    -- ? https://bookshelf.vitalsource.com/#/books/9780071799362/cfi/6/38!/4/414/2/2@0:0

    -- # Other topics
    -- ? https://bookshelf.vitalsource.com/#/books/9780071799362/cfi/6/38!/4@0:0
    -- Renaming a Table
    -- Adding a Comment to a Table
    -- Retrieving Table Comments
    -- Retrieving Column Comments
    -- Truncating a Table
    -- Dropping a Table
    -- Using the BINARY_FLOAT and BINARY_DOUBLE Types
    -- Using DEFAULT ON NULL Columns
    -- Using Visible and Invisible Columns in a Table
    -- Sequences
    -- Retrieving Information on Sequences

    -- # Indexes
    -- ? https://bookshelf.vitalsource.com/#/books/9780071799362/cfi/6/38!/4/944/2@0:65.6
    -- When looking for a particular subject in a book, you can either scan the whole book or use the index to find the location. An index for a database table is similar in concept to a book index, except that database indexes are used to find specific rows in a table. The downside of indexes is that when a row is added to the table, additional time is required to update the index for the new row.
    -- Generally, you should create an index on a column when you are retrieving a small number of rows from a table containing many rows. A simple rule for when to create indexes is
    -- Create an index when a query retrieves <= 10 percent of the total rows in a table.
    -- This means the column for the index should contain a wide range of values. These types of indexes are called B-tree indexes, a name that comes from a tree data structure used in computer science. A good candidate for B-tree indexing would be a column containing a unique value for each row (for example, a Social Security number). A poor candidate for B-tree indexing would be a column that contains only a small range of values (for example, N, S, E, W or 1, 2, 3, 4, 5, 6). An Oracle database automatically creates a B-tree index for the primary key of a table and for columns included in a unique constraint. For columns that contain a small range of values, you can use a bitmap index. You’ll learn about bitmap indexes shortly.
    -- In this section, you’ll learn how to perform the following tasks:

    -- TIP: For performance reasons, you should typically store indexes in a different tablespace from tables. For simplicity, the examples in this chapter use the default tablespace. In a production database, the database administrator should create separate tablespaces for the tables and indexes.
























