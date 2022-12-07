--Financial Partition Feb 2022
DROP Table IF EXISTS QA.FPTR_FactORIApplicablePremiumDataHistory;

With CTE_PRD as (
     SELECT [DimORIApplicablePremiumID] as [DimORIApplicablePremiumID25],[DimDataHistoryID] as [DimDataHistoryID25],[InsertWarehouseLoadID] as [InsertWarehouseLoadID25],[DimExternalSyndicateID] as [DimExternalSyndicateID25],[DimBrokerID] as [DimBrokerID25],[DimSettlementCurrencyID] as [DimSettlementCurrencyID25],[DimYOAID] as [DimYOAID25],[DimORIPlacementID] as [DimORIPlacementID25],[DimSourceSystemID] as [DimSourceSystemID25],[ORIDepositPremiumSettCcy] as [ORIDepositPremiumSettCcy25],[ORIEstimatedPremiumSettCcy] as [ORIEstimatedPremiumSettCcy25],[ORIAdjustmentPremiumSettCcy] as [ORIAdjustmentPremiumSettCcy25],[ORIExpectedNetPremiumOrder] as [ORIExpectedNetPremiumOrder25],[ORIMinimumPremiumSettCcy] as [ORIMinimumPremiumSettCcy25],[ORIReinsurerPremiumToEarnSettCcy] as [ORIReinsurerPremiumToEarnSettCcy25],[DimAdjustmentID] as [DimAdjustmentID25],[DimAdjustmentTransactionType] as [DimAdjustmentTransactionType25]
           --,HASHBYTES('SHA1',CONCAT([DimORIApplicablePremiumID],'%',[DimDataHistoryID],'%',[InsertWarehouseLoadID],'%',[DimExternalSyndicateID],'%',[DimBrokerID],'%',[DimSettlementCurrencyID],'%',[DimYOAID],'%',[DimORIPlacementID],'%',[DimSourceSystemID],'%',[ORIDepositPremiumSettCcy],'%',[ORIEstimatedPremiumSettCcy],'%',[ORIAdjustmentPremiumSettCcy],'%',[ORIExpectedNetPremiumOrder],'%',[ORIMinimumPremiumSettCcy],'%',[ORIReinsurerPremiumToEarnSettCcy],'%',[DimAdjustmentID],'%',[DimAdjustmentTransactionType]))as PRD_HashBytes
		   ,HASHBYTES('SHA1',CONCAT([DimORIApplicablePremiumID],'%',[DimExternalSyndicateID],'%',[DimBrokerID],'%',[DimSettlementCurrencyID],'%',[DimYOAID],'%',[DimORIPlacementID],'%',[DimSourceSystemID],'%',[ORIDepositPremiumSettCcy],'%',[ORIEstimatedPremiumSettCcy],'%',[ORIAdjustmentPremiumSettCcy],'%',[ORIExpectedNetPremiumOrder],'%',[ORIMinimumPremiumSettCcy],'%',[ORIReinsurerPremiumToEarnSettCcy],'%',[DimAdjustmentID],'%',[DimAdjustmentTransactionType]))as PRD_HashBytes
		   --Removed DimDataHistoryId & InsertWarehouseLoadId
	   FROM [MYMI-PROD].[MyMI_DataWareHouse].DWH.FactORIApplicablePremiumDataHistory with (NOLOCK)
      WHERE DimDataHistoryId = 3316
        AND DimSourceSystemId  = 14
)

,CTE_TEST as (
     SELECT [DimORIApplicablePremiumID] as [DimORIApplicablePremiumID210],[DimDataHistoryID] as [DimDataHistoryID210],[InsertWarehouseLoadID] as [InsertWarehouseLoadID210],[DimExternalSyndicateID] as [DimExternalSyndicateID210],[DimBrokerID] as [DimBrokerID210],[DimSettlementCurrencyID] as [DimSettlementCurrencyID210],[DimYOAID] as [DimYOAID210],[DimORIPlacementID] as [DimORIPlacementID210],[DimSourceSystemID] as [DimSourceSystemID210],[ORIDepositPremiumSettCcy] as [ORIDepositPremiumSettCcy210],[ORIEstimatedPremiumSettCcy] as [ORIEstimatedPremiumSettCcy210],[ORIAdjustmentPremiumSettCcy] as [ORIAdjustmentPremiumSettCcy210],[ORIExpectedNetPremiumOrder] as [ORIExpectedNetPremiumOrder210],[ORIMinimumPremiumSettCcy] as [ORIMinimumPremiumSettCcy210],[ORIReinsurerPremiumToEarnSettCcy] as [ORIReinsurerPremiumToEarnSettCcy210],[DimAdjustmentID] as [DimAdjustmentID210],[DimAdjustmentTransactionType] as [DimAdjustmentTransactionType210]
           --,HASHBYTES('SHA1',CONCAT([DimORIApplicablePremiumID],'%',[DimDataHistoryID],'%',[InsertWarehouseLoadID],'%',[DimExternalSyndicateID],'%',[DimBrokerID],'%',[DimSettlementCurrencyID],'%',[DimYOAID],'%',[DimORIPlacementID],'%',[DimSourceSystemID],'%',[ORIDepositPremiumSettCcy],'%',[ORIEstimatedPremiumSettCcy],'%',[ORIAdjustmentPremiumSettCcy],'%',[ORIExpectedNetPremiumOrder],'%',[ORIMinimumPremiumSettCcy],'%',[ORIReinsurerPremiumToEarnSettCcy],'%',[DimAdjustmentID],'%',[DimAdjustmentTransactionType]))as TEST_HashBytes
		   --Removed DimDataHistoryId & InsertWarehouseLoadId
           ,HASHBYTES('SHA1',CONCAT([DimORIApplicablePremiumID],'%',[DimExternalSyndicateID],'%',[DimBrokerID],'%',[DimSettlementCurrencyID],'%',[DimYOAID],'%',[DimORIPlacementID],'%',[DimSourceSystemID],'%',[ORIDepositPremiumSettCcy],'%',[ORIEstimatedPremiumSettCcy],'%',[ORIAdjustmentPremiumSettCcy],'%',[ORIExpectedNetPremiumOrder],'%',[ORIMinimumPremiumSettCcy],'%',[ORIReinsurerPremiumToEarnSettCcy],'%',[DimAdjustmentID],'%',[DimAdjustmentTransactionType]))as TEST_HashBytes		   
       FROM DWH.FactORIApplicablePremiumDataHistory with (NOLOCK)
      WHERE DimDataHistoryId = 3314
        AND DimSourceSystemId  = 14
)

SELECT * INTO QA.FPTR_FactORIApplicablePremiumDataHistory
  FROM (
     SELECT 'FactORIApplicablePremiumDataHistory' as EntityName
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
         on DimORIApplicablePremiumID210 = DimORIApplicablePremiumID25
)TMP



SELECT TestResult, COUNT(*) as Total FROM QA.FPTR_FactORIApplicablePremiumDataHistory group by TestResult;
