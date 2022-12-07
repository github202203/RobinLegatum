--use MYMI_Datawarehouse


/*********************************************************************************************************

Purpose     :- Script to compare Row by Row using Hash (Only FOR FACTOriTransactionDataHistory Table)
Table Type  :- FACTOriTransactionDataHistory 
Owner       :- Ram Baskar
Date        :- 26/04/2022
DATE		:- 05/05/2022 - Modified to capture the result in a table
DATE		:- 10/05/2022 - Modified to Stored Procedure

This script will create only CTE Query and needs to run manually

Syntax to call this procedure to generate CTE Script for FACTOriTransactionDataHistory Entity
QA.FactHashCheck_CTE_For_FactORITransactionDataHistory @SName = 'DWH',@TName = 'FactORITransactionDataHistory',@CDATE = '2022-05-08', @PTYPE = 'C', @Scenario = 'Scenario-1', @PPeriod = '202203', @SSID = '14'

* *********************************************************************************************************/

use MYMI_Datawarehouse

SET ANSI_NULLS    ON 
SET ANSI_WARNINGS ON

GO


CREATE or ALTER Procedure QA.FactHashCheck_CTE_For_FactORITransactionDataHistory (@SName VARCHAR(20),@TName VARCHAR(100),@CDATE DATE, @PTYPE VARCHAR(1), @Scenario VARCHAR(250), @PPEriod VARCHAR(6), @SSID VARCHAR(2))
AS 
BEGIN


DECLARE	 @QUERY	     		    NVARCHAR(MAX)
        ,@COLUMNS        	    VARCHAR (MAX) = '' 
		,@COLUMNList     	    NVARCHAR(MAX) = '' 
		,@COLUMNList25		    NVARCHAR(MAX) = '' 
		,@COLUMNList210		    NVARCHAR(MAX) = '' 
		,@QRY            	    VARCHAR (MAX) = ''
		,@QRY1           	    VARCHAR (MAX) = ''
		,@QRY2           	    VARCHAR (MAX) = ''
		,@QRY3           	    VARCHAR (MAX) = ''
		,@QRY4           	    VARCHAR (MAX) = ''
        ,@PRD		    	    VARCHAR(150)
		,@TEST		    	    VARCHAR(150)
		,@SK210          	    VARCHAR(50)
		,@SK25          	    VARCHAR(50)
		,@PNAME		    	    VARCHAR(100) --Partiton Name will be derived
		,@DEVPNAME				VARCHAR(100)
		,@MAX_DimDataHistoryId	NVARCHAR(50)
/*		
		,@SNAME          	VARCHAR(3)   --Schema Name = 'DWH'
		,@TNAME          	VARCHAR(100) --TableName in test
		,@SSID				VARCHAR(2)   --Source System Id ( =14 for GXLP )
		,@PPeriod			VARCHAR(6)   --Process Period to validate for a particular month in YYYYMM format
		,@CDATE             DATE */
		;

DECLARE @DropTable NVARCHAR(MAX) = 'DROP TABLE IF EXISTS QA.TR_' + @TNAME;
EXEC(@DropTable);

--Setting up all the Parameters 

SET @MAX_DimDataHistoryId = 'NOT CHANGED';				
SET @PRD     = '[MYMI-PRD].[MyMI_DataWareHouse]';  -- Linked Server created from MyMI-Dev to access PROD
SET @TEST    = '[MYMI-TEST].[MyMI_DataWareHouse]'; -- Linked Server created from MyMI-Dev to access TEST

/**************************************************************
SET @SNAME   = 'DWH';
SET @TNAME   = 'FactORITransactionDataHistory';
SET @CDATE   = '2022-05-08';
SET @PPeriod = 202203;
SET @SSID    = 14;
* ************************************************************/
	    
SELECT @PNAME = DimDataHistoryId
  --FROM DWH.DimDataHistory ---------->1
  FROM [MYMI-TEST].[MYMI_Datawarehouse].DWH.DimDataHistory ---------->1
 WHERE CalendarAsAtDate = @CDATE
   --AND DataHistoryCode like 'C%'
   AND DataHistoryCode like @PTYPE+'%'
   
