CREATE DATABASE SHOP_DB

CREATE TABLE tblPRODUCT_TYPE (
    ProductTypeID INT IDENTITY(1,1) PRIMARY KEY,
    ProductTypeName VARCHAR(50) NOT NULL,
    ProductTypeDescr VARCHAR(255)
);

CREATE TABLE tblPRODUCT (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    ProductTypeID INT NOT NULL,
    ProductDescr VARCHAR(255),
    CONSTRAINT FK_PRODUCT_TYPE
        FOREIGN KEY (ProductTypeID)
        REFERENCES tblPRODUCT_TYPE(ProductTypeID)
);



CREATE TABLE tblCUSTOMER (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    Fname VARCHAR(50),
    Lname VARCHAR(50),
    BirthDate DATE
);

CREATE TABLE tblORDER (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    OrderDate DATE NOT NULL,
    CustomerID INT NOT NULL,
    CONSTRAINT FK_ORDER_CUSTOMER
        FOREIGN KEY (CustomerID)
        REFERENCES tblCUSTOMER(CustomerID)
);


CREATE TABLE tblORDER_PRODUCT (
    OrderProductID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    CONSTRAINT FK_OP_ORDER
        FOREIGN KEY (OrderID)
        REFERENCES tblORDER(OrderID),
    CONSTRAINT FK_OP_PRODUCT
        FOREIGN KEY (ProductID)
        REFERENCES tblPRODUCT(ProductID)
);

--====== INSERT =========--

INSERT INTO tblPRODUCT_TYPE (ProductTypeName, ProductTypeDescr)
VALUES
('Electronics','Electronic devices'),
('Clothing','Apparel'),
('Books','Printed books'),
('Food','Food items'),
('Furniture','Home furniture'),
('Toys','Children toys'),
('Sports','Sports equipment'),
('Beauty','Beauty products'),
('Health','Health products'),
('Stationery','Office supplies'),
('Garden','Garden tools'),
('Automotive','Car accessories'),
('Music','Music instruments'),
('Movies','DVD and Blu-ray'),
('Games','Video games'),
('Shoes','Footwear'),
('Accessories','Fashion accessories'),
('Pets','Pet supplies'),
('Tools','Hand tools'),
('Lighting','Lights'),
('Kitchen','Kitchen tools'),
('Office','Office equipment'),
('Outdoors','Outdoor gear'),
('Travel','Travel items'),
('Baby','Baby products'),
('Jewelry','Jewelry'),
('Art','Art supplies'),
('Education','Educational materials'),
('Software','Software licenses'),
('Hardware','Computer hardware');





INSERT INTO tblCUSTOMER (Fname, Lname, BirthDate)
VALUES
('John','Smith','1990-01-01'),
('Anna','Brown','1992-02-02'),
('Mike','Davis','1988-03-03'),
('Sara','Wilson','1995-04-04'),
('Alex','Taylor','1991-05-05'),
('Emma','Moore','1993-06-06'),
('David','Clark','1987-07-07'),
('Laura','Hall','1994-08-08'),
('James','Allen','1989-09-09'),
('Olivia','Young','1996-10-10'),
('Daniel','King','1990-11-11'),
('Sophia','Scott','1992-12-12'),
('Chris','Green','1986-01-13'),
('Linda','Adams','1991-02-14'),
('Robert','Baker','1985-03-15'),
('Mia','Gonzalez','1997-04-16'),
('Andrew','Nelson','1988-05-17'),
('Chloe','Carter','1994-06-18'),
('Brian','Mitchell','1989-07-19'),
('Grace','Perez','1993-08-20'),
('Kevin','Roberts','1991-09-21'),
('Lily','Turner','1995-10-22'),
('Steven','Phillips','1987-11-23'),
('Zoe','Campbell','1996-12-24'),
('Mark','Parker','1988-01-25'),
('Ella','Evans','1992-02-26'),
('Jason','Edwards','1990-03-27'),
('Nina','Collins','1994-04-28'),
('Paul','Stewart','1986-05-29'),
('Kate','Sanchez','1995-06-30');


