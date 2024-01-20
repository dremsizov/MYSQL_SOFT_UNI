
                                                   -- Exercises: Data Definition and Data Types

													-- Създаване на базаданни --
-- 0. Create Database
CREATE DATABASE minions;

-- За да кажем коя база данни искаме да използваме
USE minions;


                                                                     -- 1. Create Tables

CREATE TABLE minions (
id INT AUTO_INCREMENT PRIMARY KEY,  
name VARCHAR(50) ,
age INT  
);

CREATE TABLE towns (
town_id INT PRIMARY KEY,
name VARCHAR(50)
);


SELECT * FROM minions;
SELECT * FROM towns;


                                                                   -- 2. Alter Minions Table
                                                                   
     -- С  alter table  избираме коя да ни бъде таблицата, след което сменяме                                                              
ALTER TABLE towns
RENAME COLUMN town_id TO id;

	-- Създаваме нова колона - ЗАДЪЛЖИТЕЛНО е да сложим ккаъв тип ще е колоната
ALTER TABLE minions
ADD COLUMN town_id INT;

	-- Създаваме  foreign key - първо влизаме в папката и казваме коя колона след това в коя таблица коя колона да се свърже
ALTER TABLE minions	
ADD CONSTRAINT fk_minions_towns
FOREIGN KEY (town_id) REFERENCES towns(id);

                                                                 -- 3. Insert Records in Both Tables
                                                                 
		-- За да добавим данни в първата таблица трябва първо да добавим градове във втората. Първо опоменаваме в коя таблица искаме да добавяме след това се изброяват всички колони
	

INSERT INTO towns (id,name)
VALUES (1,'Sofia');
INSERT INTO towns (id,name)
VALUES (2,'Plovdiv');
INSERT INTO towns (id,name)
VALUES (3,'Varna');


INSERT INTO minions (id,name,age,town_id)
VALUES (1,'Kevin',22,1);
INSERT INTO minions (id,name,age,town_id)
VALUES (2,'Bob',15,3);
INSERT INTO minions (id,name,age,town_id)
VALUES (3,'Steward',NULL,2);


																	-- 4.Truncate Table Minions
                -- изтриване на всички данни от дадена таблица / изтриване на всички редове. Това се праси с TRUNCATE с DELET можем да кажем как да изтрием само конкретен запис -- DELETE FROM TABLENAME WHERE COLUMNAME='rowNAME';                                                   
TRUNCATE TABLE minions;

                                                                   -- 5. Drop All Tables
			-- С  DROP изтрива, като просто казваме DROP TABLE и избираме коя таблица да изтрием
                                                                   
DROP TABLE minions;
DROP TABLE towns;


																-- 6. Create Table People
                                                                
		-- BLOB  използваме за определен стринг с големинаalter
        -- BLOB values are treated as binary strings (byte strings). They have the binary character set and collation, and comparison and sorting are based on the numeric values of the bytes in column values. 
        -- TEXT values are treated as nonbinary strings (character strings). They have a character set other than binary, and values are sorted and compared based on the collation of the character set.
	
    -- CHAR - за определн текст в случая даваме само една опция 
    
    CREATE TABLE people(
    id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    picture MEDIUMBLOB,
    height DECIMAL(6,2) ,
    weight DECIMAL(6,2) ,
    gender CHAR(1) NOT NULL,
    birthdate DATE NOT NULL,
    biography BLOB
    );

DROP TABLE people;
		
        -- Добавяне на данни в таблица пишен INSERT INTO избираме таблицата, след което сладаме колоните, където искаме да има данни и добавяме задължително VALUES
    INSERT INTO people (name,picture,height,weight,gender,birthdate,biography) VALUES
    ('Vito','pic',1.80,70,'m','1990-12-02','test'),
	('Mary','pic',1.60,50,'f','1992-10-09','test'),
    ('Petia','pic',1.70,60,'f','1994-1-12','test'),
	('Ivo','pic',1.90,100,'m','1989-1-12','test'),
    ('Simo','pic',1.85,80,'m','1990-1-12','test');

SELECT * FROM people;


													-- 7. Create Table Users
		-- UNIQUE -- това се добавя за уникалност или задължителност,
        --  profile_picture BLOB CHECK(LENGTH(profile_picture) <= 921600), когато искаме ограничение
        
	CREATE TABLE users(
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(30) UNIQUE ,
    password VARCHAR(26) NOT NULL,
    profile_picture BLOB CHECK(LENGTH(profile_picture) <= 921600),
    last_login_time DATETIME,
    is_deleted BOOLEAN
    );
    
    INSERT INTO users (username,password, profile_picture,last_login_time,is_deleted) VALUES
('simo','345','test',(NOW()), false),   -- (NOW()) това се изпозлва за да може времето да е сега NOW
('pepi','12345','test1',(NOW()), true),
('lora','123','test2',(NOW()), false),
('maya','1245','test3',(NOW()), true),
('gogo','245','test4',(NOW()), true);


