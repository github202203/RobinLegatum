
/********************************************************************************************************************

Purpose     :- Script to compare Row by Row using Hash for FACT.INW_Fact_OSClaim Table between Staging & DAL Server

Owner       :- Ram Baskar
Date        :- 23/06/2022		Initial version v0.1


Run this Query from MYMI-Dev Server

************************************************************************************************************* */

DECLARE	
	    @COLUMNS			NVARCHAR(MAX) = '' 
	   ,@COLUMNList			NVARCHAR(MAX) = ''
	   ,@COLUMNListMYMISTG	NVARCHAR(MAX) = '' 
	   ,@COLUMNListDAL		NVARCHAR(MAX) = '' 
	   ,@SKDAL          	VARCHAR(50)
	   ,@SKMYMI        		VARCHAR(50)		
	   ,@QRY				NVARCHAR(MAX)
	   ,@DAL				NVARCHAR(MAX) 	= '[AZURE DATALIBLEG SQLDB].[datalibleg-sqldb-01-uks-dev]'
	   ,@DALSNAME			VARCHAR(50) 	= 'FACT'
	   ,@DALTNAME			VARCHAR(150) 	= 'INW_OSCLAIM'
	   ,@MAXDALDATE			VARCHAR(10)
	   ,@DBNAME				VARCHAR(100) = '[datalibleg-sqldb-01-uks-dev]'
	   ,@SNAME				VARCHAR(50)		= 'Staging'
	   ,@TNAME				VARCHAR(100) 	= 'INW_OS_Claim_Extract'
	   ;

SET @MAXDALDATE = (SELECT MAX(Date_Of_LOAD) FROM [AZURE DATALIBLEG SQLDB].[datalibleg-sqldb-01-uks-dev].[FACT].[INW_OSClaim]);

SELECT @COLUMNS          = @COLUMNS         + '[' + ColumnName      + ']' + ',' + '''%''' +','
      ,@COLUMNList       = @COLUMNList      + '[' + ColumnName      + ']' + ','
	  ,@COLUMNListMYMISTG = @COLUMNListMYMISTG  + '[' + ColumnNameMYMISTG  + ']' + ','
	  ,@COLUMNListDAL    = @COLUMNListDAL   + '[' + ColumnNameDAL   + ']' + ','	  

  FROM (

	    SELECT S.schema_id
		      ,S.Name             as SchemName 
	          ,T.Name             as TableName
	          ,C.Column_id
			  ,C.Name             as ColumnName
			  ,C.Name+']' + ' as '  +  '[' + C.Name + 'MYMISTG'         as  ColumnNameMYMISTG
			  ,C.Name+']' + ' as '  +  '[' + C.Name + 'DAL'             as  ColumnNameDAL

	      FROM [datalibleg-sqldb-01-uks-dev].sys.schemas S
	      join [datalibleg-sqldb-01-uks-dev].sys.tables  T
	        on S.Schema_Id = T.Schema_Id
	
	      join [datalibleg-sqldb-01-uks-dev].sys.Columns C
	        on T.object_id = C.Object_Id 
		   
	          
	     WHERE S.name = @SNAME 
	       AND T.Name = @TNAME 
		   ) T WHERE ColumnName NOT in ('REPORTING_FLAG','ROW_ID')
 
--	    print 'Columns = ' + @COLUMNS 
		SELECT @COLUMNS       = SUBSTRING (@COLUMNS   ,1 ,LEN(@COLUMNS)-5)
--		print 'Columns = ' + @COLUMNS 
		SELECT @COLUMNList    = SUBSTRING (@COLUMNList,1 ,LEN(@COLUMNList)-1)
--		print 'ColumnList = ' + @COLUMNList
		SELECT @COLUMNListMYMISTG  = SUBSTRING (@COLUMNListMYMISTG,1 ,LEN(@COLUMNListMYMISTG)-1)
		SELECT @COLUMNListDAL      = SUBSTRING (@COLUMNListDAL,1 ,LEN(@COLUMNListDAL)-1)		

--		print @COLUMNListMYMI
--		print @COLUMNListDAL
		

 SELECT @QRY = 'With CTE_PRD as ('                                                                                                                   + CHAR(10) + 
		                   ('     SELECT ' + @COLUMNListMYMISTG)                                                                                     + CHAR(10) + 
		                    '           ,HASHBYTES(' + '''SHA1'''       + ','      + 'CONCAT(' + @COLUMNS + ')' + ')' + 'as MYMISTG_HashBytes'       + CHAR(10) + 
							'       FROM ' +  @DBNAME + '.' + @SNAME        + '.'      + @TNAME    +  ' with (NOLOCK)'                               + CHAR(10) + 
							')'                                                                                                                      + CHAR(10) + 
							

                       ',CTE_DEV as ('                                                                                                               + CHAR(10) + 
		                   ('     SELECT ' + @COLUMNListDAL)                                                                                         + CHAR(10) + 
		                    '           ,HASHBYTES(' + '''SHA1'''       + ','      + 'CONCAT(' + @COLUMNS + ')' + ')' + 'as DAL_HashBytes'           + CHAR(10) + 
							'       FROM ' + @DAL + '.' + @DALSNAME        + '.'      + @DALTNAME    +  ' with (NOLOCK)'                             + CHAR(10) + 
							'      WHERE Date_Of_Load  =  ' + '''' + @MaxDALDate  + ''''                                                           + CHAR(10) + 
							'        AND Reporting_Flag = 'RITC Legatum'                                                                              + CHAR(10) + 

							')'                                                                                                                      + CHAR(10) + 
							

        --Building Comparison Query between Prod & Dev
		                    '     SELECT * INTO QA.TR_' + @TNAME                                                                                     + CHAR(10) +
							'  FROM ('                                                                                                               + CHAR(10) +
					        '     SELECT ' + '''' + @TNAME + '''' + ' as EntityName'                                                                 + CHAR(10) +
							'           ,P.MYMISTG_HashBytes as MYMIHashBytesSTG, D.DAL_HashBytes as DALHashBytes'                                      + CHAR(10) +
                            '           ,Case WHEN P.MYMISTG_HashBytes = D.DAL_HashBytes '                                                           + CHAR(10) +
	                        '                 THEN ' + '''Passed'''                                                                                  + CHAR(10) + 
			                '                 ELSE ' + '''Failed'''                                                                                  + CHAR(10) +
		                    '             End as TestResult'                                                                                         + CHAR(10) + 
							'           ,GetDate() ' + 'as TestedOn '                                                                                + CHAR(10) +
							'           ,P.*,D.*   '                                                                                                 + CHAR(10) +
                            '       FROM CTE_PRD P '                                                                                                 + CHAR(10) + 
                            '  FULL Join CTE_DEV D '                                                                                                 + CHAR(10) + 
--							'        on ' + @SKDAL + ' = ' + @SKMYMI                                                                                 + CHAR(10) +
							'        on MYMISTG_Hashbytes = DAL_HashBytes '                                                                             + CHAR(10) +
--							'       and  P.REPORTING_FLAGMYMI =  D.REPORTING_FLAGDAL '                                                               + CHAR(10) +
							')TMP'




print @QRY

--EXECUTE sp_executesql @QRY

--SELECT * FROM QA.TR_TMP_FACT_INW_OSClaim;
--SELECT TestResult, COUNT(*) as TotalRecords FROM QA.TR_TMP_FACT_INW_OSClaim GROUP By TestResult;