

-- LAB 1
CREATE DATABASE relations; 
USE relations;

DROP TABLE mountains; 
CREATE TABLE mountains(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50) NOT NULL  
);

CREATE TABLE peaks (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50) NOT NULL,
-- за да дефинираме foreign key трябва да сложим constrain
--  когато правим връзка ни трябва колона - в случая mountain_id
-- за да обвържем две таблици използваме constraint но ни трябва някакво ограничение затова създаваме  fk_peaks_mountains_id_mountains_id
-- След това ясно посочваме ограничението какъв вид да е, в случая foreign key
-- след това трябва да кажем  информацяита от foreign key трябва да съответства на данните от таблицата и конкретната колона
mountain_id INT,
CONSTRAINT fk_peaks_mountain_id_mountains_id
FOREIGN KEY (mountain_id)
REFERENCES mountains(id)
);

INSERT INTO mountains(name) VALUES
('Pirin'),
('Rila');

INSERT INTO peaks (name, mountain_id) VALUES
('Musala', 2);

SElECT * FROM mountains;

						-- JOIN
                        
                        
                        
SELECT *
FROM peaks
JOIN mountains ON
peaks.mountain_id = mountains.id;


use camp;

SELECT * FROM campers;



 -- lab 2
SELECT vehicles.driver_id AS 'driver_id'
, vehicle_type,
CONCAT (campers.first_name, ' ', campers.last_name) AS 'driver_name'
 FROM vehicles
	JOIN campers ON vehicles.driver_id = campers.id;
    
    
    -- lab 3
    
SELECT starting_point AS 'route_starting_point',
end_point AS 'route_end_point',
leader_id,
CONCAT(first_name, " ", last_name) AS 'leader_name'
FROM routes
JOIN campers ON routes.leader_id = campers.id;


-- CASCADE

-- Първично MYSQL ни пази от триенето на данни от една таблица свързана с foreign key
				-- CASCADE DELETE or UPDATE
                
	-- CASCADE се поставя на последно място след REFERANCE
    
    
    CREATE TABLE peaks (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50) NOT NULL,
mountain_id INT,
CONSTRAINT fk_peaks_mountain_id_mountains_id
FOREIGN KEY (mountain_id)
REFERENCES mountains(id)
);


-- При Cascade като триен от страна на foreign_key не рефлектира върху  primary_key
-- КОгата изтирваме primary_key или parent тогава се изтриват и децата