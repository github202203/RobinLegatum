--SELECT COUNT(*) FROM [QA].[BNB_Switch_Config_Check]
SELECT * 
  FROM (
         SELECT T1.*, 'PICKUP' as TobePickedup 
		   FROM [QA].[BNB_Switch_Config_Check] T1 WHERE GROUPCLASS <> 'ENGINEERING & CPE' 
		   
         UNION ALL
		 
         SELECT T2.*, Case WHEN GroupClass = 'ENGINEERING & CPE' AND ExternalSyndicate <> '2987' THEN 'Ignore' ELSE 'PICKUP' End as ToBePickedUp
           FROM [QA].[BNB_Switch_Config_Check] T2 WHERE GROUPCLASS =  'ENGINEERING & CPE'
        )T WHERE TestResult <> 'Passed' AND TobePickedup <> 'Ignore'
 ORDER BY TableName, GroupClass