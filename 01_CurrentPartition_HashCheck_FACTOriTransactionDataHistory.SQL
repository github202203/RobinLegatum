use MyMI_DataWarehouse
;

DROP TABLE IF EXISTS QA.TR_FactORITransactionDataHistory
;

With CTE_PRD as (
SELECT F.[DimORITransactionID] as [DimORITransactionID25] ,F.[DimDataHistoryID] as [DimDataHistoryID25],F.[InsertWarehouseLoadID] as [InsertWarehouseLoadID25],F.[DimAssuredID] as [DimAssuredID25],F.[DimBrokerID] as [DimBrokerID25],C.[First_DimClaimID] as [DimClaimID25],F.[DimCodeID] as [DimCodeID25],F.[DimDevelopmentYOAMonthID] as [DimDevelopmentYOAMonthID25],F.[DimDevelopmentYOAQuarterID] as [DimDevelopmentYOAQuarterID25],F.[DimDevelopmentYOAYearID] as [DimDevelopmentYOAYearID25],F.[DimGroupClassID] as [DimGroupClassID25],F.[DimInceptionDateID] as [DimInceptionDateID25],F.[DimLegalEntityID] as [DimLegalEntityID25],F.[DimNewRenewalID] as [DimNewRenewalID25],F.[DimORIBrokerID] as [DimORIBrokerID25],CS.[First_DimORIClaimSubEventID] as [DimORIClaimSubEventID25],DP.[First_DimORIPlacementID] as [DimORIPlacementID25],F.[DimORITransactionTypeID] as [DimORITransactionTypeID25],DPY.[First_DimPolicyID] as [DimPolicyID25],DPG.[First_DimPolicyGranularDetailID] as [DimPolicyGranularDetailID25],F.[DimPolicyStatusID] as [DimPolicyStatusID25],F.[DimPolicyYOAID] as [DimPolicyYOAID25],F.[DimProcessedDateID] as [DimProcessedDateID25],F.[DimProcessPeriodID] as [DimProcessPeriodID25],F.[DimProgrammeID] as [DimProgrammeID25],F.[DimReassuredID] as [DimReassuredID25],F.[DimRegionID] as [DimRegionID25],F.[DimSettlementCurrencyID] as [DimSettlementCurrencyID25],F.[DimSourceSystemID] as [DimSourceSystemID25],F.[DimTerritoryID] as [DimTerritoryID25],F.[DimTransactionDateID] as [DimTransactionDateID25],F.[DimVelocityProductID] as [DimVelocityProductID25],F.[DimYOAID] as [DimYOAID25],F.[ORIIncurredClaimSettCcy] as [ORIIncurredClaimSettCcy25],F.[ORIOutstandingClaimSettCcy] as [ORIOutstandingClaimSettCcy25],F.[ORIOutstandingClaimCoreCcy] as [ORIOutstandingClaimCoreCcy25],F.[ORIOutstandingClaimNotIssuedSettCcy] as [ORIOutstandingClaimNotIssuedSettCcy25],F.[ORIPaidClaimSettCcy] as [ORIPaidClaimSettCcy25],F.[ORIPaidClaimCoreCcy] as [ORIPaidClaimCoreCcy25],F.[ORIPaidClaimNotIssuedSettCcy] as [ORIPaidClaimNotIssuedSettCcy25],F.[ORIPremiumIncurredSettCcy] as [ORIPremiumIncurredSettCcy25],F.[ORIPremiumOutstandingSettCcy] as [ORIPremiumOutstandingSettCcy25],F.[ORIPremiumOutstandingNotIssuedSettCcy] as [ORIPremiumOutstandingNotIssuedSettCcy25],F.[ORISignedPremiumPaidSettCcy] as [ORISignedPremiumPaidSettCcy25],F.[ORISignedPremiumPaidCoreCcy] as [ORISignedPremiumPaidCoreCcy25],F.[ORISignedPremiumPaidNotIssuedSettCcy] as [ORISignedPremiumPaidNotIssuedSettCcy25],F.[DimAdjustmentID] as [DimAdjustmentID25],F.[DimAdjustmentTransactionType] as [DimAdjustmentTransactionType25],F.[IsAdjusted] as [IsAdjusted25],F.[DimUnderwriterID] as [DimUnderwriterID25],F.[DimORILegatumFlagID] as [DimORILegatumFlagID25]
	  --,HASHBYTES('SHA1',CONCAT([DimORITransactionID],'%',[InsertWarehouseLoadID],'%',F.[DimAssuredID],'%',/*[DimBrokerID],'%',*/C.[First_DimClaimID],'%',[DimCodeID],'%',[DimDevelopmentYOAMonthID],'%',[DimDevelopmentYOAQuarterID],'%',[DimDevelopmentYOAYearID],'%',F.[DimGroupClassID],'%',[DimInceptionDateID],'%',F.[DimLegalEntityID],'%',F.[DimNewRenewalID],'%',F.[DimORIBrokerID],'%',CS.[First_DimORIClaimSubEventID],'%',DP.[First_DimORIPlacementID],'%',[DimORITransactionTypeID],'%',DPY.[First_DimPolicyID],'%',DPG.[First_DimPolicyGranularDetailID],'%',F.[DimPolicyStatusID],'%',F.[DimPolicyYOAID],'%',[DimProcessedDateID],'%',[DimProcessPeriodID],'%',F.[DimProgrammeID],'%',[DimReassuredID],'%',[DimRegionID],'%',[DimSettlementCurrencyID],'%',F.[DimSourceSystemID],'%',[DimTerritoryID],'%',[DimTransactionDateID],'%',F.[DimVelocityProductID],'%',[DimYOAID],'%',[ORIIncurredClaimSettCcy],'%',[ORIOutstandingClaimSettCcy],'%',[ORIOutstandingClaimCoreCcy],'%',[ORIOutstandingClaimNotIssuedSettCcy],'%',[ORIPaidClaimSettCcy],'%',[ORIPaidClaimCoreCcy],'%',[ORIPaidClaimNotIssuedSettCcy],'%',[ORIPremiumIncurredSettCcy],'%',[ORIPremiumOutstandingSettCcy],'%',[ORIPremiumOutstandingNotIssuedSettCcy],'%',[ORISignedPremiumPaidSettCcy],'%',[ORISignedPremiumPaidCoreCcy],'%',[ORISignedPremiumPaidNotIssuedSettCcy],'%',[DimAdjustmentID],'%',[DimAdjustmentTransactionType],'%',[IsAdjusted],'%',F.[DimUnderwriterID],'%',[DimORILegatumFlagID]))as PRD_HashBytes
	  ,HASHBYTES('SHA1',CONCAT([DimORITransactionID],'%',[InsertWarehouseLoadID],'%',F.[DimAssuredID],'%',F.[DimBrokerID],'%',C.[First_DimClaimID],'%',[DimCodeID],'%',[DimDevelopmentYOAMonthID],'%',[DimDevelopmentYOAQuarterID],'%',[DimDevelopmentYOAYearID],'%',F.[DimGroupClassID],'%',[DimInceptionDateID],'%',F.[DimLegalEntityID],'%',F.[DimNewRenewalID],'%',F.[DimORIBrokerID],'%',CS.[First_DimORIClaimSubEventID],'%',DP.[First_DimORIPlacementID],'%',[DimORITransactionTypeID],'%',DPY.[First_DimPolicyID],'%',DPG.[First_DimPolicyGranularDetailID],'%',F.[DimPolicyStatusID],'%',F.[DimPolicyYOAID],'%',[DimProcessedDateID],'%',[DimProcessPeriodID],'%',F.[DimProgrammeID],'%',[DimReassuredID],'%',[DimRegionID],'%',[DimSettlementCurrencyID],'%',F.[DimSourceSystemID],'%',[DimTerritoryID],'%',[DimTransactionDateID],'%',F.[DimVelocityProductID],'%',[DimYOAID],'%',[ORIIncurredClaimSettCcy],'%',[ORIOutstandingClaimSettCcy],'%',[ORIOutstandingClaimCoreCcy],'%',[ORIOutstandingClaimNotIssuedSettCcy],'%',[ORIPaidClaimSettCcy],'%',[ORIPaidClaimCoreCcy],'%',[ORIPaidClaimNotIssuedSettCcy],'%',[ORIPremiumIncurredSettCcy],'%',[ORIPremiumOutstandingSettCcy],'%',[ORIPremiumOutstandingNotIssuedSettCcy],'%',[ORISignedPremiumPaidSettCcy],'%',[ORISignedPremiumPaidCoreCcy],'%',[ORISignedPremiumPaidNotIssuedSettCcy],'%',[DimAdjustmentID],'%',[DimAdjustmentTransactionType],'%',[IsAdjusted],'%',F.[DimUnderwriterID],'%',[DimORILegatumFlagID]))as PRD_HashBytes
  FROM [MYMI-TEST].[MyMI_DataWareHouse].DWH.FactORITransactionDataHistory F with (NOLOCK)
  Left Join [MYMI-TEST].[MyMI_DataWareHouse].DWH.DimClaim C                  on F.DimClaimId = C.DimClaimId
  Left Join [MYMI-TEST].[MyMI_DataWareHouse].DWH.DimORIClaimSubEvent CS      on F.DimORIClaimSubEventID = CS.DimORIClaimSubEventID 
  Left Join [MYMI-TEST].[MyMI_DataWareHouse].DWH.DimORIPlacement DP          on F.DimORIPlacementId = DP.DimORIPlacementId 
  Left Join [MYMI-TEST].[MyMI_DataWareHouse].DWH.DimPolicy DPY               on F.DimPolicyID = DPY.First_DimPolicyID
  Left Join [MYMI-TEST].[MyMI_DataWareHouse].DWH.DimPolicyGranularDetail DPG on F.DimPolicyGranularDetailID = DPG.First_DimPolicyGranularDetailID

 WHERE F.DimDataHistoryId = 3225 AND DimProcessPeriodId = 202203 AND F.DimSourceSystemId  = 14  --AND F.DimORITransactionID =  253694027
 )

