CREATE SCHEMA myJoinsDB;
CREATE TABLE emploees
(
emploees_id INTEGER NOT NULL auto_increment, 
name_emploees VARCHAR(30),
phone_emploees INTEGER,
PRIMARY KEY (emploees_id)
);

insert into emploees (name_emploees, phone_emploees) values ('Lesya', 0664380410);
insert into emploees (name_emploees, phone_emploees) values ('Stas', 0502226070);
insert into emploees (name_emploees, phone_emploees) values ('Nikolay', 0663535345);

ALTER TABLE `myjoinsdb`.`emploees` 
ADD COLUMN `funktion_id` INT NULL AFTER `emploees_id`;

ALTER TABLE `myjoinsdb`.`emploees` 
ADD COLUMN `details_id` INT NULL AFTER `funktion_id`;

ALTER TABLE `myjoinsdb`.`emploees` ADD CONSTRAINT fk_funktion
FOREIGN KEY (funktion_id) REFERENCES funktion (funktion_id);

ALTER TABLE `myjoinsdb`.`emploees` ADD CONSTRAINT fk_details
FOREIGN KEY (details_id) REFERENCES details (details_id);


UPDATE `myjoinsdb`.`emploees` SET `funktion_id` = '1' WHERE (`emploees_id` = '1');
UPDATE `myjoinsdb`.`emploees` SET `funktion_id` = '2' WHERE (`emploees_id` = '2');
UPDATE `myjoinsdb`.`emploees` SET `funktion_id` = '3' WHERE (`emploees_id` = '3');

UPDATE `myjoinsdb`.`emploees` SET `details_id` = '1' WHERE (`emploees_id` = '1');
UPDATE `myjoinsdb`.`emploees` SET `details_id` = '2' WHERE (`emploees_id` = '2');
UPDATE `myjoinsdb`.`emploees` SET `details_id` = '3' WHERE (`emploees_id` = '3');

CREATE TABLE funktion
(
funktion_id INTEGER NOT NULL auto_increment, 
salary_emploees INTEGER,
position_emploees VARCHAR(20),
PRIMARY KEY (funktion_id)
);

insert into funktion (salary_emploees, position_emploees) values (120000, 'Director');
insert into funktion (salary_emploees, position_emploees) values (35000, 'Manager');
insert into funktion (salary_emploees, position_emploees) values (15000, 'Worker');

CREATE TABLE details
(
details_id INTEGER NOT NULL auto_increment, 
family_status VARCHAR(10),
date_birth VARCHAR(10),
place_live VARCHAR(20),
PRIMARY KEY (details_id)
);

insert into details (family_status, date_birth, place_live) values ('married', '1982-09-24','Kyiv');
insert into details (family_status, date_birth, place_live) values ('married', '1980-11-30','Ternopil');
insert into details (family_status, date_birth, place_live) values ('married', '1964-05-01','Kyiv');
UPDATE `myjoinsdb`.`details` SET `family_status` = 'unmarried' WHERE (`details_id` = '3');

DROP TABLE details;

-- 1) Получите контактные данные сотрудников (номера телефонов, место жительства)

SELECT emploees.name_emploees, emploees.phone_emploees, details.place_live FROM emploees
INNER JOIN details 
ON details.details_id = emploees.emploees_id 
;
-- 2) Получите информацию о дате рождения всех холостых сотрудников и их номера.

SELECT emploees.name_emploees, emploees.phone_emploees, details.date_birth FROM emploees
INNER JOIN details 
ON details.details_id = emploees.emploees_id 
WHERE details.family_status = 'unmarried'
;

-- 3) Получите информацию обо всех менеджерах компании: дату рождения и номер телефона. 
SELECT emploees.name_emploees, funktion.position_emploees, details.date_birth FROM emploees
JOIN funktion ON emploees.emploees_id=funktion.funktion_id
JOIN details ON emploees.details_id=details.details_id
WHERE funktion.position_emploees = 'Manager';

;






