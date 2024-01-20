SELECT * FROM departments;

USE restaurant;
SELECT department_id, SUM(salary)
FROM employees
GROUP BY department_id;


-- LAB 1
SELECT department_id, COUNT(id) AS 'Number of employees'
FROM employees 
GROUP BY department_id
ORDER BY department_id;


SELECT COUNT(id) FROM employees;

SELECT * FROM hotel.clients;

SELECT COUNT(first_name) FROM hotel.clients;

SELECT COUNT(*) FROM hotel.clients;



-- LAB 2
SELECT department_id, ROUND(AVG(salary),2)
FROM employees
GROUP BY department_id
ORDER BY department_id;

-- Lab 3
SELECT department_id, MIN(salary)
FROM employees
WHERE salary > 800
GROUP BY department_id;