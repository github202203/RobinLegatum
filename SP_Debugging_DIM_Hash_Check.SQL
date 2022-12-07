
/****************************************************************************************************************

Purpose     :- Script to compare Row by Row using Hash (Only FOR FACTOriTransactionDataHistory Table)
Table Type  :- DIM Tables 
Owner       :- Ram Baskar
Date        :- 26/04/2022
DATE		:- 05/05/2022 - Modified to capture the result in a table
DATE		:- 12/05/2022 - Modified to exclude ValidFromWarehouseLoadId and to check only active records

This script will create CTE Query and runs automatically and results will be stoted in a table under QA schema

--Execute DimHashCheck
--EXEC QA.DimHashCheck @SNAME = 'DWH', @TNAME = 'DimBroker'
--EXEC QA.DimHashCheck @SNAME = 'DWH', @TNAME = 'DimOriTransaction'

* *************************************************************************************************************/
use MYMI_Datawarehouse;


CREATE or ALTER Procedure QA.DimHashCheck (@SName VARCHAR(20),@TName VARCHAR(100))
AS 
BEGIN


DECLARE @QUERY			NVARCHAR(MAX)
       ,@RETURNED_VALUE NVARCHAR(50)
	   ,@PRD			VARCHAR(150)
	   ,@TEST			VARCHAR(150)
	   ,@PNAME			VARCHAR(100)
	   /*
	   ,@SNAME			VARCHAR(3)   --SCHEMA NAME = 'DWH'
	   ,@TNAME			VARCHAR(100) --TABLENAME IN TEST
	   */
	   ,@SSID			VARCHAR(2)   --Source System Id ( =14 for GXLP )
	   ,@PPeriod		VARCHAR(6)   --Process Period to validate for a particular month in YYYYMM format
	   ,@CDATE			DATE
	   
SET @RETURNED_VALUE = 'NOT CHANGED';
--SET @SNAME = 'DWH';
--SET @TNAME = 'DimORIReinsurer';

DECLARE @DropTable NVARCHAR(MAX) = 'DROP TABLE IF EXISTS QA.TR_' + @TNAME;
EXEC(@DropTable);

SET @PRD   = '[MYMI-PRD].[MyMI_DataWareHouse]'; -- Linked Server created from MyMI-Dev
SET @TEST  = '[MYMI-TEST].[MyMI_DataWareHouse]'; -- Linked Server created from MyMI-Dev

SET @QUERY = 'SELECT @RETURNED_VALUE = MAX(ValidFromWarehouseLoadId) FROM ' + @TEST + '.' + @SNAME + '.' + @TNAME
	

EXEC sp_executesql @query, N'@returned_value varchar(50) OUTPUT', @returned_value OUTPUT 
--SELECT @returned_value

SET @PNAME = @returned_value;



DECLARE	
	    @COLUMNS			VARCHAR(MAX) = '' 
	   ,@COLUMNList			VARCHAR(MAX) = ''
	   ,@COLUMNList25		NVARCHAR(MAX) = '' 
	   ,@COLUMNList210		NVARCHAR(MAX) = '' 
	   ,@SK210          	VARCHAR(50)
	   ,@SK25          		VARCHAR(50)		
	   ,@QRY				NVARCHAR(MAX)
	   ;

SELECT @COLUMNS        = @COLUMNS       + '[' + ColumnName    + ']' + ',' + '''%''' +','
      ,@COLUMNList     = @COLUMNList    + '[' + ColumnName    + ']' + ','
	  ,@COLUMNList25   = @COLUMNList25  + '[' + ColumnName25  + ']' + ','
	  ,@COLUMNList210  = @COLUMNList210 + '[' + ColumnName210 + ']' + ','	  

  FROM (

	    SELECT S.schema_id
		      ,S.Name             as SchemName 
	          ,T.Name             as TableName
	          ,C.Column_id
			  ,C.Name             as ColumnName
			  ,C.Name+']' + ' as '  +  '['+C.Name +'25'         as  ColumnName25
			  ,C.Name+']' + ' as '  +  '['+C.Name +'210'        as  ColumnName210

	      FROM sys.schemas S
	      join sys.tables  T
	        on S.Schema_Id = T.Schema_Id
	
	      join sys.Columns C
	        on T.object_id = C.Object_Id 
		   --and C.Name not in ('InsertDateTime','LastUpdateDateTime')
	          
	     WHERE S.name = @SNAME 
	       AND T.Name = @TNAME 
		   ) T WHERE ColumnName NOT in ('InsertDateTime','LastUpdateDateTime')
 
	    
		SELECT @COLUMNS       = SUBSTRING (@COLUMNS   ,1 ,LEN(@COLUMNS)-5)
		SELECT @COLUMNList    = SUBSTRING (@COLUMNList,1 ,LEN(@COLUMNList)-1)
		SELECT @COLUMNList25  = SUBSTRING (@COLUMNList25,1 ,LEN(@COLUMNList25)-1)
		SELECT @COLUMNList210 = SUBSTRING (@COLUMNList210,1 ,LEN(@COLUMNList210)-1)		
		
-------------------------------------------------------------------------------------

