DROP Table IF EXISTS QA.TR_FactORIApplicablePremiumDataHistory;

With CTE_PRD as (
     SELECT [DimORIApplicablePremiumID] as [DimORIApplicablePremiumID25],[DimDataHistoryID] as [DimDataHistoryID25],[InsertWarehouseLoadID] as [InsertWarehouseLoadID25],[DimExternalSyndicateID] as [DimExternalSyndicateID25],[DimBrokerID] as [DimBrokerID25],[DimSettlementCurrencyID] as [DimSettlementCurrencyID25],[DimYOAID] as [DimYOAID25],[DimORIPlacementID] as [DimORIPlacementID25],[DimSourceSystemID] as [DimSourceSystemID25],[ORIDepositPremiumSettCcy] as [ORIDepositPremiumSettCcy25],[ORIEstimatedPremiumSettCcy] as [ORIEstimatedPremiumSettCcy25],[ORIAdjustmentPremiumSettCcy] as [ORIAdjustmentPremiumSettCcy25],[ORIExpectedNetPremiumOrder] as [ORIExpectedNetPremiumOrder25],[ORIMinimumPremiumSettCcy] as [ORIMinimumPremiumSettCcy25],[ORIReinsurerPremiumToEarnSettCcy] as [ORIReinsurerPremiumToEarnSettCcy25],[DimAdjustmentID] as [DimAdjustmentID25],[DimAdjustmentTransactionType] as [DimAdjustmentTransactionType25]
           --,HASHBYTES('SHA1',CONCAT([DimORIApplicablePremiumID],'%',[DimDataHistoryID],'%',[InsertWarehouseLoadID],'%',[DimExternalSyndicateID],'%',[DimBrokerID],'%',[DimSettlementCurrencyID],'%',[DimYOAID],'%',[DimORIPlacementID],'%',[DimSourceSystemID],'%',[ORIDepositPremiumSettCcy],'%',[ORIEstimatedPremiumSettCcy],'%',[ORIAdjustmentPremiumSettCcy],'%',[ORIExpectedNetPremiumOrder],'%',[ORIMinimumPremiumSettCcy],'%',[ORIReinsurerPremiumToEarnSettCcy],'%',[DimAdjustmentID],'%',[DimAdjustmentTransactionType]))as PRD_HashBytes
		   --Only DimDataHistoryId Removed from Hash
		   ,HASHBYTES('SHA1',CONCAT([DimORIApplicablePremiumID],'%',[InsertWarehouseLoadID],'%',[DimExternalSyndicateID],'%',[DimBrokerID],'%',[DimSettlementCurrencyID],'%',[DimYOAID],'%',[DimORIPlacementID],'%',[DimSourceSystemID],'%',[ORIDepositPremiumSettCcy],'%',[ORIEstimatedPremiumSettCcy],'%',[ORIAdjustmentPremiumSettCcy],'%',[ORIExpectedNetPremiumOrder],'%',[ORIMinimumPremiumSettCcy],'%',[ORIReinsurerPremiumToEarnSettCcy],'%',[DimAdjustmentID],'%',[DimAdjustmentTransactionType]))as PRD_HashBytes
       FROM [MYMI-TEST].[MyMI_DataWareHouse].DWH.FactORIApplicablePremiumDataHistory with (NOLOCK)
      WHERE DimDataHistoryId = 3225
        AND DimSourceSystemId  = 14
)

,CTE_DEV as (
     SELECT [DimORIApplicablePremiumID] as [DimORIApplicablePremiumID210],[DimDataHistoryID] as [DimDataHistoryID210],[InsertWarehouseLoadID] as [InsertWarehouseLoadID210],[DimExternalSyndicateID] as [DimExternalSyndicateID210],[DimBrokerID] as [DimBrokerID210],[DimSettlementCurrencyID] as [DimSettlementCurrencyID210],[DimYOAID] as [DimYOAID210],[DimORIPlacementID] as [DimORIPlacementID210],[DimSourceSystemID] as [DimSourceSystemID210],[ORIDepositPremiumSettCcy] as [ORIDepositPremiumSettCcy210],[ORIEstimatedPremiumSettCcy] as [ORIEstimatedPremiumSettCcy210],[ORIAdjustmentPremiumSettCcy] as [ORIAdjustmentPremiumSettCcy210],[ORIExpectedNetPremiumOrder] as [ORIExpectedNetPremiumOrder210],[ORIMinimumPremiumSettCcy] as [ORIMinimumPremiumSettCcy210],[ORIReinsurerPremiumToEarnSettCcy] as [ORIReinsurerPremiumToEarnSettCcy210],[DimAdjustmentID] as [DimAdjustmentID210],[DimAdjustmentTransactionType] as [DimAdjustmentTransactionType210]
           --,HASHBYTES('SHA1',CONCAT([DimORIApplicablePremiumID],'%',[DimDataHistoryID],'%',[InsertWarehouseLoadID],'%',[DimExternalSyndicateID],'%',[DimBrokerID],'%',[DimSettlementCurrencyID],'%',[DimYOAID],'%',[DimORIPlacementID],'%',[DimSourceSystemID],'%',[ORIDepositPremiumSettCcy],'%',[ORIEstimatedPremiumSettCcy],'%',[ORIAdjustmentPremiumSettCcy],'%',[ORIExpectedNetPremiumOrder],'%',[ORIMinimumPremiumSettCcy],'%',[ORIReinsurerPremiumToEarnSettCcy],'%',[DimAdjustmentID],'%',[DimAdjustmentTransactionType]))as DEV_HashBytes
		   --Only DimDataHistoryId Removed from Hash
		   ,HASHBYTES('SHA1',CONCAT([DimORIApplicablePremiumID],'%',[InsertWarehouseLoadID],'%',[DimExternalSyndicateID],'%',[DimBrokerID],'%',[DimSettlementCurrencyID],'%',[DimYOAID],'%',[DimORIPlacementID],'%',[DimSourceSystemID],'%',[ORIDepositPremiumSettCcy],'%',[ORIEstimatedPremiumSettCcy],'%',[ORIAdjustmentPremiumSettCcy],'%',[ORIExpectedNetPremiumOrder],'%',[ORIMinimumPremiumSettCcy],'%',[ORIReinsurerPremiumToEarnSettCcy],'%',[DimAdjustmentID],'%',[DimAdjustmentTransactionType]))as DEV_HashBytes
       FROM DWH.FactORIApplicablePremiumDataHistory with (NOLOCK)
      WHERE DimDataHistoryId = 3281
        AND DimSourceSystemId  = 14
)

SELECT * INTO QA.TR_FactORIApplicablePremiumDataHistory
  FROM (
     SELECT 'FactORIApplicablePremiumDataHistory' as EntityName
           ,P.PRD_HashBytes as PRDHashBytes, D.DimDataHistoryId210 as DEV_DimDataHistory,D.Dev_HashBytes as DEVHashBytes
           ,Case WHEN P.PRD_HashBytes = D.Dev_HashBytes THEN 'Passed'
                 WHEN P.PRD_Hashbytes is NULL THEN 'Failed - Missing in 2.5'
                 WHEN D.Dev_HashBytes is NULL THEN 'Failed - Missing in 2.10'
                 ELSE 'Failed - MisMatch of Hash'
             End as TestResult
           ,GetDate() as TestedOn 
           ,P.*,D.*   
       FROM CTE_PRD P 
		FULL Join CTE_DEV D 
         on DimORIApplicablePremiumID210 = DimORIApplicablePremiumID25
)TMP



SELECT TestResult, COUNT(*) as Total FROM QA.TR_FactORIApplicablePremiumDataHistory group by TestResult;
