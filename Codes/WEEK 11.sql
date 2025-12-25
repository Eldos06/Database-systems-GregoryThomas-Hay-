

CREATE FUNCTION FN_No_Cali_Biology_200_Summer ()
RETURNS INTEGER
AS
BEGIN

DECLARE @RET INTEGER = 0
IF EXISTS (SELECT * FROM 
				tblSTUDENT S
		       JOIN tblCLASS_LIST CL ON S.StudentID = CL.StudentID
			   JOIN tblCLASS CS      ON CL.ClassID  = CS.ClassID
			   JOIN tblQUARTER Q     ON CS.QuarterID = Q.QuarterID
			   JOIN tblCOURSE CR     ON CS.CourseID  = CR.CourseID
			   JOIN tblDEPARTMENT    ON CR.DeptID   = CR.DeptID
			   WHERE DATEPART(Weekday, StudentBirth) = 6
			   AND StudentPermState = 'California, CA'
			   AND CR.CourseNumber LIKE '2%'
			   AND Q.QuarterName = 'summer')


SET @RET = 1
RETURN @RET
END
GO

ALTER TABLE tblCLASS_LIST WITH NOCHECK
ADD CONSTRAINT CK_No_Students_Friday_California
CHECK (dbo.FN_Cali_Biology_200_Summer () = 0)


/*
Write the SQL to enforce the following business rule:
"No Instructor born in March of any year after 1980 may be 
assigned to teach a 300 - level engineering class held in Mary Gates Hall
*/


CREATE FUNCTION 
FN_NO_INS_MARCH_YEAR_CLASS()
RETURNS INTEGER 
AS 
BEGIN 

DECLARE @RET INTEGER = 0
IF EXISTS (SELECT *
   FROM tblINSTRUCTOR  I
   JOIN tblINSTRUCTUR_CLASS IC

   WHERE DATEPART(Month,INSTRUCTORBIRTH) = 3
   AND CL.YEAR LIKE '198%'
   AND CO.

)