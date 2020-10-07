-- @ CRUD 

-- # Create 
INSERT INTO table_name (col1, col2, col3)
VALUES (val1, val2, val3);
-- multi-insert 
INSERT INTO table_name (col1, col2, col3)
VALUES (val1, val2, val3),
        (val1, val2, val3),
        (val1, val2, val3),
        (val1, val2, val3),
        (val1, val2, val3);
-- Example, ColdFusion no ; 
INSERT INTO afb_rules_coupons_logic ( corp_id, coupon_amount, coupon_code, coupon_description, coupon_name, coupon_qty, coupon_status, coupon_type, coupon_usage, coupon_web_qty_used, cust_list, limit_cust, minimum_value_activity, purchase_type, purchase_type_amount, purchase_type_id, specific_item)
VALUES ( 1, 0, 'dummy', 'dummy', 'dummy', 0, 1, 1, 1, 0, 'dummy', 0, 0, 0, 0, 0, 0)

-- # Read 
SELECT *
FROM table_name
WHERE column_name = 'some_text'
    AND column_name = 'some_text'
    OR column_name = some_number
ORDER BY column_name ASC;

-- Aliases
SELECT post_id AS id, post_title AS title
FROM table_name
WHERE column_name = 'some_text'

-- The where clause is case insensitive
WHERE column_name = 'some_text'

-- # update 
UPDATE table_name
SET col1 = 'text',
    col2 = number
WHERE column_name = some_number LIMIT 1;

-- # delete 
DELETE FROM table_name
WHERE column_name = column_value LIMIT 1;

-- php mysql 
mysql: original MySQL API
mysqli: MySQL 'improved' API
PDO: PHP data objects