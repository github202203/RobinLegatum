---------------------------------------------------------
----FactORIPlacementDataHistory CURRENT Partition
---------------------------------------------------------

USE MyMI_DataWareHouse;

DROP TABLE IF EXISTS QA.PRODTR_FactORIPlacementDataHistory;

With CTE_PRD as (
     SELECT [DimORIPlacementID] as [DimORIPlacementID25],[DimDataHistoryID] as [DimDataHistoryID25],[InsertWarehouseLoadID] as [InsertWarehouseLoadID25],[DimORIBrokerID] as [DimORIBrokerID25],[DimSourceSystemID] as [DimSourceSystemID25],[DimYOAID] as [DimYOAID25],[ContractCount] as [ContractCount25],[ContractCountByORIBrokerPct] as [ContractCountByORIBrokerPct25],[ContractCountByORIReinsurerPctOfOrder] as [ContractCountByORIReinsurerPctOfOrder25],[ContractCountByORIReinsurerPctOfWhole] as [ContractCountByORIReinsurerPctOfWhole25],[ORIBrokerPct] as [ORIBrokerPct25],[ORIReinsurerPctOfWhole] as [ORIReinsurerPctOfWhole25],[ORIReinsurerPctOfOrder] as [ORIReinsurerPctOfOrder25],[ORIReinsurerPctOfOrderByBrokerPct] as [ORIReinsurerPctOfOrderByBrokerPct25],[ORIReinsurerPctOfWholeByBrokerPct] as [ORIReinsurerPctOfWholeByBrokerPct25],[ContractCountByORIReinsurerPctOfOrderByBrokerPct] as [ContractCountByORIReinsurerPctOfOrderByBrokerPct25],[ContractCountByORIReinsurerPctOfWholeByBrokerPct] as [ContractCountByORIReinsurerPctOfWholeByBrokerPct25],[DimAdjustmentID] as [DimAdjustmentID25],[DimAdjustmentTransactionType] as [DimAdjustmentTransactionType25]
           --,HASHBYTES('SHA1',CONCAT([DimORIPlacementID],'%',[DimDataHistoryID],'%',[InsertWarehouseLoadID],'%',[DimORIBrokerID],'%',[DimSourceSystemID],'%',[DimYOAID],'%',[ContractCount],'%',[ContractCountByORIBrokerPct],'%',[ContractCountByORIReinsurerPctOfOrder],'%',[ContractCountByORIReinsurerPctOfWhole],'%',[ORIBrokerPct],'%',[ORIReinsurerPctOfWhole],'%',[ORIReinsurerPctOfOrder],'%',[ORIReinsurerPctOfOrderByBrokerPct],'%',[ORIReinsurerPctOfWholeByBrokerPct],'%',[ContractCountByORIReinsurerPctOfOrderByBrokerPct],'%',[ContractCountByORIReinsurerPctOfWholeByBrokerPct],'%',[DimAdjustmentID],'%',[DimAdjustmentTransactionType]))as PRD_HashBytes
		   --ContractCount column needs to be removed for Hash check
		   ,HASHBYTES('SHA1',CONCAT([DimORIPlacementID],'%',[InsertWarehouseLoadID],'%',[DimORIBrokerID],'%',[DimSourceSystemID],'%',[DimYOAID],'%',[ContractCountByORIBrokerPct],'%',[ContractCountByORIReinsurerPctOfOrder],'%',[ContractCountByORIReinsurerPctOfWhole],'%',[ORIBrokerPct],'%',[ORIReinsurerPctOfWhole],'%',[ORIReinsurerPctOfOrder],'%',[ORIReinsurerPctOfOrderByBrokerPct],'%',[ORIReinsurerPctOfWholeByBrokerPct],'%',[ContractCountByORIReinsurerPctOfOrderByBrokerPct],'%',[ContractCountByORIReinsurerPctOfWholeByBrokerPct],'%',[DimAdjustmentID],'%',[DimAdjustmentTransactionType]))as PRD_HashBytes
       --FROM [MYMI-TEST].[MyMI_DataWareHouse].DWH.FactORIPlacementDataHistory with (NOLOCK)
	   FROM [MYMI-PROD].[MyMI_DataWareHouse].DWH.FactORIPlacementDataHistory with (NOLOCK)
      WHERE DimDataHistoryId = 3324
        AND DimSourceSystemId  = 14
)

