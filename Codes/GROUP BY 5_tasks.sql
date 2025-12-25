
SELECT SA.StatusName,  COUNT(S.StudentID) AS total_Students
FROM tblSTUDENT S
JOIN tblSTUDENT_STATUS ST ON S.StudentID = ST.StudentID
JOIN tblSTATUS SA ON SA.StatusID = ST.StatusID
GROUP BY SA.StatusName;
