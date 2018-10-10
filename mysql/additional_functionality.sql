-- @ additional functionality

    -- # ON UPDATE
    -- when the row updates trigger event
    CREATE TABLE comments2 (
        content VARCHAR(100),
        changed_at TIMESTAMP DEFAULT NOW() ON UPDATE CURRENT_TIMESTAMP
    );