INSERT INTO tblORDER (OrderDate, CustomerID)
VALUES
('2025-01-01',1),('2025-01-02',2),('2025-01-03',3),
('2025-01-04',4),('2025-01-05',5),('2025-01-06',6),
('2025-01-07',7),('2025-01-08',8),('2025-01-09',9),
('2025-01-10',10),('2025-01-11',11),('2025-01-12',12),
('2025-01-13',13),('2025-01-14',14),('2025-01-15',15),
('2025-01-16',16),('2025-01-17',17),('2025-01-18',18),
('2025-01-19',19),('2025-01-20',20),('2025-01-21',21),
('2025-01-22',22),('2025-01-23',23),('2025-01-24',24),
('2025-01-25',25),('2025-01-26',26),('2025-01-27',27),
('2025-01-28',28),('2025-01-29',29),('2025-01-30',30);


INSERT INTO tblORDER_PRODUCT (OrderID, ProductID, Quantity)
VALUES
(1,1,1),(2,2,2),(3,3,3),(4,4,1),(5,5,2),
(6,6,4),(7,7,1),(8,8,1),(9,9,2),(10,10,1),
(11,11,1),(12,12,3),(13,13,2),(14,14,1),(15,15,2),
(16,16,1),(17,17,2),(18,18,1),(19,19,1),(20,20,1),
(21,21,2),(22,22,3),(23,23,1),(24,24,2),(25,25,1),
(26,26,2),(27,27,1),(28,28,1),(29,29,2),(30,30,1);




INSERT INTO tblPRODUCT (ProductName, Price, ProductTypeID, ProductDescr)
VALUES
('Laptop', 1200,
    (SELECT ProductTypeID FROM tblPRODUCT_TYPE WHERE ProductTypeName = 'Electronics'),
    'Business laptop'),

('Smartphone', 800,
    (SELECT ProductTypeID FROM tblPRODUCT_TYPE WHERE ProductTypeName = 'Electronics'),
    'Android phone'),

('T-Shirt', 25,
    (SELECT ProductTypeID FROM tblPRODUCT_TYPE WHERE ProductTypeName = 'Clothing'),
    'Cotton shirt'),

('Jeans', 60,
    (SELECT ProductTypeID FROM tblPRODUCT_TYPE WHERE ProductTypeName = 'Clothing'),
    'Blue jeans'),

('Novel', 15,
    (SELECT ProductTypeID FROM tblPRODUCT_TYPE WHERE ProductTypeName = 'Books'),
    'Fiction book'),

('Notebook', 5,
    (SELECT ProductTypeID FROM tblPRODUCT_TYPE WHERE ProductTypeName = 'Stationery'),
    'Office notebook'),

('Chair', 90,
    (SELECT ProductTypeID FROM tblPRODUCT_TYPE WHERE ProductTypeName = 'Furniture'),
    'Office chair'),

('Table', 150,
    (SELECT ProductTypeID FROM tblPRODUCT_TYPE WHERE ProductTypeName = 'Furniture'),
    'Dining table'),

('Headphones', 70,
    (SELECT ProductTypeID FROM tblPRODUCT_TYPE WHERE ProductTypeName = 'Electronics'),
    'Wireless'),

('Keyboard', 40,
    (SELECT ProductTypeID FROM tblPRODUCT_TYPE WHERE ProductTypeName = 'Hardware'),
    'Mechanical'),

('Mouse', 30,
    (SELECT ProductTypeID FROM tblPRODUCT_TYPE WHERE ProductTypeName = 'Hardware'),
    'Gaming mouse'),

('Football', 25,
    (SELECT ProductTypeID FROM tblPRODUCT_TYPE WHERE ProductTypeName = 'Sports'),
    'Size 5'),

('Basketball', 28,
    (SELECT ProductTypeID FROM tblPRODUCT_TYPE WHERE ProductTypeName = 'Sports'),
    'Outdoor'),

('Toy Car', 18,
    (SELECT ProductTypeID FROM tblPRODUCT_TYPE WHERE ProductTypeName = 'Toys'),
    'Kids toy'),

('Puzzle', 12,
    (SELECT ProductTypeID FROM tblPRODUCT_TYPE WHERE ProductTypeName = 'Toys'),
    '500 pieces'),

('Cookbook', 22,
    (SELECT ProductTypeID FROM tblPRODUCT_TYPE WHERE ProductTypeName = 'Books'),
    'Cooking'),

('Sneakers', 95,
    (SELECT ProductTypeID FROM tblPRODUCT_TYPE WHERE ProductTypeName = 'Shoes'),
    'Running shoes'),

