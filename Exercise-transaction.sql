
CREATE TABLE users
(
ID INTEGER ,
Name VARCHAR(20),
Email VARCHAR(20),
Account_no INTEGER UNIQUE,
PRIMARY KEY (ID,Account_no)
);

CREATE TABLE accounts
(
ID INTEGER,
Account_no INTEGER,
Balance INTEGER,
FOREIGN KEY (ID) REFERENCES users(ID),
FOREIGN KEY (Account_no) REFERENCES users(Account_no)
);

INSERT INTO users
VALUES (1,"userA","userA@gmail.com",15001),
(2,"userB","userB@gmail.com",15002),
(3,"userC","userC@gmail.com",15003),
(4,"userD","userD@gmail.com",15004),
(5,"userE","userE@gmail.com",15005),
(6,"userF","userF@gmail.com",15006),
(7,"userG","userG@gmail.com",15007);

INSERT INTO accounts
VALUES (1,15001,2500),
(2,15002,150),
(3,15003,5000),
(4,15004,700),
(5,15005,9990),
(6,15006,100),
(7,15007,66000); 

START TRANSACTION;
SET  @deposit_amount=1000;
UPDATE accounts
JOIN users ON accounts.ID=users.ID
SET accounts.balance = accounts.balance+@deposit_amount
WHERE users.name='userA';

SET @withdrawl_amount=500;
UPDATE accounts
JOIN users ON accounts.ID=users.ID
SET accounts.balance = accounts.balance-@withdrawl_amount
WHERE users.name='userA';

SET @transfer_amount=200;
UPDATE accounts
JOIN users ON accounts.ID=users.ID
SET accounts.balance = accounts.balance-@transfer_amount 
WHERE users.name='userA';
UPDATE accounts
JOIN users ON accounts.ID=users.ID
SET accounts.balance = accounts.balance+@transfer_amount
WHERE users.name='userB';
COMMIT;


