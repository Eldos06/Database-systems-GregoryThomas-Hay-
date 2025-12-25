--Write the SQL to determine the STUDENTS that meet the following conditions:
--a.Born on a Tuesday in the months of January, March, October, or November
--b.Completed more than 3 classes from College of Medicine with a grade between 2.96 and 3.65 after 1986
--c.Spent more than $650 on 400-level classes during Spring quarters
--d.Earned more than 6 credits in Physics classes held in classrooms that have seating capacity greater than 50 and fewer than 200 seats

	

SELECT DISTINCT S.StudentID, S.StudentFname, S.StudentLname, S.StudentBirth
FROM tblSTUDENT S
WHERE
	MONTH(S.StudentBirth) IN (1, 3, 10, 11)
	AND DATENAME(WEEKDAY, S.StudentBirth) = 'Tuesday'

	AND (
		SELECT COUNT(*)
		FROM tblCLASS_LIST CL
		JOIN tblCLASS C ON C.ClassID = CL.ClassID
		JOIN tblCOURSE CO ON C.CourseID = CO.CourseID
		JOIN tblDEPARTMENT D ON D.DeptID = CO.DeptID
		JOIN tblCOLLEGE CG ON CG.CollegeID = D.CollegeID
		WHERE CL.StudentID = S.StudentID
			AND CG.CollegeName = 'Medicine'
			AND CL.Grade BETWEEN 2.96 AND 3.65
			AND C.Year > 1986
		) > 3

	AND (
		SELECT SUM(C.ClassID)
		FROM tblCLASS_LIST CL
		JOIN tblCLASS C ON CL.ClassID = C.ClassID
		JOIN tblCOURSE CO ON C.CourseID = CO.CourseID
		JOIN tblQUARTER Q ON C.QuarterID = Q.QuarterID
		WHERE CL.StudentID = S.StudentID
			AND CO.CourseNumber >= 400 AND CO.CourseNumber < 500
			AND Q.QuarterName = 'Spring'
		) > 650

	AND (
		SELECT SUM(CO.Credits)
		FROM tblCLASS_LIST CL
		JOIN tblCLASS C ON CL.ClassID = C.ClassID
		JOIN tblCOURSE CO ON C.CourseID = CO.CourseID
		JOIN tblDEPARTMENT D ON CO.DeptID = D.DeptID
		JOIN tblCLASSROOM CR ON C.ClassroomID = CR.ClassroomID
		JOIN tblCLASSROOM_TYPE CRT ON CR.ClassroomTypeID = CRT.ClassroomTypeID
		WHERE CL.StudentID = S.StudentID
			AND D.DeptName = 'Physics'
			AND CRT.SeatingCapacity > 50 AND CRT.SeatingCapacity < 200
		) > 6;


-- 2.Write the SQL to determine the BUILDINGS that meet the following conditions:
-- a.The year it opened was between 1931 and 1988
-- b.Held more than 230 classes from college of Arts and Sciences after 1966
-- c.Is located on either Stevens Way, Memorial Way, or South Campus
-- d.Has had more than 5600 students from the states of Texas, California, or Washington complete classes held in one of its classrooms


SELECT B.BuildingName, B.YearOpened, L.LocationName, COUNT(DISTINCT S.StudentID) AS TotalStudents, COUNT(DISTINCT C.ClassID) AS TotalClasses	
FROM tblBUILDING B
JOIN tblCLASSROOM CR ON B.BuildingID = CR.BuildingID
JOIN tblCLASS C ON CR.ClassroomID = C.ClassroomID
JOIN tblCLASS_LIST CL ON C.ClassID = CL.ClassID
JOIN tblCOURSE CO ON C.CourseID = CO.CourseID
JOIN tblDEPARTMENT D ON CO.DeptID = D.DeptID
JOIN tblCOLLEGE CG ON D.CollegeID = CG.CollegeID
JOIN tblLOCATION L ON B.LocationID = L.LocationID
JOIN tblSTUDENT S ON S.StudentID = CL.StudentID
WHERE 
	YearOpened BETWEEN 1931 AND 1988
	AND L.LocationName IN ('Stevens Way', 'Memorial Way', 'South Campus')
	AND CG.CollegeName = 'Arts and Sciences'
	AND C.YEAR > 1966
	AND StudentPermState IN ('Texas, TX', 'California, CA', 'Washington, WA')
   
GROUP BY B.BuildingName, B.YearOpened, L.LocationName
HAVING 
	COUNT(C.ClassID) > 230
AND COUNT(DISTINCT S.StudentID) > 5600;



