

--Execute DimHashCheck
SELECT 'Regressin for Dim Started at:- '  +  CAST(GetDate() as VARCHAR(20)) as StartTime
--EXEC QA.DimHashCheck @SNAME = 'DWH', @TNAME = 'DimBroker',               @PTYPE = 'C', @PRDCDATE = '2022-03-27', @DEVCDATE = '2022-05-25' -- Out of scope
EXEC QA.DimHashCheck @SNAME = 'DWH', @TNAME = 'DimRiskCount',            @PTYPE = 'C', @PRDCDATE = '2022-03-27', @DEVCDATE = '2022-05-25'
EXEC QA.DimHashCheck @SNAME = 'DWH', @TNAME = 'DimORICession',           @PTYPE = 'C', @PRDCDATE = '2022-03-27', @DEVCDATE = '2022-05-25'
EXEC QA.DimHashCheck @SNAME = 'DWH', @TNAME = 'DimORIApplicablePremium', @PTYPE = 'C', @PRDCDATE = '2022-03-27', @DEVCDATE = '2022-05-25'
EXEC QA.DimHashCheck @SNAME = 'DWH', @TNAME = 'DimORIClaimSubEvent',     @PTYPE = 'C', @PRDCDATE = '2022-03-27', @DEVCDATE = '2022-05-25'
EXEC QA.DimHashCheck @SNAME = 'DWH', @TNAME = 'DimORIContractType',      @PTYPE = 'C', @PRDCDATE = '2022-03-27', @DEVCDATE = '2022-05-25'
EXEC QA.DimHashCheck @SNAME = 'DWH', @TNAME = 'DimORIDepartment',        @PTYPE = 'C', @PRDCDATE = '2022-03-27', @DEVCDATE = '2022-05-25'
EXEC QA.DimHashCheck @SNAME = 'DWH', @TNAME = 'DimORIUSMTransaction',    @PTYPE = 'C', @PRDCDATE = '2022-03-27', @DEVCDATE = '2022-05-25'
EXEC QA.DimHashCheck @SNAME = 'DWH', @TNAME = 'DimORIProgramme',         @PTYPE = 'C', @PRDCDATE = '2022-03-27', @DEVCDATE = '2022-05-25'
EXEC QA.DimHashCheck @SNAME = 'DWH', @TNAME = 'DimORIReinsurer',         @PTYPE = 'C', @PRDCDATE = '2022-03-27', @DEVCDATE = '2022-05-25'
EXEC QA.DimHashCheck @SNAME = 'DWH', @TNAME = 'DimOriTransaction',       @PTYPE = 'C', @PRDCDATE = '2022-03-27', @DEVCDATE = '2022-05-25'
SELECT 'Regressin for Dim Completed at:- '  +  CAST(GetDate() as VARCHAR(20)) as CompletedTime

/*
--Execute FACTHashCheck
SELECT 'Regressin for FACT Started at:- '  +  CAST(GetDate() as VARCHAR(20))
EXEC QA.FactHashCheck_CTE_EXCEPT_For_FactORITransactionDataHistory @SName = 'DWH',@TName = 'FactORIPlacementDataHistory',@CDATE = '2022-03-27', @PTYPE = 'C', @Scenario = 'Scenario-1', @PPeriod = '202203', @SSID = '14'
EXEC QA.FactHashCheck_CTE_EXCEPT_For_FactORITransactionDataHistory @SName = 'DWH',@TName = 'FactRiskCountDataHistory',@CDATE = '2022-03-27', @PTYPE = 'C', @Scenario = 'Scenario-1', @PPeriod = '202203', @SSID = '14'
--EXEC QA.FactHashCheck_CTE_EXCEPT_For_FactORITransactionDataHistory @SName = 'DWH',@TName = 'FactORICessionDataHistory',@CDATE = '2022-03-27', @PTYPE = 'C', @Scenario = 'Scenario-1', @PPeriod = '202203', @SSID = '14'
EXEC QA.FactHashCheck_CTE_EXCEPT_For_FactORITransactionDataHistory @SName = 'DWH',@TName = 'FactORIApplicablePremiumDataHistory',@CDATE = '2022-03-27', @PTYPE = 'C', @Scenario = 'Scenario-1', @PPeriod = '202203', @SSID = '14'
SELECT 'Regressin for FACT Completed at:- '  +  CAST(GetDate() as VARCHAR(20))
*/
--Display Test Result

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
    INNER JOIN sys.tables t ON t.schema_id = s.schema_id and s.schema_id = 31 --and t.name like  'TR_Dim%'
	--INNER JOIN sys.tables t ON t.schema_id = s.schema_id and s.schema_id = 31 and t.name like  'TR_Fact%'
    ORDER BY
        s.name,
        t.name

--print @sql
EXEC(@sql)

