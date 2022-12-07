

/*************************************************************************************************************************************************************************

Purpose     :- Script to compare Row by Row using Hash (Only FOR FACTOriTransactionDataHistory Table)
Table Type  :- DIM Tables 
Owner       :- Ram Baskar
Date        :- 26/04/2022
DATE		:- 05/05/2022 - Modified to capture the result in a table
DATE		:- 12/05/2022 - Modified to exclude ValidFromWarehouseLoadId and to check only active records

This script will create CTE Query and runs automatically and results will be stoted in a table under QA schema


DATE		:- 16/05/2022 - Modified to include the partitions correctly for Dev/Prod(TEST) as the partitions in Dev for 27th March 2022 will be different from Prod/TEST
DATE		:- 17/05/2022 - Modified to pick up the correct SK Id for the given input table for comparison


***************************************
***************************************


LATEST Copy of the Script 


***************************************
***************************************


* ************************************************************************************************************************************************************************/
--use MYMI_Datawarehouse;


CREATE or ALTER Procedure QA.PRODDimHashCheck (@SName VARCHAR(20),@TName VARCHAR(100),@PTYPE VARCHAR(1),@PRDCDATE  DATE, @DEVCDATE DATE)
AS 
BEGIN


DECLARE @QUERY			NVARCHAR(MAX)
       ,@RETURNED_VALUE NVARCHAR(50)
	   ,@PRD			VARCHAR(150)
	   ,@TEST			VARCHAR(150)
	   ,@PRDPNAME		VARCHAR(100)
	   ,@DEVPNAME		VARCHAR(100)
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

DECLARE @DropTable NVARCHAR(MAX) = 'DROP TABLE IF EXISTS QA.PRODTR_' + @TNAME;
EXEC(@DropTable);

SET @PRD   = '[MYMI-PRD].[MyMI_DataWareHouse]'; -- Linked Server created from MyMI-Dev
--SET @TEST  = '[MYMI-TEST].[MyMI_DataWareHouse]'; -- Linked Server created from MyMI-Dev used as Production as MYMI-Test was being used as Production
SET @TEST  = '[MYMI-PROD].[MyMI_DataWareHouse]'; -- Linked Server created from MyMI-test to access MYMI-PRODUCTION

SELECT @PRDPNAME = WarehouseLoadId
  --FROM [MYMI-TEST].[MYMI_Datawarehouse].DWH.DimDataHistory ---------->1
  FROM [MYMI-PROD].[MYMI_Datawarehouse].DWH.DimDataHistory ---------->1
 WHERE CalendarAsAtDate = @PRDCDATE
   AND DataHistoryCode like @PTYPE+'%'

 SET @QUERY = 'SELECT @RETURNED_VALUE = MAX(ValidFromWarehouseLoadId) FROM ' + @SNAME + '.' + @TNAME
EXEC sp_executesql @query, N'@returned_value varchar(50) OUTPUT', @returned_value OUTPUT 
--SELECT @returned_value

SET @DEVPNAME = @returned_value; -- Get the latest Calendar Partition data from DEV which is in 2.10 version


DECLARE	
	    @COLUMNS			VARCHAR(MAX) = '' 
	   ,@COLUMNList			VARCHAR(MAX) = ''
	   ,@COLUMNList25		NVARCHAR(MAX) = '' 
	   ,@COLUMNList210		NVARCHAR(MAX) = '' 
	   ,@SK210          	VARCHAR(50)
	   ,@SK25          		VARCHAR(50)		
	   ,@CNAMEID       		VARCHAR(50)		
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
		   --) T WHERE ColumnName NOT in ('InsertDateTime','LastUpdateDateTime','ValidFromWarehouseLoadID')
		   ) T WHERE ColumnName NOT in ('InsertDateTime','LastUpdateDateTime','ValidFromWarehouseLoadID','ORIProgrammeDescription','GXLPProgrammeCode','DimensionCheckSum') 
 
	    
		SELECT @COLUMNS       = SUBSTRING (@COLUMNS   ,1 ,LEN(@COLUMNS)-5)
		SELECT @COLUMNList    = SUBSTRING (@COLUMNList,1 ,LEN(@COLUMNList)-1)
		SELECT @COLUMNList25  = SUBSTRING (@COLUMNList25,1 ,LEN(@COLUMNList25)-1)
		SELECT @COLUMNList210 = SUBSTRING (@COLUMNList210,1 ,LEN(@COLUMNList210)-1)		
		
