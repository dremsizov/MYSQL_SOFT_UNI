

-- 1. Employee Address

SELECT e.employee_id,
e.job_title,
a.address_id,
a.address_text
FROM employees e
JOIN addresses a ON e.address_id = a.address_id
ORDER BY address_id ASC
LIMIT 5;


-- 02. Addresses with Towns

SELECT
e.first_name,
e.last_name,
t.name AS town,
a.address_text
FROM employees e
JOIN addresses a ON e.address_id = a.address_id
JOIN towns t ON a.town_id = t.town_id
ORDER BY 
    e.first_name ASC,
    e.last_name ASC
LIMIT 5;



-- 03. Sales Employee

SELECT
e.employee_id,
e.first_name,
e.last_name,
d.name AS 'department_name'

FROM employees e
JOIN departments d ON d.department_id = e.department_id
WHERE d.name = "Sales"
ORDER BY
e.employee_id DESC;


-- 04. Employee Departments

SELECT
e.employee_id,
e.first_name,
e.salary,
d.name AS 'department_name'
FROM employees e
JOIN departments d ON d.department_id = e.department_id
WHERE e.salary > 15000
ORDER BY
d.department_id DESC
LIMIT 5;


-- 05. Employees Without Project


SELECT
    e.employee_id,
    e.first_name
FROM
    employees e
LEFT JOIN
    employees_projects ep ON e.employee_id = ep.employee_id
WHERE
		ep.employee_id IS NULL
ORDER BY
    e.employee_id DESC
LIMIT 3;

-- Алтернативно решение?
SELECT 
employee_id,
first_name
FROM employees
WHERE manager_id IS NULL
ORDER BY employee_id DESC
LIMIT 3;


-- 6. Employees Hired After

SELECT
e.first_name,
e.last_name,
e.hire_date,
d.name AS 'dept_name'

FROM employees e 
JOIN departments as d ON d.department_id = e.department_id
WHERE d.name IN ('Sales', 'Finance')
AND DATE (e.hire_date) > '1999/1/1'
ORDER BY
e.hire_date ASC;


-- 07. Employees with Project. !!!!!!!!

-- MY

SELECT
e.employee_id,
e.first_name,
p.name AS 'project_name'
FROM employees e
JOIN employees_projects ep ON ep.employee_id = e.employee_id
JOIN projects p ON ep.project_id = p.project_id
WHERE p.end_date IS NULL
AND (p.start_date > '2002-08-13')
ORDER BY
e.first_name,
p.name
LIMIT 5;


--

SELECT 
    e.employee_id, e.first_name, p.name AS 'project_name'
FROM
    `employees` AS e
        JOIN
    `employees_projects` AS ep ON ep.employee_id = e.employee_id
        JOIN
    `projects` AS p ON ep.project_id = p.project_id
WHERE
    DATE(p.start_date) > '2002-08-13'
        AND p.end_date IS NULL
ORDER BY e.first_name , p.name
LIMIT 5;


-- 08. Employee 24

-- Тук за изискването за проверка на годината и ако тя е 2005 да изписва NULL, а ако е преди това да изпизва името означава че трябва да изпозлваме IF конструкция

SELECT 
e.employee_id,
e.first_name,
IF(YEAR (p.start_date) >= 2005, NULL,
p.name) as 'project_name'
FROM employees e

JOIN employees_projects ep ON ep.employee_id = e.employee_id
JOIN projects p ON ep.project_id = p.project_id

WHERE e.employee_id = 24
ORDER BY
p.name ASC;


-- 09. Employee Manager.  !!!

SELECT * FROM departments;


SELECT 
e.employee_id,
e.first_name,
e.manager_id,
m.first_name

FROM employees e
JOIN employees m ON e.manager_id = m.employee_id
WHERE (e.manager_id =3 OR e.manager_id = 7)
ORDER BY
e.first_name ASC;



-- 10. Employee Summary. !!!!!

SELECT
e.employee_id,
CONCAT (e.first_name, ' ', e.last_name) AS 'employee_name',
CONCAT (m.first_name, ' ',  m.last_name) AS 'manager_name',
d.name as department_name

FROM employees e
JOIN employees AS m ON e.manager_id = m.employee_id
JOIN departments d ON d.department_id = e.department_id
ORDER BY
e.employee_id
LIMIT 5;

--  11. Min Average Salary

SELECT 
    AVG(salary) AS 'min_average_salary'
FROM
    employees
GROUP BY department_id
ORDER BY `min_average_salary`
LIMIT 1;



use geography;
-- 12. Highest Peaks in Bulgaria

SELECT * FROm mountains;

SELECT 
c.country_code,
m.mountain_range,
p.peak_name,
p.elevation

FROM countries c
JOIN mountains_countries as mc ON mc.country_code = c.country_code
JOIN mountains as m ON m.id = mc.mountain_id
JOIN peaks as p ON p.mountain_id = m.id
WHERE p.elevation > 2835 AND (c.country_code = "BG")
ORDER BY p.elevation DESC;


-- 13. Count Mountain Ranges

SELECT * FROM rivers;

SELECT 
c.country_code, COUNT(mc.mountain_id) AS 'mountain_range'

FROM countries c
JOIN mountains_countries as mc ON mc.country_code = c.country_code
WHERE
    c.country_name IN ('United States' , 'Russia', 'Bulgaria')
    GROUP BY c.country_code
ORDER BY `mountain_range` DESC;



-- 14. Countries with Rivers.  !!!!!!!!!

SELECT  
c.country_name,
r.river_name

FROM countries c
LEFT JOIN countries_rivers as cr ON cr.country_code = c.country_code  -- Тук трябва да се изпозлва LEFT за да имаме визуализация на NULL
LEFT JOIN rivers as r ON r.id = cr.river_id
JOIN continents as cn ON cn.continent_code = c.continent_code
WHERE     cn.continent_name = 'Africa'
ORDER BY c.country_name ASC
LIMIT 5;

--  15. *Continents and Currencies (not included in final score)






-- 16. Countries without any Mountains

SELECT 
    COUNT(*) as 'country_count'
FROM
    (SELECT 
        mc.country_code AS 'mc_country_code'
    FROM
        `mountains_countries` AS mc
    GROUP BY mc.country_code) AS d
        RIGHT JOIN
    `countries` AS c ON c.country_code = d.mc_country_code
WHERE
    d.mc_country_code IS NULL;
    


-- 17. Highest Peak and Longest River by Country

SELECT 
    c.country_name,
    MAX(p.elevation) AS 'highest_peak_elevation',
    MAX(r.length) AS 'longest_river_length'
FROM
    countries  c
LEFT JOIN
`mountains_countries` as mc ON c.country_code = mc.country_code
LEFT JOIN
`peaks` as p ON mc.mountain_id = p.mountain_id
LEFT JOIN
`countries_rivers` as cr ON c.country_code = cr.country_code
LEFT JOIN
    `rivers` as r ON cr.river_id = r.id
GROUP BY c.country_name
ORDER BY `highest_peak_elevation` DESC , `longest_river_length` DESC , c.country_name
LIMIT 5;
