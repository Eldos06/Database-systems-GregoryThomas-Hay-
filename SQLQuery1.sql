CREATE FUNCTION dbo.FN_Instre (@PK INT)
RETURNS TABLE
AS
RETURN(

	SELECT S.StudentFname, S.StudentLname, CO.CourseName, I.InstructorFname, I.InstructorLname
	FROM tblSTUDENT S
	JOIN tblCLASS_LIST CL         ON CL.StudentID = S.StudentID
	JOIN tblCLASS  C             ON C.ClassID = CL.ClassID
	JOIN tblCOURSE   CO         ON CO.CourseID = C.CourseID
	JOIN tblINSTRUCTOR_CLASS IC ON C.ClassID = IC.ClassID
	JOIN tblINSTRUCTOR I        ON I.InstructorID = IC.InstructorID
	WHERE I.InstructorID = @PK
	);

SELECT *
FROM dbo.FN_Instre(5);





