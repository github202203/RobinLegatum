DECLARE	@SName      VARCHAR(20),
	    @TName      VARCHAR(100),
	    @COLUMNS    VARCHAR(MAX) = '', 
		@COLUMNList VARCHAR(MAX) = '', 
	    @QRY        NVARCHAR(4000),
	    @SRCTBLname VARCHAR(100),
	    @TGTTBLname VARCHAR(100),
	    @returnVal  INT;

SELECT @COLUMNS = @COLUMNS + '[' + ColumnName + ']' + ',' + '''%''' +','
      ,@COLUMNList = @COLUMNList + '[' + ColumnName + ']' + ','
  FROM (

	    SELECT S.schema_id
		      ,S.Name             as SchemName 
	          ,T.Name             as TableName
	          ,C.Column_id,C.Name as ColumnName
	      FROM sys.schemas S
	      JOIN sys.tables  T
	        on S.Schema_Id = T.Schema_Id
	
	      JOIN sys.Columns C
	        on T.object_id = C.Object_Id 
	          
	     WHERE S.name = 'DWH'
	       AND T.Name = 'DimORITransaction'
		   ) T
	    --SELECT @COLUMNS = SUBSTRING (@COLUMNS,1 ,LEN(@COLUMNS)-1)
		SELECT @COLUMNS    = SUBSTRING (@COLUMNS,1 ,LEN(@COLUMNS)-5)
		SELECT @COLUMNList = SUBSTRING (@COLUMNList,1 ,LEN(@COLUMNS)-5)
		--print @COLUMNS

		print('SELECT ' + @COLUMNList) -- Print the list of Columns
		print 'HASHBYTES(' + '''SHA1''' + ',' + 'CONCAT(' + @COLUMNS + ')' + ')' + 'as Dev_HashBytes' --Print the Hash with the list of columns