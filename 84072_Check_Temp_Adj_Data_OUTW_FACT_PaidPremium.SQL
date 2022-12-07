-- *******************************************************************
--Check Temporary Adjustment Data for Outward FACT_PaidPremium table 
--Input Parameter - DimDataHistoryId 
-- *******************************************************************

USE [MyMI_DataWarehouse]
GO


DROP TABLE IF EXISTS #UnAdjusted 
;

DECLARE @int_DataHistoryId AS INT
    SET @int_DataHistoryId = 3404 -- Change the DataHistoryId before run this query
;

	-- Get unadjusted references
select dimadjustmentid, d.adjustmenttype, d.isadjusted
  into #unadjusted 
  from [dwh].[dimadjustment] d
 where d.isadjusted = 'Unadjusted' --UNADJUSTED DATA
          OR 
   --(D.AdjustmentType like '%Permanent%' AND D.DimEclipseAdjustmentID <> 0)
   (D.AdjustmentType like '%Permanent%' AND D.DimORIAdjustmentID <> 0);
;

select @@ServerName as Server, 'OUTW_FACTPaidPremium' as TableName,'84072 - Remove Temporary Adjustment from Outward Facts' as UserStory
      ,@INT_DataHistoryId as DataHistoryId
	  ,AdjustmentType
      ,count(*) as TotalRecords
	  ,GetDate() as TestedOn
      ,Case when UPPER(AdjustmentType) NOT LIKE '%TEMPORARAY%' 
      	    then 'Passed' 
      		ELSE 'Failed'
      	End as TestResult
  from (
  
        -- Code from RITX_EXT.OUTW_Fact_PaidPremium sored PROCEDURE
		
         SELECT DISTINCT
	FT.[DimProcessPeriodID]/100 AS [REPORTING_YEAR],
	UA.AdjustmentType,
	(FT.[DimProcessPeriodID]%100-1)/3+1 AS [REPORTING_QUARTER],
	'M' AS [PERIOD_TYPE],
	FT.[DimProcessPeriodID]%100 AS [PERIOD_NUMBER],
	CAST(dd.Date AS Date) AS [TRANSACTION_DATE],
	CASE WHEN op.DimORIContractID=-3 THEN -3 ELSE  OP.[First_DimORIContractID] END AS [RI_CONTRACT_ID],
	dgc.First_DimGroupClassID AS [CLASS_ID], 
	CASE WHEN FT.DimPolicyYOAID=0 then FT.DimYOAID ELSE FT.DimPolicyYOAID END AS [UW_YEAR],
	[OP].[ORIReinsurerCode] AS [LORS_CODE],
	DC.[LloydsRiskCode] AS [LLOYDS_RISK_CODE],
	'A' AS [ADVISED_OR_CASH],
	[DSC].[MasterDataCurrencyISOCode] AS [SETT_CCY_CODE],
	CASE WHEN OP.[ORIContractType] IN ('FP','FX') THEN DP.[PolicyReference] ELSE 'UNK' END AS [INWARDS_REFERENCE],
	SUM([FT].[ORISignedPremiumPaidSettCcy]) AS [PAID_TOTAL_MVT],
	dlf.ORILegatumFlag AS [REPORTING_FLAG]

FROM [DWH_MI].[FactORITransaction] FT
INNER JOIN #UnAdjusted UA ON UA.DimAdjustmentID = FT.DimAdjustmentID
INNER JOIN DWH.DimORILegatumFlag dlf ON dlf.DimORILegatumFlagID=FT.DimORILegatumFlagID

INNER JOIN DWH_MI.DimDate DD 
ON DD.DimDateID=FT.DimTransactionDateID

INNER JOIN [DWH_MI].[DimORIPlacement] OP
	ON OP.[DimORIPlacementID] =FT.[DimORIPlacementID]

 JOIN DWH_MI.DimClaimEvent dce
            ON FT.DimORIClaimSubEventID_DimClaimEventCatastropheID = dce.DimORIClaimSubEventID_DimClaimEventCatastropheID
        JOIN DWH.DimGroupClass dgc
            ON FT.DimGroupClassID = dgc.DimGroupClassID

INNER JOIN DWH.DimPolicy DP ON DP.DimPolicyID = FT.DimPolicyID

LEFT JOIN [DWH_MI].[DimCode] DC
	ON DC.DimCodeID = FT.[DimCodeID]

LEFT JOIN [DWH_MI].[DimCurrency] DSC
	ON [DSC].[DimCurrencyID] = FT.[DimSettlementCurrencyID]
	
 WHERE dlf.ORILegatumFlag <> 'Retained' AND FT.DimDataHistoryID = @int_DataHistoryId 
GROUP BY
	FT.[DimProcessPeriodID],
	UA.AdjustmentType,
	dd.Date,
	case when op.DimORIContractID=-3 then -3 Else  OP.[First_DimORIContractID] END,
	CASE WHEN OP.[ORIContractType] IN ('FP','FX') THEN DP.[PolicyReference] ELSE 'UNK' END,
	[OP].[ORIReinsurerCode],
	DC.[LloydsRiskCode],
	[DSC].[MasterDataCurrencyISOCode] 
         ,    dgc.First_DimGroupClassID
	, CASE WHEN FT.DimPolicyYOAID=0 then FT.DimYOAID ELSE FT.DimPolicyYOAID END
	,dlf.ORILegatumFlag
HAVING SUM([FT].[ORISignedPremiumPaidSettCcy])  <> 0
		 
	    ) T group by adjustmenttype 