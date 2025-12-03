
--CREATE DATABASE YeldosS_Nov5

CREATE TABLE tblHOBBY_TYPE(
HobbyTypeID INT IDENTITY(1, 1) PRIMARY KEY,
HobbyTypeName VARCHAR(50) NOT NULL,
HobbyTypeDescr VARCHAR(500) NULL,)
GO

CREATE TABLE tblHOBBY
(HobbyID INT IDENTITY(1, 1) PRIMARY KEY,





CREATE TABLE tblPERSON_HOBBY
(PersonHabbyID INT INDENTITY(1, 1) PRIMARY KEY,
PersonID INT NOT NULL,
HobbyID INT NOT NULL,
BeginDate DATE NULL)
GO

ALTER TABLE tblPERSON_HOBBY
ADD 


INSERT INTO tblHOBBY_TYPE (HobbyTypeName, HobbyTypeDescr)
VALUES ('Team Sports', 'Any activity where there is physical competition'),
('Anr','Any activity where people are being creative'),
('Board Games', 'Any activity where people compete over a boxed game'),
