USE XLPRO_TEST_210

DECLARE @SName      VARCHAR(20),
	              @TName      VARCHAR(100),
	              @COLUMNS    VARCHAR(MAX) = '', 
	              @QRY        NVARCHAR(4000),
	              @SRCTBLname VARCHAR(100),
	              @TGTTBLname VARCHAR(100),
	              @returnVal  INT;

SELECT @COLUMNS = @COLUMNS + '[' + ColumnName + ']' + ',' + '''%''' +','
  FROM (

	        select S.schema_id,S.Name as SchemName 
	              ,T.Name as TableName
	                 ,C.Column_id,C.Name as ColumnName
	          from sys.schemas S
	          join sys.tables  T
	            on S.Schema_Id = T.Schema_Id
	
	          join sys.Columns C
	            on T.object_id = C.Object_Id 
	              
	         where S.name = 'dbo'
	           and T.Name = 'CLM_OS_IMP'
			   ) T
	        --SELECT @COLUMNS = SUBSTRING (@COLUMNS,1 ,LEN(@COLUMNS)-1)
			SELECT @COLUMNS = SUBSTRING (@COLUMNS,1 ,LEN(@COLUMNS)-5)

			print @COLUMNS 



