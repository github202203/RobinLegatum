/*********************************************************************************************************

Purpose:- Script to compare the Count of Records 
Table  :- [DWH].[DimORITransaction]

******************************************************************************************************** */
WITH 
 CTE_PRD as (
 SELECT 'MyMI-Prod' as PRD_ServerName, ProcessPeriod as PRD_ProcessPeriod, COUNT(*) as PRD_TotalRecords
   FROM [MYMI-PRD].[MyMI_DataWareHouse].[DWH].[DimORITransaction] with (NOLOCK)
  GROUP By ProcessPeriod 
)

,CTE_DEV as (
 SELECT @@ServerName as DEV_ServerName, ProcessPeriod as DEV_ProcessPeriod, COUNT(*) as DEV_TotalRecords
   FROM DWH.DimORITransaction with (NOLOCK)
  GROUP By ProcessPeriod 
)

SELECT * FROM (
 SELECT PRD_ServerName, PRD_ProcessPeriod, PRD_TotalRecords
       ,DEV_ServerName, DEV_ProcessPeriod, DEV_TotalRecords
	   ,Case 
	        when PRD_ProcessPeriod = DEV_ProcessPeriod and PRD_TotalRecords = DEV_TotalRecords
			then 'Passed'
			else 'Failed'
	     End as TestResult
	   ,GetDate() as TestedOn
   FROM CTE_PRD P
   Left Join CTE_Dev D
     On P.PRD_ProcessPeriod = D.DEV_ProcessPeriod

 )T ORDER BY PRD_ProcessPeriod

 