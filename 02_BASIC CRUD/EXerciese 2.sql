
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


										-- 10. Find All Employees Without Manager
    
SELECT first_name, last_name FROM employees
WHERE manager_id IS NULL;


										-- 11. Find All Employees with Salary More Than
SELECT first_name, last_name, salary FROM employees
WHERE salary > 50000
ORDER BY salary DESC;
