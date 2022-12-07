--USE MYMI_Datawarehouse

/*********************************************************************************************************

Purpose 	:- Script to compare the Count for DIM Tables based on "ValidFromWarehouseLoadId" attribute
Table Type  :- All the DIM Tables ( @TNAME Parameter needs to be changed to check the Count )
Owner   	:- Ram Baskar
Date    	:- 25/04/2022

Date:28/04/2022 - Convert T-SQL script into Stored Procedure with the input parameters
******************************************************************************************************** */


CREATE or ALTER Procedure QA.DimCountCheck (@SName VARCHAR(20),@TName VARCHAR(100),@CDATE DATE)
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

SELECT @PNAME = WarehouseLoadId 
  FROM DWH.DimDataHistory
 WHERE CalendarAsAtDate = @CDATE
   AND DataHistoryCode like 'C%';
		
		--SET @SNAME = '[DWH]';
		--SET @TNAME = '[DimBroker]';
		SET @PRD   = '[MYMI-PRD].[MyMI_DataWareHouse]'; -- Linked Server created from MyMI-Dev

					  
        --Building CTE Query
        SELECT @QRY = 'With CTE_PRD as ( '                                                                                                   + CHAR(10) +
		              '     SELECT ' + '''MYMI-Prod''' + ' as PRD_ServerName' + ',' + 'ValidFromWarehouseLoadId ' +','                       + CHAR(10) +
					  '                COUNT(*)'  + ' as PRD_TotalRecords '                                                                  + CHAR(10) +
					  '       FROM ' + @PRD   + '.' +@SNAME  + '.' + @TNAME                                                                  + CHAR(10) +
					  '      WHERE ValidFromWarehouseLoadId = '    + @PNAME                                                                  + CHAR(10) + 
					  '        AND ValidToWarehouseLoadId   = 2123456789  '                                                                  + CHAR(10) +                                                   
					  '        AND DIMSourceSystemId = 14  '                                                                                 + CHAR(10) +
					  '        Group by ValidFromWarehouseLoadId' + ')'                                                                      + CHAR(10) +
					  

		              '    ,CTE_DEV as ( '                                                                                                   + CHAR(10) +
					  '     SELECT  ' + '''MYMI-Dev''' + ' as Dev_ServerName' + ',' + 'ValidFromWarehouseLoadId '+','                        + CHAR(10) +
					  '                COUNT(*)'  + ' as DEV_TotalRecords '                                                                  + CHAR(10) + 
					  '       FROM '  + @SNAME + '.' + @TNAME                                                                                + CHAR(10) +
					  '      WHERE ValidFromWarehouseLoadId = '    + @PNAME                                                                  + CHAR(10) + 
					  '        AND ValidToWarehouseLoadId   = 2123456789  '                                                                  + CHAR(10) +                                                   
					  '        AND DIMSourceSystemId = 14  '                                                                                 + CHAR(10) +
					  '        Group by ValidFromWarehouseLoadId' + ')'                                                                      + CHAR(10) + 

                    --Building Comparison Query
					
					  '     SELECT  ' + '''' + @SNAME + '.' + @TNAME + '''' + ' as EntityName'                                               + CHAR(10) +
					  '           ,P.PRD_ServerName, P.ValidFromWarehouseLoadId,P.PRD_TotalRecords'                                          + CHAR(10) +
                      '           ,D.DEV_ServerName, D.ValidFromWarehouseLoadId,D.DEV_TotalRecords'                                          + CHAR(10) +
	                  '          ,Case WHEN P.ValidFromWarehouseLoadId = D.ValidFromWarehouseLoadId and PRD_TotalRecords = DEV_TotalRecords' + CHAR(10) +
			          '                THEN ' +  '''Passed'''   + CHAR(10) +
					  '			       ELSE ' + '''Failed'''    + CHAR(10) +
	                  '            End as TestResult'           + CHAR(10) +
	                  '          ,GetDate()' + ' as TestedOn '  + CHAR(10) +
                      '       FROM CTE_PRD P '                  + CHAR(10) +
                      --'       Left Join CTE_Dev D '             + CHAR(10) +
					  '       FULL Join CTE_Dev D '             + CHAR(10) +
                      '         on P.ValidFromWarehouseLoadId = D.ValidFromWarehouseLoadId' + CHAR(10) +
					  '       ORDER BY P.ValidFromWarehouseLoadId'
			 


		print(@QRY)

		EXECUTE sp_executesql @QRY

END;
GO


--EXEC QA.DimCountCheck @SNAME = 'DWH', @TNAME = 'DimBroker', @CDATE = '2022-03-11'
--EXEC QA.DimCountCheck @SNAME = 'DWH', @TNAME = 'DimOriTransaction', @CDATE = '2022-03-11'