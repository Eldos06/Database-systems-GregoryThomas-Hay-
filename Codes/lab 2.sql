-- 1) Write the SQL to determine which STUDENTS with a permanent residence 
-- in the state of Texas finished more than 47 credits from 
-- the college of 'Medicine' during the 1970s.
SELECT 
       S.StudentID,
	   S.StudentLname,
	   S.StudentFname,
	   S.StudentPermState,
	   CG.CollegeName,
	   SUM(CO.Credits) AS total_credits_1970s
FROM tblSTUDENT S
	JOIN tblCLASS_LIST CL ON S.StudentID = CL.StudentID
	JOIN tblCLASS C ON CL.ClassID = C.ClassID
	JOIN tblCOURSE CO ON C.CourseID = CO.CourseID
	JOIN tblDEPARTMENT D ON CO.DeptID = D.DeptID
	JOIN tblCOLLEGE CG ON D.CollegeID = CG.CollegeID
WHERE
	S.StudentPermState IN ('Texas, TX')
	AND CG.CollegeName = 'Medicine'
	AND C.YEAR BETWEEN 1970 AND 1979
GROUP BY
    S.StudentID,
	S.StudentLname,
	S.StudentFname,
	S.StudentPermState,
	CG.CollegeName
HAVING
	SUM(CO.Credits) > 47
ORDER BY
	total_credits_1970s DESC;

-- 2) Write the SQL to determine the STUDENTS who completed 
-- more than 5 classes held in classroom 
-- of type 'Medium Lecture Hall' during any Spring quarter 
-- during the 1980s.

SELECT S.StudentID,S.StudentFname,S.StudentLname,CLRT.ClassroomTypeName, COUNT(*) AS Total_Classes
FROM tblSTUDENT S
	JOIN tblCLASS_LIST CL ON S.StudentID = CL.StudentID
	JOIN tblCLASS C ON CL.ClassID = C.ClassID
	JOIN tblQUARTER Q ON C.QuarterID = C.QuarterID
	JOIN tblCLASSROOM CLR ON C.ClassroomID = CLR.ClassroomID
	JOIN tblCLASSROOM_TYPE CLRT ON CLR.ClassroomTypeID = CLRT.ClassroomTypeID

WHERE CLRT.ClassroomTypeName = 'Medium Lecture Hall'
	AND Q.QuarterName = 'Spring'
	AND C.YEAR LIKE '198%'

GROUP BY S.StudentID,S.StudentFname,S.StudentLname,CLRT.ClassroomTypeName
HAVING COUNT(*) >5

-- 3) Write the SQL to determine the STAFF members who were 
-- hired for any position in the college of 'Arts and Sciences' 
-- on a Tuesday after March 4, 1993.
SELECT S.StaffID,S.StaffFname, S.StaffLName,P.PositionName,COL.CollegeName,SP.BeginDate,DATENAME(weekday,SP.BeginDate) AS Day_Name
FROM tblSTAFF S
	JOIN tblSTAFF_POSITION SP ON S.StaffID = SP.StaffID
	JOIN tblPOSITION P ON SP.PositionID = P.PositionID
	JOIN  tblDEPARTMENT DEPT ON SP.DeptID = DEPT.DeptID
	JOIN tblCOLLEGE COL ON DEPT.CollegeID = COL.CollegeID


WHERE COL.CollegeName = 'Arts and Sciences'
	AND DATENAME(weekday, SP.BeginDate) = 'Tuesday'
	AND SP.BeginDate > '1993-03-04'

-- 4) Write the SQL to determine the DEPARTMENTS that generated 
-- more than $1,250,000 during Winter quarters for 300-level classes between 1952 and 1986. 
SELECT D.DeptID, D.DeptName, SUM(CL.RegistrationFee) AS Money_Generated

FROM tblDEPARTMENT D
JOIN tblCOURSE CR ON D.DeptID = CR.DeptID
JOIN tblCLASS C ON CR.CourseID = C.CourseID
JOIN tblCLASS_LIST CL ON C.ClassID = CL.ClassID
JOIN tblQUARTER Q ON C.QuarterID = Q.QuarterID

WHERE C.YEAR BETWEEN 1952 and 1986
AND Q.QuarterName = 'Winter'
AND CR.CourseNumber LIKE '3%%'

GROUP BY D.DeptID, D.DeptName
HAVING SUM(CL.RegistrationFee) > 1250000


-- 5) Write the SQL to determine the INSTRUCTORS who were born fewer than 43 years ago. 