('Boots', 130,
    (SELECT ProductTypeID FROM tblPRODUCT_TYPE WHERE ProductTypeName = 'Shoes'),
    'Winter boots'),

('Watch', 200,
    (SELECT ProductTypeID FROM tblPRODUCT_TYPE WHERE ProductTypeName = 'Accessories'),
    'Smart watch'),

('Necklace', 300,
    (SELECT ProductTypeID FROM tblPRODUCT_TYPE WHERE ProductTypeName = 'Jewelry'),
    'Gold necklace'),

('Dog Food', 40,
    (SELECT ProductTypeID FROM tblPRODUCT_TYPE WHERE ProductTypeName = 'Pets'),
    '10kg pack'),

('Cat Toy', 8,
    (SELECT ProductTypeID FROM tblPRODUCT_TYPE WHERE ProductTypeName = 'Pets'),
    'Interactive'),

('Hammer', 20,
    (SELECT ProductTypeID FROM tblPRODUCT_TYPE WHERE ProductTypeName = 'Tools'),
    'Steel'),

('Screwdriver', 15,
    (SELECT ProductTypeID FROM tblPRODUCT_TYPE WHERE ProductTypeName = 'Tools'),
    'Flat head'),

('Lamp', 45,
    (SELECT ProductTypeID FROM tblPRODUCT_TYPE WHERE ProductTypeName = 'Lighting'),
    'Desk lamp'),

('Pan', 35,
    (SELECT ProductTypeID FROM tblPRODUCT_TYPE WHERE ProductTypeName = 'Kitchen'),
    'Non-stick'),

('Backpack', 60,
    (SELECT ProductTypeID FROM tblPRODUCT_TYPE WHERE ProductTypeName = 'Travel'),
    'Travel backpack'),

('Tent', 220,
    (SELECT ProductTypeID FROM tblPRODUCT_TYPE WHERE ProductTypeName = 'Outdoors'),
    '2-person tent'),

('Baby Bottle', 12,
    (SELECT ProductTypeID FROM tblPRODUCT_TYPE WHERE ProductTypeName = 'Baby'),
    'Plastic'),

('Antivirus', 50,
    (SELECT ProductTypeID FROM tblPRODUCT_TYPE WHERE ProductTypeName = 'Software'),
    '1 year license');
GO

--- creating NESTED PROCEDURE to use in the base procedure that begins on line 127
CREATE PROCEDURE yeldos_GetProdTypeID
	@PT_Name2 VARCHAR(50),
	@PT_ID_2     INT OUTPUT
	AS
	SET @PT_ID_2 = (SELECT ProductTypeID
					FROM tblPRODUCT_TYPE
					WHERE ProductTypeName = @PT_Name2)
GO

CREATE OR ALTER PROCEDURE yeldos_INSERT_tblPRODUCT
	@Pname	VARCHAR(50),
	@Price  NUMERIC(8,2),
	@PTname VARCHAR(50),
	@Pdescr VARCHAR(500)
	AS
	BEGIN
	DECLARE @PT_ID INT
	EXEC yeldos_GetProdTypeID
	@PT_Name2 = @PTname,
	@PT_ID_2  = @PT_ID

	IF @PT_ID IS NULL
		BEGIN
			PRINT '@PT_ID is empty, check spelling';
			THROW 55442, '@PT_ID can not be NULL', 1;
		END
	BEGIN TRAN T1
		INSERT INTO tblPRODUCT (ProductName, Price, ProductTypeID, ProductDescr)
		VALUES (@Pname, @Price, @PT_ID, @Pdescr)
		IF @@ERROR <> 0
			BEGIN
				PRINT('Something just prior to COMMIT')
				ROLLBACK TRAN T1
			END
		ELSE
			COMMIT TRAN T1
	END
GO
--- Objective: Write a nested procedure to fetch the ProductTypeID for a given ProductTypeName.

--Steps:

--Write a stored procedure yeldos_GetProdTypeID to return the ProductTypeID for a given ProductTypeName.
--Test the nested procedure by passing a ProductTypeName and retrieving the ProductTypeID.
CREATE OR ALTER PROCEDURE yeldos_GetProdTypeID
	@PTname2 VARCHAR(50),
	@PT_ID_2 INT OUTPUT
	AS
	SET @PT_ID_2 = (SELECT ProductTypeID
				    FROM tblPRODUCT_TYPE
					WHERE ProductTypeName = @PTname)
