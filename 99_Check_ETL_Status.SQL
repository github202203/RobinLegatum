
SELECT S.name, E.Name, Rb.FileDateTime, rb.Status
  FROM ETL.ETLRunbook RB
  JOIN Metadata.Entity E 
    ON E.EntityID = RB.TargetEntityID
  JOIN Metadata.Subject S 
    ON S.SubjectID = E.SubjectID
 WHERE DataMartLoadID = 2022052401 AND RB.Status <> 'Completed'
 ORDER BY 4