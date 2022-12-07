SELECT
dv.variablename
--'EarnedGrossClaimCoreCcy' as VARIABLE
,dre.IFRSReportingEntity as REPORTING_ENTITY
,dgc.GroupClass as GROUP_CLASS
,drb.RiBasis as RI_BASIS
,dy.Year as YOA
,dc.CurrencyCode as CURRENCY
,fim.variableValue as VALUE

FROM `parquet`.`dbfs:/mnt/main/Integration/IFRS-Mart/Confidential/54587/dwh_FactIFRSMetrics/*/*.parquet` fim
;


  SELECT DataHistoryCode,DataHistoryName,CalendarAsAtDate, F.DimDataHistoryId210,F.DimProcessedDateID210, F.DimProcessPeriodID210, F.DimSourceSystemId210,F.TotalRecords 
   FROM (
 SELECT  DimDataHistoryId210,DimProcessedDateID210, DimProcessPeriodID210, DimSourceSystemId210,COUNT(*) as TotalRecords 
   FROM (
         SELECT [DimORITransactionID] as [DimORITransactionID210],[DimDataHistoryID] as [DimDataHistoryID210],[InsertWarehouseLoadID] as [InsertWarehouseLoadID210],[DimAssuredID] as [DimAssuredID210],[DimBrokerID] as [DimBrokerID210],[DimClaimID] as [DimClaimID210],[DimCodeID] as [DimCodeID210],[DimDevelopmentYOAMonthID] as [DimDevelopmentYOAMonthID210],[DimDevelopmentYOAQuarterID] as [DimDevelopmentYOAQuarterID210],[DimDevelopmentYOAYearID] as [DimDevelopmentYOAYearID210],[DimGroupClassID] as [DimGroupClassID210],[DimInceptionDateID] as [DimInceptionDateID210],[DimLegalEntityID] as [DimLegalEntityID210],[DimNewRenewalID] as [DimNewRenewalID210],[DimORIBrokerID] as [DimORIBrokerID210],[DimORIClaimSubEventID] as [DimORIClaimSubEventID210],[DimORIPlacementID] as [DimORIPlacementID210],[DimORITransactionTypeID] as [DimORITransactionTypeID210],[DimPolicyID] as [DimPolicyID210],[DimPolicyGranularDetailID] as [DimPolicyGranularDetailID210],[DimPolicyStatusID] as [DimPolicyStatusID210],[DimPolicyYOAID] as [DimPolicyYOAID210],[DimProcessedDateID] as [DimProcessedDateID210],[DimProcessPeriodID] as [DimProcessPeriodID210],[DimProgrammeID] as [DimProgrammeID210],[DimReassuredID] as [DimReassuredID210],[DimRegionID] as [DimRegionID210],[DimSettlementCurrencyID] as [DimSettlementCurrencyID210],[DimSourceSystemID] as [DimSourceSystemID210],[DimTerritoryID] as [DimTerritoryID210],[DimTransactionDateID] as [DimTransactionDateID210],[DimVelocityProductID] as [DimVelocityProductID210],[DimYOAID] as [DimYOAID210],[ORIIncurredClaimSettCcy] as [ORIIncurredClaimSettCcy210],[ORIOutstandingClaimSettCcy] as [ORIOutstandingClaimSettCcy210],[ORIOutstandingClaimCoreCcy] as [ORIOutstandingClaimCoreCcy210],[ORIOutstandingClaimNotIssuedSettCcy] as [ORIOutstandingClaimNotIssuedSettCcy210],[ORIPaidClaimSettCcy] as [ORIPaidClaimSettCcy210],[ORIPaidClaimCoreCcy] as [ORIPaidClaimCoreCcy210],[ORIPaidClaimNotIssuedSettCcy] as [ORIPaidClaimNotIssuedSettCcy210],[ORIPremiumIncurredSettCcy] as [ORIPremiumIncurredSettCcy210],[ORIPremiumOutstandingSettCcy] as [ORIPremiumOutstandingSettCcy210],[ORIPremiumOutstandingNotIssuedSettCcy] as [ORIPremiumOutstandingNotIssuedSettCcy210],[ORISignedPremiumPaidSettCcy] as [ORISignedPremiumPaidSettCcy210],[ORISignedPremiumPaidCoreCcy] as [ORISignedPremiumPaidCoreCcy210],[ORISignedPremiumPaidNotIssuedSettCcy] as [ORISignedPremiumPaidNotIssuedSettCcy210],[DimAdjustmentID] as [DimAdjustmentID210],[DimAdjustmentTransactionType] as [DimAdjustmentTransactionType210],[IsAdjusted] as [IsAdjusted210],[DimUnderwriterID] as [DimUnderwriterID210],[DimORILegatumFlagID] as [DimORILegatumFlagID210]
           FROM DWH.FactORITransactionDataHistory with (NOLOCK)
          WHERE DimSourceSystemId = 14  --Source System as GXLP
		    AND DimProcessPeriodID = 202203 --Only for March 2022
		    --AND DimDataHistoryId = 3226 -- 28th March, 2022 Partition (198579)
	     ) T GROUP BY DimDataHistoryId210,DimProcessedDateID210,DimProcessPeriodID210,DimSourceSystemId210
		 )F Join DWH.DimDataHistory H
 ON DimDataHistoryId210 = DimDataHistoryId
 ORDER BY DimDataHistoryId210 

