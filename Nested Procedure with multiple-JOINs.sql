CREATE OR ALTER PROCEDURE yeld_2_GetClassID
	@CR_Name VARCHAR(50),
	@Q_Name  VARCHAR(30),
	@Sec     CHAR(4),
	@Year    CHAR(4),
	@C_ID    INTEGER OUTPUT
	AS 
	
	SET @C_ID = (SELECT ClassID	
				 FROM tblCLASS CS
					JOIN tblQUATER Q ON CS.QuarterID = Q.QuarterID
					JOIN tblCOURSE CR ON CS.CourseID = CR.CourseID
				 WHERE Q.QuarterName = @Q_Name
				 AND CR.CourseName = @CR_Name
				 AND Section = @Sec
				 AND CS.Year = @Year
				 )
GO

CREATE OR ALTER PROCEDURE yeld_INSERT_tblCLASS_LIST
	@Fname VARCHAR(50),
	@Lname VARCHAR(50),
	@DOB   DATE,
	@Course VARCHAR(50),
	@Qname  VARCHAR(30),
	@Section CHAR(4),
	@Yr    CHAR(4),
	@RegDate DATE,
	@RegFee  NUMERIC(6, 2)

	AS
	DECLARE @SID INT, @CID INT

	EXEC gthay_2_GetStudentID
	@F = @Fname,
	@L = @Lname,
	@BD= @DOB,
	@S_ID = @SID OUTPUT

	IF @SID IS NULL
		BEGIN
			PRINT 'Hey ... @SID is empty.. please check spelling and dates';
			THROW 56765, '@SID can not be NULL; process is terminating', 1;
		END
	
	EXEC yeld_INSERT_tblCLASS_LIST
	@CR_Name = @Course,
	@Q_Name  = @Qname,
	@Sec     = @Section,
	@Year    = @Yr,
	@C_ID    = @CID OUTPUT

	IF @CID IS NULL
		BEGIN 
			PRINT 'Hey ... @CID is empty.. please check spelling and dates';
			THROW 56765, '@CID can not be NULL; process is terminating', 1;
		END

	BEGIN TRAN T1
		INSERT INTO tblCLASS_LIST (ClassID, StudentID, RegistrationDate, RegistrationFee, Grade)
		VALUES (@CID, @SID, @RegDate, @RegFee, NULL)
		IF @@ERROR <> 0
			BEGIN
				PRINT 'Something went wrong just before commit statement!'
				ROLLBACK TRAN T1
			END 
	COMMIT TRAN T1



EXEC yeld_INSERT_tblCLASS_LIST
	@Fname = 'Darell',
	@Lname = 'Schleimer',
	@DOB   = '1999-01-03',
	@Course = 'NME677',
	@Qname = 'Winter',
	@Section = 'C',
	@Yr = '2020',
	@RegDate = '12-21-2019',
	@RegFee = 1688.50
	










