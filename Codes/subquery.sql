
-- SUM() --> find all the money spent on tuition for all students from 
-- california for math classes 1998

SELECT
    S.StudentID,
    S.StudentLname,
    SUM(CL.RegistrationFee) AS MoneySpent_Math
FROM tblSTUDENT AS S
JOIN tblCLASS_LIST AS CL ON S.StudentID = CL.StudentID
JOIN tblCLASS AS CS        ON CL.ClassID   = CS.ClassID
JOIN tblCOURSE AS CR       ON CS.CourseID  = CR.CourseID
JOIN tblDEPARTMENT AS D    ON CR.DeptID    = D.DeptID
WHERE
    -- keep if you truly mean Math-only; otherwise drop this line
    D.DeptName = 'Math'
    AND S.StudentPermState = 'California, CA'
    -- if Year is INT:
    AND CS.Year LIKE '199%'
    -- if Year is CHAR/VARCHAR, use this instead of the BETWEEN line:
    -- AND CS.[Year] LIKE '199_'
	AND SUM(CL.RegistrationFee) > 1500
GROUP BY
    S.StudentID,
    S.StudentLname
    
ORDER BY
    MoneySpent_Math DESC;
	

GetDate


-- write the sql to determine the students that have completed at 
--least 1 5 credit class from history depretment in the last 15 years

SELECT StudentFname, StudentLname, CR.Credits, D.DeptName, C.YEAR
FROM tblSTUDENT S
	JOIN tblCLASS_LIST CL ON CL.StudentID = S.StudentID
	JOIN tblCLASS C ON C.ClassID = CL.ClassID
	JOIN tblCOURSE CR ON CR.CourseID = C.CourseID
	JOIN tblDEPARTMENT D ON D.DeptID = CR.DeptID
WHERE C.YEAR >= YEAR(GETDATE()) - 15  --> GETDATE = 2025-09-24 04:38:14.560
AND D.DeptName = 'History'
AND C.YEAR >= 2010
ORDER BY
	Credits DESC;


SELECT GETDATE()
SELECT GETUTCDATE()  --> 2025-09-24 04:38:42.483

-- write the Query to determine the number of students that received a grade of less thatn 3.6
-- 
SELECT StudentFname, StudentLname, C.YEAR, D.DeptName
FROM tblSTUDENT S
	JOIN tblCLASS_LIST CL ON CL.StudentID = S.StudentID
	JOIN tblCLASS C ON C.ClassID = CL.ClassID
	JOIN tblCOURSE CR ON CR.CourseID = C.CourseID
	JOIN tblDEPARTMENT D ON D.DeptID = CR.DeptID
WHERE CR.Credits = 5
AND D.DeptName LIKE 'Math%'
AND YEAR LIKE '199_'

--SUBQUERY  -  powerfull method of connecting two or more queries
-- three ways to structure a subquery -- > WHERE, FROM 'ABC'

-- write the query to determine the students that meet all conditions below

-- 1) recieved a grade greater than 3.4 in a biology class before 2012
-- 2) completed more than 12 credits of Anthropology
-- 3) took four classes of 200 level from business sch




SELECT  S.StudentID, StudentFname, StudentLname, SUM(Credits) AS NumCredits
FROM tblSTUDENT S
	JOIN tblCLASS_LIST CL ON CL.StudentID = S.StudentID
	JOIN tblCLASS C ON C.ClassID = CL.ClassID
	JOIN tblCOURSE CR ON CR.CourseID = C.CourseID
	JOIN tblDEPARTMENT D ON D.DeptID = CR.DeptID
WHERE D.DeptName = 'Anthropology'
ORDER BY S.StudentID, StudentFname, StudentLname
HAVING SUM(CR.Credits) >= 12;

SELECT  S.StudentID, StudentFname, StudentLname, COUNT(*) AS NumCredits
FROM tblSTUDENT S
	JOIN tblCLASS_LIST CL ON CL.StudentID = S.StudentID
	JOIN tblCLASS C ON C.ClassID = CL.ClassID
	JOIN tblCOURSE CR ON CR.CourseID = C.CourseID
	JOIN tblDEPARTMENT D ON D.DeptID = CR.DeptID
WHERE D.DeptName = 'Anthropology'
ORDER BY S.StudentID, StudentFname, StudentLname
HAVING SUM(CR.Credits) >= 12;



