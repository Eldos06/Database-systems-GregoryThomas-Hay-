--TO DO: add other FK (TemplateID, DeskID)
CREATE TABLE tblCard
(CardID INT IDENTITY(1, 1) PRIMARY KEY,
DueAt DATE,
Easyfactor FLOAT,
Interval DATE,
Lapses INT DEFAULT 0,
State VARCHAR(30)
)
GO

CREATE TABLE tblReviewLog
(ReviewID INT IDENTITY(1, 1) PRIMARY KEY,
ReviewedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
Rating INT CHECK (Rating BETWEEN 1 AND 5),
TimeTakenMs INT, -- TO DO  !!! change the INT!!!
OldInterval INT,
NewInterval INT,
OldEasy FLOAT,
NewEasy FLOAT,
)
GO

--TO DO: add other FK (ModelID, OwnerUserID)
CREATE TABLE tblNote
(NoteID INT IDENTITY(1, 1) PRIMARY KEY,
Guid VARCHAR(100), -- why we need Guid what is it???
CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
)
GO

-- adding Foreign key tblCard --> tblReviewLog
ALTER TABLE tblReviewLog
ADD CONSTRAINT FK_tblCard_CardID FOREIGN KEY (CardID)
REFERENCES tblCard (CardID)
GO

ALTER TABLE tblCard
ADD CONSTRAINT FK_tblNote_NoteID FOREIGN KEY (NoteID)
REFERENCES tblNote (NoteID)
GO