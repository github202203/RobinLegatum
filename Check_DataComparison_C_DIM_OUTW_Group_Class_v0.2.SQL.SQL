
/****************************************************************************************************************

Purpose     :- Script to compare Row by Row using Hash for Dim.OUTW_GroupClass Table

Owner       :- Ram Baskar
Date        :- 16/06/2022		Initial version
Date		:- 19/06/2022		Changed to Dynamic SQL
DATE		:- 27/06/2022		Included Partition Type & DAL Date

Run this Query from MYMI-Dev Server

************************************************************************************************************* */
use MYMI_datawarehouse; 

DECLARE @DAL			VARCHAR(150)
	   ,@PNAME			VARCHAR(100)
	   ,@PTYPE          VARCHAR(20)
	   ,@SNAME			VARCHAR(10)   
	   ,@DALSNAME		VARCHAR(10)   
	   ,@TNAME			VARCHAR(100) 
	   ,@DALTNAME		VARCHAR(100) 
	   ,@MAXDALDATE		VARCHAR(10)
	   ,@SRCTNAME		VARCHAR(100)
	   ,@SRCTTYPE		VARCHAR(10)
	   
	   
SET @DAL  = '[AZURE DATALIBLEG SQLDB].[datalibleg-sqldb-01-uks-dev]'; 

SET @SNAME = 'QA';
SET @TNAME = 'TMP_DIM_OUTW_GroupClass';
SET @PTYPE = 'Calendar'

SET @DALSNAME = 'DIM';
SET @DALTNAME = 'OUTW_GroupClass';

SET @MAXDALDATE = (SELECT MAX(Date_Of_LOAD) FROM [AZURE DATALIBLEG SQLDB].[datalibleg-sqldb-01-uks-dev].[Dim].[OUTW_GroupClass]);

SET @SRCTNAME = 'OUTW_GroupClass';
SET @SRCTTYPE   = 'DIM';

DECLARE @TRDropTable NVARCHAR(MAX) = 'DROP TABLE IF EXISTS QA.TR_' + @TNAME; 
   EXEC(@TRDropTable);
   
DECLARE @TMPDropTable NVARCHAR(MAX) = 'DROP TABLE IF EXISTS QA.TMP_' + @SRCTTYPE + '_' + @SRCTNAME; 
   EXEC(@TMPDropTable);   
   
DECLARE @CRTable   NVARCHAR(MAX) = 'SELECT * INTO QA.TMP_' + @SRCTTYPE + '_' + @SRCTNAME + ' FROM [AZURE DATALIBLEG SQLDB].[datalibleg-sqldb-01-uks-dev].Dim.OUTW_GroupClass  WHERE 1=2';
   EXEC(@CRTable);   
   
DECLARE @ALTable   NVARCHAR(MAX) = 'ALTER TABLE QA.TMP_' + @SRCTTYPE + '_' +@SRCTNAME + ' DROP COLUMN Date_Of_Load, ROW_ID';
   EXEC(@ALTable);   

DECLARE @INSERTDATA NVARCHAR(MAX) = 'INSERT INTO QA.TMP_' + @SRCTTYPE + '_' + @SRCTNAME +  CHAR(10) + 
                                    'EXEC [RITC_EXT].[OUTW_Dim_GroupClass] 1 '
   EXEC(@INSERTDATA);

--SELECT * FROM QA.TMP_DIM_INW_GroupClass 

--print @DAL

--DROP TABLE IF EXISTS QA.TR_TMP_DIM_INW_GroupClass;

DECLARE	
	    @COLUMNS			NVARCHAR(MAX) = '' 
	   ,@COLUMNList			NVARCHAR(MAX) = ''
	   ,@COLUMNListMYMI		NVARCHAR(MAX) = '' 
	   ,@COLUMNListDAL		NVARCHAR(MAX) = '' 
	   ,@SKDAL          	VARCHAR(50)
	   ,@SKMYMI        		VARCHAR(50)		
	   ,@QRY				NVARCHAR(MAX)
	   ;

SELECT @COLUMNS        = @COLUMNS       + '[' + ColumnName    + ']' + ',' + '''%''' +','
      ,@COLUMNList     = @COLUMNList    + '[' + ColumnName    + ']' + ','
	  ,@COLUMNListMYMI   = @COLUMNListMYMI  + '[' + ColumnNameMYMI  + ']' + ','
	  ,@COLUMNListDAL  = @COLUMNListDAL + '[' + ColumnNameDAL + ']' + ','	  

  FROM (

	    SELECT S.schema_id
		      ,S.Name             as SchemName 
	          ,T.Name             as TableName
	          ,C.Column_id
			  ,C.Name             as ColumnName
			  ,C.Name+']' + ' as '  +  '[' + C.Name + 'MYMI'         as  ColumnNameMYMI
			  ,C.Name+']' + ' as '  +  '[' + C.Name + 'DAL'          as  ColumnNameDAL

	      FROM sys.schemas S
	      join sys.tables  T
	        on S.Schema_Id = T.Schema_Id
	
	      join sys.Columns C
	        on T.object_id = C.Object_Id 
		   
	          
	     WHERE S.name = @SNAME 
	       AND T.Name = @TNAME 
		   ) T --WHERE ColumnName NOT in ('InsertDateTime','LastUpdateDateTime')
 
