CREATE DATABASE testUniversity

CREATE TABLE tblSTUDENT(
StudentID INT IDENTITY(1, 1) PRIMARY KEY,
FirstName VARCHAR(50) NOT NULL,
LastName  VARCHAR(50) NOT NULL,
BirthDate DATE NOT NULL,
Email     NVARCHAR(100) NULL,
);

CREATE TABLE tblTASK_TYPE(
TaskTypeID      INT IDENTITY(1, 1) PRIMARY KEY,
TaskTypeName    VARCHAR(50) NOT NULL UNIQUE,
IsPhysicalLabor BIT NOT NULL DEFAULT 0
); 

CREATE TABLE tblTASK(
TaskID          INT IDENTITY(1, 1) PRIMARY KEY,
TaskName	    VARCHAR(100) NOT NULL,
TaskDescription VARCHAR(500) NULL,
TaskTypeID      INT NOT NULL
); 

CREATE TABLE tblREVIEW_TYPE(
ReviewTypeID   INT IDENTITY(1, 1) PRIMARY KEY,
ReviewTypeName VARCHAR(50) NOT NULL UNIQUE,
); 

CREATE TABLE tblRATING(
RatingID    INT IDENTITY(1, 1) PRIMARY KEY,
RatingName  VARCHAR(50) NOT NULL UNIQUE,
RatingValue TINYINT NOT NULL
); 

CREATE TABLE tblSTUDENT_TASK(
StudentTaskID INT IDENTITY(1, 1) PRIMARY KEY,
StudentID     INT NOT NULL,
TaskID        INT NOT NULL,
AssignedDate  DATE NOT NULL,
DueDate       DATE NULL,
CompletedDate DATE NULL,
); 

CREATE TABLE tblREVIEW(
ReviewID	   INT IDENTITY(1, 1) PRIMARY KEY,
StudentTaskID  INT NOT NULL,
ReviewTypeID   INT NOT NULL,
RatingID	   INT NOT NULL,
ReviewComments VARCHAR(1000) NULL,
ReviewDate     DATE NOT NULL
); 

ALTER TABLE tblTASK
ADD CONSTRAINT FK_TASK_TASK_TYPE
	FOREIGN KEY (TaskTypeID)
	REFERENCES tblTASK_TYPE(TaskTypeID);

ALTER TABLE tblSTUDENT_TASK
ADD CONSTRAINT FK_STUDENT_TASK_STUDENT
	FOREIGN KEY (StudentID)
	REFERENCES tblSTUDENT(StudentID),
	CONSTRAINT FK_STUDENT_TASK_TASK
	FOREIGN KEY (TaskID)
	REFERENCES tblTASK(TaskID);


ALTER TABLE tblREVIEW
ADD CONSTRAINT FK_REVIEW_STUDENT_TASK
	FOREIGN KEY (StudentTaskID)
	REFERENCES tblSTUDENT_TASK(StudentTaskID),
	CONSTRAINT FK_REVIEW_REVIEW_TYPE
	FOREIGN KEY (ReviewTypeID)
	REFERENCES tblREVIEW_TYPE(ReviewTypeID),
	CONSTRAINT FK_REVIEW_RATING
	FOREIGN KEY (RatingID)
	REFERENCES tblRATING(RatingID);






INSERT INTO tblSTUDENT (FirstName, LastName, BirthDate, Email)
VALUES 
('Alex',  'Smith','2005-03-15', 'alex.smith@example.com'),
('Maria', 'Ivanova','2000-07-20','maria.ivanova@example.com'),
('John',  'Brown','1998-11-05', 'john.brown@example.com'),
('Sara',  'Lee','2006-01-10','sara.lee@example.com'),
('Timur', 'Akhmet','1999-09-25','timur.akhmet@example.com');


INSERT INTO tblTASK_TYPE (TaskTypeName, IsPhysicalLabor)
VALUES
('Physical labor', 1),
('Office work',    0),
('Online research',0),
('Tutoring',       0),
('Event support',  1);

INSERT INTO tblREVIEW_TYPE (ReviewTypeName)
VALUES
('Peer review'),
('Teacher review'),
('Self review'),
('External mentor'),
('Automated system');

INSERT INTO tblRATING (RatingName, RatingValue)
VALUES
('Poor',       1),
('Fair',       2),
('Good',       3),
('Very Good',  4),
('Excellent',  5);


INSERT INTO tblTASK (TaskName, TaskDescription, TaskTypeID)
VALUES
('Move boxes', 'Help with moving boxes in storage', 1),
('Date entry', 'Input survey results',              2),
('Web research', 'Research competitors online',     3),
('Math tutoring', 'Help classmates with math',      4),
('Stage setup', 'Prepare stage for event',          5);

CREATE OR ALTER PROCEDURE dbo.spGetStudentIDByName
	@FirstName VARCHAR(50),
	@LastName  VARCHAR(50),
	@StudentID INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT @StudentID = S.StudentID
	FROM tblSTUDENT S
	WHERE S.FirstName = @FirstName
	AND   S.LastName  = @LastName;
