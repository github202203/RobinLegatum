DECLARE	@SName      VARCHAR(20),
	    @TName      VARCHAR(100),
	    @COLUMNS    VARCHAR(MAX) = '', 
		@COLUMNList VARCHAR(MAX) = '', 
	    @QRY        NVARCHAR(4000),
	    @SRCTBLname VARCHAR(100),
	    @TGTTBLname VARCHAR(100),
	    @returnVal  INT;

	SET @SNAME = 'DWH';
	SET @TNAME = 'DimORITransaction';

SELECT @COLUMNS    = @COLUMNS    + '[' + ColumnName + ']' + ',' + '''%''' +','
      ,@COLUMNList = @COLUMNList + '[' + ColumnName + ']' + ','
  FROM (

	    SELECT S.schema_id
		      ,S.Name             as SchemName 
	          ,T.Name             as TableName
	          ,C.Column_id,C.Name as ColumnName
	      FROM sys.schemas S
	      join sys.tables  T
	        on S.Schema_Id = T.Schema_Id
	
	      join sys.Columns C
	        on T.object_id = C.Object_Id 
	          
	     WHERE S.name = @SNAME --'DWH'
	       AND T.Name = @TNAME --'DimORITransaction'
		   ) T
	    
		SELECT @COLUMNS    = SUBSTRING (@COLUMNS   ,1 ,LEN(@COLUMNS)-5)
		SELECT @COLUMNList = SUBSTRING (@COLUMNList,1 ,LEN(@COLUMNList)-1)
		--print @COLUMNS

		--print('SELECT ' + @COLUMNList) 
		--print ',HASHBYTES(' + '''SHA1''' + ',' + 'CONCAT(' + @COLUMNS + ')' + ')' + 'as Dev_HashBytes' 

		SELECT @QRY = 'With CTE_DEV as ('                 + CHAR(10) + 
		                   ('     SELECT ' + @COLUMNList) + CHAR(10) + 
		                    '           ,HASHBYTES(' + '''SHA1''' + ',' + 'CONCAT(' + @COLUMNS + ')' + ')' + 'as Dev_HashBytes' + CHAR(10) + 
							' FROM ' + @SNAME        +'.' + @TNAME + CHAR(10) + ')' + CHAR(10) + 
					   'SELECT * FROM CTE_DEV'

		print(@QRY)