SELECT @SK210 = SK210,
       @SK25  = SK25
  FROM (

	    SELECT C.Column_id
			  ,C.Name+'210' as SK210
			  ,C.Name+'25'  as SK25
			  
	      FROM sys.schemas S
	      join sys.tables  T
	        on S.Schema_Id = T.Schema_Id
	
	      join sys.Columns C
	        on T.object_id = C.Object_Id 
	          
	     WHERE S.name = @SNAME 
	       AND T.Name = @TNAME 
		   ) T 
 WHERE Column_Id = 1		

-------------------------------------------------------------------------------------




        SELECT @QRY = 'With CTE_PRD as ('                                                                                                           + CHAR(10) + 
		                   ('     SELECT ' + @COLUMNList25)                                                                                        + CHAR(10) + 
		                    '           ,HASHBYTES(' + '''SHA1'''       + ','      + 'CONCAT(' + @COLUMNS + ')' + ')' + 'as PRD_HashBytes'          + CHAR(10) + 
							'       FROM ' + @TEST + '.' + @SNAME        + '.'      + @TNAME    +  ' with (NOLOCK)'                                 + CHAR(10) + 
							--'       FROM ' + @PRD + '.' + @SNAME        + '.'      + @TNAME    +  ' with (NOLOCK)'                                 + CHAR(10) + 
							--'      WHERE ValidFromWarehouseLoadId = '   + @PNAME                                                                    + CHAR(10) + 
							--'        AND ValidToWarehouseLoadId   = 2123456789  '                                                                   + CHAR(10) +
							'        WHERE ValidToWarehouseLoadId   = 2123456789  '                                                                   + CHAR(10) +
							'        AND DIMSourceSystemId = 14  '                                                                                  + CHAR(10) +
							')'                                                                                                                     + CHAR(10) + 
							

                       ',CTE_DEV as ('                                                                                                              + CHAR(10) + 
		                   ('     SELECT ' + @COLUMNList210)                                                                                         + CHAR(10) + 
		                    '           ,HASHBYTES(' + '''SHA1'''       + ','      + 'CONCAT(' + @COLUMNS + ')' + ')' + 'as DEV_HashBytes'          + CHAR(10) + 
							--'       FROM '              + @SNAME        + '.'      +  @TNAME   +                 ' with (NOLOCK)'                 + CHAR(10) + 
							'       FROM ' + @TEST + '.' + @SNAME        + '.'      + @TNAME    +  ' with (NOLOCK)'                                 + CHAR(10) + 
							--'      WHERE ValidFromWarehouseLoadId = '   + @PNAME                                                                    + CHAR(10) +
							--'        AND ValidToWarehouseLoadId   = 2123456789  '                                                                   + CHAR(10) +
							'        WHERE ValidToWarehouseLoadId   = 2123456789  '                                                                   + CHAR(10) +
							'        AND DIMSourceSystemId = 14  '                                                                                  + CHAR(10) +
							')'                                                                                                                     + CHAR(10) + 
							

        --Building Comparison Query between Prod & Dev
		                    '     SELECT * INTO QA.TR_' + @TNAME                                                                                    + CHAR(10) +
							'  FROM ('                                                                                                              + CHAR(10) +
					        '     SELECT ' + '''' + @TNAME + '''' + ' as EntityName'                                                                + CHAR(10) +
                            '           ,DH.WarehouseLoadId,DH.DataHistoryCode,DH.DataHistoryName'          + CHAR(10) +
							'           ,P.PRD_HashBytes as PRDHashBytes, D.Dev_HashBytes as DevHashBytes'                    + CHAR(10) +
                            '           ,Case WHEN P.PRD_HashBytes = D.Dev_HashBytes '                                                              + CHAR(10) +
	                        '                 THEN ' + '''Passed'''                                                                                 + CHAR(10) + 
			                '                 ELSE ' + '''Failed'''                                                                                 + CHAR(10) +
		                    '             End as TestResult'                                                                                        + CHAR(10) + 
							'           ,GetDate() ' + 'as TestedOn '                                                                               + CHAR(10) +
							'           ,P.*,D.*   '                                                                                                + CHAR(10) +
                            '       FROM CTE_PRD P '                                                                                                + CHAR(10) + 
                            '  FULL Join CTE_DEV D '                                                                                                + CHAR(10) + 
--	                        '        and P.PRD_HashBytes = D.Dev_HashBytes'                                                                           + CHAR(10) + 
                            '         on P.ValidFromWareHouseLoadId25 = D.ValidFromWareHouseLoadId210 '                                             + CHAR(10) +
							'        and ' + @SK210 + ' = ' + @SK25                                                                                 + CHAR(10) +
							'       Left join ' + @TEST + '.' + 'DWH.DimDataHistory DH On P.ValidFromWareHouseLoadId25 = DH.WareHouseLoadId'       + CHAR(10) +
							--'       Left join DWH.DimDataHistory DH On P.DimDataHistoryId210 = DH.DimDataHistoryId'                  + CHAR(10) +
							')TMP'




		--print @QRY

		EXECUTE sp_executesql @QRY

--SELECT * FROM QA.TR_DimORIReinsurer;


END;
GO


--Execute DimHashCheck
--EXEC QA.DimHashCheck @SNAME = 'DWH', @TNAME = 'DimBroker'
--EXEC QA.DimHashCheck @SNAME = 'DWH', @TNAME = 'DimOriTransaction'