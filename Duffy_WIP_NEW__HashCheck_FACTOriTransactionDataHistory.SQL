
With CTE_PRD as (
SELECT [DimORITransactionID] as [DimORITransactionID25] ,[DimDataHistoryID] as [DimDataHistoryID25],[InsertWarehouseLoadID] as [InsertWarehouseLoadID25],[DimAssuredID] as [DimAssuredID25],[DimBrokerID] as [DimBrokerID25],F.[DimClaimID] as [DimClaimID25],[DimCodeID] as [DimCodeID25],[DimDevelopmentYOAMonthID] as [DimDevelopmentYOAMonthID25],[DimDevelopmentYOAQuarterID] as [DimDevelopmentYOAQuarterID25],[DimDevelopmentYOAYearID] as [DimDevelopmentYOAYearID25],F.[DimGroupClassID] as [DimGroupClassID25],[DimInceptionDateID] as [DimInceptionDateID25],[DimLegalEntityID] as [DimLegalEntityID25],[DimNewRenewalID] as [DimNewRenewalID25],F.[DimORIBrokerID] as [DimORIBrokerID25],F.[DimORIClaimSubEventID] as [DimORIClaimSubEventID25],F.[DimORIPlacementID] as [DimORIPlacementID25],[DimORITransactionTypeID] as [DimORITransactionTypeID25],[DimPolicyID] as [DimPolicyID25],[DimPolicyGranularDetailID] as [DimPolicyGranularDetailID25],[DimPolicyStatusID] as [DimPolicyStatusID25],[DimPolicyYOAID] as [DimPolicyYOAID25],[DimProcessedDateID] as [DimProcessedDateID25],[DimProcessPeriodID] as [DimProcessPeriodID25],[DimProgrammeID] as [DimProgrammeID25],[DimReassuredID] as [DimReassuredID25],[DimRegionID] as [DimRegionID25],[DimSettlementCurrencyID] as [DimSettlementCurrencyID25],F.[DimSourceSystemID] as [DimSourceSystemID25],[DimTerritoryID] as [DimTerritoryID25],[DimTransactionDateID] as [DimTransactionDateID25],[DimVelocityProductID] as [DimVelocityProductID25],[DimYOAID] as [DimYOAID25],[ORIIncurredClaimSettCcy] as [ORIIncurredClaimSettCcy25],[ORIOutstandingClaimSettCcy] as [ORIOutstandingClaimSettCcy25],[ORIOutstandingClaimCoreCcy] as [ORIOutstandingClaimCoreCcy25],[ORIOutstandingClaimNotIssuedSettCcy] as [ORIOutstandingClaimNotIssuedSettCcy25],[ORIPaidClaimSettCcy] as [ORIPaidClaimSettCcy25],[ORIPaidClaimCoreCcy] as [ORIPaidClaimCoreCcy25],[ORIPaidClaimNotIssuedSettCcy] as [ORIPaidClaimNotIssuedSettCcy25],[ORIPremiumIncurredSettCcy] as [ORIPremiumIncurredSettCcy25],[ORIPremiumOutstandingSettCcy] as [ORIPremiumOutstandingSettCcy25],[ORIPremiumOutstandingNotIssuedSettCcy] as [ORIPremiumOutstandingNotIssuedSettCcy25],[ORISignedPremiumPaidSettCcy] as [ORISignedPremiumPaidSettCcy25],[ORISignedPremiumPaidCoreCcy] as [ORISignedPremiumPaidCoreCcy25],[ORISignedPremiumPaidNotIssuedSettCcy] as [ORISignedPremiumPaidNotIssuedSettCcy25],[DimAdjustmentID] as [DimAdjustmentID25],[DimAdjustmentTransactionType] as [DimAdjustmentTransactionType25],[IsAdjusted] as [IsAdjusted25],[DimUnderwriterID] as [DimUnderwriterID25],[DimORILegatumFlagID] as [DimORILegatumFlagID25]
      --,HASHBYTES('SHA1',CONCAT([DimORITransactionID],'%',[DimDataHistoryID],'%',[InsertWarehouseLoadID],'%',[DimAssuredID],'%',[DimBrokerID],'%',[DimClaimID],'%',[DimCodeID],'%',[DimDevelopmentYOAMonthID],'%',[DimDevelopmentYOAQuarterID],'%',[DimDevelopmentYOAYearID],'%',[DimGroupClassID],'%',[DimInceptionDateID],'%',[DimLegalEntityID],'%',[DimNewRenewalID],'%',[DimORIBrokerID],'%',[DimORIClaimSubEventID],'%',[DimORIPlacementID],'%',[DimORITransactionTypeID],'%',[DimPolicyID],'%',[DimPolicyGranularDetailID],'%',[DimPolicyStatusID],'%',[DimPolicyYOAID],'%',[DimProcessedDateID],'%',[DimProcessPeriodID],'%',[DimProgrammeID],'%',[DimReassuredID],'%',[DimRegionID],'%',[DimSettlementCurrencyID],'%',[DimSourceSystemID],'%',[DimTerritoryID],'%',[DimTransactionDateID],'%',[DimVelocityProductID],'%',[DimYOAID],'%',[ORIIncurredClaimSettCcy],'%',[ORIOutstandingClaimSettCcy],'%',[ORIOutstandingClaimCoreCcy],'%',[ORIOutstandingClaimNotIssuedSettCcy],'%',[ORIPaidClaimSettCcy],'%',[ORIPaidClaimCoreCcy],'%',[ORIPaidClaimNotIssuedSettCcy],'%',[ORIPremiumIncurredSettCcy],'%',[ORIPremiumOutstandingSettCcy],'%',[ORIPremiumOutstandingNotIssuedSettCcy],'%',[ORISignedPremiumPaidSettCcy],'%',[ORISignedPremiumPaidCoreCcy],'%',[ORISignedPremiumPaidNotIssuedSettCcy],'%',[DimAdjustmentID],'%',[DimAdjustmentTransactionType],'%',[IsAdjusted],'%',[DimUnderwriterID],'%',[DimORILegatumFlagID]))as PRD_HashBytes
	  ,HASHBYTES('SHA1',CONCAT([DimORITransactionID],'%',[InsertWarehouseLoadID],'%',[DimAssuredID],'%',/*[DimBrokerID],'%',*/C.[First_DimClaimID],'%',[DimCodeID],'%',[DimDevelopmentYOAMonthID],'%',[DimDevelopmentYOAQuarterID],'%',[DimDevelopmentYOAYearID],'%',F.[DimGroupClassID],'%',[DimInceptionDateID],'%',[DimLegalEntityID],'%',[DimNewRenewalID],'%',F.[DimORIBrokerID],'%',CS.[First_DimORIClaimSubEventID],'%',DP.[First_DimORIPlacementID]))as PRD_HashBytes
  FROM [MYMI-TEST].[MyMI_DataWareHouse].DWH.FactORITransactionDataHistory F with (NOLOCK)
  Join [MYMI-TEST].[MyMI_DataWareHouse].DWH.DimClaim C             on F.DimClaimId = C.DimClaimId
  Join [MYMI-TEST].[MyMI_DataWareHouse].DWH.DimORIClaimSubEvent CS on F.DimORIClaimSubEventID = CS.DimORIClaimSubEventID 
  Join [MYMI-TEST].[MyMI_DataWareHouse].DWH.DimORIPlacement DP on F.DimORIPlacementId = DP.DimORIPlacementId 

 WHERE F.DimDataHistoryId = 3225 AND DimProcessPeriodId = 202203 AND F.DimSourceSystemId  = 14  --AND F.DimORITransactionID =  253694027
 )

