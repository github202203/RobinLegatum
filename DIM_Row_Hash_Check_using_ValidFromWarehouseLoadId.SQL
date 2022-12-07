
/*********************************************************************************************************

Purpose     :- Script to compare Row by Row using Hash
Table Type  :- All the DIM Tables ( @TNAME Parameter needs to be changed to check the Count )
Owner       :- Ram Baskar
Date        :- 26/04/2022

******************************************************************************************************** */
USE MyMI_DataWarehouse

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

		SET @SNAME = 'DWH';
		SET @TNAME = 'DimORICession';
		SET @PRD   = '[MYMI-PRD].[MyMI_DataWareHouse]'; -- Linked Server created from MyMI-Dev

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
	          
	     WHERE S.name = @SNAME --'DWH'
	       AND T.Name = @TNAME --'DimBroker'
		   ) T WHERE ColumnName NOT in ('InsertDateTime','LastUpdateDateTime')
 
	    
		SELECT @COLUMNS    = SUBSTRING (@COLUMNS   ,1 ,LEN(@COLUMNS)-5)
		SELECT @COLUMNList = SUBSTRING (@COLUMNList,1 ,LEN(@COLUMNList)-1)

		--Check the output from the variables @COLUMNS/@COLUMNList/HASHBYTES ....
		--print @COLUMNS
		--print('SELECT ' + @COLUMNList) 
		--print ',HASHBYTES(' + '''SHA1''' + ',' + 'CONCAT(' + @COLUMNS + ')' + ')' + 'as Dev_HashBytes' 

		--Building CTE Query


        SELECT @QRY = 'With CTE_PRD as ('                               + CHAR(10) + 
		                   ('     SELECT ' + @COLUMNList)               + CHAR(10) + 
		                    '           ,HASHBYTES(' + '''SHA1'''       + ','      + 'CONCAT(' + @COLUMNS + ')' + ')' + 'as PRD_HashBytes'          + CHAR(10) + 
							'       FROM ' + @PRD + '.' + @SNAME        + '.'      + @TNAME    +  ' with (NOLOCK)'                 + CHAR(10) + ')' + CHAR(10) + 

                       ',CTE_DEV as ('                                  + CHAR(10) + 
		                   ('     SELECT ' + @COLUMNList)               + CHAR(10) + 
		                    '           ,HASHBYTES(' + '''SHA1'''       + ','      + 'CONCAT(' + @COLUMNS + ')' + ')' + 'as DEV_HashBytes'          + CHAR(10) + 
							'       FROM '              + @SNAME        + '.'      +  @TNAME   +                 ' with (NOLOCK)'  + CHAR(10) + ')' + CHAR(10) + 

        --Building Comparison Query between Prod & Dev

					        '     SELECT ' + '''' + @TNAME + '''' + ' as EntityName'                                                                + CHAR(10) +
							'           ,P.ValidFromWareHouseLoadId,P.PRD_HashBytes, D.ValidFromWareHouseLoadId,D.Dev_HashBytes'                    + CHAR(10) +
                            '           ,Case WHEN P.PRD_HashBytes = D.Dev_HashBytes '                                                              + CHAR(10) +
	                        '                 THEN ' + '''Passed'''                                                                                 + CHAR(10) + 
			                '                 ELSE ' + '''Failed'''                                                                                 + CHAR(10) +
		                    '             End as TestResult'                                                                                        + CHAR(10) + 
							'           ,GetDate() ' + 'as TestedOn '                                                                               + CHAR(10) +
							'           ,P.*,D.*   '                                                                                                + CHAR(10) +
                            '       FROM CTE_PRD P '                                                                                                + CHAR(10) + 
                            '  Left Join CTE_DEV D '                                                                                                + CHAR(10) + 
--                          '         on P.ContractReference = D.ContractReference '                                                                + CHAR(10) +
--	                        '        and P.PRD_HashBytes = D.Dev_HashBytes'
                            '         on P.ValidFromWareHouseLoadId = D.ValidFromWareHouseLoadId '                                                  + CHAR(10) +
	                        '        and P.PRD_HashBytes = D.Dev_HashBytes'



		print(@QRY)

		EXECUTE sp_executesql @QRY

      --WHERE ContractReference = '00029F001000'