,CTE_TEST as (
     SELECT [DimORIPlacementID] as [DimORIPlacementID210],[DimDataHistoryID] as [DimDataHistoryID210],[InsertWarehouseLoadID] as [InsertWarehouseLoadID210],[DimORIBrokerID] as [DimORIBrokerID210],[DimSourceSystemID] as [DimSourceSystemID210],[DimYOAID] as [DimYOAID210],[ContractCount] as [ContractCount210],[ContractCountByORIBrokerPct] as [ContractCountByORIBrokerPct210],[ContractCountByORIReinsurerPctOfOrder] as [ContractCountByORIReinsurerPctOfOrder210],[ContractCountByORIReinsurerPctOfWhole] as [ContractCountByORIReinsurerPctOfWhole210],[ORIBrokerPct] as [ORIBrokerPct210],[ORIReinsurerPctOfWhole] as [ORIReinsurerPctOfWhole210],[ORIReinsurerPctOfOrder] as [ORIReinsurerPctOfOrder210],[ORIReinsurerPctOfOrderByBrokerPct] as [ORIReinsurerPctOfOrderByBrokerPct210],[ORIReinsurerPctOfWholeByBrokerPct] as [ORIReinsurerPctOfWholeByBrokerPct210],[ContractCountByORIReinsurerPctOfOrderByBrokerPct] as [ContractCountByORIReinsurerPctOfOrderByBrokerPct210],[ContractCountByORIReinsurerPctOfWholeByBrokerPct] as [ContractCountByORIReinsurerPctOfWholeByBrokerPct210],[DimAdjustmentID] as [DimAdjustmentID210],[DimAdjustmentTransactionType] as [DimAdjustmentTransactionType210]
           --,HASHBYTES('SHA1',CONCAT([DimORIPlacementID],'%',[DimDataHistoryID],'%',[InsertWarehouseLoadID],'%',[DimORIBrokerID],'%',[DimSourceSystemID],'%',[DimYOAID],'%',[ContractCount],'%',[ContractCountByORIBrokerPct],'%',[ContractCountByORIReinsurerPctOfOrder],'%',[ContractCountByORIReinsurerPctOfWhole],'%',[ORIBrokerPct],'%',[ORIReinsurerPctOfWhole],'%',[ORIReinsurerPctOfOrder],'%',[ORIReinsurerPctOfOrderByBrokerPct],'%',[ORIReinsurerPctOfWholeByBrokerPct],'%',[ContractCountByORIReinsurerPctOfOrderByBrokerPct],'%',[ContractCountByORIReinsurerPctOfWholeByBrokerPct],'%',[DimAdjustmentID],'%',[DimAdjustmentTransactionType]))as DEV_HashBytes
		   --ContractCount column needs to be removed for Hash check
           ,HASHBYTES('SHA1',CONCAT([DimORIPlacementID],'%',[InsertWarehouseLoadID],'%',[DimORIBrokerID],'%',[DimSourceSystemID],'%',[DimYOAID],'%',[ContractCountByORIBrokerPct],'%',[ContractCountByORIReinsurerPctOfOrder],'%',[ContractCountByORIReinsurerPctOfWhole],'%',[ORIBrokerPct],'%',[ORIReinsurerPctOfWhole],'%',[ORIReinsurerPctOfOrder],'%',[ORIReinsurerPctOfOrderByBrokerPct],'%',[ORIReinsurerPctOfWholeByBrokerPct],'%',[ContractCountByORIReinsurerPctOfOrderByBrokerPct],'%',[ContractCountByORIReinsurerPctOfWholeByBrokerPct],'%',[DimAdjustmentID],'%',[DimAdjustmentTransactionType]))as TEST_HashBytes
       FROM DWH.FactORIPlacementDataHistory with (NOLOCK)
      WHERE DimDataHistoryId = 3324
        AND DimSourceSystemId  = 14
)

SELECT * INTO QA.PRODTR_FactORIPlacementDataHistory
  FROM (
     SELECT 'FactORIPlacementDataHistory' as EntityName
           ,P.PRD_HashBytes as PRDHashBytes, D.DimDataHistoryId210 as TEST_DimDataHistory,D.TEST_HashBytes as TESTHashBytes
           ,Case WHEN P.PRD_HashBytes = D.TEST_HashBytes THEN 'Passed'
                 WHEN P.PRD_Hashbytes is NULL THEN 'Failed - Missing in 2.5'
                 WHEN D.TEST_HashBytes is NULL THEN 'Failed - Missing in 2.10'
                 ELSE 'Failed - MisMatch of Hash'
             End as TestResult
           ,GetDate() as TestedOn 
           ,P.*,D.*   
       FROM CTE_PRD P 
		FULL Join CTE_TEST D 
         on DimORIPlacementID210 = DimORIPlacementID25
)TMP

SELECT TestResult, COUNT(*) as Total FROM QA.PRODTR_FactORIPlacementDataHistory group by TestResult;
