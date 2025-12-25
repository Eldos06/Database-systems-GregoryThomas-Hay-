SELECT DISTINCT s.StudentID, s.StudentFname AS FirstName, s.StudentLname AS LastName
FROM dbo.tblSTUDENT s
JOIN dbo.tblCLASS_LIST cl ON s.StudentID = cl.StudentID
JOIN dbo.tblCLASS c ON cl.ClassID = c.ClassID
JOIN dbo.tblDEPARTMENT d ON c.DeptID = d.DeptID
JOIN dbo.tblCOLLEGE co ON d.CollegeID = co.CollegeID
WHERE s.StudentPermState = 'WA'
  AND s.StudentLname LIKE 'R%' 
  AND co.CollegeName = 'Medicine'
  AND c.YEAR = 2016
ORDER BY s.StudentLname;
