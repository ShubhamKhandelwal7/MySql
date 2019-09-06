CREATE TABLE testing_table
(
name VARCHAR(20),
contact_name VARCHAR(20),
roll_no VARCHAR(10)	
);

ALTER TABLE testing_table
DROP COLUMN name,
CHANGE COLUMN contact_name username VARCHAR(20) ,
ADD COLUMN first_name VARCHAR(20),
ADD COLUMN last_name VARCHAR(20),
MODIFY roll_no INTEGER;


