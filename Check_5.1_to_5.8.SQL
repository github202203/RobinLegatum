SELECT 'Config.Load_Details' as TableName, C.* FROM Config.Load_Details C
 ORDER By Date_Of_Load

SELECT '[RS].[LoadStatus]' as ViewName, [Load_status]
      ,[Load_ID]
  FROM [RS].[LoadStatus]

SELECT DISTINCT Date_Of_Load FROM [Dim].[INW_GroupClass]
SELECT DISTINCT Date_Of_Load FROM [RS].[INW_Group_Class]