-- @ ACID topics 

    -- # transactions
    -- MySQL engines InnoDB (ACID compliant)

    -- by default MySQL is = set autocommit = 1;
    start transaction;

        INSERT INTO books (title, author)
        VALUES ('The Great Mountain', 'Tonya Nilsson');

        INSERT INTO books (title, author)
        VALUES ('The Small Mountain', 'Jessica Simpson');

    commit; -- solidifies changes

    -- or if some of the numbers don't add up or something is incorrect you can always roll back the data
    rollback; -- a rollback allows you to disregard changes before you commit

    -- can not run, fake data
    set autocommit = 0; -- this turns the autocommit feature off, so we can perform multiple actions at once

        INSERT INTO books (title, author)
        VALUES ('The Great Mountain', 'Tonya Nilsson');

        INSERT INTO books (title, author)
        VALUES ('The Small Mountain', 'Jessica Simpson');

        SELECT * FROM books; -- they look like they were added, but are not added completely intell you commit

    commit; -- solidifies changes

    -- or if some of the numbers don't add up or something is incorrect you can always roll back the data
    rollback; -- a rollback allows you to disregard changes before you commit

    -- # Isolation

    SELECT @@session.tx_isolation; -- checking isolation level, repeatable-read by default

    -- how to set 
    set session transaction isolation level repeatable read;

    -- isolation level types
        -- repeatable-read by default
        


