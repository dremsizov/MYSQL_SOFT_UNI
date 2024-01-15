
						--  01. Find All Information About Departments
-- С ORDER BY селектираме

SELECT * FROM departments 
ORDER BY department_id;

								-- 02. Find all Department Names
                                
-- Изкарваме всички имена от департментс, селектираме ги по департментс–ид
SELECT name from departments ORDER BY department_id;

								-- 03. Find Salary of Each Employee
                                
-- Взимаме определени колони - изреждаме със , колоните. 

SELECT first_name,last_name,salary FROM employees ORDER by employee_id;

					-- 04. Find Full Name of Each Employee
                    
SELECT first_name, middle_name,last_name FROM employees ORDER BY employee_id;


						-- 05. Find Email Address of Each Employee
                        
-- С CONCAT избираме кои стойности от таблицата да ДОЛЕПИМ заедно. С опцията AS избираме под какво име да ги обединим
		SELECT CONCAT(first_name, '.', last_name, '@softuni.bg') AS full_email_adress FROM employees;
        
        
					-- 06. Find All Different Employee’s Salaries
                    
	-- С опциетя DISTINCT казваме само по веднъж данните и ако има повтарящи се не ги показвай
SELECT DISTINCT salary FROM employees;


							-- 07. Find all Information About Employees
-- АКо искаме да додавим условие при търсенето добавяме WHERE... в случая казваме от таблицата job_title искаме само тези които са  Sales Representative

SELECT * FROM employees
WHERE job_title = 'Sales Representative' 
ORDER BY employee_id;

							-- 08. Find Names of All Employees by Salary in Range
                            
 -- За избиране на определен критерии можем да сложим ADD или BETWEEN
 
 -- Вариант 1 с AND
SELECT first_name, last_name, job_title FROM employees
WHERE salary >= 20000 AND salary <= 30000
ORDER BY employee_id;

-- Вариант 2 с BETWEEN --- тук казваме в кой диапазон

SELECT first_name, last_name, job_title FROM employees
WHERE salary BETWEEN  20000 AND 30000
ORDER BY employee_id;

								-- 9. Find Names of All Employees

-- Вариант 1 с изброяване
SELECT CONCAT (first_name, ' ', middle_name, ' ', last_name)
AS `Full Name`
FROM employees
WHERE salary = 25000 OR
	 salary = 14000 OR
     salary = 12500 OR
     salary = 23600;
     
     -- Вариант 2
     
     -- IN изброяваме, може за числа може и за стрингове
     SELECT CONCAT (first_name, ' ', middle_name, ' ', last_name)
AS `Full Name`
FROM employees
WHERE salary IN(25000, 14000, 12500,23600);

-- 12 


										-- 10. Find All Employees Without Manager
    
SELECT first_name, last_name FROM employees
WHERE manager_id IS NULL;


										-- 11. Find All Employees with Salary More Than
SELECT first_name, last_name, salary FROM employees
WHERE salary > 50000
ORDER BY salary DESC;


							-- 12. Find 5 Best Paid Employees
			
-- С LIMIT  избираме само колко данни да виждаме. В случая понеже селектираме по DESC ще даде първите 5						
SELECT first_name, last_name FROM employees
ORDER BY salary DESC
LIMIT 5;


							-- 13. Find All Employees Except Marketing

SELECT first_name, last_name FROM employees
WHERE department_id != 4;

										-- 14. Sort Employees Table 
                            
	-- Можем за всяка града да си дадем определена сортировка
	SELECT * FROM employees
    ORDER BY salary DESC, first_name,last_name DESC, middle_name;
    
    
										-- 15. Create View Employees with Salaries
    -- СЪЗДАВАНЕ НА VIEW. Това си е отделна визуацизацияalter
    -- Задължително първо си създаваме VIEW.ДАваме му име и добавяме AS  за да покажем какво искаме да има в това VIEW
    
CREATE VIEW v_employees_salaries AS
SELECT first_name, last_name, salary FROM employees;

SELECT * FROM v_employees_salaries;
    
    
									-- 16. Create View Employees with Job Titles
                                    
      -- CONCAT_WS --- WS - white space. Просто в началото казваме при конкатенация с какво да раделя? Така обаче ако има някъде НУЛЛ ще добавя " "                               
                                    
	CREATE VIEW v_employees_job_titles AS
    SELECT CONCAT(first_name, ' ', IF(middle_name IS NOT NULL, CONCAT(middle_name, ' '),''), last_name) AS full_name, job_title
    FROM employees;
    
    -- Изтриване на VIEW
    DROP ViEW v_employees_job_titles;
    
    
    SELECT * FROM v_employees_job_titles;




											--  17. Distinct Job Titles
                                            
	-- Distinct - взима ни уникални стойности не ни показва уникати
    
    SELECT DISTINCT job_title FROM employees
    ORDER BY job_title;
    
								-- 18. Find First 10 Started Projects
                                
	SELECT * FROM projects
    ORDER BY start_date, name
    LIMIT 10;
			
            
								-- 19. Last 7 Hired Employees
            
	SELECT first_name,last_name, hire_date FROM employees
    ORDER BY hire_date DESC
    LIMIT 7;
    

								-- 20. Increase Salaries
                 
 SELECT department_id FROM departments
 WHERE name IN ('Engineering', 'Tool Design', 'Marketing', 'Information Services');
 
 UPDATE employees
 SET salary = salary * 1.12
 WHERE department_id IN(1,2,4,11);
 
 SELECT salary FROM employees;



 UPDATE employees
SET salary = salary * 1.12
WHERE department_id IN (
SELECT department_id FROM departments
WHERE `name` IN ('Engineering',
'Tool Design',
'Marketing',
'Information Services')
);
SELECT salary FROM employees;


								-- 21. All Mountain Peaks

use geography;

SELECT peak_name FROM peaks 
ORDER BY peak_name;


						-- 22. Biggest Countries by Population
                        
SELECT country_name, population FROM countries
WHERE continent_code = 'EU'
ORDER BY population DESC, country_name
LIMIT 30;


						--  23. Countries and Currency (Euro / Not Euro)
-- При IF първо слагаме проверкката и какво да пише ако е правилно, а след това какво да напише ако не е  
                        
	SELECT country_name, country_code, IF(currency_code = "EUR", "Euro", "Not Euro") 
    AS currency
    FROM countries
    ORDER BY country_name;
    
    
					--  24. All Diablo Characters
                    
	use diablo;
    
    SELECT name FROM characters 
    ORDER BY name;