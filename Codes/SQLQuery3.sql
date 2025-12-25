

SELECT --> the colums we want returned go here

FROM   --> the tables that connect all the columns
	JOIN --> allows us to connect many tables
	JOIN 

WHERE  --> conditional logic of filtering out undesired rows

--------------------------------------------------------------
/*
SELECT StudentFname, StudentLname, StudentPermState, [Year], Grade
FROM tblSTUDENT S
	JOIN tblCLASS_LIST CL ON S.StudentID = CL.StudentID
	JOIN tblCLASS CS ON CL.ClassID = CL.ClassID
	JOIN tblCOURSE CR ON CS.CourseID = CR.CourseID
WHERE (S.StudentPermState IN ('Florida, FL', 'Oregon, OR')
AND
CL.GRADE BETWEEN 2.8 AND 3.44
AND D.PeptName IN ('Math')

AND CS.Year = 1980
*/

SELECT
    StudentFname,
    StudentLname,
    StudentPermState,
    Grade,
    BuildingName,
    QuarterName,
    [Year],
    CourseName
FROM tblSTUDENT       AS
JOIN tblCLASS_LIST    AS CL ON CL.StudentID   = S.StudentID
JOIN tblCLASS         AS CS ON CS.ClassID     = CL.ClassID
JOIN tblCOURSE        AS CR ON CR.CourseID    = CS.CourseID
JOIN tblDEPARTMENT    AS D  ON D.DeptID       = CR.DeptID
JOIN tblQUARTER       AS Q  ON Q.QuarterID    = CS.QuarterID
JOIN tblCLASSROOM     AS CM ON CM.ClassroomID = CS.ClassroomID
JOIN tblBUILDING      AS B  ON B.BuildingID   = CM.BuildingID
WHERE
    B.BuildingName IN ('Johnson Hall', 'Mary Gates Hall')
    AND CL.Grade BETWEEN 2.8 AND 3.44
    AND D.DeptName = 'MATH%'
    AND CS.Year LIKE '198_'
	AND S.StudentPermState IN ('Floride, FL', 'Oregon, OR')



