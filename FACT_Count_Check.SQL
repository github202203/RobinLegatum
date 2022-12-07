---FACT Count of records for Current/Historical Calendar Partition ( For the given input Calendar Partition )


/*********************************************************************************************************

Purpose     :- Script to compare Count of Records check between Prod/Dev
Table Type  :- All the FACT Tables 
Owner       :- Ram Baskar
Date        :- 26/04/2022

--EXEC QA.FactCountCheck 'DWH','FactORIPlacementDataHistory','2022-03-28','C','Scenario-1'
--EXEC QA.FactCountCheck 'DWH','FACTOriTransactionDataHistory','2022-05-03','F','Scenario-5'

******************************************************************************************************** */


--Use MyMI_Datawarehouse;
CREATE or ALTER Procedure QA.FactCountCheck (@SName VARCHAR(20),@TName VARCHAR(100),@CDATE DATE, @PTYPE VARCHAR(1), @Scenario VARCHAR(250))
AS 
BEGIN

DECLARE	
	    @COLUMNS    VARCHAR(MAX) = '', 
		@COLUMNList VARCHAR(MAX) = '', 
		@PRD		VARCHAR(150),
	    @QRY        NVARCHAR(4000),
		@PNAME		VARCHAR(100),
	    @SRCTBLname VARCHAR(100),
	    @TGTTBLname VARCHAR(100),
	    @returnVal  INT;
/*
DECLARE -- These are the input parameters 

        @SNAME		VARCHAR(5)		= 'DWH',
		@TNAME		VARCHAR(100)	= 'FactORIPlacementDataHistory',
		@CDATE		DATE			= '2022-03-28',  
		@PTYPE      VARCHAR(1)      = 'C',
		@Scenario	VARCHAR(250)    = 'Scenario-3';
    */

SELECT @PNAME = DimDataHistoryId
  FROM DWH.DimDataHistory
 WHERE CalendarAsAtDate = @CDATE
   AND DataHistoryCode like @PTYPE + '%'

SELECT @Scenario = Case when @Scenario = 'Scenario-1' then 'FACT - Count Check - Latest Calendar Open Period'                                + ' - ' + @TNAME
                        when @Scenario = 'Scenario-2' then 'FACT - Count Check - Latest Calendar Closed Period'                              + ' - ' + @TNAME
						when @Scenario = 'Scenario-3' then 'FACT - Count Check - Historical Calendar Open/Closed Period'                     + ' - ' + @TNAME
						when @Scenario = 'Scenario-5' then 'FACT - Count Check - Financial Closed Period'                                    + ' - ' + @TNAME
		            End 
		
        --FactORIPlacementDataHistory
        --FactORITransactionDataHistory
        --FactRiskCountDataHistory
        --FactORICessionDataHistory
        --FactORIApplicablePremiumDataHistory


		--SET @SNAME = 'DWH';
		--SET @TNAME = 'FactRiskCountDataHistory';
		SET @PRD   = '[MYMI-PRD].[MyMI_DataWareHouse]'; -- Linked Server created from MyMI-Dev
		
					  
                    --Building CTE Query
        SELECT @QRY = 'With CTE_PRD as ( '                                                                                                   + CHAR(10) +
		              '     SELECT ' + '''MYMI-Prod''' + ' as PRD_ServerName' + ',' + 'DimDataHistoryId ' +','                               + CHAR(10) +
					  '                COUNT(*)'  + ' as PRD_TotalRecords '                                                                  + CHAR(10) +
					  '       FROM ' + @PRD   + '.' +@SNAME  + '.' + @TNAME + ' with (NOLOCK)'                                               + CHAR(10) +
					  '      WHERE DimDataHistoryId = '    + @PNAME                                                                          + CHAR(10) + 

					  '        Group by DimDataHistoryId' + ')'                                                                              + CHAR(10) +

		              '    ,CTE_DEV as ( '                                                                                                   + CHAR(10) +
					  '     SELECT  ' + '''MYMI-Dev''' + ' as Dev_ServerName' + ',' + 'DimDataHistoryId '+','                                + CHAR(10) +
					  '                COUNT(*)'  + ' as DEV_TotalRecords '                                                                  + CHAR(10) + 
					  '       FROM '  + @SNAME + '.' + @TNAME               + ' with (NOLOCK)'                                               + CHAR(10) +
					  '      WHERE DimDataHistoryId = '    + @PNAME                                                                          + CHAR(10) + 
					  '        Group by DimDataHistoryId' + ')'                                                                              + CHAR(10) + 

                    --Building Comparison Query
					
					  '     SELECT  '  + '''' + @SNAME + '.' + @TNAME + '''' + ' as EntityName'                                              + CHAR(10) +
					  '             ,' + '''' + @Scenario + '''' + ' as TestType'                                                            + CHAR(10) +
					  '             ,P.DimDataHistoryId,DH.WarehouseLoadId,DH.DataHistoryCode,DH.DataHistoryName '                           + CHAR(10) +
					  '             ,P.PRD_ServerName,P.PRD_TotalRecords '                                                                   + CHAR(10) +
                      '             ,D.DEV_ServerName, D.DimDataHistoryId,D.DEV_TotalRecords'                                                + CHAR(10) +
	                  '             ,Case WHEN P.DimDataHistoryId = D.DimDataHistoryId and PRD_TotalRecords = DEV_TotalRecords'              + CHAR(10) +
			          '                   THEN ' + '''Passed'''                                                                              + CHAR(10) +
					  '			          ELSE ' + '''Failed'''                                                                              + CHAR(10) +
	                  '               End as TestResult'                                                                                     + CHAR(10) +
	                  '             ,GetDate()' + ' as TestedOn '                                                                            + CHAR(10) +
                      '       FROM CTE_PRD P '                                                                                               + CHAR(10) +
					  '       Left join DWH.DimDataHistory DH On P.DimDataHistoryId = DH.DimDataHistoryId'                                   + CHAR(10) +
                      '       Left Join CTE_Dev D '                                                                                          + CHAR(10) +
                      '         on P.DimDataHistoryId = D.DimDataHistoryId'                                                                  + CHAR(10) +
					  '      ORDER BY P.DimDataHistoryId'
			 

		print(@QRY)
		EXECUTE sp_executesql @QRY
END
GO