-------------------------------------------------------------------------------------

SELECT @SK210 = SK210,
       @SK25  = SK25
  FROM (

	    SELECT C.Column_id
		      ,C.Name
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
 --WHERE Column_Id = 1		
 WHERE Name = @TNAME+'ID'		--Changed to pick up the correct SK Id for the given input table

-------------------------------------------------------------------------------------




        SELECT @QRY = 'With CTE_PRD as ('                                                                                                           + CHAR(10) + 
		                   ('     SELECT ' + @COLUMNList25)                                                                                         + CHAR(10) + 
		                    '           ,HASHBYTES(' + '''SHA1'''       + ','      + 'CONCAT(' + @COLUMNS + ')' + ')' + 'as PRD_HashBytes'          + CHAR(10) + 
							'       FROM ' + @TEST + '.' + @SNAME        + '.'      + @TNAME    +  ' with (NOLOCK)'                                 + CHAR(10) + 
							'      WHERE DIMSourceSystemId = 14 '                                                                                   + CHAR(10) + 
							'        AND ValidFromWarehouseLoadId <= '   + @PRDPNAME                                                                + CHAR(10) + 
							'        AND ValidToWarehouseLoadId   = 2123456789  '                                                                   + CHAR(10) +
							')'                                                                                                                     + CHAR(10) + 
							

                       ',CTE_DEV as ('                                                                                                              + CHAR(10) + 
		                   ('     SELECT ' + @COLUMNList210)                                                                                        + CHAR(10) + 
		                    '           ,HASHBYTES(' + '''SHA1'''       + ','      + 'CONCAT(' + @COLUMNS + ')' + ')' + 'as TEST_HashBytes'          + CHAR(10) + 
							'       FROM '              + @SNAME        + '.'      +  @TNAME   +                 ' with (NOLOCK)'                   + CHAR(10) + 
							'      WHERE DIMSourceSystemId = 14  '                                                                                  + CHAR(10) +
							'        AND ValidFromWarehouseLoadId   <= ' + @DEVPNAME                                                                + CHAR(10) +
							'        AND ValidToWarehouseLoadId   = 2123456789  '                                                                   + CHAR(10) +
							')'                                                                                                                     + CHAR(10) + 
							

        --Building Comparison Query between Prod & Dev
		                    '     SELECT * INTO QA.PRODTR_' + @TNAME                                                                                    + CHAR(10) +
							'  FROM ('                                                                                                              + CHAR(10) +
					        '     SELECT ' + '''' + @TNAME + '''' + ' as EntityName'                                                                + CHAR(10) +
                            --'           ,DH.WarehouseLoadId,DH.DataHistoryCode,DH.DataHistoryName'                                                  + CHAR(10) +
							'           ,P.PRD_HashBytes as PRDHashBytes, D.TEST_HashBytes as TestHashBytes'                                          + CHAR(10) +
                            '           ,Case WHEN P.PRD_HashBytes = D.TEST_HashBytes THEN ' + '''Passed'''                                          + CHAR(10) +
	                        '                 WHEN P.PRD_Hashbytes is NULL           THEN ' + '''Failed - Missing in 2.5'''                         + CHAR(10) + 
							'                 WHEN D.TEST_HashBytes is NULL           THEN ' + '''Failed - Missing in 2.10'''                        + CHAR(10) + 
			                '                 ELSE                                        ' + '''Failed - MisMatch of Hash'''                       + CHAR(10) +
		                    '             End as TestResult'                                                                                        + CHAR(10) + 
							'           ,GetDate() ' + 'as TestedOn '                                                                               + CHAR(10) +
							'           ,P.*,D.*   '                                                                                                + CHAR(10) +
                            '       FROM CTE_PRD P '                                                                                                + CHAR(10) + 
                            '  FULL Join CTE_DEV D '                                                                                                + CHAR(10) + 
							'         on ' + @SK210 + ' = ' + @SK25                                                                                 + CHAR(10) +
                            --'        and P.ValidFromWareHouseLoadId25 = D.ValidFromWareHouseLoadId210 '                                             + CHAR(10) +
							--'       Left join '   + 'DWH.DimDataHistory DH On P.ValidFromWareHouseLoadId25 = DH.WareHouseLoadId'                    + CHAR(10) +
							--'       Left join ' + @TEST + '.' + 'DWH.DimDataHistory DH On P.ValidFromWareHouseLoadId25 = DH.WareHouseLoadId'       + CHAR(10) +
							
							')TMP'




		--print @QRY

		EXECUTE sp_executesql @QRY

--SELECT * FROM QA.TR_DimORIReinsurer;


END;
GO
/*
--Execute DimHashCheck
--EXEC QA.DimHashCheck @SNAME = 'DWH', @TNAME = 'DimBroker',               @PTYPE = 'C', @PRDCDATE = '2022-03-27', @DEVCDATE = '2022-05-25' -- Out of scope
EXEC QA.PRODDimHashCheck @SNAME = 'DWH', @TNAME = 'DimRiskCount',            @PTYPE = 'C', @PRDCDATE = '2022-06-30', @DEVCDATE = '2022-06-30'
EXEC QA.PRODDimHashCheck @SNAME = 'DWH', @TNAME = 'DimORICession',           @PTYPE = 'C', @PRDCDATE = '2022-06-30', @DEVCDATE = '2022-06-30'
EXEC QA.PRODDimHashCheck @SNAME = 'DWH', @TNAME = 'DimBroker',               @PTYPE = 'C', @PRDCDATE = '2022-06-30', @DEVCDATE = '2022-06-30'
EXEC QA.PRODDimHashCheck @SNAME = 'DWH', @TNAME = 'DimORIApplicablePremium', @PTYPE = 'C', @PRDCDATE = '2022-06-30', @DEVCDATE = '2022-06-30'
EXEC QA.PRODDimHashCheck @SNAME = 'DWH', @TNAME = 'DimORIClaimSubEvent',     @PTYPE = 'C', @PRDCDATE = '2022-06-30', @DEVCDATE = '2022-06-30'
EXEC QA.PRODDimHashCheck @SNAME = 'DWH', @TNAME = 'DimORIContractType',      @PTYPE = 'C', @PRDCDATE = '2022-06-30', @DEVCDATE = '2022-06-30'
EXEC QA.PRODDimHashCheck @SNAME = 'DWH', @TNAME = 'DimORIDepartment',        @PTYPE = 'C', @PRDCDATE = '2022-06-30', @DEVCDATE = '2022-06-30'
EXEC QA.PRODDimHashCheck @SNAME = 'DWH', @TNAME = 'DimORIUSMTransaction',    @PTYPE = 'C', @PRDCDATE = '2022-06-30', @DEVCDATE = '2022-06-30'
EXEC QA.PRODDimHashCheck @SNAME = 'DWH', @TNAME = 'DimORIProgramme',         @PTYPE = 'C', @PRDCDATE = '2022-06-30', @DEVCDATE = '2022-06-30'
EXEC QA.PRODDimHashCheck @SNAME = 'DWH', @TNAME = 'DimORIReinsurer',         @PTYPE = 'C', @PRDCDATE = '2022-06-30', @DEVCDATE = '2022-06-30'
EXEC QA.PRODDimHashCheck @SNAME = 'DWH', @TNAME = 'DimOriTransaction',       @PTYPE = 'C', @PRDCDATE = '2022-06-30', @DEVCDATE = '2022-06-30'
*/