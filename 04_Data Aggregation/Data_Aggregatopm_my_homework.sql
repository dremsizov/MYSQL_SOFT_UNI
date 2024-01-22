
															-- EX DATA Aggregation

						-- 1. Records' Count

use gringotts;

-- С функцията COUNT избираме да ни преброи записаните файлове в дадената таблица. 
-- При * избираме всички, можем да сложим и нещо специфично (first_name)
SELECT COUNT(*) FROM wizzard_deposits;

-- лекторско решение

SELECT COUNT(*) AS 'count' FROM wizzard_deposits; 


					-- 02. Longest Magic Wand
          
          -- С опцията на МАХ сравняваме всички стойности в графата magic_wand_size, след което с AS просто си даваме име на новата таблица
	SELECT MAX(magic_wand_size) AS 'longest_magic_wand'
    FROM wizzard_deposits;


					-- 03. Longest Magic Wand per Deposit Groups


SELECT deposit_group,
MAX(magic_wand_size) AS 'longest_wand_size'
FROM wizzard_deposits
GROUP BY deposit_group
ORDER BY longest_wand_size ASC, deposit_group ASC;

					-- 4. Smallest Deposit Group Per Magic Wand Size*

SELECT deposit_group
FROM wizzard_deposits
GROUP BY deposit_group
LIMIT 1;

-- с ордер
SELECT deposit_group
FROM wizzard_deposits
GROUP BY deposit_group
ORDER BY AVG(magic_wand_size)
LIMIT 1;
					-- 05. Deposits Sum

-- Със финкцията СУМ избираме да сумираме.

SELECT deposit_group,
SUM(deposit_amount) AS 'total_sum'
FROM wizzard_deposits
GROUP BY deposit_group
ORDER BY total_sum ASC;

					-- 06. Deposits Sum for Ollivander Family

-- Тук с  WHERE си поставяме условието за това кой е правил магията. Трябва да се внимава за мястото на FROM.


SELECT deposit_group,
SUM(deposit_amount) AS 'total_sum'
FROM wizzard_deposits
WHERE magic_wand_creator = 'Ollivander family'
GROUP BY deposit_group
ORDER BY deposit_group ASC;

					-- 07. Deposits Filter
                    

SELECT deposit_group,
SUM(deposit_amount) AS 'total_sum'
FROM wizzard_deposits
WHERE magic_wand_creator = 'Ollivander family' 
GROUP BY deposit_group
HAVING total_sum < 150000
ORDER BY total_sum DESC;              
	
					-- 08. Deposit Charge
    
SELECT deposit_group, magic_wand_creator,
MIN(deposit_charge) AS min_deposit_charge
FROM wizzard_deposits
GROUP BY deposit_group, magic_wand_creator
ORDER BY magic_wand_creator ASC, deposit_group ASC;


					-- 09. Age Groups
                    
		-- При CASE  винаги завършваме с END!!! да не се забравя
                    
SELECT
  CASE
    WHEN age BETWEEN 0 AND 10 THEN '[0-10]'
    WHEN age BETWEEN 11 AND 20 THEN '[11-20]'
    WHEN age BETWEEN 21 AND 30 THEN '[21-30]'
    WHEN age BETWEEN 31 AND 40 THEN '[31-40]'
    WHEN age BETWEEN 41 AND 50 THEN '[41-50]'
    WHEN age BETWEEN 51 AND 60 THEN '[51-60]'
    ELSE '[61+]'
  END AS age_group,
  COUNT(*) AS wizard_count
FROM wizzard_deposits
GROUP BY age_group
ORDER BY MIN(age) ASC;


					-- 10. First Letter

SELECT LEFT(first_name, 1) as first_letter
FROM wizzard_deposits
WHERE deposit_group = 'Troll Chest'
GROUP BY first_letter
ORDER BY first_letter ASC;


					-- 11. Average Interest
                 
 SELECT deposit_group,is_deposit_expired, AVG(deposit_interest) AS 'average_interest'
 FROM wizzard_deposits
 WHERE deposit_start_date > '1985-01-01'
 GROUP BY deposit_group,is_deposit_expired
 ORDER BY deposit_group DESC, is_deposit_expired ASC;
 
 
			-- 12. Employees Minimum Salaries
            
use soft_uni;

SELECT department_id,
	MIN(salary) AS 'minimum_salary'
FROM employees
WHERE department_id IN(2,5,7)
AND hire_date > '2000-01-01'
GROUP BY department_id
ORDER BY department_id ASC;


-- 13. Employees Average Salaries

-- 1 вариант


CREATE TABLE highest_paid_employees 
SELECT * FROM employees -- по този начин създаваме нова таблица и взимаме текущите данни от вече съществуваща
WHERE salary > 30000;

DELETE FROM highest_paid_employees   -- изтриваме на данни от дадена таблица
WHERE manager_id = 42;

UPDATE highest_paid_employees   -- увеличаване на заплатите 
SET salary = salary + 5000
WHERE department_id = 1;

SELECT department_id, AVG(salary) AS 'avr_salary' FROM highest_paid_employees 
GROUP BY department_id
ORDER BY department_id;


-- втори вариант само с една заявка като селект
SELECT 
    `department_id`,
    CASE
        WHEN `department_id` = 1 THEN AVG(`salary`) + 5000
        ELSE AVG(`salary`)
    END AS 'avg_salary'
FROM
    `employees`
WHERE
    `salary` > 30000 AND `manager_id` != 42
GROUP BY `department_id`
ORDER BY `department_id`;





							-- 14. Employees Maximum Salaries

 -- Тук трябва да изпозлваме Having защото искаме да направим групиране и след това да направим конкретното филтриране
SELECT department_id,
MAX(salary) AS 'max_salary'
FROM employees
GROUP BY department_id
HAVING NOT `max_salary` BETWEEN 30000 AND 70000
ORDER BY department_id ASC;


-- 15. Employees Count Salaries

SELECT
COUNT(salary)
FROM employees
WHERE
ISNULL (manager_id);


-- 16. 3rd Highest Salary
		
		-- Вложени заявки 
        use soft_uni;
        
SELECT department_id, (SELECT DISTINCT salary FROM employees -- с distinct вчимаме само уникалните стойности
						WHERE e.department_id = department_id -- тук показваме че за селектнатият департамент от външанта заявха искаме да се мачва с  вътрешния
						ORDER BY salary DESC
						LIMIT 1 OFFSET 2) AS third_higest_salary  -- offset казва искам да пропуснеш първите два реда и да вземеш само третия --- LImit по принцип си работят с OFFSET 0)
FROM employees e
GROUP BY department_id
HAVING third_higest_salary  IS NOT NULL
ORDER BY department_id;





--  17. Salary Challenge


SELECT first_name,last_name,department_id 
FROM employees e
WHERE salary > (
	SELECT avg(salary)
    FROM employees
    WHERE department_id = e.department_id -- кръщаваме го с Е за да можем да го подадем на външната заявка
) -- Със () се отваря вложена заявка
ORDER BY department_id, employee_id
LIMIT 10;




-- 18. Departments Total Salaries

SELECT 
    department_id, SUM(salary) AS 'total_salary'
FROM
    employees
GROUP BY department_id
ORDER BY department_id ASC;

		

