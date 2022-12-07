select 'Req5.6 Distinguish between Robin and Legatum transaction in feed' as ReqId,*, GetDate() as TestedOn 
  from [DATALIBLEG-SQLDB-01-UKS-TEST].[datalibleg-sqldb-01-uks-test].information_schema.view_column_usage
 where view_schema = 'RS'
   and column_name in ('REPORTING_FLAG')
 order by view_name, table_schema