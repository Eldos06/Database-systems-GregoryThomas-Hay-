-- "Madularity" ----> Modular code
--		~ writing tiny/small/exact pieces of code that can be plugged into other applications
--		~ re-used ---> all ober the place       
--		~ evidence of Organize or Die !!!

--		WHERE / WHEN DO WE Beneit?
--			1) BEFORE 2% (coded once)                  }      
--		    2) DURING 8% (paraler processing)		   ]---> RUNTIME
--			3) AFTER  	 			                   }





-- INSERT INTO tblProduct_Type
INSERT INTO tblPRODUCT_TYPE (ProductTypeName, ProductTypeDescr)
VALUES ('Fruit', 'Sweet, juicey, and grows on a tree'), ('Meat', 'Though, nutritious and grows in the dirt'), ('Clothing'
, 'Anything people wear')

INSERT INTO tblCUSTOMER (Fname, Lname, BirthDate)
VALUES ( 'Kenny', 'TheCat', 'Octover 20, 2012'), ('Mitch', 'TheCat', 'November 5, 2011')

CREATE PROCEDURE uspINSERT_PRODUCT
@ProdName varchar(50),
@PTName varchar(50),
@Price numeric(8, 2),
@Descr varchar (500)
AS
DECLARE @PTID INTEGER
SET @PTID = (SELECT ProductTypeID FROM tblPRODUCT_TYPE WHERE ProductTypeName = 'vegetable')

-- validate
IF @PTID = IS NULL
	BEGIN
		PRINT 'Hey...it looks like @PTID came back empty; please check';
		THROW 55434, '@PTID cannot be NULL; process is terminating', 1;
	END


BEGIN TRANSACTION 
INSERT INTO tblPRODUCT( ProductName, ProductTypeID, Price, ProductDescr)
VALUES (@ProdName, @PTID, @Price, @Descr)
COMMIT TRANSACTION


BEGIN TRANSACTION 
INSERT INTO tblPRODUCT( ProductName, ProductTypeID, Price, ProductDescr)
VALUES ('Pumpkin Squash',  (SELECT ProductTypeID FROM tblPRODUCT_TYPE WHERE 
		ProductTypeName = 'vegetable'), 6.58, 'Seasonal in autumn, usually fat,
		and full of seeds')  -- transaction
		--ACID
			-- implicit transaction --> automaic "implied"
			-- explicit transaction --> specified   


		 
SELECT *
FROM tblPRODUCT



-- second 




-- NOW show me how it works
EXECUTE  uspINSERT_PRODUCT
@ProdName = 'watermelon',
@PTName = 'Fruit',
@Price = 4.52,
@Descr = 'red, plump, sweet ... and hopefully cold'

SELECT * FROM tblPRODUCT

EXECUTE  uspINSERT_PRODUCT
@ProdName = 'ecectric Watermelon',
@PTName = 'Fruit',
@Price = 44.52,
@Descr = 'red, plump, sweet ... and expensive'



