SELECT I.InstructorID,I.InstructorFName,I.InstructorLName,I.InstructorBirth , DATEADD(YEAR,-43,GETDATE()) AS YEARS_AGO43
FROM tblINSTRUCTOR I
WHERE I.InstructorBirth > DATEADD(YEAR,-43,GETDATE())


--6) Write the SQL to determine the STUDENTS that meet all conditions: 
--* spent between $850 and $2550 on classes from Mathematics department during 1990s 
--* completed at least 2 classes held in buildings located on West Campus 
--* earned more than 4 credits with a grade above 3.2 of 400-level engineering classes held in 
--either Mary Gates Hall or Johnson Hall.

--Q1
--* spent between $850 and $2550 on classes from Mathematics department during 1990s 

SELECT S.StudentID,S.StudentFname,S.StudentLname, D.DeptName, SUM(CL.RegistrationFee) AS Total_Fees
FROM tblSTUDENT S
	JOIN tblCLASS_LIST CL ON S.StudentID = CL.StudentID
	JOIN tblCLASS C ON CL.ClassID = C.ClassID
	JOIN tblCOURSE CR ON C.CourseID = CR.CourseID
	JOIN tblDEPARTMENT D ON CR.DeptId = D.DeptID

WHERE D.DeptName = 'Mathematics'
	AND C.YEAR LIKE '199%'
GROUP BY S.StudentID,S.StudentFname,S.StudentLname, D.DeptName
HAVING SUM(CL.RegistrationFee) BETWEEN 850 and 2550

-- Query2
-- completed at least 2 classes held in buildings located on West Campus 
SELECT S.StudentID,S.StudentFname,S.StudentLname,L.LocationName, COUNT(*) AS NUM_CLASSES

FROM tblSTUDENT S
	JOIN tblCLASS_LIST CL ON S.StudentID = CL.StudentID
	JOIN tblCLASS C ON CL.ClassID = C.ClassID
	JOIN tblCLASSROOM CLR ON C.ClassroomID = CLR.ClassroomID
	JOIN tblBUILDING B ON CLR.BuildingID = B.BuildingID
	JOIN tblLOCATION L ON B.LocationID = L.LocationID

WHERE L.LocationName = 'West Campus'
GROUP BY S.StudentID,S.StudentFname,S.StudentLname,L.LocationName
HAVING COUNT(*) >= 2


--Query3
--* earned more than 4 credits with a grade above 3.2 of 400-level engineering classes held in 
--either Mary Gates Hall or Johnson Hall.

SELECT S.StudentID, S.StudentFname,S.StudentLname,CL.Grade,CR.CourseNumber,B.BuildingName,COL.CollegeName, SUM(CR.Credits)  AS Total_Credits
FROM tblSTUDENT S
	JOIN tblCLASS_LIST CL ON S.StudentID = CL.StudentID
	JOIN tblCLASS C ON CL.ClassID = C.ClassID
	JOIN tblCOURSE CR ON C.CourseID = CR.CourseID
	JOIN tblDEPARTMENT D ON CR.DeptID = D.DeptID
	JOIN tblCOLLEGE COL ON D.CollegeID = COL.CollegeID
	JOIN tblCLASSROOM CLR ON C.ClassroomID = CLR.ClassroomID
	JOIN tblBUILDING B ON CLR.BuildingID = B.BuildingID

WHERE COL.CollegeName LIKE '%Engineering'
	AND CL.Grade > 3.2
	AND CR.CourseNumber LIKE '4%%'
	AND B.BuildingName IN ('Mary Gates Hall' ,'Johnson Hall')

GROUP BY S.StudentID, S.StudentFname,S.StudentLname,B.BuildingName,CL.Grade,CR.CourseNumber,COL.CollegeName
HAVING SUM(CR.Credits) > 4




SELECT S.StudentID,S.StudentFname,S.StudentLname, D.DeptName, SUM(CL.RegistrationFee) AS Total_Fees
FROM tblSTUDENT S
	JOIN tblCLASS_LIST CL ON S.StudentID = CL.StudentID
	JOIN tblCLASS C ON CL.ClassID = C.ClassID
	JOIN tblCOURSE CR ON C.CourseID = CR.CourseID
	JOIN tblDEPARTMENT D ON CR.DeptId = D.DeptID

