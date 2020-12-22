CREATE DATABASE test_store_procedure;
SHOW DATABASES;
USE test_store_procedure;

/* script SQL CREATE TABLE */

CREATE TABLE Orders (
	OrderID INT NOT NULL,
	OrderNumber INT NOT NULL,
	PersonID INT,
	PRIMARY KEY (OrderID)	
);

/* script SQL Store Procedure create table */

DELIMITER //
CREATE PROCEDURE Stored_Procedure_CreatingTable()
BEGIN
	CREATE TABLE DemoTable
	(
		Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
		UseFirstName VARCHAR(20),
		UserLastName VARCHAR(20)
	);
END;

CALL Stored_Procedure_CreatingTable();

/* store procedure insert data to tabel */

DELIMITER //
CREATE PROCEDURE Stored_Procedure_InsertTabel()
BEGIN
DECLARE i INT DEFAULT 1;
while (i <= 10) DO
	INSERT INTO demotable (Id, UseFirstName, UserLastName) VALUES (i, 'irsal' , 'yunus');
	SET i = i+1;
END while;
END

CALL Stored_Procedure_InsertTabel();

/* store procedure update data by parameter id to tabel */

DELIMITER //
CREATE PROCEDURE Stored_Procedure_UpdateTabel(fName VARCHAR(20), lName VARCHAR (20))
BEGIN
UPDATE demotable
SET UseFirstName=fName,
UserLastName=lName
WHERE Id=1;
END

CALL Stored_Procedure_UpdateTabel('muhamad','yunus');

/* store procedure delete data by parameter id to tabel */

DELIMITER //
CREATE PROCEDURE Stored_Procedure_DeleteTabel()
BEGIN
DELETE FROM demotable;
END

CALL Stored_Procedure_DeleteTabel();

DROP procedure Stored_Procedure_DeleteTabel;

/* store procedure insert data to multiples tabel */

DELIMITER //
CREATE PROCEDURE Stored_Procedure_InsertMultipleTabel()
BEGIN
DECLARE i INT DEFAULT 1;
while (i <= 10) DO
	INSERT INTO demotable (Id, UseFirstName, UserLastName) VALUES (i, 'irsal' , 'yunus');
	INSERT INTO orders (OrderID, OrderNumber, PersonID) VALUES (i, i, i);
	SET i = i+1;
END while;
END

CALL Stored_Procedure_InsertMultipleTabel();

/* Checking if a temporary table exists Store Procedure */

DELIMITER //
CREATE PROCEDURE check_table_exists(table_name VARCHAR(100)) 
BEGIN
    DECLARE CONTINUE HANDLER FOR SQLSTATE '42S02' SET @err = 1;
    SET @err = 0;
    SET @table_name = table_name;
    SET @sql_query = CONCAT('SELECT 1 FROM ',@table_name);
    PREPARE stmt1 FROM @sql_query;
    IF (@err = 1) THEN
        SET @table_exists = 0;
    ELSE
        SET @table_exists = 1;
        DEALLOCATE PREPARE stmt1;
    END IF;
END //
DELIMITER ;

/* call store procedure by parameter table exist */
CALL check_table_exists('credits');
SELECT @table_exists;
