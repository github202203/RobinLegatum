DECLARE @sql varchar(MAX)

SELECT
     @sql = COALESCE(@sql + CHAR(10) + CHAR(10) + 'UNION ALL ' + CHAR(10) , '') + CHAR(10) + 
	 --'SELECT ' + ' ''' + t.name + ''' AS TableName ' + ',' + ' TestResult,Count(*) as TotalRecords' + ' FROM ' + s.name + '.' +  t.name + ' GROUP BY TestResult'
	 'SELECT * FROM ('                                                                                                + CHAR(10) + 
	 '               SELECT ' + ' ''' + t.name + ''' AS TableName ' + ',' + ' TestResult' + ','+ 'TestedOn '             + CHAR(10) + 
	 '                       ,CASE when TestResult = ' + '''Failed - Missing in 2.5''     then ' + '''Failed-Missing in 2.5'''    + CHAR(10) + 
     '                             when TestResult = ' + '''Failed - Missing in 2.10''    then ' + '''Failed-Missing in 2.10'''   + CHAR(10) + 
	 '                             when TestResult = ' + '''Failed - MisMatch of Hash''   then ' + '''Failed-HashMismatch''' + CHAR(10) + 
	 '                             when TestResult = ' + '''Passed''                      then ' + '''Passed'''       + CHAR(10) + 
	 '                         END as TestResultList'                                                                 + CHAR(10) +
	 --'                          ,GetDate() ' + 'as TestResultStatusAsAt '                                             + CHAR(10) +
     '                FROM ' + s.name + '.' +  t.name                                                                 + CHAR(10) + 
	 '               )T'                                                                                              + CHAR(10) + 

	 'PIVOT '                                                                                                         + CHAR(10) + 

	 '('                                                                                                              + CHAR(10) + 
	 ' COUNT(TestResult)  FOR TestResultList in ("Failed-Missing in 2.5", "Failed-Missing in 2.10","Failed-HashMismatch",Passed)'                          + CHAR(10) + 
	 ' )PV'

    FROM sys.schemas s
    --INNER JOIN sys.tables t ON t.schema_id = s.schema_id and s.schema_id = 29 and t.name like  'PRODTR_Dim%'
	INNER JOIN sys.tables t ON t.schema_id = s.schema_id and s.schema_id = 29 and t.name like  'FPTR_Fact%'
    ORDER BY
        s.name,
        t.name

print @sql
EXEC(@sql)