WHERE D.DeptName = 'Mathematics'
	AND C.YEAR LIKE '199%'
	AND S.StudentID IN(
SELECT S.StudentID

FROM tblSTUDENT S
	JOIN tblCLASS_LIST CL ON S.StudentID = CL.StudentID
	JOIN tblCLASS C ON CL.ClassID = C.ClassID
	JOIN tblCLASSROOM CLR ON C.ClassroomID = CLR.ClassroomID
	JOIN tblBUILDING B ON CLR.BuildingID = B.BuildingID
	JOIN tblLOCATION L ON B.LocationID = L.LocationID

WHERE L.LocationName = 'West Campus'
GROUP BY S.StudentID
HAVING COUNT(*) >= 2

)
	AND S.StudentID IN (
SELECT S.StudentID 
FROM tblSTUDENT S
	JOIN tblCLASS_LIST CL ON S.StudentID = CL.StudentID
	JOIN tblCLASS C ON CL.ClassID = C.ClassID
	JOIN tblCOURSE CR ON C.CourseID = CR.CourseID
	JOIN tblDEPARTMENT D ON CR.DeptID = D.DeptID
	JOIN tblCOLLEGE COL ON D.CollegeID = COL.CollegeID
	JOIN tblCLASSROOM CLR ON C.ClassroomID = CLR.ClassroomID
	JOIN tblBUILDING B ON CLR.BuildingID = B.BuildingID

WHERE COL.CollegeName LIKE '%Engineering'
	AND CL.Grade > 3.2
	AND CR.CourseNumber LIKE '4%%'
	AND B.BuildingName IN ('Mary Gates Hall' ,'Johnson Hall')

GROUP BY S.StudentID
HAVING SUM(CR.Credits) > 4)
GROUP BY S.StudentID,S.StudentFname,S.StudentLname, D.DeptName
HAVING SUM(CL.RegistrationFee) BETWEEN 850 and 2550



--7) EXTRA CREDIT 1 point: Write all three formats (WHERE clause, FROM clause, and ABC 
--method) shown on connecting the queries. 
--Write the SQL to determine the INSTRUCTORS that meet all following conditions: 
--* Assigned at least 3 classes held in classroom type 'auditorium' between 1993 and 2017 
--* Had at least 12 students from California, Florida, New York, or Texas that received a grade of 
--3.8 or greater during a Spring quarter before 2016.  
--* Assigned at least 2 classes held in buildings located on ‘the Quad’ (hint: --> ‘%quad%’) 
--*/


--Q1
--* Assigned at least 3 classes held in classroom type 'auditorium' between 1993 and 2017 
SELECT I.InstructorID,I.InstructorFName, I.InstructorLName, COUNT(*) AS Num_Classes
FROM tblINSTRUCTOR I
	JOIN tblINSTRUCTOR_CLASS IC ON I.InstructorID = IC.InstructorID
	JOIN tblCLASS C ON IC.ClassID = C.ClassID
	JOIN tblCLASSROOM CLR ON C.ClassroomID = CLR.ClassroomID
	JOIN tblCLASSROOM_TYPE CLRT ON CLR.ClassroomTypeID = CLRT.ClassroomTypeID

WHERE CLRT.ClassroomTypeName = 'auditorium' 
	AND C.YEAR BETWEEN 1993 and 2017

GROUP BY I.InstructorID,I.InstructorFName, I.InstructorLName
HAVING  COUNT(*) >= 3


--Q2
--* Had at least 12 students from California, Florida, New York, or Texas that received a grade of 
--3.8 or greater during a Spring quarter before 2016.

SELECT I.InstructorID,I.InstructorFName, I.InstructorLName, COUNT(*) AS Num_Students
FROM tblINSTRUCTOR I
	JOIN tblINSTRUCTOR_CLASS IC ON I.InstructorID = IC.InstructorID
	JOIN tblCLASS C ON IC.ClassID = C.ClassID
	JOIN tblQUARTER Q ON C.QuarterID = Q.QuarterID
	JOIN tblCLASS_LIST CL ON C.ClassID = CL.ClassID
	JOIN tblSTUDENT S ON CL.StudentID = S.StudentID

WHERE S.StudentPermState IN ('California, CA', 'Florida, FL','New York, NY', 'Texas, TX')
	AND CL.Grade  >= 3.8
	AND Q.QuarterName = 'Spring'
	AND C.YEAR < 2016

GROUP BY  I.InstructorID,I.InstructorFName, I.InstructorLName
HAVING COUNT(*) >=12

