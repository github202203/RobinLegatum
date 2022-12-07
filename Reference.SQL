use MYMI_Datawarehouse
SELECT *  FROM DWH.FACTOriTransactionDataHistory where DimDataHistoryid = 3228
SELECT * FROM [MYMI-PRD].[MyMI_DataWareHouse].[DWH].[FACTOriTransactionDataHistory]  where DimDataHistoryId = 3225
SELECT * FROM DWH.DimDataHistory where CalendarAsAtDate in ('2022-03-27','2022-03-28')
SELECT * FROM DWH.DimDataHistory where DimDataHistoryId in (3219, 3229,3254)

SELECT DimDataHistoryId, COUNT(*) as Total from DWH.FACTOriTransactionDataHistory group by DimDataHistoryId order by DimDataHistoryId DESC

SELECT ValidFromWarehouseLoadId, ProcessPeriod, Count(*) as Total from dwh.DimOriTransaction group by ValidFromWarehouseLoadId, ProcessPeriod ORDER BY ValidFromWarehouseLoadId DESC

SELECT * FROM DWH.DimORITransaction WHERE ProcessPeriod = 202203 and ValidFromWarehouseLoadId = 2022032101

SELECT * FROM DWH.DimDataHistoryStatus where IsMonthEnd = 1 and SchemaName = 'DWH' ORDER BY DimDataHistoryId DESC

SELECT ValidFromWarehouseLoadId,  Count(*) FROM DWH.DimORICession group by ValidFromWarehouseLoadId Order by ValidFromWarehouseLoadId DESC

SELECT * FROM DWH.DimORICession Order by ValidFromWarehouseLoadId DESC

SELECT COUNT(*) FROM DWH.DimORITransaction Order by ValidFromWarehouseLoadId DESC --26849362

SELECT DISTINCT InsertDateTime FROM DWH.DimORITransaction

SELECT VALIDFROMWAREHOUSELOADID, COUNT(*) as total from dwh.dimbroker group by validfromwarehouseloadid order by validfromwarehouseloadid desc

select cast(insertdatetime as Date) as InsertDate, count(*) as Total from dwh.DimBroker group by cast(insertdatetime as Date) order by cast(insertdatetime as Date) desc


SELECT * FROM DWH.DimBroker where DimSourceSystemID = 14 and ValidToWarehouseLoadID = 2123456789 --6552


 WHERE ValidFromWarehouseLoadid = 2022050201
SELECT * FROM Dwh.DimDataHistory where warehouseloadid = 2022050201


SELECT FACT_DimDataHistoryId,D.DimDataHistoryId,D.DataHistoryCode,D.DataHistoryName,D.WarehouseLoadId,D.DimFinancialPeriodId, D.CalendarAsAtDate
  FROM (
        SELECT DISTINCT DimDataHistoryId as FACT_DimDataHistoryId 
          FROM [MYMI-PRD].[MYMI_Datawarehouse].DWH.FACTOriTransactionDataHistory
		  ) F
  Join [MYMI-PRD].[MYMI_Datawarehouse].Dwh.DimDataHistory D
   On F.FACT_DimDataHistoryId = D.DimDataHistoryId
  ORDER By CalendarAsAtDate DESC


