/*********************************************************************************************************

Purpose 	:- Script to compare the Count for DIM Tables based on "ValidFromWarehouseLoadId" attribute
Table Type  :- All the DIM Tables ( @TNAME Parameter needs to be changed to check the Count )
Owner   	:- Ram Baskar
Date    	:- 25/04/2022

******************************************************************************************************** */

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
		
		--DWH.DimORIUSMTransaction
		--DWH.DimORIDepartment
		--DWH.DimORIContractType
		--DWH.DimORIClaimSubEvent
		--DWH.DimORIApplicablePremium
		--DWH.DimORICession
		--DWH.DimRiskCount		

		SET @SNAME = '[DWH]';
		SET @TNAME = '[DimBroker]';
		SET @PRD   = '[MYMI-PRD].[MyMI_DataWareHouse]'; -- Linked Server created from MyMI-Dev
		
/* **************************************************************************************************************************************************************************************************
SELECT @COLUMNS    = @COLUMNS    + '[' + ColumnName + ']' + ',' + '''%''' +','
      ,@COLUMNList = @COLUMNList + '[' + ColumnName + ']' + ','

  FROM (

	    SELECT S.schema_id
		      ,S.Name             as SchemName 
	          ,T.Name             as TableName
	          ,C.Column_id
			  ,C.Name             as ColumnName

	      FROM sys.schemas S
	      join sys.tables  T
	        on S.Schema_Id = T.Schema_Id
	
	      join sys.Columns C
	        on T.object_id = C.Object_Id 
		   --and C.Name not in ('InsertDateTime','LastUpdateDateTime')
	          
	     WHERE S.name = @SNAME 
	       AND T.Name = @TNAME
		   ) T --WHERE ColumnName NOT in ('InsertDateTime','LastUpdateDateTime')
 
	    
		
		SELECT @QRY = 'With CTE_DEV as ( SELECT  ' + '''MYMI-Prod ''' + 'as Prod' + ',' + 'COUNT(*) FROM'    +@SNAME + '.' + @TNAME
		SELECT @QRY = 'With CTE_PRD as ( SELECT  ' + '''MYMI-Prod ''' + ' as Prod' + ',' + 'COUNT(*) ' + ' as PRD_TotalRecords ' + 'FROM '    + @PRD   + '.' +@SNAME  + '.' + @TNAME + ')' + CHAR(10) +
		              '    ,CTE_DEV as ( SELECT  ' + '''MYMI-Dev  ''' + ' as Dev ' + ',' + 'COUNT(*) ' + ' as DEV_TotalRecords ' + 'FROM '    + @SNAME + '.' + @TNAME + ')' 
***************************************************************************************************************************************************************************************************** */
					  
                    --Building CTE Query
        SELECT @QRY = 'With CTE_PRD as ( '                                                                                                   + CHAR(10) +
		              '     SELECT ' + '''MYMI-Prod''' + ' as PRD_ServerName' + ',' + 'ValidFromWarehouseLoadId ' +','                       + CHAR(10) +
					  '                COUNT(*)'  + ' as PRD_TotalRecords '                                                                  + CHAR(10) +
					  '       FROM ' + @PRD   + '.' +@SNAME  + '.' + @TNAME                                                                  + CHAR(10) +
					  '        Group by ValidFromWarehouseLoadId' + ')'                                                                      + CHAR(10) +

		              '    ,CTE_DEV as ( '                                                                                                   + CHAR(10) +
					  '     SELECT  ' + '''MYMI-Dev''' + ' as Dev_ServerName' + ',' + 'ValidFromWarehouseLoadId '+','                        + CHAR(10) +
					  '                COUNT(*)'  + ' as DEV_TotalRecords '                                                                  + CHAR(10) + 
					  '       FROM '  + @SNAME + '.' + @TNAME                                                                                + CHAR(10) +
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
                      '       Left Join CTE_Dev D '             + CHAR(10) +
                      '         on P.ValidFromWarehouseLoadId = D.ValidFromWarehouseLoadId' + CHAR(10) +
					  '       ORDER BY P.ValidFromWarehouseLoadId'
			 


		print(@QRY)

		EXECUTE sp_executesql @QRY

