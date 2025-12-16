CREATE DATABASE BankSystem;

CREATE TABLE balances (
	balanceID  INT IDENTITY(1, 1) PRIMARY KEY,
	userID INT,
	amount INT,
)

INSERT INTO balances (userID, amount) VALUES
	(1, 100), (2, 100);

SELECT * FROM balances b;	


BEGIN;
UPDATE balances SET amount = amount - 100 WHERE balanceID = 1;
UPDATE balances SET amount = amount + 100 WHERE balanceID = 2;
END;
 
SELECT * FROM balances b;	


CREATE TABLE example_table (
	id INT IDENTITY(1, 1) PRIMARY KEY,
	value INTEGER CHECK (value >= 0)
);

BEGIN TRAN;
INSERT INTO example_table (value) VALUES (1);
INSERT INTO example_table (value) VALUES (-1);
ROLLBACK;


