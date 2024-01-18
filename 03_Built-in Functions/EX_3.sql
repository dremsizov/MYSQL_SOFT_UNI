

									-- Exercise: Buil-in Functions


USE soft_uni;
							-- 01. Find Names of All Employees by First Name

-- LIKE работи като case sensitiv
SELECT first_name,last_name FROM employees
WHERE first_name LIKE 'sa%'
ORDER BY employee_id;

-- Втори вариант

SELECT first_name,last_name FROM employees
WHERE LEFT (first_name,2) = 'sa'
ORDER BY employee_id;


						-- 02. Find Names of All Employees by Last Name

SELECT first_name,last_name FROM employees
WHERE last_name LIKE '%ei%'
ORDER BY employee_id;


					-- 03. Find First Names of All Employess
                    
SELECT first_name FROM employees
WHERE (department_id = 3 OR department_id = 10) AND
YEAR(hire_date) BETWEEN 1995 AND 2005
ORDER BY employee_id;
             
             
             -- 04. Find All Employees Except Engineers
SELECT first_name,last_name FROM employees
WHERE job_title NOT LIKE '%engineer%'
ORDER BY employee_id;

			-- 05. Find Towns with Name Length

SELECT name FROM towns
WHERE LENGTH(name) = 5 OR LENGTH(name) = 6
ORDER BY name;

				-- 06. Find Towns Starting With

SELECT town_id, name FROM towns
WHERE LEFT(name,1) IN ('M','K', 'B','E')
ORDER BY name;


				-- 07. Find Towns Not Starting With

SELECT town_id, name FROM towns
WHERE LEFT(name,1) NOT IN ('R','B', 'D')
ORDER BY name;


-- 08. Create View Employees Hired After

CREATE VIEW v_employees_hired_after_2000 AS
SELECT first_name,last_name FROM employees
WHERE YEAR(hire_date) > 2000;

SELECT * FROM v_employees_hired_after_2000; 

-- 09. Length of Last Name

SELECT first_name,last_name FROM employees
WHERE LENGTH(last_name)=5;


-- 10. Countries Holding 'A'

USE geography;

SELECT country_name, iso_code FROM countries
WHERE country_name LIKE '%A%A%A%'
ORDER BY iso_code;


					-- 11. Mix of Peak and River Names

SELECT peak_name, river_name,
CONCAT (LOWER(peak_name), SUBSTRING(LOWER(river_name), 2)) AS 'mix'
FROM peaks, rivers
WHERE RIGHT(peak_name, 1) = LEFT(river_name,1)
ORDER BY mix;


					-- 12. Games From 2011 and 2012 Year

USE diablo;
SELECT name, DATE_FORMAT(start, '%Y-%m-%d')
FROM games
WHERE YEAR(start) IN (2011,2012)
ORDER BY start LIMIT 50;


-- 13. User Email Providers

SELECT user_name, SUBSTRING(email, LOCATE('@', email) + 1) AS 'email_provider'
FROM users
ORDER BY email_provider, user_name;


-- 14. Get Users with IP Address Like Pattern


SELECT user_name, ip_address FROM users
WHERE ip_address LIKE '___.1%.%.___'
ORDER BY user_name;


-- s Regex


--  15. Show All Games with Duration


SELECT name AS game,
CASE
	WHEN HOUR(start) < 12 THEN 'Morning'
    WHEN HOUR(start)  < 18 THEN 'Afternoon'
	WHEN HOUR(start)  < 24 THEN 'Evening'
END AS 'Part of the Day',

CASE
WHEN duration < 4 THEN 'Extra Short'
WHEN duration < 7 THEN 'Short'
WHEN duration < 11 THEN 'Long'
ELSE 'Extra Long'

END AS 'Duration'

FROM games;


-- 16. Orders Table

USE orders;

SELECT product_name,order_date, 
DATE_ADD(order_date, INTERVAL 3 DAY) AS 'pay_due',
DATE_ADD(order_date, INTERVAL 1 MONTH) AS 'deliver_due'
FROM orders;



