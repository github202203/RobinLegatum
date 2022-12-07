SELECT S.Name,E.Name,	
        S.name+'.'+E.Name EntityName,SUBLayer
FROM	METADATA.ENTITY E
JOIN	METADATA.SUBJECT S
ON		E.SUBJECTID = S.SUBJECTID
WHERE	S.NAME LIKE '%GXLP210' AND SUBLAYER IN ('Abstract','transformed') --and E.Name = 'Stg10_oricontracttype'
--WHERE S.SubjectId = 466 and SUBLayer is not null
order by s.name,sequence

SELECT * FROM Metadata.Subject WHERE Layer = 'Curated'
SELECT * FROM Metadata.Subject WHERE Layer = 'Snapshot'

SELECT * FROM Metadata.Entity WHERE subjectid = 136
SELECT * FROM Metadata.Entity WHERE subjectid = 424

SELECT S.Name AS Pre_Database,E.Name ,	
        S.name+'.'+E.Name EntityName, SUBLAYER
  FROM	METADATA.ENTITY E
  JOIN	METADATA.SUBJECT S
    ON	E.SUBJECTID = S.SUBJECTID
 WHERE	E.subjectid = 136 --Curated Tables
   AND E.NAME = 'DWH_DimTerritory'
 ORDER BY S.NAME,SEQUENCE

 SELECT S.Name AS Pre_Database,E.Name ,	
        S.name+'.'+E.Name EntityName, SUBLAYER
  FROM	METADATA.ENTITY E
  JOIN	METADATA.SUBJECT S
    ON	E.SUBJECTID = S.SUBJECTID
 WHERE	E.subjectid = 424 --Snapshot Tables
 --AND E.NAME not in ('DWH_FactEarnedPremium')
 --AND E.NAME = 'DWH_DimBrokerName' 
 ORDER BY S.NAME,SEQUENCE