---------------------------------------------------------------------------------------------------------------------------

-- ************************** View mapping test for INWard/OUTWard Control, DIM & Fact Tables ************************** 

---------------------------------------------------------------------------------------------------------------------------
select --InOutward .* 
       Table_Catalog
	  ,TableTable_schema as TableSchema
	  ,ViewTable_Schema  as "TableSchema (View Definition )"
	  ,TableTable_Name   as TableName
	  ,ViewTable_Name    as "TableName (View Definition )"
	  ,view_name         as ViewName
	  ,ViewView_Schema   as ViewSchema
	  ,TableColumn_Name  as "ColumnName (Table Defenition)"
	  ,Viewcolumn_name  as "ColumnName (View Defenition)"
      ,Case when TableColumn_Name = ViewColumn_Name then 'Passed' else 'Failed' End as TestResult
  from (

-- ************************* Inward Control tables *************************

--Control.INW_OSClaim
 select Table_Catalog,TableTable_Schema, ViewTable_Schema, TableTable_Name, ViewTable_Name
       ,view_name,ViewView_Schema  ,TableColumn_name, Viewcolumn_name 
  from (
        select t.table_catalog as Table_Catalog
		      ,t.table_schema  as TableTable_schema,t.table_name as TableTable_Name, t.column_name  as TableColumn_name 
              ,v.table_schema  as ViewTable_Schema ,v.table_name as ViewTable_Name,  v.view_schema  as ViewView_Schema
	 		  ,v.view_name, v.column_name as Viewcolumn_name 
          from [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.columns t
     full join [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.view_column_usage v
            on t.table_name = v.table_name
           and t.table_schema = v.table_schema
           and t.column_name = v.column_name
        ) T 
  where Tabletable_schema = 'Control' and TableTable_Name = 'INW_OSClaim'

UNION ALL 

--Control.INW_PaidClaim
 select Table_Catalog,TableTable_Schema, ViewTable_Schema, TableTable_Name, ViewTable_Name
       ,view_name,ViewView_Schema  ,TableColumn_name, Viewcolumn_name 
  from (
        select t.table_catalog as Table_Catalog
		      ,t.table_schema  as TableTable_schema,t.table_name as TableTable_Name, t.column_name  as TableColumn_name 
              ,v.table_schema  as ViewTable_Schema ,v.table_name as ViewTable_Name,  v.view_schema  as ViewView_Schema
	 		  ,v.view_name, v.column_name as Viewcolumn_name 
          from [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.columns t
     full join [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.view_column_usage v
            on t.table_name = v.table_name
           and t.table_schema = v.table_schema
           and t.column_name = v.column_name
        ) T 
  where Tabletable_schema = 'Control' and TableTable_Name = 'INW_PaidClaim'

UNION ALL 

--Control.INW_Premium
 select Table_Catalog,TableTable_Schema, ViewTable_Schema, TableTable_Name, ViewTable_Name
       ,view_name,ViewView_Schema  ,TableColumn_name, Viewcolumn_name 
  from (
        select t.table_catalog as Table_Catalog
		      ,t.table_schema  as TableTable_schema,t.table_name as TableTable_Name, t.column_name  as TableColumn_name 
              ,v.table_schema  as ViewTable_Schema ,v.table_name as ViewTable_Name,  v.view_schema  as ViewView_Schema
	 		  ,v.view_name, v.column_name as Viewcolumn_name 
          from [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.columns t
     full join [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.view_column_usage v
            on t.table_name = v.table_name
           and t.table_schema = v.table_schema
           and t.column_name = v.column_name
        ) T 
  where Tabletable_schema = 'Control' and TableTable_Name = 'INW_Premium'

  UNION ALL 

--Control.INW_WrittenPremium
 select Table_Catalog,TableTable_Schema, ViewTable_Schema, TableTable_Name, ViewTable_Name
       ,view_name,ViewView_Schema  ,TableColumn_name, Viewcolumn_name 
  from (
        select t.table_catalog as Table_Catalog
		      ,t.table_schema  as TableTable_schema,t.table_name as TableTable_Name, t.column_name  as TableColumn_name 
              ,v.table_schema  as ViewTable_Schema ,v.table_name as ViewTable_Name,  v.view_schema  as ViewView_Schema
	 		  ,v.view_name, v.column_name as Viewcolumn_name 
          from [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.columns t
     full join [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.view_column_usage v
            on t.table_name = v.table_name
           and t.table_schema = v.table_schema
           and t.column_name = v.column_name
        ) T 
  where Tabletable_schema = 'Control' and TableTable_Name = 'INW_WrittenPremium'

UNION ALL

--  ************************* Inward Dim tables  *************************

--Dim.INW_LossEvent
 select Table_Catalog,TableTable_Schema, ViewTable_Schema, TableTable_Name, ViewTable_Name
       ,view_name,ViewView_Schema  ,TableColumn_name, Viewcolumn_name 
  from (
        select t.table_catalog as Table_Catalog
		      ,t.table_schema  as TableTable_schema,t.table_name as TableTable_Name, t.column_name  as TableColumn_name 
              ,v.table_schema  as ViewTable_Schema ,v.table_name as ViewTable_Name,  v.view_schema  as ViewView_Schema
	 		  ,v.view_name, v.column_name as Viewcolumn_name 
          from [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.columns t
     full join [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.view_column_usage v
            on t.table_name = v.table_name
           and t.table_schema = v.table_schema
           and t.column_name = v.column_name
        ) T 
  where Tabletable_schema = 'Dim' and TableTable_Name = 'INW_LossEvent'

UNION ALL

--DIM.INW_GroupClass
 select Table_Catalog,TableTable_Schema, ViewTable_Schema, TableTable_Name, ViewTable_Name
       ,view_name,ViewView_Schema  ,TableColumn_name, Viewcolumn_name 
  from (
        select t.table_catalog as Table_Catalog
		      ,t.table_schema  as TableTable_schema,t.table_name as TableTable_Name, t.column_name  as TableColumn_name 
              ,v.table_schema  as ViewTable_Schema ,v.table_name as ViewTable_Name,  v.view_schema  as ViewView_Schema
	 		  ,v.view_name, v.column_name as Viewcolumn_name 
          from [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.columns t
     full join [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.view_column_usage v
            on t.table_name = v.table_name
           and t.table_schema = v.table_schema
           and t.column_name = v.column_name
        ) T 
  where Tabletable_schema = 'Dim' and TableTable_Name = 'INW_GroupClass'

UNION ALL

--DIM.INW_Loss
 select Table_Catalog,TableTable_Schema, ViewTable_Schema, TableTable_Name, ViewTable_Name
       ,view_name,ViewView_Schema  ,TableColumn_name, Viewcolumn_name 
  from (
        select t.table_catalog as Table_Catalog
		      ,t.table_schema  as TableTable_schema,t.table_name as TableTable_Name, t.column_name  as TableColumn_name 
              ,v.table_schema  as ViewTable_Schema ,v.table_name as ViewTable_Name,  v.view_schema  as ViewView_Schema
	 		  ,v.view_name, v.column_name as Viewcolumn_name 
          from [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.columns t
     full join [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.view_column_usage v
            on t.table_name = v.table_name
           and t.table_schema = v.table_schema
           and t.column_name = v.column_name
        ) T 
  where Tabletable_schema = 'Dim' and TableTable_Name = 'INW_Loss'

UNION ALL

--DIM.INW_RISK
 select Table_Catalog,TableTable_Schema, ViewTable_Schema, TableTable_Name, ViewTable_Name
       ,view_name,ViewView_Schema  ,TableColumn_name, Viewcolumn_name 
  from (
        select t.table_catalog as Table_Catalog
		      ,t.table_schema  as TableTable_schema,t.table_name as TableTable_Name, t.column_name  as TableColumn_name 
              ,v.table_schema  as ViewTable_Schema ,v.table_name as ViewTable_Name,  v.view_schema  as ViewView_Schema
	 		  ,v.view_name, v.column_name as Viewcolumn_name 
          from [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.columns t
     full join [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.view_column_usage v
            on t.table_name = v.table_name
           and t.table_schema = v.table_schema
           and t.column_name = v.column_name
        ) T 
  where Tabletable_schema = 'Dim' and TableTable_Name = 'INW_RISK'
  
UNION ALL

--  ************************* Inward Fact tables  *************************

--FACT.INW_OSClaim
 select Table_Catalog,TableTable_Schema, ViewTable_Schema, TableTable_Name, ViewTable_Name
       ,view_name,ViewView_Schema  ,TableColumn_name, Viewcolumn_name 
  from (
        select t.table_catalog as Table_Catalog
		      ,t.table_schema  as TableTable_schema,t.table_name as TableTable_Name, t.column_name  as TableColumn_name 
              ,v.table_schema  as ViewTable_Schema ,v.table_name as ViewTable_Name,  v.view_schema  as ViewView_Schema
	 		  ,v.view_name, v.column_name as Viewcolumn_name 
          from [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.columns t
     full join [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.view_column_usage v
            on t.table_name = v.table_name
           and t.table_schema = v.table_schema
           and t.column_name = v.column_name
        ) T 
  where Tabletable_schema = 'Fact' and TableTable_Name = 'INW_OSClaim'

UNION ALL

--FACT.INW_PaidClaim
 select Table_Catalog,TableTable_Schema, ViewTable_Schema, TableTable_Name, ViewTable_Name
       ,view_name,ViewView_Schema  ,TableColumn_name, Viewcolumn_name 
  from (
        select t.table_catalog as Table_Catalog
		      ,t.table_schema  as TableTable_schema,t.table_name as TableTable_Name, t.column_name  as TableColumn_name 
              ,v.table_schema  as ViewTable_Schema ,v.table_name as ViewTable_Name,  v.view_schema  as ViewView_Schema
	 		  ,v.view_name, v.column_name as Viewcolumn_name 
          from [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.columns t
     full join [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.view_column_usage v
            on t.table_name = v.table_name
           and t.table_schema = v.table_schema
           and t.column_name = v.column_name
        ) T 
  where Tabletable_schema = 'Fact' and TableTable_Name = 'INW_PaidClaim'

UNION ALL

--FACT.INW_Premium
 select Table_Catalog,TableTable_Schema, ViewTable_Schema, TableTable_Name, ViewTable_Name
       ,view_name,ViewView_Schema  ,TableColumn_name, Viewcolumn_name 
  from (
        select t.table_catalog as Table_Catalog
		      ,t.table_schema  as TableTable_schema,t.table_name as TableTable_Name, t.column_name  as TableColumn_name 
              ,v.table_schema  as ViewTable_Schema ,v.table_name as ViewTable_Name,  v.view_schema  as ViewView_Schema
	 		  ,v.view_name, v.column_name as Viewcolumn_name 
          from [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.columns t
     full join [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.view_column_usage v
            on t.table_name = v.table_name
           and t.table_schema = v.table_schema
           and t.column_name = v.column_name
        ) T 
  where Tabletable_schema = 'Fact' and TableTable_Name = 'INW_Premium'

UNION ALL

--FACT.INW_WrittenPremium
 select Table_Catalog,TableTable_Schema, ViewTable_Schema, TableTable_Name, ViewTable_Name
       ,view_name,ViewView_Schema  ,TableColumn_name, Viewcolumn_name 
  from (
        select t.table_catalog as Table_Catalog
		      ,t.table_schema  as TableTable_schema,t.table_name as TableTable_Name, t.column_name  as TableColumn_name 
              ,v.table_schema  as ViewTable_Schema ,v.table_name as ViewTable_Name,  v.view_schema  as ViewView_Schema
	 		  ,v.view_name, v.column_name as Viewcolumn_name 
          from [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.columns t
     full join [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.view_column_usage v
            on t.table_name = v.table_name
           and t.table_schema = v.table_schema
           and t.column_name = v.column_name
        ) T 
  where Tabletable_schema = 'Fact' and TableTable_Name = 'INW_WrittenPremium'  
  
UNION ALL  

-- **************************************************************************
------------------------------ Outward Table --------------------------------
-- **************************************************************************

-- ************************* Outward Control tables *************************

--Control.OUTW_OSClaim
 select Table_Catalog,TableTable_Schema, ViewTable_Schema, TableTable_Name, ViewTable_Name
       ,view_name,ViewView_Schema  ,TableColumn_name, Viewcolumn_name 
  from (
        select t.table_catalog as Table_Catalog
		      ,t.table_schema  as TableTable_schema,t.table_name as TableTable_Name, t.column_name  as TableColumn_name 
              ,v.table_schema  as ViewTable_Schema ,v.table_name as ViewTable_Name,  v.view_schema  as ViewView_Schema
	 		  ,v.view_name, v.column_name as Viewcolumn_name 
          from [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.columns t
     full join [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.view_column_usage v
            on t.table_name = v.table_name
           and t.table_schema = v.table_schema
           and t.column_name = v.column_name
        ) T 
  where Tabletable_schema = 'Control' and TableTable_Name = 'OUTW_OSClaim'

UNION ALL 

--Control.OUTW_PaidClaim
 select Table_Catalog,TableTable_Schema, ViewTable_Schema, TableTable_Name, ViewTable_Name
       ,view_name,ViewView_Schema  ,TableColumn_name, Viewcolumn_name 
  from (
        select t.table_catalog as Table_Catalog
		      ,t.table_schema  as TableTable_schema,t.table_name as TableTable_Name, t.column_name  as TableColumn_name 
              ,v.table_schema  as ViewTable_Schema ,v.table_name as ViewTable_Name,  v.view_schema  as ViewView_Schema
	 		  ,v.view_name, v.column_name as Viewcolumn_name 
          from [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.columns t
     full join [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.view_column_usage v
            on t.table_name = v.table_name
           and t.table_schema = v.table_schema
           and t.column_name = v.column_name
        ) T 
  where Tabletable_schema = 'Control' and TableTable_Name = 'OUTW_PaidClaim'

UNION ALL 

--Control.OUTW_OSPremium
 select Table_Catalog,TableTable_Schema, ViewTable_Schema, TableTable_Name, ViewTable_Name
       ,view_name,ViewView_Schema  ,TableColumn_name, Viewcolumn_name 
  from (
        select t.table_catalog as Table_Catalog
		      ,t.table_schema  as TableTable_schema,t.table_name as TableTable_Name, t.column_name  as TableColumn_name 
              ,v.table_schema  as ViewTable_Schema ,v.table_name as ViewTable_Name,  v.view_schema  as ViewView_Schema
	 		  ,v.view_name, v.column_name as Viewcolumn_name 
          from [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.columns t
     full join [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.view_column_usage v
            on t.table_name = v.table_name
           and t.table_schema = v.table_schema
           and t.column_name = v.column_name
        ) T 
  where Tabletable_schema = 'Control' and TableTable_Name = 'OUTW_OSPremium'

  UNION ALL 

--Control.OUTW_PaidPremium
 select Table_Catalog,TableTable_Schema, ViewTable_Schema, TableTable_Name, ViewTable_Name
       ,view_name,ViewView_Schema  ,TableColumn_name, Viewcolumn_name 
  from (
        select t.table_catalog as Table_Catalog
		      ,t.table_schema  as TableTable_schema,t.table_name as TableTable_Name, t.column_name  as TableColumn_name 
              ,v.table_schema  as ViewTable_Schema ,v.table_name as ViewTable_Name,  v.view_schema  as ViewView_Schema
	 		  ,v.view_name, v.column_name as Viewcolumn_name 
          from [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.columns t
     full join [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.view_column_usage v
            on t.table_name = v.table_name
           and t.table_schema = v.table_schema
           and t.column_name = v.column_name
        ) T 
  where Tabletable_schema = 'Control' and TableTable_Name = 'OUTW_PaidPremium'

UNION ALL 

-- ************************* Outward Dim tables *************************

--Dim.OUTW_GroupClass
 select Table_Catalog,TableTable_Schema, ViewTable_Schema, TableTable_Name, ViewTable_Name
       ,view_name,ViewView_Schema  ,TableColumn_name, Viewcolumn_name 
  from (
        select t.table_catalog as Table_Catalog
		      ,t.table_schema  as TableTable_schema,t.table_name as TableTable_Name, t.column_name  as TableColumn_name 
              ,v.table_schema  as ViewTable_Schema ,v.table_name as ViewTable_Name,  v.view_schema  as ViewView_Schema
	 		  ,v.view_name, v.column_name as Viewcolumn_name 
          from [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.columns t
     full join [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.view_column_usage v
            on t.table_name = v.table_name
           and t.table_schema = v.table_schema
           and t.column_name = v.column_name
        ) T 
  where Tabletable_schema = 'Dim' and TableTable_Name = 'OUTW_GroupClass'
  
UNION ALL 

--Dim.OUTW_LossEvent
 select Table_Catalog,TableTable_Schema, ViewTable_Schema, TableTable_Name, ViewTable_Name
       ,view_name,ViewView_Schema  ,TableColumn_name, Viewcolumn_name 
  from (
        select t.table_catalog as Table_Catalog
		      ,t.table_schema  as TableTable_schema,t.table_name as TableTable_Name, t.column_name  as TableColumn_name 
              ,v.table_schema  as ViewTable_Schema ,v.table_name as ViewTable_Name,  v.view_schema  as ViewView_Schema
	 		  ,v.view_name, v.column_name as Viewcolumn_name 
          from [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.columns t
     full join [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.view_column_usage v
            on t.table_name = v.table_name
           and t.table_schema = v.table_schema
           and t.column_name = v.column_name
        ) T 
  where Tabletable_schema = 'Dim' and TableTable_Name = 'OUTW_LossEvent'  
  
  
UNION ALL 

--Dim.OUTW_RIContract
 select Table_Catalog,TableTable_Schema, ViewTable_Schema, TableTable_Name, ViewTable_Name
       ,view_name,ViewView_Schema  ,TableColumn_name, Viewcolumn_name 
  from (
        select t.table_catalog as Table_Catalog
		      ,t.table_schema  as TableTable_schema,t.table_name as TableTable_Name, t.column_name  as TableColumn_name 
              ,v.table_schema  as ViewTable_Schema ,v.table_name as ViewTable_Name,  v.view_schema  as ViewView_Schema
	 		  ,v.view_name, v.column_name as Viewcolumn_name 
          from [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.columns t
     full join [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.view_column_usage v
            on t.table_name = v.table_name
           and t.table_schema = v.table_schema
           and t.column_name = v.column_name
        ) T 
  where Tabletable_schema = 'Dim' and TableTable_Name = 'OUTW_RIContract'    
  
  
UNION ALL 

--Dim.OUTW_RIContractAcc
 select Table_Catalog,TableTable_Schema, ViewTable_Schema, TableTable_Name, ViewTable_Name
       ,view_name,ViewView_Schema  ,TableColumn_name, Viewcolumn_name 
  from (
        select t.table_catalog as Table_Catalog
		      ,t.table_schema  as TableTable_schema,t.table_name as TableTable_Name, t.column_name  as TableColumn_name 
              ,v.table_schema  as ViewTable_Schema ,v.table_name as ViewTable_Name,  v.view_schema  as ViewView_Schema
	 		  ,v.view_name, v.column_name as Viewcolumn_name 
          from [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.columns t
     full join [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.view_column_usage v
            on t.table_name = v.table_name
           and t.table_schema = v.table_schema
           and t.column_name = v.column_name
        ) T 
  where Tabletable_schema = 'Dim' and TableTable_Name = 'OUTW_RIContractAcc'    
  
 UNION ALL 

--Dim.OUTW_RIContractCcyLimit
 select Table_Catalog,TableTable_Schema, ViewTable_Schema, TableTable_Name, ViewTable_Name
       ,view_name,ViewView_Schema  ,TableColumn_name, Viewcolumn_name 
  from (
        select t.table_catalog as Table_Catalog
		      ,t.table_schema  as TableTable_schema,t.table_name as TableTable_Name, t.column_name  as TableColumn_name 
              ,v.table_schema  as ViewTable_Schema ,v.table_name as ViewTable_Name,  v.view_schema  as ViewView_Schema
	 		  ,v.view_name, v.column_name as Viewcolumn_name 
          from [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.columns t
     full join [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.view_column_usage v
            on t.table_name = v.table_name
           and t.table_schema = v.table_schema
           and t.column_name = v.column_name
        ) T 
  where Tabletable_schema = 'Dim' and TableTable_Name = 'OUTW_RIContractCcyLimit'    
    
 UNION ALL 

--Dim.OUTW_RIContractIns
 select Table_Catalog,TableTable_Schema, ViewTable_Schema, TableTable_Name, ViewTable_Name
       ,view_name,ViewView_Schema  ,TableColumn_name, Viewcolumn_name 
  from (
        select t.table_catalog as Table_Catalog
		      ,t.table_schema  as TableTable_schema,t.table_name as TableTable_Name, t.column_name  as TableColumn_name 
              ,v.table_schema  as ViewTable_Schema ,v.table_name as ViewTable_Name,  v.view_schema  as ViewView_Schema
	 		  ,v.view_name, v.column_name as Viewcolumn_name 
          from [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.columns t
     full join [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.view_column_usage v
            on t.table_name = v.table_name
           and t.table_schema = v.table_schema
           and t.column_name = v.column_name
        ) T 
  where Tabletable_schema = 'Dim' and TableTable_Name = 'OUTW_RIContractIns'    
  
  UNION ALL 

--Dim.OUTW_Risk
 select Table_Catalog,TableTable_Schema, ViewTable_Schema, TableTable_Name, ViewTable_Name
       ,view_name,ViewView_Schema  ,TableColumn_name, Viewcolumn_name 
  from (
        select t.table_catalog as Table_Catalog
		      ,t.table_schema  as TableTable_schema,t.table_name as TableTable_Name, t.column_name  as TableColumn_name 
              ,v.table_schema  as ViewTable_Schema ,v.table_name as ViewTable_Name,  v.view_schema  as ViewView_Schema
	 		  ,v.view_name, v.column_name as Viewcolumn_name 
          from [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.columns t
     full join [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.view_column_usage v
            on t.table_name = v.table_name
           and t.table_schema = v.table_schema
           and t.column_name = v.column_name
        ) T 
  where Tabletable_schema = 'Dim' and TableTable_Name = 'OUTW_Risk'    
  
  UNION ALL

--  ************************* Outward Fact tables  *************************

--FACT.OUTW_OSClaim
 select Table_Catalog,TableTable_Schema, ViewTable_Schema, TableTable_Name, ViewTable_Name
       ,view_name,ViewView_Schema  ,TableColumn_name, Viewcolumn_name 
  from (
        select t.table_catalog as Table_Catalog
		      ,t.table_schema  as TableTable_schema,t.table_name as TableTable_Name, t.column_name  as TableColumn_name 
              ,v.table_schema  as ViewTable_Schema ,v.table_name as ViewTable_Name,  v.view_schema  as ViewView_Schema
	 		  ,v.view_name, v.column_name as Viewcolumn_name 
          from [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.columns t
     full join [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.view_column_usage v
            on t.table_name = v.table_name
           and t.table_schema = v.table_schema
           and t.column_name = v.column_name
        ) T 
  where Tabletable_schema = 'Fact' and TableTable_Name = 'OUTW_OSClaim'

UNION ALL

--FACT.OUTW_OSPremium
 select Table_Catalog,TableTable_Schema, ViewTable_Schema, TableTable_Name, ViewTable_Name
       ,view_name,ViewView_Schema  ,TableColumn_name, Viewcolumn_name 
  from (
        select t.table_catalog as Table_Catalog
		      ,t.table_schema  as TableTable_schema,t.table_name as TableTable_Name, t.column_name  as TableColumn_name 
              ,v.table_schema  as ViewTable_Schema ,v.table_name as ViewTable_Name,  v.view_schema  as ViewView_Schema
	 		  ,v.view_name, v.column_name as Viewcolumn_name 
          from [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.columns t
     full join [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.view_column_usage v
            on t.table_name = v.table_name
           and t.table_schema = v.table_schema
           and t.column_name = v.column_name
        ) T 
  where Tabletable_schema = 'Fact' and TableTable_Name = 'OUTW_OSPremium'

UNION ALL

--FACT.OUTW_PaidClaim
 select Table_Catalog,TableTable_Schema, ViewTable_Schema, TableTable_Name, ViewTable_Name
       ,view_name,ViewView_Schema  ,TableColumn_name, Viewcolumn_name 
  from (
        select t.table_catalog as Table_Catalog
		      ,t.table_schema  as TableTable_schema,t.table_name as TableTable_Name, t.column_name  as TableColumn_name 
              ,v.table_schema  as ViewTable_Schema ,v.table_name as ViewTable_Name,  v.view_schema  as ViewView_Schema
	 		  ,v.view_name, v.column_name as Viewcolumn_name 
          from [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.columns t
     full join [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.view_column_usage v
            on t.table_name = v.table_name
           and t.table_schema = v.table_schema
           and t.column_name = v.column_name
        ) T 
  where Tabletable_schema = 'Fact' and TableTable_Name = 'OUTW_PaidClaim'

UNION ALL

--FACT.OUTW_PaidPremium
 select Table_Catalog,TableTable_Schema, ViewTable_Schema, TableTable_Name, ViewTable_Name
       ,view_name,ViewView_Schema  ,TableColumn_name, Viewcolumn_name 
  from (
        select t.table_catalog as Table_Catalog
		      ,t.table_schema  as TableTable_schema,t.table_name as TableTable_Name, t.column_name  as TableColumn_name 
              ,v.table_schema  as ViewTable_Schema ,v.table_name as ViewTable_Name,  v.view_schema  as ViewView_Schema
	 		  ,v.view_name, v.column_name as Viewcolumn_name 
          from [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.columns t
     full join [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.view_column_usage v
            on t.table_name = v.table_name
           and t.table_schema = v.table_schema
           and t.column_name = v.column_name
        ) T 
  where Tabletable_schema = 'Fact' and TableTable_Name = 'OUTW_PaidPremium'

)InOutward 
 where TableColumn_name <> 'ROW_ID'
  