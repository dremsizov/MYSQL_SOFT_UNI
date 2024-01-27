
-- lab 1


-- 01 Manager

use soft_uni;

SELECT
employee_id, -- тук се повтарят с др таблица опцията е или department.manager_id или employees_id

CONCAT(first_name, ' ' , last_name) AS 'full_name', -- това го изпозлваме за да си вузуализираме колона full_name

departments.department_id,  -- тук го посочвам така, за да не се повтарят
name AS 'department_name'

FROM departments

JOIN employees ON departments.manager_id = employees.employee_id
ORDER BY employee_id
LIMIT 5;

					--  2. Towns and Addresses
                    
	-- Опнция с WHERE
SELECT a.town_id,
		a.address_text
FROM addresses AS a
JOIN towns AS t ON a.town_id = t.town_id
WHERE t.name IN ('San Francisco', 'Sofia','Carnation')
ORDER BY a.town_id, a.address_id;
       
       
     -- Опция с AND  и  INNER JOIN  
       
SELECT a.town_id,
		t.name,
		a.address_text
FROM addresses AS a
INNER JOIN towns AS t ON a.town_id = t.town_id 
AND  t.name IN ('San Francisco', 'Sofia','Carnation')
ORDER BY a.town_id, a.address_id;
                    
                    
                    
                    -- 3. Employees Without Managers 
                    
SELECT
employee_id,
first_name,
last_name,
department_id,
salary
FROM employees
WHERE manager_id IS NULL;

     	
-- 4. High Salary

SELECT COUNT(*)
FROM employees
WHERE salary > (
SELECT AVG(salary) FROM employees); -- Вкарваме фунция - вложена заявка






-- More work

Select * from employees



