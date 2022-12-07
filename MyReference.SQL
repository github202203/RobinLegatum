USE MyMI_DataWareHouse;
SELECT top 10 * FROM [DWH].[FactClaimTransactionDataHistory] WHERE DimProcessPeriodId = 999912

SELECT * FROM [DWH].[FactClaimTransactionDataHistory] WHERE DimClaimTransactionId = 1455239

SELECT DimClaimTransactionId FROM [DWH].[FactClaimTransactionDataHistory] WHERE CAST(InsertDateTime as Date) = '2022-04-19' --6475772
EXCEPT
SELECT DimClaimTransactionId FROM [DWH].[FactClaimTransactionDataHistory] WHERE CAST(InsertDateTime as Date) = '2022-04-18' --6475749

SELECT MAX(DIMPROCESSPERIODID) from [DWH].[FactClaimTransactionDataHistory]

SELECT MAX(InsertDateTime) from [DWH].[FactClaimTransactionDataHistory]

SELECT * FROM DWH.DimORIPlacement WHERE validfromwarehouseloadid <= 2022031802--this should be end as 02 always and ignore the one end 01

SELECT * FROM DWH.DImDataHistory order by DimDataHistoryId DESC

SELECT * FROM [DWH].[FactClaimTransactionDataHistory] WHERE DImDatahistoryid = 3219
SELECT * FROM [DWH].[FactClaimTransactionDataHistory] WHERE DImDatahistoryid = 3220

SELECT * FROM [DWH].[FactClaimTransactionDataHistory] WHERE DImDatahistoryid = 3218 and DimClaimId = 18617785 order by DimClaimTransactionId
SELECT * FROM [DWH].[FactClaimTransactionDataHistory] WHERE DImDatahistoryid = 3219 and DimClaimId = 18617785 order by DimClaimTransactionId



select * from DWH.DimORITransaction WHERe ValidFromWarehouseLoadId = 2022032401 AND IsDeleted = 1

select * from DWH.DimORITransaction WHERe ValidFromWarehouseLoadId = 2022032501  AND IsDeleted = 1


SELECT @@ServerName as Test, ProcessPeriod, COUNT(*) as Total from DWH.DimORITransaction GROUP By ProcessPeriod ORDER BY ProcessPeriod



SELECT DISTINCT DimDataHistoryId FROM DWH.FactORIPlacementDataHistory order by dimdatahistoryId



SELECT TOP 10 * FROM DWH.DimORITransaction



SELECT TOP 10 * FROM DWH.FactORITransactionDataHistory --DimProcessPeriodId is very important for FACT ( Accrual table in Source is the table t find the period is closed or not)


select MAX(ValidFromWarehouseLoadId) from DWH.DimORITransaction

SELECT * FROM DWH.DimORICession

SELECT F.DimDataHistoryId, D.DataHistoryCode, D.DataHistoryName, F.TotalRecords
  FROM (
SELECT DimDataHistoryId, COUNT(*) as TotalRecords 
  FROM DWH.FactRiskCountDataHistory 
 GROUP BY DimDataHistoryId 
 --ORDER BY DimDataHistoryId 
 )F

   JOIN DWH.DImDataHistory D
     On F.DimDataHistoryId = D.DimDataHistoryId
 ORDER BY 1



SELECT F.DimDataHistoryId, D.DataHistoryCode, D.DataHistoryName, F.TotalRecords
  FROM (
SELECT DimDataHistoryId, COUNT(*) as TotalRecords 
  FROM [MYMI-PRD].[MyMI_DataWareHouse].DWH.FactRiskCountDataHistory 
 GROUP BY DimDataHistoryId 
 --ORDER BY DimDataHistoryId 
 )F

   JOIN DWH.DImDataHistory D
     On F.DimDataHistoryId = D.DimDataHistoryId
 ORDER BY 1


SE MyMI_DataWareHouse;


