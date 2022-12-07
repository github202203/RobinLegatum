select T.* 
  from (
        select T.table_catalog, T.table_schema, T.table_name, T.view_schema,T.view_name,C.column_name
          from [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.view_table_usage  T
          join [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.view_column_usage C
            on T.table_schema = C.table_schema 
           and T.table_name = C.table_name 
           and T.view_schema = C.view_schema
           and T.view_name = C.view_name
		)T
  where view_schema = 'RS'
    and table_name in (
--List of tables in scope for Robin project 	
 'INW_GroupClass'
,'INW_Loss'
,'INW_LossEvent'
,'INW_RISK'
,'INW_OSClaim'
,'INW_PaidClaim'
,'INW_Premium'
,'INW_WrittenPremium'
,'INW_OSClaim'
,'INW_PaidClaim'
,'INW_Premium'
,'INW_WrittenPremium'
,'OUTW_GroupClass'
,'OUTW_LossEvent'
,'OUTW_RIContract'
,'OUTW_RIContractAcc'
,'OUTW_RIContractCcyLimit'
,'OUTW_RIContractIns'
,'OUTW_Risk'
,'OUTW_OSClaim'
,'OUTW_OSPremium'
,'OUTW_PaidClaim'
,'OUTW_PaidPremium'
,'OUTW_OSClaim'
,'OUTW_PaidClaim'
,'OUTW_OSPremium'
,'OUTW_PaidPremium'
)