SELECT * FROM users;


													-- 08. Change Primary Key
                                                    
		--  Като изтирем ПК трябва да посочим нов
                                                    
 ALTER TABLE users DROP PRIMARY KEY,
 ADD CONSTRAINT pk_users PRIMARY KEY (id,username);
 
 -- Друг работещ начин

ALTER TABLE users DROP PRIMARY KEY,
ADD PRIMARY KEY (id, username);


													-- 9. Set Default Value of a Field
                                                    
					-- Тум можем да напрвим промяна по няколко начина. Първо с CHANGE като пишем колонята която да променим след това пак колконата която ще променяме а стойностите следват така старата към новата с DEFAULT междутях
ALTER TABLE users
CHANGE last_login_time last_login_time DATETIME DEFAULT CURRENT_TIMESTAMP ;

-- Втори начин 
-- Използвайки ALTER COLUMN избираме колоната и директно с SET DAFAULT посочваме новият тип

ALTER TABLE users
ALTER COLUMN last_login_time SET DEFAULT (NOW());




														-- 10. Set Unique Field
                                                        
ALTER TABLE users DROP PRIMARY KEY,
ADD PRIMARY KEY(id),
ADD CONSTRAINT unique_username UNIQUE (username);


														-- 11 Movies Database
                                                        
CREATE DATABASE movies;

USE movies;

CREATE TABLE directors (
id INT AUTO_INCREMENT PRIMARY KEY,
director_name VARCHAR(80) NOT NULL,
notes TEXT
);

CREATE TABLE genres (
id INT AUTO_INCREMENT PRIMARY KEY,
genre_name VARCHAR(80) NOT NULL,
notes TEXT
);

CREATE TABLE categories (
id INT AUTO_INCREMENT PRIMARY KEY,
category_name VARCHAR(80) NOT NULL,
notes TEXT
);

CREATE TABLE movies (
id INT AUTO_INCREMENT PRIMARY KEY,
title VARCHAR(100) NOT NULL,
director_id INT,
copyright_year YEAR,
length TIME,
genre_id INT,
category_id INT,
rating DOUBLE,
notes TEXT
);

INSERT INTO directors (director_name, notes) VALUES
('Spilsburg', 'This is nice'),
('Spilsburg1', 'This is nice2'),
('Spilsburg2', 'This is nice3'),
('Spilsburg3', 'This is nice4'),
('Spilsburg4', 'This is nice5');


INSERT INTO genres (genre_name, notes) VALUES
('TEST 1', 'This is note 1'),
('TEST 2', 'This is note 2'),
('TEST 3', 'This is note 3'),
('TEST 4', 'This is note 4'),
('TEST 5', 'This is note 5');

INSERT INTO categories (category_name, notes) VALUES
('TEST 1', 'This is note 1'),
('TEST 2', 'This is note 2'),
('TEST 3', 'This is note 3'),
('TEST 4', 'This is note 4'),
('TEST 5', 'This is note 5');

INSERT INTO movies (title, director_id, copyright_year, length, gerne_id, category_id, rating, notes) 
VALUES
	("TEST 1", 3, "2024", "00:01:00", 2, 4, 5.0, 'This is note 1'),
	("TEST 2", 2, "2023", "00:02:00", 2, 1, 9.2, 'This is note 2'),
	("TEST 3", 1, "2022", "00:03:00", 3, 1, 7.2, 'This is note 3'),
	("TEST 4", 5, "2021", "00:04:00", 5, 5, 8.2, 'This is note 4'),
	("TEST 1", 4, "2020", "00:05:00", 4, 2, 6.0, 'This is note 5');



								-- 12. Car Rental Database
                                
CREATE DATABASE car_rental;
USE car_rental;

CREATE TABLE categories (
id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
category VARCHAR(50),
daily_rate DECIMAL, 
weekly_rate DECIMAL, 
monthly_rate DECIMAL, 
weekend_rate DECIMAL
);

CREATE TABLE cars (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
plate_number INT,
make VARCHAR(50),
model VARCHAR(50),
car_year YEAR,
category_id INT,
doors SMALLINT,
picture BLOB,
car_condition VARCHAR(50),
available BOOLEAN
);

CREATE TABLE employees (
id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50),
title VARCHAR(100),
notes TEXT
);

CREATE TABLE customers (
id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
driver_licence_number INT NOT NULL,
full_name VARCHAR(100),
adress VARCHAR(100),
city VARCHAR(50),
zip_code SMALLINT,
notes TEXT
);

CREATE TABLE rental_orders (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
employee_id INT NOT NULL,
customer_id INT NOT NULL,
car_id INT NOT NULL,
car_condition VARCHAR(50),
tank_level DECIMAL,
kilometrage_start INT,
kilometrage_edn INT,
total_kilometrage INT,
start_data DATE,
end_date DATE,
tatal_days INT,
rate_applied DECIMAL,
tax_rate DECIMAL,
order_status VARCHAR(50),
notes TEXT
);

INSERT INTO categories (category,daily_rate,weekly_rate,monthly_rate,weekend_rate) VALUES
('car', 4.5,5,2,5),
('car2', 4.5,5,2,5),
('car3', 4.5,5,2,5);

