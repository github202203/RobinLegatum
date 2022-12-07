DECLARE @sql varchar(MAX)

SELECT
     @sql = COALESCE(@sql + CHAR(10) + CHAR(10) + 'UNION ALL ' + CHAR(10) , '') + CHAR(10) + 
	 --'SELECT ' + ' ''' + t.name + ''' AS TableName ' + ',' + ' TestResult,Count(*) as TotalRecords' + ' FROM ' + s.name + '.' +  t.name + ' GROUP BY TestResult'
	 'SELECT * FROM ('                                                                                                + CHAR(10) + 
	 '               SELECT ' + ' ''' + t.name + ''' AS TableName ' + ',' + ' TestResult'                             + CHAR(10) + 
	 '                       ,CASE when TestResult = ' + '''Failed - Missing in 2.5''     then ' + '''Missing25'''    + CHAR(10) + 
     '                             when TestResult = ' + '''Failed - Missing in 2.10''    then ' + '''Missing210'''   + CHAR(10) + 
	 '                             when TestResult = ' + '''Failed - MisMatch of Hash''   then ' + '''HashMismatch''' + CHAR(10) + 
	 '                             when TestResult = ' + '''Passed''                      then ' + '''Passed'''       + CHAR(10) + 
	 '                         END as TestResultList'                                                                 + CHAR(10) +
	 '                          ,GetDate() ' + 'as TestResultStatusAsAt '                                             + CHAR(10) +
     '                FROM ' + s.name + '.' +  t.name                                                                 + CHAR(10) + 
	 '               )T'                                                                                              + CHAR(10) + 

	 'PIVOT '                                                                                                         + CHAR(10) + 

	 '('                                                                                                              + CHAR(10) + 
	 ' COUNT(TestResult)  FOR TestResultList in (Missing25, Missing210,HashMismatch,Passed)'                          + CHAR(10) + 
	 ' )PV'

    FROM sys.schemas s
    INNER JOIN sys.tables t ON t.schema_id = s.schema_id and s.schema_id = 31 --and t.name like  'TR_Dim%'
	--INNER JOIN sys.tables t ON t.schema_id = s.schema_id and s.schema_id = 31 and t.name like  'TR_Fact%'
    ORDER BY
        s.name,
        t.name

--print @sql
EXEC(@sql)







SELECT  'TR_DimBroker' AS TableName , TestResult,Count(*) as TotalRecords FROM QA.TR_DimBroker GROUP BY TestResult UNION ALL 
SELECT  'TR_DimORIApplicablePremium' AS TableName , TestResult,Count(*) as TotalRecords FROM QA.TR_DimORIApplicablePremium GROUP BY TestResult UNION ALL 
SELECT  'TR_DimORICession' AS TableName , TestResult,Count(*) as TotalRecords FROM QA.TR_DimORICession GROUP BY TestResult UNION ALL 
SELECT  'TR_DimORIClaimSubEvent' AS TableName , TestResult,Count(*) as TotalRecords FROM QA.TR_DimORIClaimSubEvent GROUP BY TestResult UNION ALL 
SELECT  'TR_DimORIContractType' AS TableName , TestResult,Count(*) as TotalRecords FROM QA.TR_DimORIContractType GROUP BY TestResult UNION ALL 
SELECT  'TR_DimORIDepartment' AS TableName , TestResult,Count(*) as TotalRecords FROM QA.TR_DimORIDepartment GROUP BY TestResult UNION ALL 
SELECT  'TR_DimORIProgramme' AS TableName , TestResult,Count(*) as TotalRecords FROM QA.TR_DimORIProgramme GROUP BY TestResult UNION ALL 
SELECT  'TR_DimORIReinsurer' AS TableName , TestResult,Count(*) as TotalRecords FROM QA.TR_DimORIReinsurer GROUP BY TestResult UNION ALL 
SELECT  'TR_DimORIUSMTransaction' AS TableName , TestResult,Count(*) as TotalRecords FROM QA.TR_DimORIUSMTransaction GROUP BY TestResult UNION ALL 
SELECT  'TR_DimRiskCount' AS TableName , TestResult,Count(*) as TotalRecords FROM QA.TR_DimRiskCount GROUP BY TestResult UNION ALL 
SELECT  'TR_FactORIApplicablePremiumDataHistory' AS TableName , TestResult,Count(*) as TotalRecords FROM QA.TR_FactORIApplicablePremiumDataHistory GROUP BY TestResult UNION ALL 
SELECT  'TR_FactORICessionDataHistory' AS TableName , TestResult,Count(*) as TotalRecords FROM QA.TR_FactORICessionDataHistory GROUP BY TestResult UNION ALL 
SELECT  'TR_FactORIPlacementDataHistory' AS TableName , TestResult,Count(*) as TotalRecords FROM QA.TR_FactORIPlacementDataHistory GROUP BY TestResult UNION ALL 
SELECT  'TR_FactORITransactionDataHistory' AS TableName , TestResult,Count(*) as TotalRecords FROM QA.TR_FactORITransactionDataHistory GROUP BY TestResult UNION ALL 
SELECT  'TR_FactRiskCountDataHistory' AS TableName , TestResult,Count(*) as TotalRecords FROM QA.TR_FactRiskCountDataHistory GROUP BY TestResult


SELECT  'TR_DimBroker' AS TableName , TestResult,Count(*) as TotalRecords FROM QA.TR_DimBroker GROUP BY TestResult

--SQL to verify the result using Pivot for a table
SELECT * 
  FROM (
        SELECT  'TR_DimBroker' AS TableName , TestResult--,Count(*) as TotalRecords 
		       ,CASE when TestResult = 'Failed - Missing in 2.5'   then 'Missing25'
			         when TestResult = 'Failed - Missing in 2.10'  then 'Missing210'
					 when TestResult = 'Failed - MisMatch of Hash' then 'HashMismatch'
					 when TestResult = 'Passed'                    then 'Passed'
				 END as TestResultList
		  FROM QA.TR_DimBroker --GROUP BY TestResult
		)T
  PIVOT 
 (
 COUNT(TestResult)  FOR TestResultList in (Missing25, Missing210,HashMismatch,Passed)
 )pv
 
select ValidFromWarehouseLoadId, Count(*) as Total from [MYMI-TEST].[MYMI_Datawarehouse].dwh.DimOritransaction where DimSourceSystemId = 14 and processperiod = 202203 GROUP By validfromwarehouseloadId 
select ValidFromWarehouseLoadId, Count(*) as Total from dwh.DimOritransaction where DimSourceSystemId = 14 and processperiod = 202203 GROUP By validfromwarehouseloadId 