--Q3
----* Assigned at least 2 classes held in buildings located on ‘the Quad’ (hint: --> ‘%quad%’) 
SELECT I.InstructorID,I.InstructorFName, I.InstructorLName, COUNT(*) AS Class_Total
FROM tblINSTRUCTOR I
	JOIN tblINSTRUCTOR_CLASS IC ON I.InstructorID = IC.InstructorID
	JOIN tblCLASS C ON IC.ClassID = C.ClassID
	JOIN tblCLASSROOM CLR ON C.ClassroomID = CLR.ClassroomID
	JOIN tblBUILDING B ON CLR.BuildingID = B.BuildingID
	JOIN tblLOCATION L ON B.LocationID = L.LocationID

WHERE L.LocationName LIKE '%quad%'
GROUP BY I.InstructorID,I.InstructorFName, I.InstructorLName
HAVING COUNT(*) >= 2


--WHERE METHOD

SELECT I.InstructorID,I.InstructorFName, I.InstructorLName, COUNT(*) AS Num_Classes
FROM tblINSTRUCTOR I
	JOIN tblINSTRUCTOR_CLASS IC ON I.InstructorID = IC.InstructorID
	JOIN tblCLASS C ON IC.ClassID = C.ClassID
	JOIN tblCLASSROOM CLR ON C.ClassroomID = CLR.ClassroomID
	JOIN tblCLASSROOM_TYPE CLRT ON CLR.ClassroomTypeID = CLRT.ClassroomTypeID

WHERE CLRT.ClassroomTypeName = 'auditorium' 
	AND C.YEAR BETWEEN 1993 and 2017
	AND I.INSTRUCTORID IN(
SELECT I.InstructorID
FROM tblINSTRUCTOR I
	JOIN tblINSTRUCTOR_CLASS IC ON I.InstructorID = IC.InstructorID
	JOIN tblCLASS C ON IC.ClassID = C.ClassID
	JOIN tblQUARTER Q ON C.QuarterID = Q.QuarterID
	JOIN tblCLASS_LIST CL ON C.ClassID = CL.ClassID
	JOIN tblSTUDENT S ON CL.StudentID = S.StudentID

WHERE S.StudentPermState IN ('California, CA', 'Florida, FL','New York, NY', 'Texas, TX')
	AND CL.Grade  >= 3.8
	AND Q.QuarterName = 'Spring'
	AND C.YEAR < 2016

GROUP BY  I.InstructorID,I.InstructorFName, I.InstructorLName
HAVING COUNT(*) >=12

)
	AND I.InstructorID IN (
SELECT I.InstructorID
FROM tblINSTRUCTOR I
	JOIN tblINSTRUCTOR_CLASS IC ON I.InstructorID = IC.InstructorID
	JOIN tblCLASS C ON IC.ClassID = C.ClassID
	JOIN tblCLASSROOM CLR ON C.ClassroomID = CLR.ClassroomID
	JOIN tblBUILDING B ON CLR.BuildingID = B.BuildingID
	JOIN tblLOCATION L ON B.LocationID = L.LocationID

WHERE L.LocationName LIKE '%quad%'
GROUP BY I.InstructorID,I.InstructorFName, I.InstructorLName
HAVING COUNT(*) >= 2
)
GROUP BY I.InstructorID,I.InstructorFName, I.InstructorLName
HAVING  COUNT(*) >= 3

--JOIN METHOD
SELECT I.InstructorID,I.InstructorFName, I.InstructorLName, COUNT(*) AS Num_Classes, Subquery1.Num_Students,Subquery2.Class_Total_Loc_Quad
FROM tblINSTRUCTOR I 
	JOIN tblINSTRUCTOR_CLASS IC ON I.InstructorID = IC.InstructorID
	JOIN tblCLASS C ON IC.ClassID = C.ClassID
	JOIN tblCLASSROOM CLR ON C.ClassroomID = CLR.ClassroomID
	JOIN tblCLASSROOM_TYPE CLRT ON CLR.ClassroomTypeID = CLRT.ClassroomTypeID
	JOIN (SELECT I.InstructorID,I.InstructorFName, I.InstructorLName, COUNT(*) AS Num_Students
FROM tblINSTRUCTOR I
	JOIN tblINSTRUCTOR_CLASS IC ON I.InstructorID = IC.InstructorID
	JOIN tblCLASS C ON IC.ClassID = C.ClassID
	JOIN tblQUARTER Q ON C.QuarterID = Q.QuarterID
	JOIN tblCLASS_LIST CL ON C.ClassID = CL.ClassID
	JOIN tblSTUDENT S ON CL.StudentID = S.StudentID

WHERE S.StudentPermState IN ('California, CA', 'Florida, FL','New York, NY', 'Texas, TX')
	AND CL.Grade  >= 3.8
	AND Q.QuarterName = 'Spring'
	AND C.YEAR < 2016

GROUP BY  I.InstructorID,I.InstructorFName, I.InstructorLName
HAVING COUNT(*) >=12) AS Subquery1 ON I.InstructorID = Subquery1.InstructorID

