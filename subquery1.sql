
--SELECT MIN(RegistrationFee) AS Bigfultion_Biology, MAX(RegistrationFee) AS

--FROM tblCLASS CS ON CS.ClassID = CS.ClassID

-- Which students pain above average registrationFee in 1986 for biology?
SELECT StudentFname, StudentLname, RegistrationFee,  AVG(RegistrationFee) 
AS AverageTuition
FROM tblSTUDENT	S
	JOIN tblCLASS_LIST CL ON S.StudentID = CL.StudentID
	JOIN tblCLASS CS ON CL.ClassID = CS.ClassID
	JOIN tblCOURSE CR ON CS.CourseID = CR.CourseID
	JOIN tblDEPARTMENT D ON CR.DeptID = D.DeptID