GO

-- Create or alter the procedure with correct parameters
CREATE OR ALTER PROCEDURE yeldos_Delete_Product
    @PTname VARCHAR(50),       -- The Product Type Name to delete
    @Pname1 VARCHAR(50),       -- New product name to insert
    @Price1 NUMERIC(8, 2),     -- New product price to insert
    @PTname1 VARCHAR(50),      -- New product type name to insert
    @Pdescr1 VARCHAR(500)      -- New product description to insert
AS
BEGIN
    DECLARE @PTID INT;

    -- Get ProductTypeID for the given ProductTypeName
    EXEC yeldos_GetProdTypeID @PT_Name2 = @PTname OUTPUT;

    -- Start a transaction
    BEGIN TRANSACTION;

    -- Delete the product type if the ProductTypeID exists
    DELETE FROM tblPRODUCT_TYPE 
    WHERE ProductTypeID = @PTID;

    -- Insert the new product
    EXEC yeldos_INSERT_tblPRODUCT
        @Pname = @Pname1,
        @Price = @Price1,
        @PTname = @PTname1,
        @Pdescr = @Pdescr1;

    -- Commit the transaction
    COMMIT TRANSACTION;
END;
GO

-- Execute the stored procedure and provide the parameters
EXEC yeldos_Delete_Product
    @PTname = 'Electronics',     -- Product Type to delete
    @Pname1 = 'Laptop',          -- New product name
    @Price1 = 1000,              -- New product price
    @PTname1 = 'Games',          -- New product type name
    @Pdescr1 = '1 TB SSD';       -- New product description



SELECT * FROM tblCARD








--- Nested Procedures Finished -----

CREATE OR ALTER PROCEDURE yeld_INSERT_tblPRODUCT
	@P_Name VARCHAR(50),
	@Price       NUMERIC(8, 2),
	@PT_Name     VARCHAR(50),
	@P_Descr	 VARCHAR(500)
	AS
	DECLARE @PT_ID INT
	SET @PT_ID = (SELECT ProductTypeID FROM tblPRODUCT_TYPE
			      WHERE ProductTypeName	 = @PT_Name)

	IF @PT_ID IS NULL
		BEGIN
			PRINT 'Hey it looks like @PT_ID is empty; check spelling';
			THROW 55442, '@PT_ID cannot be NULL, process is terminating', 1;
		END

	BEGIN TRAN T1
	INSERT INTO tblPRODUCT (ProductName, Price, ProductTypeID, ProductDescr)
	VALUES (@P_Name, @Price, @PT_ID, @P_Descr)
	IF @@ERROR <> 0
		BEGIN 
			PRINT('Something just prior to COMMIT')
			ROLLBACK TRAN T1
		END
	ELSE
		COMMIT TRAN T1
GO



EXEC yeld_INSERT_tblPRODUCT
@P_Name = 'SAMSUNG A52',
@Price  = 273,
@PT_Name = 'phonehjkjh',
@P_Descr = 'Phone Samsung Galaxy A52 is smart phone'

SELECT * FROM tblPRODUCT
GO




				
EXEC yeldos_INSERT_tblPRODUCT
@Pname	= 'Orange Juice 1L',
@Price  = 650,
@PTname = 'Food',
@Pdescr = 'Just enjoy'

SELECT * FROM tblPRODUCT
GO


CREATE OR ALTER PROCEDURE SET_Price_Type
	@ProductName     VARCHAR(50),
	@Price			 NUMERIC(8, 2),	
	@ProductTypeName VARCHAR(50)
	AS
	BEGIN
		DECLARE @PT_ID INT;

		--inline look up 
		SET @PT_ID = (SELECT ProductTypeID FROM tblPRODUCT_TYPE
					  WHERE ProductTypeName = @ProductTypeName)

		IF @PT_ID IS NULL
		BEGIN;
			THROW 55450, 'Invalid ProductTypeName', 1;
			RETURN;
		END

		UPDATE tblPRODUCT
		SET
			Price = @Price
			WHERE ProductName = @ProductName 
			AND   ProductTypeID = @PT_ID;

		
	END;
GO

SELECT ProductID, ProductName, Price, ProductTypeName FROM tblPRODUCT P
JOIN tblPRODUCT_TYPE PT ON P.ProductTypeID = PT.ProductTypeID
ORDER BY Price ASC;

