
-- LAB 01  Databases Introduction. Data Definition and Datatypes 


															-- 01 Create Tables

CREATE DATABASE name;

use name;

CREATE TABLE employees (
id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL
);

CREATE TABLE categories (
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50));

CREATE TABLE products (
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) NOT NULL,
category_id INT NOT NULL);


															--  02. Insert Data in Tables
                                                            
	-- Taka mySQL ме задължава да попълня всички полета, затова трябва да сложа и на ID
    INSERT INTO employees  VALUES
    (1,'Viktor', 'Slavov'),
    (2,'Petur', 'Ivanov'),
    (3,'Hristo', 'Ivanov');
    
    -- Така вече ясно показвам в кои полета какво искам да добавя
        INSERT INTO  employees (first_name, last_name)  VALUES
    ('Viktor', 'Slavov'),
    ('Petur', 'Ivanov'),
    ('Hristo', 'Ivanov');
    
            INSERT INTO  employees (first_name)  VALUES
    ('Viktor1'),
    ('Petur1'),
    ('Hristo1');
    
    -- ТОва не работи, защото сме казали, че last_name не може да бъде NULL
    
    SELECT * FROM employees;
    
    
    
															-- 03. Alter Tables
                    
                    
	ALTER TABLE employees
    ADD COLUMN middle_name VARCHAR(50) NOT NULL;
    
															-- 04. Adding Constraints
                    
	ALTER TABLE products
	ADD INDEX `fk_category_id_idx` (`category_id` ASC) VISIBLE;
    
    ALTER TABLE products
ADD CONSTRAINT `fk_category_id`
  FOREIGN KEY (`category_id`)
  REFERENCES categories (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
	
    
														-- 05. Modifying Columns
    
ALTER TABLE employees
MODIFY COLUMN middle_name VARCHAR(100);
