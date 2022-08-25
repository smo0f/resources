-- @ GROUP_CONCAT
-- ? https://www.mysqltutorial.org/mysql-group_concat/
-- GROUP_CONCAT(
--     DISTINCT expression
--     ORDER BY expression
--     SEPARATOR sep
-- );

SELECT GROUP_CONCAT(DISTINCT v ORDER BY v ASC SEPARATOR ';')
FROM t;

SELECT 
    employeeNumber,
    firstName,
    lastName,
    GROUP_CONCAT(DISTINCT customername ORDER BY customerName)
FROM
    employees
        INNER JOIN
    customers ON customers.salesRepEmployeeNumber = employeeNumber
GROUP BY employeeNumber
ORDER BY firstName, lastname;

SELECT 
    GROUP_CONCAT(
       CONCAT_WS(', ', contactLastName, contactFirstName)
       SEPARATOR ';')
FROM customers;

-- @ JSON
-- ? https://www.mysqltutorial.org/mysql-json/
SELECT id, browser->>'$.name' browser
FROM events;

SELECT browser->>'$.name' browser, 
      count(browser)
FROM events
GROUP BY browser->>'$.name';

SELECT visitor, SUM(properties->>'$.amount') revenue
FROM events
WHERE properties->>'$.amount' > 0
GROUP BY visitor;

-- @ FIND_IN_SET
-- ? https://www.mysqltutorial.org/mysql-find_in_set/
-- FIND_IN_SET(needle,haystack);

SELECT FIND_IN_SET('y','x,y,z'); -- 2
SELECT FIND_IN_SET('a','x,y,z'); -- 0
SELECT FIND_IN_SET(NULL,'x,y,z'); -- NULL
SELECT FIND_IN_SET('a',NULL); -- NULL

SELECT name, belts
FROM divisions
WHERE FIND_IN_SET('red', belts);

SELECT name, belts
FROM divisions
WHERE NOT FIND_IN_SET('black', belts);

-- @ COUNT->where
-- ? https://www.mysqltutorial.org/mysql-count/
SELECT 
    COUNT(IF(status = 'Cancelled', 1, NULL)) 'Cancelled',
    COUNT(IF(status = 'On Hold', 1, NULL)) 'On Hold',
    COUNT(IF(status = 'Disputed', 1, NULL)) 'Disputed'
FROM
    orders;

-- @ Loop
-- ? https://www.mysqltutorial.org/stored-procedures-loop.aspx
DROP PROCEDURE LoopDemo;

DELIMITER $$
CREATE PROCEDURE LoopDemo()
BEGIN
	DECLARE x  INT;
	DECLARE str  VARCHAR(255);
        
	SET x = 1;
	SET str =  '';
        
	loop_label:  LOOP
		IF  x > 10 THEN 
			LEAVE  loop_label;
		END  IF;
            
		SET  x = x + 1;
		IF  (x mod 2) THEN
			ITERATE  loop_label;
		ELSE
			SET  str = CONCAT(str,x,',');
		END  IF;
	END LOOP;
	SELECT str;
END$$

DELIMITER ;

CALL LoopDemo();

-- +-------------+
-- | str         |
-- +-------------+
-- | 2,4,6,8,10, |
-- +-------------+
-- 1 row in set (0.01 sec)

-- @ Other
WITH offices_ranked AS (
	SELECT 
		NAME,
		MAX(id) OVER(PARTITION BY name) AS max_id,
		RANK() OVER(PARTITION BY name ORDER BY id) AS rank_order,
		COUNT(NAME) OVER(PARTITION BY name) AS office_count
   FROM offices
   WHERE name IN ('Virginia Beach','Buffalo','Corpus Christi')
)
SELECT *
FROM offices
WHERE id IN (
	SELECT max_id
	FROM offices_ranked
	WHERE rank_order = 1
);