EXEC SET_Price_Type
@ProductName     = 'Notebook',
@Price		     = 7.50,	
@ProductTypeName = 'Stationery';
GO


CREATE OR ALTER PROCEDURE DEL_tblPRODUCT
	@ProductName  VARCHAR(50),
	@ProductID    INT
	AS
	BEGIN
		DELETE FROM tblPRODUCT
		WHERE ProductName = @ProductName
		AND   ProductID   = @ProductID
	END
GO

EXEC DEL_tblPRODUCT
@ProductName = 'Cat Toy',
@ProductID   = 22
GO

CREATE OR ALTER PROCEDURE GetSubID
	@name VARCHAR(50),
	@SID INT OUTPUT
	AS
	SET @SID = (SELECT SubjectID FROM tblSUBJECT
				WHERE SubjectName = @name)
GO

CREATE OR ALTER PROCEDURE InsertDECK_IFSIDexist
	@DeckName VARCHAR(100),
	@DeckDescr VARCHAR(500),
	@SubName  VARCHAR(50),
	@OwnerID  INT


	AS
	BEGIN 
		DECLARE @SubID INT;

		EXEC GetSubID
		@name = @SubName,
		@SID = @SubID OUTPUT

		IF @SubID IS NULL
			BEGIN;
				THROW 50001, 'Subject does not exists, Check your spelling', 1;
			END

		BEGIN TRAN T1
			INSERT INTO tblDECK(DeckName, DeckDescr, OwnerID, SubjectID)
			VALUES             (@DeckName, @DeckDescr, @OwnerID, @SubID)
			
			IF @@ERROR <> 0
			BEGIN
				ROLLBACK TRAN T1;
				THROW 50002, 'Insert into tblDEKC failed', 1;
			END

			COMMIT TRAN T1
	END
GO

EXEC InsertDECK_IFSIDexist
	@DeckName = 'English Unit 4',
	@DeckDescr = 'Grammar, Vocabulary',
	@SubName = 'Computer Science' ,
	@OwnerID  = 2
GO
--ƒобавить карточку в деку только если Deck существует.

CREATE OR ALTER PROCEDURE GetDeckID
	@Dname VARCHAR(100),
	@Ddescr VARCHAR(500),
	@DeckID INT OUTPUT
	AS
	SET @DeckID = (SELECT DeckID FROM tblDECK
				   WHERE  DeckName = @Dname
				   AND    DeckDescr = @Ddescr)
GO

CREATE OR ALTER PROCEDURE INSERT_CARD
	@DeckName  VARCHAR(50),
	@DeckDescr VARCHAR(50),
	@CardFront VARCHAR(500),
	@CardBack  VARCHAR(500)
	
	AS
	BEGIN
		DECLARE @DID INT;

		EXEC GetDeckID
		@Dname = @DeckName,
		@Ddescr = @DeckDescr,
		@DeckID = @DID OUTPUT

		IF @DID IS NULL
			BEGIN;
				THROW 50001, 'Deck is not exist, check your spelling', 1;
			END

		BEGIN TRAN T1
			INSERT INTO tblCARD(DeckID, CardFront, CardBack)
			VALUES             (@DID,   @CardFront, @CardBack)

			IF @@ERROR <> 0
				BEGIN;
					ROLLBACK TRAN T1;
					THROW 50002, 'Something went wrong while INSERT', 1
				END
			COMMIT TRAN T1
	END

SELECT * FROM tblDECK
	
EXEC INSERT_CARD
	@DeckName  = 'Algebra Deck',
	@DeckDescr = 'Deck for algebra exercises',
	@CardFront = 'pi',
	@CardBack  ='3.14159265'

SELECT * FROM tblCARD
GO
CREATE OR ALTER PROCEDURE GetCardID
	@Front VARCHAR(500),
	@Back  VARCHAR(500),
	@DeckName VARCHAR(100),
	@DeckDescr VARCHAR(100)
	AS
	BEGIN
		DECLARE @DID INT;

		EXEC GetDeckID
		@Dname = @DeckName,
		@Ddescr = @DeckDescr,
		@DeckID = @DID OUTPUT

		IF @DID IS NULL
			BEGIN;
				THROW 50001, 'Deck is not exist, check your spelling', 1;
			END

CREATE OR ALTER PROCEDURE GetAssignID
	@
		



















			 