SELECT * FROM DWH.FactORITransactionDataHistory with (NOLOCK)
 WHERE DimSourceSystemId = 14  --Source System as GXLP
   AND DimProcessPeriodID = 202203 --Only for March 2022
   AND DimDataHistoryId = 3226 -- 28th March, 2022 Partition
   
 
 SELECT DataHistoryCode,DataHistoryName,CalendarAsAtDate, F.DimDataHistoryId210,F.DimProcessedDateID210, F.DimProcessPeriodID210, F.DimSourceSystemId210,F.TotalRecords 
   FROM (
 SELECT  DimDataHistoryId210,DimProcessedDateID210, DimProcessPeriodID210, DimSourceSystemId210,COUNT(*) as TotalRecords 
   FROM (
         SELECT [DimORITransactionID] as [DimORITransactionID210],[DimDataHistoryID] as [DimDataHistoryID210],[InsertWarehouseLoadID] as [InsertWarehouseLoadID210],[DimAssuredID] as [DimAssuredID210],[DimBrokerID] as [DimBrokerID210],[DimClaimID] as [DimClaimID210],[DimCodeID] as [DimCodeID210],[DimDevelopmentYOAMonthID] as [DimDevelopmentYOAMonthID210],[DimDevelopmentYOAQuarterID] as [DimDevelopmentYOAQuarterID210],[DimDevelopmentYOAYearID] as [DimDevelopmentYOAYearID210],[DimGroupClassID] as [DimGroupClassID210],[DimInceptionDateID] as [DimInceptionDateID210],[DimLegalEntityID] as [DimLegalEntityID210],[DimNewRenewalID] as [DimNewRenewalID210],[DimORIBrokerID] as [DimORIBrokerID210],[DimORIClaimSubEventID] as [DimORIClaimSubEventID210],[DimORIPlacementID] as [DimORIPlacementID210],[DimORITransactionTypeID] as [DimORITransactionTypeID210],[DimPolicyID] as [DimPolicyID210],[DimPolicyGranularDetailID] as [DimPolicyGranularDetailID210],[DimPolicyStatusID] as [DimPolicyStatusID210],[DimPolicyYOAID] as [DimPolicyYOAID210],[DimProcessedDateID] as [DimProcessedDateID210],[DimProcessPeriodID] as [DimProcessPeriodID210],[DimProgrammeID] as [DimProgrammeID210],[DimReassuredID] as [DimReassuredID210],[DimRegionID] as [DimRegionID210],[DimSettlementCurrencyID] as [DimSettlementCurrencyID210],[DimSourceSystemID] as [DimSourceSystemID210],[DimTerritoryID] as [DimTerritoryID210],[DimTransactionDateID] as [DimTransactionDateID210],[DimVelocityProductID] as [DimVelocityProductID210],[DimYOAID] as [DimYOAID210],[ORIIncurredClaimSettCcy] as [ORIIncurredClaimSettCcy210],[ORIOutstandingClaimSettCcy] as [ORIOutstandingClaimSettCcy210],[ORIOutstandingClaimCoreCcy] as [ORIOutstandingClaimCoreCcy210],[ORIOutstandingClaimNotIssuedSettCcy] as [ORIOutstandingClaimNotIssuedSettCcy210],[ORIPaidClaimSettCcy] as [ORIPaidClaimSettCcy210],[ORIPaidClaimCoreCcy] as [ORIPaidClaimCoreCcy210],[ORIPaidClaimNotIssuedSettCcy] as [ORIPaidClaimNotIssuedSettCcy210],[ORIPremiumIncurredSettCcy] as [ORIPremiumIncurredSettCcy210],[ORIPremiumOutstandingSettCcy] as [ORIPremiumOutstandingSettCcy210],[ORIPremiumOutstandingNotIssuedSettCcy] as [ORIPremiumOutstandingNotIssuedSettCcy210],[ORISignedPremiumPaidSettCcy] as [ORISignedPremiumPaidSettCcy210],[ORISignedPremiumPaidCoreCcy] as [ORISignedPremiumPaidCoreCcy210],[ORISignedPremiumPaidNotIssuedSettCcy] as [ORISignedPremiumPaidNotIssuedSettCcy210],[DimAdjustmentID] as [DimAdjustmentID210],[DimAdjustmentTransactionType] as [DimAdjustmentTransactionType210],[IsAdjusted] as [IsAdjusted210],[DimUnderwriterID] as [DimUnderwriterID210],[DimORILegatumFlagID] as [DimORILegatumFlagID210]
           FROM DWH.FactORITransactionDataHistory with (NOLOCK)
          WHERE DimSourceSystemId = 14  --Source System as GXLP
		    AND DimProcessPeriodID = 202203 --Only for March 2022
		    --AND DimDataHistoryId = 3226 -- 28th March, 2022 Partition (198579)
	     ) T GROUP BY DimDataHistoryId210,DimProcessedDateID210,DimProcessPeriodID210,DimSourceSystemId210
		 )F Join DWH.DimDataHistory H
 ON DimDataHistoryId210 = DimDataHistoryId
 ORDER BY DimDataHistoryId210    