,CTE_DEV as (
 SELECT [DimORITransactionID] as [DimORITransactionID210],[DimDataHistoryID] as [DimDataHistoryID210],[InsertWarehouseLoadID] as [InsertWarehouseLoadID210],[DimAssuredID] as [DimAssuredID210],[DimBrokerID] as [DimBrokerID210],F.[DimClaimID] as [DimClaimID210],[DimCodeID] as [DimCodeID210],[DimDevelopmentYOAMonthID] as [DimDevelopmentYOAMonthID210],[DimDevelopmentYOAQuarterID] as [DimDevelopmentYOAQuarterID210],[DimDevelopmentYOAYearID] as [DimDevelopmentYOAYearID210],F.[DimGroupClassID] as [DimGroupClassID210],[DimInceptionDateID] as [DimInceptionDateID210],[DimLegalEntityID] as [DimLegalEntityID210],[DimNewRenewalID] as [DimNewRenewalID210],F.[DimORIBrokerID] as [DimORIBrokerID210],F.[DimORIClaimSubEventID] as [DimORIClaimSubEventID210],F.[DimORIPlacementID] as [DimORIPlacementID210],[DimORITransactionTypeID] as [DimORITransactionTypeID210],[DimPolicyID] as [DimPolicyID210],[DimPolicyGranularDetailID] as [DimPolicyGranularDetailID210],[DimPolicyStatusID] as [DimPolicyStatusID210],[DimPolicyYOAID] as [DimPolicyYOAID210],[DimProcessedDateID] as [DimProcessedDateID210],[DimProcessPeriodID] as [DimProcessPeriodID210],[DimProgrammeID] as [DimProgrammeID210],[DimReassuredID] as [DimReassuredID210],[DimRegionID] as [DimRegionID210],[DimSettlementCurrencyID] as [DimSettlementCurrencyID210],F.[DimSourceSystemID] as [DimSourceSystemID210],[DimTerritoryID] as [DimTerritoryID210],[DimTransactionDateID] as [DimTransactionDateID210],[DimVelocityProductID] as [DimVelocityProductID210],[DimYOAID] as [DimYOAID210],[ORIIncurredClaimSettCcy] as [ORIIncurredClaimSettCcy210],[ORIOutstandingClaimSettCcy] as [ORIOutstandingClaimSettCcy210],[ORIOutstandingClaimCoreCcy] as [ORIOutstandingClaimCoreCcy210],[ORIOutstandingClaimNotIssuedSettCcy] as [ORIOutstandingClaimNotIssuedSettCcy210],[ORIPaidClaimSettCcy] as [ORIPaidClaimSettCcy210],[ORIPaidClaimCoreCcy] as [ORIPaidClaimCoreCcy210],[ORIPaidClaimNotIssuedSettCcy] as [ORIPaidClaimNotIssuedSettCcy210],[ORIPremiumIncurredSettCcy] as [ORIPremiumIncurredSettCcy210],[ORIPremiumOutstandingSettCcy] as [ORIPremiumOutstandingSettCcy210],[ORIPremiumOutstandingNotIssuedSettCcy] as [ORIPremiumOutstandingNotIssuedSettCcy210],[ORISignedPremiumPaidSettCcy] as [ORISignedPremiumPaidSettCcy210],[ORISignedPremiumPaidCoreCcy] as [ORISignedPremiumPaidCoreCcy210],[ORISignedPremiumPaidNotIssuedSettCcy] as [ORISignedPremiumPaidNotIssuedSettCcy210],[DimAdjustmentID] as [DimAdjustmentID210],[DimAdjustmentTransactionType] as [DimAdjustmentTransactionType210],[IsAdjusted] as [IsAdjusted210],[DimUnderwriterID] as [DimUnderwriterID210],[DimORILegatumFlagID] as [DimORILegatumFlagID210]
      --,HASHBYTES('SHA1',CONCAT([DimORITransactionID],'%',[DimDataHistoryID],'%',[InsertWarehouseLoadID],'%',[DimAssuredID],'%',[DimBrokerID],'%',[DimClaimID],'%',[DimCodeID],'%',[DimDevelopmentYOAMonthID],'%',[DimDevelopmentYOAQuarterID],'%',[DimDevelopmentYOAYearID],'%',[DimGroupClassID],'%',[DimInceptionDateID],'%',[DimLegalEntityID],'%',[DimNewRenewalID],'%',[DimORIBrokerID],'%',[DimORIClaimSubEventID],'%',[DimORIPlacementID],'%',[DimORITransactionTypeID],'%',[DimPolicyID],'%',[DimPolicyGranularDetailID],'%',[DimPolicyStatusID],'%',[DimPolicyYOAID],'%',[DimProcessedDateID],'%',[DimProcessPeriodID],'%',[DimProgrammeID],'%',[DimReassuredID],'%',[DimRegionID],'%',[DimSettlementCurrencyID],'%',[DimSourceSystemID],'%',[DimTerritoryID],'%',[DimTransactionDateID],'%',[DimVelocityProductID],'%',[DimYOAID],'%',[ORIIncurredClaimSettCcy],'%',[ORIOutstandingClaimSettCcy],'%',[ORIOutstandingClaimCoreCcy],'%',[ORIOutstandingClaimNotIssuedSettCcy],'%',[ORIPaidClaimSettCcy],'%',[ORIPaidClaimCoreCcy],'%',[ORIPaidClaimNotIssuedSettCcy],'%',[ORIPremiumIncurredSettCcy],'%',[ORIPremiumOutstandingSettCcy],'%',[ORIPremiumOutstandingNotIssuedSettCcy],'%',[ORISignedPremiumPaidSettCcy],'%',[ORISignedPremiumPaidCoreCcy],'%',[ORISignedPremiumPaidNotIssuedSettCcy],'%',[DimAdjustmentID],'%',[DimAdjustmentTransactionType],'%',[IsAdjusted],'%',[DimUnderwriterID],'%',[DimORILegatumFlagID]))as DEV_HashBytes
	   ,HASHBYTES('SHA1',CONCAT([DimORITransactionID],'%',[InsertWarehouseLoadID],'%',[DimAssuredID],'%',/*[DimBrokerID],'%',*/C.[First_DimClaimID],'%',[DimCodeID],'%',[DimDevelopmentYOAMonthID],'%',[DimDevelopmentYOAQuarterID],'%',[DimDevelopmentYOAYearID],'%',F.[DimGroupClassID],'%',[DimInceptionDateID],'%',[DimLegalEntityID],'%',[DimNewRenewalID],'%',F.[DimORIBrokerID],'%',CS.[First_DimORIClaimSubEventID],'%',DP.[First_DimORIPlacementID]))as DEV_HashBytes
  FROM DWH.FactORITransactionDataHistory F with (NOLOCK) 
  Join DWH.DimClaim C on F.DimClaimId = C.DimClaimId
  join DWH.DimORIClaimSubEvent CS on F.DimORIClaimSubEventID = CS.DimORIClaimSubEventID 
  Join DWH.DimORIPlacement DP     on F.DimORIPlacementId = DP.DimORIPlacementId 

 WHERE F.DimDataHistoryId = 3281 AND F.DimProcessPeriodId = 202203 AND F.DimSourceSystemId  = 14 --AND F.DimORITransactionID =  253694027
 )

 SELECT * FROM (
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