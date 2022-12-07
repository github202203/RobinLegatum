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
	           and T.Name = 'EVENT_IMP'
			   ) T
	        --SELECT @COLUMNS = SUBSTRING (@COLUMNS,1 ,LEN(@COLUMNS)-1)
			SELECT @COLUMNS = SUBSTRING (@COLUMNS,1 ,LEN(@COLUMNS)-5)

			print @COLUMNS

--[XLPRO_TEST_210].[dbo].[POLICY_IMP]


--select * from information_schema.tables
--select * from information_schema.columns


--Other queries 

use XLPRO_TEST_210

select S.schema_id,S.Name as SchemaName 
	              ,T.Name as TableName
	                 ,C.Column_id,C.Name as ColumnName
	          from sys.schemas S
	          join sys.tables  T
	            on S.Schema_Id = T.Schema_Id
	
	          join sys.Columns C
	            on T.object_id = C.Object_Id 
	              
	         where S.name = 'dbo'
	           and T.Name = 'POLICY'

ORDER BY SchemaName, TableName, column_id

select * from information_schema.columns
select TABLE_CATALOG, TABLE_SCHEMA, Table_Name from information_schema.tables

select TABLE_CATALOG, TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME
  from information_schema.columns
 where TABLE_CATALOG = 'XLPRO_TEST_210'
   and TABLE_NAME = 'POLICY_IMP'
   and TABLE_SCHEMA = 'dbo'
  order by ORDINAL_POSITION

use XLPRO_PROD
  select TABLE_CATALOG, TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME
  from information_schema.columns
 where TABLE_CATALOG = 'XLPRO_PROD'
   and TABLE_NAME = 'POLICY_IMP'
   and TABLE_SCHEMA = 'dbo'
  order by ORDINAL_POSITION

  SELECT * FROM XLPRO_PROD.dbo.POLICY_IMP

  SELECT * FROM XLPRO_TEST_210.dbo.POLICY_IMP

  select * from sys.all_columns

  select * from sys.all_objects where name like '%POLICY%'
  
  select TABLE_CATALOG, TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME
  from information_schema.columns
 where TABLE_CATALOG = 'XLPRO_TEST_210'
   and TABLE_NAME = 'POLICY_IMP'
   and TABLE_SCHEMA = 'dbo'
  order by ORDINAL_POSITION
  
  select TABLE_CATALOG, TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME
  from information_schema.columns
 where TABLE_CATALOG = 'XLPRO_TEST_210'
   and TABLE_NAME = 'POLICY_IMP'
   and TABLE_SCHEMA = 'dbo'
  order by ORDINAL_POSITION

  SELECT COUNT(*) FROM XLPRO_PROD.dbo.POLICY_IMP --792389
  SELECT COUNT(*) FROM XLPRO_PROD_2.dbo.POLICY_IMP --I have no select privilege 
  SELECT COUNT(*) FROM XLPRO_PROD_IMP.dbo.POLICY_IMP --I have no select privilege 
  SELECT COUNT(*) FROM XLPRO_TEST_210.dbo.POLICY_IMP --785426