JOIN (
SELECT I.InstructorID,I.InstructorFName, I.InstructorLName, COUNT(*) AS Class_Total_Loc_Quad
FROM tblINSTRUCTOR I
	JOIN tblINSTRUCTOR_CLASS IC ON I.InstructorID = IC.InstructorID
	JOIN tblCLASS C ON IC.ClassID = C.ClassID
	JOIN tblCLASSROOM CLR ON C.ClassroomID = CLR.ClassroomID
	JOIN tblBUILDING B ON CLR.BuildingID = B.BuildingID
	JOIN tblLOCATION L ON B.LocationID = L.LocationID

WHERE L.LocationName LIKE '%quad%'
GROUP BY I.InstructorID,I.InstructorFName, I.InstructorLName
HAVING COUNT(*) >= 2
) AS Subquery2 ON I.InstructorID = Subquery2.InstructorID

WHERE CLRT.ClassroomTypeName = 'auditorium' 
AND C.YEAR BETWEEN 1993 and 2017

GROUP BY I.InstructorID,I.InstructorFName, I.InstructorLName, Subquery1.Num_Students, Subquery2.Class_Total_Loc_Quad
HAVING  COUNT(*) >= 3


--ABC
SELECT A.*,B.Num_Students,C.Class_Total_Loc_Quad
FROM
(
SELECT I.InstructorID,I.InstructorFName, I.InstructorLName, COUNT(*) AS Num_Classes
FROM tblINSTRUCTOR I
	JOIN tblINSTRUCTOR_CLASS IC ON I.InstructorID = IC.InstructorID
	JOIN tblCLASS C ON IC.ClassID = C.ClassID
	JOIN tblCLASSROOM CLR ON C.ClassroomID = CLR.ClassroomID
	JOIN tblCLASSROOM_TYPE CLRT ON CLR.ClassroomTypeID = CLRT.ClassroomTypeID

WHERE CLRT.ClassroomTypeName = 'auditorium' 
AND C.YEAR BETWEEN 1993 and 2017

GROUP BY I.InstructorID,I.InstructorFName, I.InstructorLName
HAVING  COUNT(*) >= 3) A,
(SELECT I.InstructorID,I.InstructorFName, I.InstructorLName, COUNT(*) AS Num_Students
FROM tblINSTRUCTOR I
	JOIN tblINSTRUCTOR_CLASS IC ON I.InstructorID = IC.InstructorID
	JOIN tblCLASS C ON IC.ClassID = C.ClassID
	JOIN tblQUARTER Q ON C.QuarterID = Q.QuarterID
	JOIN tblCLASS_LIST CL ON C.ClassID = CL.ClassID
	JOIN tblSTUDENT S ON CL.StudentID = S.StudentID

WHERE S.StudentPermState IN ('California, CA', 'Florida, FL','New York, NY', 'Texas, TX')
	AND CL.Grade  >= 3.8
	AND Q.QuarterName = 'Spring'
	AND C.YEAR < 2016

GROUP BY  I.InstructorID,I.InstructorFName, I.InstructorLName
HAVING COUNT(*) >=12
) B,
(
SELECT I.InstructorID,I.InstructorFName, I.InstructorLName, COUNT(*) AS Class_Total_Loc_Quad
FROM tblINSTRUCTOR I
	JOIN tblINSTRUCTOR_CLASS IC ON I.InstructorID = IC.InstructorID
	JOIN tblCLASS C ON IC.ClassID = C.ClassID
	JOIN tblCLASSROOM CLR ON C.ClassroomID = CLR.ClassroomID
	JOIN tblBUILDING B ON CLR.BuildingID = B.BuildingID
	JOIN tblLOCATION L ON B.LocationID = L.LocationID

WHERE L.LocationName LIKE '%quad%'
GROUP BY I.InstructorID,I.InstructorFName, I.InstructorLName
HAVING COUNT(*) >= 2
) C

WHERE A.InstructorID = B.InstructorID
	AND A.InstructorID = C.InstructorID
	
		