SELECT TOP 2 * FROM DWH.DimCode
SELECT TOP 2 * FROM DWH.DimORITransaction
SELECT TOP 2 * FROM DWH.DimORITransaction
SELECT TOP 2 * FROM DWH.DimRiskCount
SELECT TOP 2 * FROM DWH.DimORICession
SELECT TOP 2 * FROM DWH.DimBroker
SELECT TOP 2 * FROM DWH.DimORIApplicablePremium
SELECT TOP 2 * FROM DWH.DimORIClaimSubEvent
SELECT TOP 2 * FROM DWH.DimORIContractType
SELECT TOP 2 * FROM DWH.DimORIDepartment
SELECT TOP 2 * FROM DWH.DimORIUSMTransaction
SELECT TOP 2 * FROM DWH.DimORIProgramme
SELECT TOP 2 * FROM DWH.DimORIReinsurer

https://britgroupservices-my.sharepoint.com/:v:/r/personal/shweta_rajani_britinsurance_com/Documents/Recordings/Cube%20testing%20for%20GXLPRO-20220412_111109-Meeting%20Recording.mp4?csf=1&web=1&e=LBbgzS
https://britgroupservices-my.sharepoint.com/:v:/r/personal/faraz_maqbool_britinsurance_com/Documents/Recordings/Cube%20testing%20for%20GXLPro-20220414_110701-Meeting%20Recording.mp4?csf=1&web=1&e=ZdbqNy

USE MyMI_DataWarehouse;

SELECT * FROM (
SELECT QUOTENAME(SCHEMA_NAME(sOBJ.schema_id)) as SchemaName
      ,QUOTENAME(SCHEMA_NAME(sOBJ.schema_id)) + '.' + QUOTENAME(sOBJ.name) AS [TableName]
      , SUM(sPTN.Rows) AS [RowCount]
FROM 
      sys.objects AS sOBJ
      INNER JOIN sys.partitions AS sPTN
            ON sOBJ.object_id = sPTN.object_id
WHERE
      sOBJ.type = 'U'
      AND sOBJ.is_ms_shipped = 0x0
      --AND index_id < 2 -- 0:Heap, 1:Clustered
	  AND index_id = 1 -- 0:Heap, 1:Clustered
GROUP BY 
      sOBJ.schema_id
      , sOBJ.name
)T WHERE SchemaName = '[DWH]'

We need to be clear to find out about the closing period/open period - Need to be clarfied Rishi
As this week is going to be month-end closure for April, will it impact in Dev as we have 28th March data in Dev?

Need to understand the location of Parquet file for the Calendar Partiion about the scenario's open/close period?
For Financial Partition, as the partitions are available in Prod, we need the partiions to be created in DEV 

USE MyMI_DataWarehouse
SELECT * FROM DWH.DimCode order by ValidFromWarehouseLoadId
SELECT * FROM [MYMI-PRD].[MyMI_DataWareHouse].DWH.DimCode order by ValidFromWarehouseLoadId

SELECT * FROM DWH.DimORIApplicablePremium  where DimORIApplicablePremiumId = 39460--48718
SELECT * FROM [MYMI-PRD].[MyMI_DataWareHouse].DWH.DimORIApplicablePremium   where DimORIApplicablePremiumId = 39460--49381

SELECT * FROM DWH.DimORIApplicablePremium  where validFromWarehouseLoadid = 2017030307
SELECT * FROM [MYMI-PRD].[MyMI_DataWareHouse].DWH.DimORIApplicablePremium   where validFromWarehouseLoadid = 2017030307


