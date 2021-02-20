-- @ Form Oracle Database 12c SQL - Jason Price
    -- # Case styling
        -- uppercase for reserved keywords, and lowercase for everything else.

    -- # Row Identifiers
        -- Each row in an Oracle database has a unique row identifier, or rowid
        SELECT ROWID, customer_ID
        FROM customers;
        -- ex
        -- ? https://bookshelf.vitalsource.com/#/books/9780071799362/cfi/6/20!/4/86/2/2@0:95.1
        -- ROWID                    CUSTOMER_ID
        ------------------------------------------
        -- AAAF4yAABAAAHeKAAA       1

    -- # Some Comands
        -- Show details about a table
        DESCRIBE customers;
        -- Select all databases
        SELECT * FROM DBA_USERS;
        -- Get distinct column
        SELECT DISTINCT customer_ID
        FROM customers;

    -- # Things I Haven't Seen Before
        SELECT 2 * 6
        FROM dual;    
        -- 12
        -- dual
            -- The dual table is often used in conjunction with functions and expressions that return values, without needing to reference a base table in the query.

        -- ORDER BY 1
        -- You can use a column position number in the ORDER BY clause to indicate which column to sort. You use 1 to sort by the first column selected, 2 to sort by the second column selected, and so on.

    -- # Dates
        SELECT TO_DATE('25-JUL-2012') + 2
        FROM dual;
        -- 27-JUL-12

        SELECT TO_DATE('25-JUL-2012') - 3
        FROM dual;
        -- 22-JUL-12

        SELECT TO_DATE('02-AUG-2012') - TO_DATE('25-JUL-2012') 
        FROM dual;
        -- TO_DATE('02-AUG-2012') - TO_DATE('25-JUL-2012')
        ----------------------------------------------------
        -- 8
        -- in days

    -- # Aliases
        SELECT Price * 2 DOUBLE_PRICE
        FROM Products; 
        -- DOUBLE_PRICE
        ----------------
        -- 39.9

        SELECT Price * 2 "Double Price"
        FROM Products; 
        -- Double Price
        ----------------
        -- 39.9

        SELECT Price * 2 AS "Double Price"
        FROM Products; 
        -- Double Price
        ----------------
        -- 39.9
    
    -- # Concatenation
        SELECT first_name || ' ' || last_name AS "Customers Name" 
        FROM customers;
        -- Customers Name
        --------------------
        -- John Brown
        -- Steve White

    -- # NULLs
        -- IS NULL

        -- NVL()
        -- How do you tell the difference between a null value and a blank string? You use the NVL() function. NVL() returns another value in place of a null. NVL() accepts two parameters: a column (or, more generally, any expression that results in a value) and the value to be returned if the first parameter is null
        SELECT customer_ID, first_name, last_name,
            NVL(phone, 'Unknown phone number') AS PHONE_NUMBER
        FROM customers;
        -- CUSTOMER_ID      FIRST_NAME      LAST_NAME       PHONE_NUMBER
        -- 1	            John	        Brown           800-555-1211
        -- 2	            Cynthia	        Green           800-555-1212
        -- 3	            Steve	        White           800-555-1213
        -- 4	            Gail	        Black           800-555-1214
        -- 5	            Doreen	        Blue            Unknown phone number

    -- # Comparing Values
        -- Operator         Description
        ---------------------------------
        -- =                Equal
        -- <> or !=         Not equal
                            -- You should use <> because it is the American National Standards Institute (ANSI) standard.
        -- <                Less than
        -- >                Greater than
        -- <=               Less than or equal to
        -- >=               Greater than or equal to
        -- ANY              Compares one value with any value in a list
        -- SOME             Identical to the ANY operator, 
                            -- You should use ANY rather than SOME because ANY is more widely used and, in my opinion, more readable.
        -- ALL              Compares one value with all values in a list

        -- * ANY
        -- The ANY operator compares a value with any of the values in a list.
        SELECT *
        FROM customers
        WHERE customer_id > ANY (2, 3, 4);
        -- CUSTOMER_ID      FIRST_NAME      LAST_NAME       DOB	        PHONE
        ------------------------------------------------------------------------------
        -- 3                Steve           White           16-MAR-71   800-555-1213
        -- 4                Gail            Black                       800-555-1214
        -- 5                Doreen          Blue            20-MAY-70

        -- * ALL
        -- The ALL operator compares a value with all of the values in a list.
        SELECT *
        FROM customers
        WHERE customer_id > ALL (2, 3, 4);
        -- CUSTOMER_ID      FIRST_NAME      LAST_NAME       DOB	        PHONE
        -------------------------------------------------------------------------------
        -- 5                Doreen          Blue            20-MAY-70

    -- # Operator
        -- Operator         Description
        --------------------------------------------------
        -- LIKE             Matches patterns in strings
        -- IN               Matches lists of values 
                            -- The IN operator checks if a value is in a list of values
        -- BETWEEN          Matches a range of values
                            -- The range is inclusive, which means the values at both ends of the range are included
        -- IS NULL          Matches null values
        -- IS NAN           Matches the NAN special value, which means “not a number”
        -- IS INFINITE      Matches infinite BINARY_FLOAT and BINARY_DOUBLE values

        -- NOT reverses the meaning of an operator:
        -- NOT LIKE
        -- NOT IN
        -- NOT BETWEEN
        -- IS NOT NULL
        -- IS NOT NAN
        -- IS NOT INFINITE

        -- * Like
        -- Underscore (_) matches one character in a specified position.
        -- Percent (%) matches any number of characters beginning at the specified position.
        SELECT *
        FROM customers 
        WHERE firstname LIKE '_o%';
        -- CUSTOMER_ID      FIRST_NAME      LAST_NAME       DOB         PHONE
        -----------------------------------------------------------------------------
        -- 1                John            Brown           01-JAN-65   800-555-1211
        -- 5                Doreen          Blue            20-MAY-70

        -- '%\%%' ESCAPE '\'
        -- ? https://bookshelf.vitalsource.com/#/books/9780071799362/cfi/6/20!/4/400/2/2@0:56.1

        -- * IN
        -- An important point to remember is that NOT IN returns false if a value in the list is null. For example, the following query doesn’t return any rows because null is included in the list:
        -- CAUTION
            -- NOT IN returns false if a value in the list is null. This is important because you can use any expression in the list and not just literal values, and it can be difficult to spot when a null value occurs. You should consider using NVL() with expressions that might return a null value.

    -- # Cartesian Products
        -- If a join condition is missing from a query, the Oracle database software will join all rows from one table with all the rows from the other table. The result set is known as a Cartesian product.
        -- ? https://bookshelf.vitalsource.com/#/books/9780071799362/cfi/6/20!/4/626/2/2@0:59.7
        SELECT pt.product_type_id, p.product_id 
        FROM product_types pt, products p;
        -- ex see example in link above
            -- * SQL/92 standard, sould use this one
            SELECT * 
            FROM product_types 
                CROSS JOIN products;

    -- # Joins

        -- Number of joins = number of tables in the query – 1.
            -- For example, a query uses two tables and therefore one join is used.

        -- Equijoins use the equality operator =.
        -- Non-equijoins use an operator other than the equality operator. For example: <, >, BETWEEN, and so on.
        -- There are three different types of joins:
            -- Inner joins return a row only when the columns in the join contain values that satisfy the join condition. This means that if a row has a null value in one of the columns in the join condition, then that row isn’t returned. The examples you’ve seen so far have been inner joins.
            -- Outer joins return a row even when one of the columns in the join condition contains a null value.
            -- Self joins return rows joined on the same table.

        -- * Implicit Join, Inner Join, SQL/86 standard
        SELECT p.name, pt.name 
        FROM products p, product_types pt 
        WHERE p.product_type_id = pt.product_type 
        ORDER BY p.name;

            -- * SQL/92 standard, sould use this one
            SELECT p.name, pt.name
            FROM produces p 
                INNER JOIN product_types pt 
                    ON p.product_type_id = pt.product_type_id 
            ORDER BY p.name;

        -- * non-equijoin
        SELECT e.first_name, e.last_name, e.title, e.salary, sg.salary_grade_id 
        FROM employees e, salary_grades sg
        WHERE e.salary BETWEEN sg.low_salary AND sg.hlgh_salary 
        ORDER BY salary_grade_id;

        -- * Outer Joins SQL/86 standard
        SELECT p.name, pt.name
        FROM products p, product_types pt
        WHERE p.product_type_id = pt.product_type_id (+)
        ORDER BY p.name;

        -- * Left outer Joins
        WHERE p.product_type_id = pt.product_type_id (+)
            -- * SQL/92 standard, sould use this one
            SELECT p.name, pt.name
            FROM products p 
                LEFT OUTER JOIN product_types pt
                    USING (product_type_id)
            ORDER BY p.name;

        -- * Right outer Joins
        WHERE p.product_type_id (+) = pt.product_type_id 
            -- * SQL/92 standard, sould use this one
            SELECT p.name, pt.name
            FROM products p 
                RIGHT OUTER JOIN product_types pt
                    USING (product_type_id)
            ORDER BY p.name;
        -- Just think opposites for saying which outer join it is 

        -- Limitations on Outer Joins
        -- There are limitations when using outer joins. You can only place the Oracle-proprietary outer join operator on one side of the join (not both). If you try to place the outer join operator on both sides, then you get an error. For example:

        -- * Full Outer Join, SQL/92 standard, sould use this one
        SELECT p.name, pt.name
        FROM products p 
            FULL OUTER JOIN product_types pt
                USING (product_type_id)
        ORDER BY p.name;

        -- * Self Join 
        SELECT w.first_name || ' ' || w.last_name || ' works for' ||
            m.first_name || ' ' || m.last_name
        FROM employees w, employees m 
        WHERE w.manager_id = m.employee_id 
        ORDER BY w.first_name;
            -- * SQL/92 standard, sould use this one
            SELECT w.last_name || ' works for ' || m.last_name
            FROM employees w 
                INNER JOIN employees m 
                    ON w.manager_id = m.employee_id;

        -- * Self Outer Jion
        SELECT w.lastname || ' works for ' || 
            NVL(m.last_name, 'the shareholders') 
        FROM employees w, employees m 
        WHERE w.manager_id = m.employee_id (+) 
        ORDER BY w.last_name;

        -- * USING
        SELECT p.name, pt.name
        FROM produces p 
            INNER JOIN product_types pt 
                USING (product_type_id);
        -- CAUTION
        -- Don’t use a table name or alias when referencing columns used in a USING clause. You’ll get an error if you do.

        -- Other examples of USING
        SELECT c.first_name, c.last_name, p.name AS PRODUCT, pt.name AS TYPE 
        FROM customers c 
            INNER JOIN purchases pr 
                USING (customer_id)
            INNER JOIN products p 
                USING (product_id)
            INNER JOIN product_types pt 
                USING (product_type_id)
        ORDER BY p.name;

        -- USING version of inner join below
        SELECT ...
        FROM tablel 
            INNER JOIN table2 
                USING (columnl, column2);

  
            -- Inner Join
            SELECT ...
            FROM tablel 
                INNER JOIN table2
                    ON table1.columnl = table2.columnl
                        AND tablel.column2 = table2.column2;
    
    -- # Normalization of Database
        -- ? https://www.studytonight.com/dbms/database-normalization.php
        -- ? https://trello.com/c/uSUbvkcY/205-normal-forms-nf
            -- * First Normal Form (1NF)
            -- For a table to be in the First Normal Form, it should follow the following 4 rules:

            -- It should only have single(atomic) valued attributes/columns.
            -- Values stored in a column should be of the same domain
            -- All the columns in a table should have unique names.
            -- And the order in which data is stored, does not matter.
            -- In the next tutorial, we will discuss about the First Normal Form in details.

            -- No repeating groups
            -- PK identified
            -- All nonkey attributes in the relation are dependent on the primary key. 

            -- * Second Normal Form (2NF)
            -- For a table to be in the Second Normal Form,

            -- It should be in the First Normal form.
            -- And, it should not have Partial Dependency.
            -- To understand what is Partial Dependency and how to normalize a table to 2nd normal for, jump to the Second Normal Form tutorial.

            -- there are no partial dependencies (dependencies in only part of the primary key).

            -- * Third Normal Form (3NF)
            -- A table is said to be in the Third Normal Form when,

            -- It is in the Second Normal form.
            -- And, it doesn't have Transitive Dependency.
            -- Here is the Third Normal Form tutorial. But we suggest you to first study about the second normal form and then head over to the third normal form.

            -- * Boyce and Codd Normal Form (BCNF)
            -- Boyce and Codd Normal Form is a higher version of the Third Normal form. This form deals with certain type of anomaly that is not handled by 3NF. A 3NF table which does not have multiple overlapping candidate keys is said to be in BCNF. For a table to be in BCNF, following conditions must be satisfied:

            -- R must be in 3rd Normal Form
            -- and, for each functional dependency ( X → Y ), X should be a super Key.
            -- To learn about BCNF in detail with a very easy to understand example, head to Boye-Codd Normal Form tutorial.

            -- * Fourth Normal Form (4NF)
            -- A table is said to be in the Fourth Normal Form when,

            -- It is in the Boyce-Codd Normal Form.
            -- And, it doesn't have Multi-Valued Dependency.
            -- Here is the Fourth Normal Form tutorial. But we suggest you to understand other normal forms before you head over to the fourth normal form.
        -- ? https://www.youtube.com/watch?v=xoTyrdT9SZI&list=PLLGlmW7jT-nTr1ory9o2MgsOmmx2w8FB3














  



                    