END;

CREATE OR ALTER PROCEDURE dbo.spGetTaskTypeIDByName
	@TaskTypeName VARCHAR(50),
	@TaskTypeID   INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT @TaskTypeID = TT.TaskTypeID
	FROM tblTASK_TYPE TT
	WHERE TT.TaskTypeName = @TaskTypeName;
END;

CREATE OR ALTER PROCEDURE dbo.spGetTaskIDByName
	@TaskName VARCHAR(100),
	@TaskID   INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT @TaskID = T.TaskID
	FROM tblTASK T
	WHERE T.TaskName = @TaskName;
END;


CREATE OR ALTER PROCEDURE dbo.spGetReviewTypeIDByName
    @ReviewTypeName VARCHAR(50),
    @ReviewTypeID   INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT @ReviewTypeID = RT.ReviewTypeID
    FROM tblREVIEW_TYPE RT
    WHERE RT.ReviewTypeName = @ReviewTypeName;
END;


CREATE OR ALTER PROCEDURE dbo.spGetRatingIDByName
    @RatingName NVARCHAR(50),
    @RatingID   INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT @RatingID = R.RatingID
    FROM tblRATING R
    WHERE R.RatingName = @RatingName;
END;

	


CREATE OR ALTER PROCEDURE dbo.spGetStudentTaskIDByNames
    @FirstName NVARCHAR(50),
    @LastName  NVARCHAR(50),
    @TaskName  NVARCHAR(100),
    @StudentTaskID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT @StudentTaskID = st.StudentTaskID
    FROM dbo.STUDENT_TASK st
    JOIN dbo.STUDENT s ON st.StudentID = s.StudentID
    JOIN dbo.TASK t    ON st.TaskID = t.TaskID
    WHERE s.FirstName = @FirstName
      AND s.LastName  = @LastName
      AND t.TaskName  = @TaskName;
END;
GO


CREATE OR ALTER PROCEDURE dbo.spAssignStudentToTask
    @FirstName    NVARCHAR(50),
    @LastName     NVARCHAR(50),
    @TaskName     NVARCHAR(100),
    @AssignedDate DATE,
    @DueDate      DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StudentID INT,
            @TaskID    INT;

    BEGIN TRY
        BEGIN TRANSACTION J1;

       
        EXEC dbo.spGetStudentIDByName
            @FirstName = @FirstName,
            @LastName  = @LastName,
            @StudentID = @StudentID OUTPUT;

     
        EXEC dbo.spGetTaskIDByName
            @TaskName = @TaskName,
            @TaskID   = @TaskID OUTPUT;

        
        IF @StudentID IS NULL
        BEGIN
            RAISERROR('Student not found', 16, 1);
        END;

        IF @TaskID IS NULL
        BEGIN
            RAISERROR('Task not found', 16, 1);
        END;

        INSERT INTO dbo.STUDENT_TASK (StudentID, TaskID, AssignedDate, DueDate)
        VALUES (@StudentID, @TaskID, @AssignedDate, @DueDate);

        COMMIT TRANSACTION J1;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION J1;

        DECLARE @ErrMsg NVARCHAR(4000), @ErrSeverity INT, @ErrState INT;
        SELECT @ErrMsg = ERROR_MESSAGE(),
               @ErrSeverity = ERROR_SEVERITY(),
               @ErrState = ERROR_STATE();

        RAISERROR(@ErrMsg, @ErrSeverity, @ErrState);
    END CATCH;
END;
GO




CREATE OR ALTER TRIGGER dbo.trgCheckStudentTaskBusinessRule
ON tblSTUDENT_TASK
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    
    SET DATEFIRST 1;

    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN tblSTUDENT s     ON i.StudentID = s.StudentID
        JOIN tblTASK t        ON i.TaskID = t.TaskID
        JOIN tblTASK_TYPE tt  ON t.TaskTypeID = tt.TaskTypeID
        WHERE tt.IsPhysicalLabor = 1
          AND DATEPART(WEEKDAY, i.AssignedDate) = 5  -- Friday
          AND DATEDIFF(YEAR, s.BirthDate, i.AssignedDate) < 18
    )
    BEGIN
        RAISERROR(
            'Business rule violation: Student younger than 18 cannot be assigned physical labor on Friday.',
            16, 1
        );
        ROLLBACK TRANSACTION;
        RETURN;
    END
END;
GO


CREATE OR ALTER FUNCTION dbo.fn_TotalTasksForStudent
(
    @StudentID INT
)
RETURNS INT
AS
BEGIN
    DECLARE @Total INT;

    SELECT @Total = COUNT(*)
    FROM tblSTUDENT_TASK st
    WHERE st.StudentID = @StudentID;

    RETURN ISNULL(@Total, 0);
END;
GO

ALTER TABLE tblSTUDENT
ADD LifetimeTaskCount AS dbo.fn_TotalTasksForStudent(StudentID);
GO








