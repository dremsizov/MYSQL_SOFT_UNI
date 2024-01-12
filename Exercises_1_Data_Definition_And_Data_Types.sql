
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