SET @QUERY = 'SELECT @MAX_DimDataHistoryId = MAX(DimDataHistoryId) FROM ' + @SNAME + '.' + @TNAME
EXEC sp_executesql @query, N'@MAX_DimDataHistoryId varchar(50) OUTPUT', @MAX_DimDataHistoryId OUTPUT 
--SELECT @MAX_DimDataHistoryId

SET @DEVPNAME = @MAX_DimDataHistoryId; -- Get the latest Calendar Partition data from DEV which is in 2.10 version
   
   
SELECT @Scenario = Case when @Scenario = 'Scenario-1' then 'FACT - Hash Check - Latest Calendar Open Period'                                + ' - ' + @TNAME
                        when @Scenario = 'Scenario-2' then 'FACT - Hash Check - Latest Calendar Closed Period'                              + ' - ' + @TNAME
						when @Scenario = 'Scenario-3' then 'FACT - Hash Check - Historical Calendar Open/Closed Period'                     + ' - ' + @TNAME
						when @Scenario = 'Scenario-5' then 'FACT - Hash Check - Financial Closed Period'                                    + ' - ' + @TNAME
		            End    

SELECT @COLUMNS        = @COLUMNS       + '[' + ColumnName    + ']' + ',' + '''%''' +','
      ,@COLUMNList     = @COLUMNList    + '[' + ColumnName    + ']' + ','
	  ,@COLUMNList25   = @COLUMNList25  + '[' + ColumnName25  + ']' + ','
	  ,@COLUMNList210  = @COLUMNList210 + '[' + ColumnName210 + ']' + ','

  FROM (

	    SELECT S.schema_id
		      ,S.Name                                           as SchemName 
	          ,T.Name                                           as TableName
	          ,C.Column_id
			  ,C.Name                                           as ColumnName
			  ,C.Name+']' + ' as '  +  '['+C.Name +'25'         as ColumnName25
			  ,C.Name+']' + ' as '  +  '['+C.Name +'210'        as ColumnName210

	      FROM sys.schemas S
	      join sys.tables  T
	        on S.Schema_Id = T.Schema_Id
	
	      join sys.Columns C
	        on T.object_id = C.Object_Id 
	          
	     WHERE S.name = @SNAME 
	       AND T.Name = @TNAME 
		   ) T WHERE ColumnName NOT in ('InsertDateTime','LastUpdateDateTime')
 
	    
		SELECT @COLUMNS       = SUBSTRING (@COLUMNS       ,1 ,LEN(@COLUMNS)-5)
		SELECT @COLUMNList    = SUBSTRING (@COLUMNList    ,1 ,LEN(@COLUMNList)-1)
		SELECT @COLUMNList25  = SUBSTRING (@COLUMNList25  ,1 ,LEN(@COLUMNList25)-1)
		SELECT @COLUMNList210 = SUBSTRING (@COLUMNList210 ,1 ,LEN(@COLUMNList210)-1)

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

		--Check the output from the variables @COLUMNS/@COLUMNList/HASHBYTES ....
		--print @COLUMNS
		--print('SELECT ' + @COLUMNList) 
		--print ',HASHBYTES(' + '''SHA1''' + ',' + 'CONCAT(' + @COLUMNS + ')' + ')' + 'as Dev_HashBytes' 

		--Building CTE Query for Prod

        SELECT @QRY1 =  'With CTE_PRD as ('                                                                                                             + CHAR(10) + 
		                   ('     SELECT ' + @COLUMNList25)                                                                                            + CHAR(10) + 
		                    '           ,HASHBYTES(' + '''SHA1'''       + ','      + 'CONCAT(' + @COLUMNS + ')' + ')' + 'as PRD_HashBytes'              + CHAR(10) + 
							'       FROM ' + @TEST + '.' + @SNAME        + '.'      + @TNAME    +  ' with (NOLOCK)'                                      + CHAR(10) + 
							'      WHERE DimDataHistoryId = '           + @PNAME                                                                        + CHAR(10) +     
							'        AND DimProcessPeriodId = '         + @PPeriod                                                                      + CHAR(10) +       
							'        AND DimSourceSystemId  = '         + @SSID                                                                         + CHAR(10) +       
							      ')'                                                                                                                   + CHAR(10) 
								 
       --Building CTE Query for Dev/Test
																																					    
         SELECT @QRY2 =   ',CTE_DEV as ('                                                                                                               + CHAR(10) + 
		                   ('     SELECT ' + @COLUMNList210)                                                                                             + CHAR(10) + 
		                    '           ,HASHBYTES(' + '''SHA1'''       + ','      + 'CONCAT(' + @COLUMNS + ')' + ')' + 'as DEV_HashBytes'              + CHAR(10) + 
							'       FROM '              + @SNAME        + '.'      +  @TNAME   +  ' with (NOLOCK)'                                      + CHAR(10) + 
							--'       FROM ' + @TEST + '.' + @SNAME        + '.'      + @TNAME    +  ' with (NOLOCK)'                                     + CHAR(10) + 
							'      WHERE DimDataHistoryId = '           + @DEVPNAME                                                                        + CHAR(10) +     
							'        AND DimProcessPeriodId = '         + @PPeriod                                                                      + CHAR(10) +       
							'        AND DimSourceSystemId  = '         + @SSID                                                                         + CHAR(10) +       
							      ')'                                                                                                                   + CHAR(10) 
							
							
        --Building Comparison Query between Prod & Dev

                            
         SELECT @QRY3 =   'SELECT * INTO QA.TR_' + @TNAME                                                                                               + CHAR(10) +
							'  FROM ('                                                                                                                  + CHAR(10) +
					        '     SELECT ' + '''' + @TNAME + '''' + ' as EntityName'                                                                    + CHAR(10) +
							'           ,' + '''' + @Scenario + '''' + ' as TestType'                                                                   + CHAR(10) +
							'           ,DH.WarehouseLoadId,DH.DataHistoryCode,DH.DataHistoryName,P.DimDataHistoryId25 as PRD_DimDataHistory'          + CHAR(10) +
							'           ,P.PRD_HashBytes as PRDHashBytes, D.DimDataHistoryId210 as DEV_DimDataHistory,D.Dev_HashBytes as DEVHashBytes'   + CHAR(10) +
                            '           ,Case WHEN P.PRD_HashBytes = D.Dev_HashBytes THEN ' + '''Passed'''                                              + CHAR(10) +
	                        '                 WHEN P.PRD_Hashbytes is NULL THEN ' + '''Failed - Missing in 2.5'''                                       + CHAR(10) + 
							'                 WHEN D.Dev_HashBytes is NULL THEN ' + '''Failed - Missing in 2.10'''                                      + CHAR(10) + 
			                '                 ELSE ' + '''Failed - MisMatch of Hash'''                                                                  + CHAR(10) +
		                    '             End as TestResult'                                                                                            + CHAR(10) + 
							'           ,GetDate() ' + 'as TestedOn '                                                                                   + CHAR(10) +
							'           ,P.*,D.*   '                                                                                                    + CHAR(10) +
                            '       FROM CTE_PRD P '                                                                                                    + CHAR(10) + 
                            '		FULL Join CTE_DEV D '                                                                                               + CHAR(10) + 
							'         on ' + @SK210 + ' = ' + @SK25                                                                                     + CHAR(10) +
                            --'        and P.DimDataHistoryId25 = D.DimDataHistoryId210 '                                                                 + CHAR(10) +
							--'       Left join ' + @TEST + '.' + 'DWH.DimDataHistory DH On P.DimDataHistoryId25 = DH.DimDataHistoryId'                  + CHAR(10) +
							'       Left join DWH.DimDataHistory DH On P.DimDataHistoryId25 = DH.DimDataHistoryId'                  + CHAR(10) +
							')TMP'
print @QRY1
print @QRY2
print @QRY3


END;
GO

--EXEC QA.FactHashCheck_CTE_For_FactORITransactionDataHistory @SName = 'DWH',@TName = 'FactORITransactionDataHistory',@CDATE = '2022-05-08', @PTYPE = 'C', @Scenario = 'Scenario-1', @PPeriod = '202203', @SSID = '14'