-- 3.Write the SQL to determine the INSTRUCTORS that meet the following conditions:
-- a.Were born between the 5th and 19th of any month
-- b.Have instructed classes that exceed 85 in cumulative credits since 1998
-- c.Have instructed more than 7 classes from College of Arts and Sciences that were held during Winter quarters

SELECT I.InstructorFName, I.InstructorLName
FROM tblINSTRUCTOR I
WHERE
	DAY(I.InstructorBirth) BETWEEN 5 AND 19
	


SELECT I.InstructorFName, I.InstructorLName, SUM(CO.Credits) AS TotalCredits
FROM tblINSTRUCTOR I
JOIN tblINSTRUCTOR_CLASS IC ON I.InstructorID = IC.InstructorID
JOIN tblCLASS C ON IC.ClassID = C.ClassID
JOIN tblCOURSE CO ON C.CourseID = CO.CourseID
JOIN tblQUARTER Q ON C.QuarterID = Q.QuarterID
WHERE C.Year >= 1998
GROUP BY
	I.InstructorFName, I.InstructorLName
HAVING
	SUM(CO.Credits) > 85;

SELECT I.InstructorFName, I.InstructorLName, COL.CollegeName, SUM(CO.Credits) AS TotalCredits
FROM tblINSTRUCTOR I
JOIN tblINSTRUCTOR_CLASS IC ON I.InstructorID = IC.InstructorID
JOIN tblCLASS C ON IC.ClassID = C.ClassID
JOIN tblCOURSE CO ON C.CourseID = CO.CourseID
JOIN tblQUARTER Q ON C.QuarterID = Q.QuarterID
JOIN tblDEPARTMENT D ON CO.DeptID = D.DeptID
JOIN tblCOLLEGE COL ON D.CollegeID = COL.CollegeID
WHERE Q.QuarterName = 'Winter'
      AND COL.CollegeName = 'Arts and Sciences'
GROUP BY
	I.InstructorFName, I.InstructorLName, COL.CollegeName
	
HAVING
	SUM(CO.Credits) > 7;

-- 4.Write the SQL to determine the DEPARTMENTS that meet the following conditions:
-- a.Had more than 1500 students register for classes on the 16th of any month after 1973
-- b.Received more than $9,000,000 in registration fees received between the 11th and 23rd of the months of July, December, February, April, or May.
-- c.Held more than 60 classes in buildings located on ‘The Quad’ that were a 300-level course that had lectures on Thursdays.

SELECT D.DeptID, D.DeptName, COUNT(DISTINCT CL.StudentID) AS StudentsRegist
FROM tblDEPARTMENT D
JOIN tblCOURSE CO ON CO.DeptID = D.DeptID
JOIN TBLCLASS C ON CO.CourseID = C.CourseID
JOIN tblCLASS_LIST CL ON CL.ClassID = C.ClassID
WHERE
	DAY(CL.RegistrationDate) = 16
	AND YEAR(CL.RegistrationDate) > 1973
GROUP BY D.DeptID, D.DeptName
HAVING COUNT(DISTINCT CL.StudentID) > 1500;


SELECT D.DeptID, D.DeptName, COUNT(CL.RegistrationFee) AS TotalFees
FROM tblDEPARTMENT D
JOIN tblCOURSE CO ON CO.DeptID = D.DeptID
JOIN TBLCLASS C ON CO.CourseID = C.CourseID
JOIN tblCLASS_LIST CL ON CL.ClassID = C.ClassID
WHERE
		DAY(CL.RegistrationDate) BETWEEN 11 AND 23
		AND MONTH(CL.RegistrationDate) IN (7, 12, 2, 4, 5)
GROUP BY D.DeptID, D.DeptName
HAVING SUM(CL.RegistrationFee) > 9000000


SELECT D.DeptID, D.DeptName, COUNT(DISTINCT C.ClassID) AS NumClasses
FROM tblDEPARTMENT D
JOIN tblCOURSE CO ON CO.DeptID = D.DeptID
JOIN tblCLASS C ON CO.CourseID = C.CourseID
JOIN tblCLASSROOM CR ON C.ClassroomID = CR.ClassroomID
JOIN tblBUILDING BD ON BD.BuildingID = CR.BuildingID
JOIN tblLOCATION L ON L.LocationID = BD.LocationID
JOIN tblSCHEDULE SH ON SH.ScheduleID = C.ScheduleID	
JOIN tblSCHEDULE_DAY SHD ON SHD.ScheduleID = SH.ScheduleID
JOIN tblDAY DY ON DY.DayID = SHD.DayID
WHERE
	L.LocationName = 'The Quad'
	AND CO.CourseNumber BETWEEN 300 AND 399
	AND DY.Day_Name = 'Thursday'
GROUP BY D.DeptID, D.DeptName
HAVING COUNT(DISTINCT C.ClassID) > 60;