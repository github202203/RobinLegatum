
DECLARE	@SName      VARCHAR(20),
	    @TName      VARCHAR(100),
	    @COLUMNS    VARCHAR(MAX) = '', 
		@COLUMNList VARCHAR(MAX) = '', 
		@PRD		VARCHAR(150),
	    @QRY        NVARCHAR(4000),
		@QRY1       NVARCHAR(4000),
	    @SRCTBLname VARCHAR(100),
	    @TGTTBLname VARCHAR(100),
	    @returnVal  INT;
		
        --FactORIPlacementDataHistory
        --FactORITransactionDataHistory
        --FactRiskCountDataHistory
        --FactORICessionDataHistory
        --FactORIApplicablePremiumDataHistory


		SET @SNAME = 'DWH';
		SET @TNAME = 'FactRiskCountDataHistory';
		SET @PRD   = '[MYMI-PRD].[MyMI_DataWareHouse]'; -- Linked Server created from MyMI-Dev
		
					  
                    --Building CTE Query
        SELECT @QRY = 'With CTE_PRD as ( '                                                                                                   + CHAR(10) +
		              '     SELECT ' + '''MYMI-Prod''' + ' as PRD_ServerName' + ',' + 'DimDataHistoryId ' +','                               + CHAR(10) +
					  '                COUNT(*)'  + ' as PRD_TotalRecords '                                                                  + CHAR(10) +
					  '       FROM ' + @PRD   + '.' +@SNAME  + '.' + @TNAME + ' with (NOLOCK)'                                               + CHAR(10) +
					  '        Group by DimDataHistoryId' + ')'                                                                              + CHAR(10) +

		              '    ,CTE_DEV as ( '                                                                                                   + CHAR(10) +
					  '     SELECT  ' + '''MYMI-Dev''' + ' as Dev_ServerName' + ',' + 'DimDataHistoryId '+','                                + CHAR(10) +
					  '                COUNT(*)'  + ' as DEV_TotalRecords '                                                                  + CHAR(10) + 
					  '       FROM '  + @SNAME + '.' + @TNAME               + ' with (NOLOCK)'                                               + CHAR(10) +
					  '        Group by DimDataHistoryId' + ')'                                                                              + CHAR(10) + 

                    --Building Comparison Query
					
					  '     SELECT  ' + '''' + @SNAME + '.' + @TNAME + '''' + ' as EntityName'                                               + CHAR(10) +
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