--	    print 'Columns = ' + @COLUMNS 
		SELECT @COLUMNS       = SUBSTRING (@COLUMNS   ,1 ,LEN(@COLUMNS)-5)
--		print 'Columns = ' + @COLUMNS 
		SELECT @COLUMNList    = SUBSTRING (@COLUMNList,1 ,LEN(@COLUMNList)-1)
--		print 'ColumnList = ' + @COLUMNList
		SELECT @COLUMNListMYMI  = SUBSTRING (@COLUMNListMYMI,1 ,LEN(@COLUMNListMYMI)-1)
		SELECT @COLUMNListDAL = SUBSTRING (@COLUMNListDAL,1 ,LEN(@COLUMNListDAL)-1)		

--		print @COLUMNListMYMI
--		print @COLUMNListDAL
		
-------------------------------------------------------------------------------------

SELECT @SKDAL = SKDAL,
       @SKMYMI  = SKMYMI
  FROM (

	    SELECT C.Column_id
			  ,C.Name + 'DAL'   as SKDAL
			  ,C.Name + 'MYMI'  as SKMYMI
			  
	      FROM sys.schemas S
	      join sys.tables  T
	        on S.Schema_Id = T.Schema_Id
	
	      join sys.Columns C
	        on T.object_id = C.Object_Id 
	          
	     WHERE S.name = @SNAME 
	       AND T.Name = @TNAME 
		   ) T 
 WHERE Column_Id = 1		

-- print 'SKDAL = ' + @SKDAL
 ----------------------------------------------------

 SELECT @QRY = 'With CTE_MYMI as ('                                                                                                                  + CHAR(10) + 
		                   ('     SELECT ' + @COLUMNListMYMI)                                                                                        + CHAR(10) + 
		                    '           ,HASHBYTES(' + '''SHA1'''       + ','      + 'CONCAT(' + @COLUMNS + ')' + ')' + 'as MYMI_HashBytes'          + CHAR(10) + 
							'       FROM ' +  @SNAME        + '.'      + @TNAME    +  ' with (NOLOCK)'                                               + CHAR(10) + 
							')'                                                                                                                      + CHAR(10) + 
							

                       ',CTE_DAL as ('                                                                                                               + CHAR(10) + 
		                   ('     SELECT ' + @COLUMNListDAL)                                                                                         + CHAR(10) + 
		                    '           ,HASHBYTES(' + '''SHA1'''       + ','      + 'CONCAT(' + @COLUMNS + ')' + ')' + 'as DAL_HashBytes'           + CHAR(10) + 
							'       FROM ' + @DAL + '.' + @DALSNAME        + '.'      + @DALTNAME    +  ' with (NOLOCK)'                             + CHAR(10) + 
							'        WHERE Date_Of_Load  =  ' + '''' + @MaxDALDate  + ''''                                                           + CHAR(10) + 

							')'                                                                                                                      + CHAR(10) + 
							

        --Building Comparison Query between Prod & Dev
		                    '     SELECT * INTO QA.TR_' + @TNAME                                                                                     + CHAR(10) +
							'  FROM ('                                                                                                               + CHAR(10) +
					        '     SELECT ' + '''' + @DALTNAME + '''' + ' as EntityName'                                                              + CHAR(10) +
							',                ''' + @MAXDALDATE + ''' ' + ' as DALDate'                                                              + CHAR(10) + 
							',                ''' + @PTYPE      + ''' ' + ' as PartitionType '                                                       + CHAR(10) + 
							'           ,P.MYMI_HashBytes as MYMIHashBytes, D.DAL_HashBytes as DALHashBytes'                                         + CHAR(10) +
                            '           ,Case WHEN P.MYMI_HashBytes = D.DAL_HashBytes '                                                              + CHAR(10) +
	                        '                 THEN ' + '''Passed'''                                                                                  + CHAR(10) + 
			                '                 ELSE ' + '''Failed'''                                                                                  + CHAR(10) +
		                    '             End as TestResult'                                                                                         + CHAR(10) + 
							'           ,GetDate() ' + 'as TestedOn '                                                                                + CHAR(10) +
							'           ,P.*,D.*   '                                                                                                 + CHAR(10) +
                            '       FROM CTE_MYMI P '                                                                                                + CHAR(10) + 
                            '  FULL Join CTE_DAL  D '                                                                                                + CHAR(10) + 
							'        on ' + @SKDAL + ' = ' + @SKMYMI                                                                                 + CHAR(10) +
							'       and    MYMI_HashBytes = DAL_HashBytes   '                                                                        + CHAR(10) + 							
							--'       and  P.REPORTING_FLAGMYMI =  D.REPORTING_FLAGDAL '                                                               + CHAR(10) +
							')TMP'




--print @QRY

EXECUTE sp_executesql @QRY

SELECT * FROM QA.TR_TMP_DIM_OUTW_GroupClass;

SELECT EntityName, DALDate,PartitionType,TestResult, COUNT(*) as TotalRecords 
  FROM QA.TR_TMP_DIM_OUTW_GroupClass
 GROUP By EntityName,DALDate,PartitionType,TestResult;