,CTE_DEV as (
 SELECT F.[DimORITransactionID] as [DimORITransactionID210] ,F.[DimDataHistoryID] as [DimDataHistoryID210],F.[InsertWarehouseLoadID] as [InsertWarehouseLoadID210],F.[DimAssuredID] as [DimAssuredID210],F.[DimBrokerID] as [DimBrokerID210],C.[First_DimClaimID] as [DimClaimID210],F.[DimCodeID] as [DimCodeID210],F.[DimDevelopmentYOAMonthID] as [DimDevelopmentYOAMonthID210],F.[DimDevelopmentYOAQuarterID] as [DimDevelopmentYOAQuarterID210],F.[DimDevelopmentYOAYearID] as [DimDevelopmentYOAYearID210],F.[DimGroupClassID] as [DimGroupClassID210],F.[DimInceptionDateID] as [DimInceptionDateID210],F.[DimLegalEntityID] as [DimLegalEntityID210],F.[DimNewRenewalID] as [DimNewRenewalID210],F.[DimORIBrokerID] as [DimORIBrokerID210],CS.[First_DimORIClaimSubEventID] as [DimORIClaimSubEventID210],DP.[First_DimORIPlacementID] as [DimORIPlacementID210],F.[DimORITransactionTypeID] as [DimORITransactionTypeID210],DPY.[First_DimPolicyID] as [DimPolicyID210],DPG.[First_DimPolicyGranularDetailID] as [DimPolicyGranularDetailID210],F.[DimPolicyStatusID] as [DimPolicyStatusID210],F.[DimPolicyYOAID] as [DimPolicyYOAID210],F.[DimProcessedDateID] as [DimProcessedDateID210],F.[DimProcessPeriodID] as [DimProcessPeriodID210],F.[DimProgrammeID] as [DimProgrammeID210],F.[DimReassuredID] as [DimReassuredID210],F.[DimRegionID] as [DimRegionID210],F.[DimSettlementCurrencyID] as [DimSettlementCurrencyID210],F.[DimSourceSystemID] as [DimSourceSystemID210],F.[DimTerritoryID] as [DimTerritoryID210],F.[DimTransactionDateID] as [DimTransactionDateID210],F.[DimVelocityProductID] as [DimVelocityProductID210],F.[DimYOAID] as [DimYOAID210],F.[ORIIncurredClaimSettCcy] as [ORIIncurredClaimSettCcy210],F.[ORIOutstandingClaimSettCcy] as [ORIOutstandingClaimSettCcy210],F.[ORIOutstandingClaimCoreCcy] as [ORIOutstandingClaimCoreCcy210],F.[ORIOutstandingClaimNotIssuedSettCcy] as [ORIOutstandingClaimNotIssuedSettCcy210],F.[ORIPaidClaimSettCcy] as [ORIPaidClaimSettCcy210],F.[ORIPaidClaimCoreCcy] as [ORIPaidClaimCoreCcy210],F.[ORIPaidClaimNotIssuedSettCcy] as [ORIPaidClaimNotIssuedSettCcy210],F.[ORIPremiumIncurredSettCcy] as [ORIPremiumIncurredSettCcy210],F.[ORIPremiumOutstandingSettCcy] as [ORIPremiumOutstandingSettCcy210],F.[ORIPremiumOutstandingNotIssuedSettCcy] as [ORIPremiumOutstandingNotIssuedSettCcy210],F.[ORISignedPremiumPaidSettCcy] as [ORISignedPremiumPaidSettCcy210],F.[ORISignedPremiumPaidCoreCcy] as [ORISignedPremiumPaidCoreCcy210],F.[ORISignedPremiumPaidNotIssuedSettCcy] as [ORISignedPremiumPaidNotIssuedSettCcy210],F.[DimAdjustmentID] as [DimAdjustmentID210],F.[DimAdjustmentTransactionType] as [DimAdjustmentTransactionType210],F.[IsAdjusted] as [IsAdjusted210],F.[DimUnderwriterID] as [DimUnderwriterID210],F.[DimORILegatumFlagID] as [DimORILegatumFlagID210]
       --,HASHBYTES('SHA1',CONCAT([DimORITransactionID],'%',[InsertWarehouseLoadID],'%',F.[DimAssuredID],'%',/*[DimBrokerID],'%',*/C.[First_DimClaimID],'%',[DimCodeID],'%',[DimDevelopmentYOAMonthID],'%',[DimDevelopmentYOAQuarterID],'%',[DimDevelopmentYOAYearID],'%',F.[DimGroupClassID],'%',[DimInceptionDateID],'%',F.[DimLegalEntityID],'%',F.[DimNewRenewalID],'%',F.[DimORIBrokerID],'%',CS.[First_DimORIClaimSubEventID],'%',DP.[First_DimORIPlacementID],'%',[DimORITransactionTypeID],'%',DPY.[First_DimPolicyID],'%',DPG.[First_DimPolicyGranularDetailID],'%',F.[DimPolicyStatusID],'%',F.[DimPolicyYOAID],'%',[DimProcessedDateID],'%',[DimProcessPeriodID],'%',F.[DimProgrammeID],'%',[DimReassuredID],'%',[DimRegionID],'%',[DimSettlementCurrencyID],'%',F.[DimSourceSystemID],'%',[DimTerritoryID],'%',[DimTransactionDateID],'%',F.[DimVelocityProductID],'%',[DimYOAID],'%',[ORIIncurredClaimSettCcy],'%',[ORIOutstandingClaimSettCcy],'%',[ORIOutstandingClaimCoreCcy],'%',[ORIOutstandingClaimNotIssuedSettCcy],'%',[ORIPaidClaimSettCcy],'%',[ORIPaidClaimCoreCcy],'%',[ORIPaidClaimNotIssuedSettCcy],'%',[ORIPremiumIncurredSettCcy],'%',[ORIPremiumOutstandingSettCcy],'%',[ORIPremiumOutstandingNotIssuedSettCcy],'%',[ORISignedPremiumPaidSettCcy],'%',[ORISignedPremiumPaidCoreCcy],'%',[ORISignedPremiumPaidNotIssuedSettCcy],'%',[DimAdjustmentID],'%',[DimAdjustmentTransactionType],'%',[IsAdjusted],'%',F.[DimUnderwriterID],'%',[DimORILegatumFlagID]))as DEV_HashBytes
	   ,HASHBYTES('SHA1',CONCAT([DimORITransactionID],'%',[InsertWarehouseLoadID],'%',F.[DimAssuredID],'%',F.[DimBrokerID],'%',C.[First_DimClaimID],'%',[DimCodeID],'%',[DimDevelopmentYOAMonthID],'%',[DimDevelopmentYOAQuarterID],'%',[DimDevelopmentYOAYearID],'%',F.[DimGroupClassID],'%',[DimInceptionDateID],'%',F.[DimLegalEntityID],'%',F.[DimNewRenewalID],'%',F.[DimORIBrokerID],'%',CS.[First_DimORIClaimSubEventID],'%',DP.[First_DimORIPlacementID],'%',[DimORITransactionTypeID],'%',DPY.[First_DimPolicyID],'%',DPG.[First_DimPolicyGranularDetailID],'%',F.[DimPolicyStatusID],'%',F.[DimPolicyYOAID],'%',[DimProcessedDateID],'%',[DimProcessPeriodID],'%',F.[DimProgrammeID],'%',[DimReassuredID],'%',[DimRegionID],'%',[DimSettlementCurrencyID],'%',F.[DimSourceSystemID],'%',[DimTerritoryID],'%',[DimTransactionDateID],'%',F.[DimVelocityProductID],'%',[DimYOAID],'%',[ORIIncurredClaimSettCcy],'%',[ORIOutstandingClaimSettCcy],'%',[ORIOutstandingClaimCoreCcy],'%',[ORIOutstandingClaimNotIssuedSettCcy],'%',[ORIPaidClaimSettCcy],'%',[ORIPaidClaimCoreCcy],'%',[ORIPaidClaimNotIssuedSettCcy],'%',[ORIPremiumIncurredSettCcy],'%',[ORIPremiumOutstandingSettCcy],'%',[ORIPremiumOutstandingNotIssuedSettCcy],'%',[ORISignedPremiumPaidSettCcy],'%',[ORISignedPremiumPaidCoreCcy],'%',[ORISignedPremiumPaidNotIssuedSettCcy],'%',[DimAdjustmentID],'%',[DimAdjustmentTransactionType],'%',[IsAdjusted],'%',F.[DimUnderwriterID],'%',[DimORILegatumFlagID]))as DEV_HashBytes
  FROM DWH.FactORITransactionDataHistory F with (NOLOCK) 
  Left Join DWH.DimClaim C                  on F.DimClaimId = C.DimClaimId
  Left join DWH.DimORIClaimSubEvent CS      on F.DimORIClaimSubEventID = CS.DimORIClaimSubEventID 
  Left Join DWH.DimORIPlacement DP          on F.DimORIPlacementId = DP.DimORIPlacementId 
  Left Join DWH.DimPolicy DPY               on F.DimPolicyID = DPY.First_DimPolicyID
  Left Join DWH.DimPolicyGranularDetail DPG on F.DimPolicyGranularDetailID = DPG.First_DimPolicyGranularDetailID

 WHERE F.DimDataHistoryId = 3281 AND F.DimProcessPeriodId = 202203 AND F.DimSourceSystemId  = 14 --AND F.DimORITransactionID =  253694027
 )

 SELECT * 
   INTO QA.TR_FactORITransactionDataHistory
   FROM (
 SELECT 'FactORITransactionDataHistory' as EntityName
           ,P.PRD_HashBytes as PRDHashBytes
		   ,D.Dev_HashBytes as DEVHashBytes
           ,Case WHEN P.PRD_HashBytes = D.Dev_HashBytes THEN 'Passed'
                 WHEN P.PRD_Hashbytes is NULL THEN 'Failed - Missing in 2.5'
                 WHEN D.Dev_HashBytes is NULL THEN 'Failed - Missing in 2.10'
                 ELSE 'Failed - MisMatch of Hash'
             End as TestResult
           ,GetDate() as TestedOn 
           ,P.*,D.*   
       FROM CTE_PRD P 
		FULL Join CTE_DEV D 
         on DimORITransactionID210 = DimORITransactionID25
       )TMP WHERE TestResult <> 'Passed'



/*

SELECT C.First_DimClaimID, F.* FROM DWH.FactORITransactionDataHistory  F with (NOLOCK) 
   INNER JOIN DWH.DimClaim C on F.DimClaimID = C.DimClaimID
 WHERE DimORITransactionID = 253693418
   AND DimDataHistoryId = 3281

   SELECT C.First_DimClaimID, F.* FROM [MYMI-TEST].[MyMI_DataWareHouse].DWH.FactORITransactionDataHistory  F with (NOLOCK) 
   INNER JOIN [MYMI-TEST].[MyMI_DataWareHouse].DWH.DimClaim C on F.DimClaimID = C.DimClaimID
 WHERE DimORITransactionID = 253693418
   AND DimDataHistoryId = 3225

SELECT * FROM DWH.DimORIClaimSubEvent WHERE DimORIClaimSubEventId = 74871
SELECT * FROM [MYMI-TEST].[MyMI_DataWareHouse].DWH.DimORIClaimSubEvent WHERE DimORIClaimSubEventId = 74871

SELECT * FROM DWH.DimBroker
 WHERE DimBrokerId in (2736,2802)

 SELECT * FROM DWH.[DimORIPlacement]
 
 */