SELECT TOP 2 * FROM DWH.DimORIPlacement
SELECT TOP 2 * FROM DWH.DimCode
SELECT TOP 2 * FROM DWH.DimORITransaction
SELECT TOP 2 * FROM DWH.DimORITransaction
SELECT TOP 2 * FROM DWH.DimRiskCount
SELECT TOP 2 * FROM DWH.DimORICession
SELECT TOP 2 * FROM DWH.DimBroker
SELECT TOP 2 * FROM DWH.DimORIApplicablePremium
SELECT TOP 2 * FROM DWH.DimORIClaimSubEvent
SELECT TOP 2 * FROM DWH.DimORIContractType
SELECT TOP 2 * FROM DWH.DimORIDepartment
SELECT TOP 2 * FROM DWH.DimORIUSMTransaction
SELECT TOP 2 * FROM DWH.DimORIProgramme
SELECT TOP 2 * FROM DWH.DimORIReinsurer

SELECT * FROM DWH.DimDataHistory D

SELECT DISTINCT DimDataHistoryId,DataHistoryCode,DataHistoryName  FROM (
SELECT D.WarehouseLoadId, D.DataHistoryCode,D.DataHistoryName,F.* 
  FROM DWH.FactORIPlacementDataHistory F
  INNER Join DWH.DimDataHistory D
    on F.DimDataHistoryid = D.DimDataHistoryId
	) T 
ORDER BY DimDataHistoryId

SELECT DISTINCT DimDataHistoryId,DataHistoryCode,DataHistoryName  
  FROM (
        SELECT D.WarehouseLoadId, D.DataHistoryCode,D.DataHistoryName,F.* 
          FROM [MYMI-PRD].MyMI_DataWareHouse.DWH.FactORIPlacementDataHistory F
          INNER Join DWH.DimDataHistory D
            on F.DimDataHistoryid = D.DimDataHistoryId
        ) T 
ORDER BY DimDataHistoryId



SELECT DISTINCT P.DimDataHistoryId as PROD_DimDataHistoryId,P.DataHistoryCode as PROD_DataHistoryCode,P.DataHistoryName as PROD_DataHistoryName
               ,D.DimDataHistoryId as DEV_DimDataHistoryId,D.DataHistoryCode as DEV_DataHistoryCode,D.DataHistoryName as DEV_DataHistoryName
  FROM (
        SELECT D.WarehouseLoadId, D.DataHistoryCode,D.DataHistoryName,F.* 
          FROM [MYMI-PRD].[MyMI_DataWareHouse].[DWH].FactORITransactionDataHistory F
          Join [MYMI-PRD].[MyMI_DataWareHouse].[DWH].DimDataHistory D  
            on F.DimDataHistoryid = D.DimDataHistoryId 
		 WHERE D.DimDataHistoryId > 3197
        ) P 
		Left Join
		(
        SELECT D.WarehouseLoadId, D.DataHistoryCode,D.DataHistoryName,F.* 
          FROM MyMI_DataWareHouse.DWH.FactORITransactionDataHistory F
          Join DWH.DimDataHistory D  
            on F.DimDataHistoryid = D.DimDataHistoryId
			)D
        on P.DimDataHistoryId = D.DimDataHistoryId

SELECT D.WarehouseLoadId, D.DataHistoryCode,D.DataHistoryName,F.* 
          FROM MyMI_DataWareHouse.DWH.FactORITransactionDataHistory F
          Join DWH.DimDataHistory D  
            on F.DimDataHistoryid = D.DimDataHistoryId

SELECT *  FROM DWH.DimSourceSystem

SELECT * FROM DWH.DImDataHistory order by DimDataHistoryId DESC

--DWH.FactORIPlacementDataHistory
--DWH.FactORITransactionDataHistory
--DWH.FactRiskCountDataHistory
--DWH.FactORICessionDataHistory
--DWH.FactORIApplicablePremiumDataHistory


SELECT DISTINCT DimDataHistoryId FROM [MYMI-PRD].[MyMI_DataWareHouse].DWH.FactORIPlacementDataHistory F ORDER BY DimDataHistoryId DESC





%sql

DESCRIBE DETAIL MyMI_Snapshot_Group.DWH_FactSignedTransaction