INSERT INTO cars(plate_number, make, model, car_year, category_id, doors, picture, car_condition, available)
VALUES
	(1, 'test', 'bmw', 1998, 1, 3, 'test', 'good', true),
	(2, 'test', 'opel', 2022, 3, 5, 'test', 'perfect', false),
	(3, 'test', 'nisan', 2000, 2, 4, 'test', 'good', false);

INSERT INTO employees(first_name, last_name, title, notes)
VALUES
	("Vito", 'Ivanov', 'test', 'good note'),
	("Maria", 'Hristova', 'test', 'good note'),
	("Simo", NULL, 'test', 'good note');


INSERT INTO customers(driver_licence_number, full_name, adress, city, zip_code, notes)
VALUES
	(12, 'Ivan Georgiev', 'adress1' 'Sofia', 1202, 'good note'),
	(25, 'Simona Petrova', 'adress2','Plovdiv', 1200, 'good note'),
	(545, 'Viktor', 'adress3' 'Tutrakan', 5500, 'good note');
    
    INSERT INTO customers(driver_licence_number, full_name, adress, city, zip_code, notes)
VALUES
	("1", NULL, NULL, NULL, NULL, NULL),
	("2", NULL, NULL, NULL, NULL, NULL),
	("3", NULL, NULL, NULL, NULL, NULL);
    
    INSERT INTO rental_orders(employee_id, customer_id, car_id, car_condition, tank_level, kilometrage_start, kilometrage_edn, total_kilometrage, start_data, end_date, tatal_days, rate_applied, tax_rate, order_status, notes)
VALUES
	(1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(2, 2, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(3, 3, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
    
    
    
							-- 13. Basic Insert
	DROP DATABASE soft_uni;
    
    CREATE DATABASE soft_uni;
    
    use soft_uni;
    
    CREATE TABLE towns(
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    name VARCHAR (80) 
    );
    CREATE TABLE addresses (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    address_text VARCHAR(80) NOT NULL,
    town_id INT,
    FOREIGN KEY (town_id) REFERENCES towns(id)
    );
    
    CREATE TABLE departments (
    id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name VARCHAR(80)
    );
    
    CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    first_name VARCHAR(50),
    middle_name VARCHAR(50),
    last_name VARCHAR(50),
    job_title VARCHAR(50),
    department_id INT,
    hire_date DATE,
    salary DECIMAL(6.2),
    address_id INT, 
    FOREIGN KEY(department_id) REFERENCES departments(id),
    FOREIGN KEY(address_id) REFERENCES addresses(id)
    );
    
    INSERT INTO towns(name) VALUES
    ('Sofia'),
    ('Plovdiv'),
    ('Varna'),
    ('Burgas');
    
    INSERT INTO departments(name) VALUES
    ("Engineering"),
	("Sales"),
	("Marketing"),
	("Software Development"),
	("Quality Assurance");
    
    INSERT INTO employees(first_name, middle_name, last_name, job_title, department_id, hire_date, salary, address_id)
VALUES
	("Ivan", "Ivanov", "Ivanov", ".NET Developer", 4, "2013-02-01", 3500, NULL),
	("Petar", "Petrov", "Petrov", "Senior Engineer", 1, "2004-03-02", 4000, NULL),
	("Maria", "Petrova", "Ivanova", "Intern", 5, "2016-08-28", 525.25, NULL),
	("Georgi", "Terziev", "Ivanov", "CEO", 2, "2007-12-09", 3000, NULL),
	("Peter", "Pan", "Pan", "Intern", 3, "2016-08-28", 599.88, NULL);
    
    
											--  14. Basic Select All Fields
                                            
	SELECT * FROM towns;
    SELECT * FROM departments;
    SELECT * FROM employees;
    
    
											-- 15. Basic Select All Fields and Order Them
    
			-- use DESC for  descending  от високо към малко
	SELECT * FROM towns
    ORDER BY name;
    SELECT * FROM departments
     ORDER BY name;
    SELECT * FROM employees
	ORDER BY salary DESC;
    
    
											-- 16. Basic Select Some Fields
                                            
	SELECT name FROM towns ORDER BY name;
    SELECT name FROM departments ORDER BY name;
    SELECT first_name,last_name,job_title,salary FROM employees ORDER BY salary DESC;
    
    
    
										-- 17. Increase Employees Salary
			-- ПЪрво казваме в коя таблица искаме UPDATE
            -- СЛед това със SET избираме коя колона искаме да променим
           
    -- Първи вариант 
    
	UPDATE employees
    SET salary = salary * 1.1;
    SELECT salary FROM employees;
    
    -- Може да се появи грешка:  Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.  To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.
    -- Тази грешка се поправя с този код: 
    SET SQL_SAFE_UPDATES = 0;
    
    
    -- Втори вариант за решение  без използването на горния код
UPDATE employees
SET salary = salary * 1.1
WHERE id > 0;
 SELECT salary FROM employees;
    
    
    
    

    
    
    