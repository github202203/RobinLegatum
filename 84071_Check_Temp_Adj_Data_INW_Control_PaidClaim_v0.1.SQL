USE [MyMI_DataWarehouse]
GO


DROP TABLE IF EXISTS #UnAdjusted 
;

DECLARE @int_DataHistoryId AS INT
    SET @int_DataHistoryId = 3300
;


	-- Get unadjusted references
SELECT  DimAdjustmentID, D.AdjustmentType, D.IsAdjusted
  INTO #UnAdjusted 
  FROM [DWH].[DimAdjustment] D
 WHERE D.ISAdjusted = 'Unadjusted' --UNADJUSTED DATA
     OR (D.AdjustmentType like '%Permanent%' AND D.DimEclipseAdjustmentID <> 0);

SELECT 'INW_Control_PaidClaim' as TableName, '84071 - Remove Temporary Adjustment from Inward Facts' as UserStory , @INT_DataHistoryId as DataHistoryId,AdjustmentType, COUNT(*) as TotalRecords, GetDate() as TestedOn
       ,Case WHEN UPPER(AdjustmentType) NOT LIKE '%TEMPORARAY%' 
	         THEN 'Passed' 
			 ELSE 'Failed'
		 End as TestResult
  FROM (


	SELECT D.DimAdjustmentID, D.AdjustmentType, D.IsAdjusted,FCC.DimDWHAdjustmentID,
		FCC.[DimProcessPeriodID]/100 AS [REPORTING_YEAR],
		(FCC.[DimProcessPeriodID]%100-1)/3+1 AS [REPORTING_QUARTER],
		'M' AS [PERIOD_TYPE],
		FCC.[DimProcessPeriodID]%100 AS [PERIOD_NUMBER],
		DC.[First_DimclaimID] AS [CLAIM_ID],
		dgc.First_DimGroupClassID AS CLASS_ID ,
		DCE.First_DimClaimEventCatastropheID AS [LOSS_EVENT_ID],
		CASE WHEN FCC.DimPolicyYOAID =0 then FCC.DimYOAID ELSE FCC.DimPolicyYOAID END AS [UW_YEAR],
		[DSC].[MasterDataCurrencyISOCode] AS [SETT_CCY_CODE],
		[DOC].[MasterDataCurrencyISOCode] AS [ORIG_CCY_CODE],
		SUM(FCC.[PaidClaimSettCcy]) AS [PAID_TOTAL_MVT_SETT_CCY],
		SUM(FCC.[PaidClaimOrigCcy]) AS [PAID_TOTAL_MVT_ORIG_CCY],
		RF.[BureauNonBureauSwitch] AS REPORTING_FLAG
	
	FROM  [Eclipse_MI].[FactClaimTransaction] FCC
	INNER JOIN #UnAdjusted D ON D.DimAdjustmentID=FCC.DimDWHAdjustmentID
	INNER JOIN [Eclipse_MI].[DimClaim] DC
		ON DC.[DimclaimID] = FCC.[DimClaimID]

	INNER JOIN Eclipse_MI.DimClaimEvent DCE
		ON DCE.DimClaimEventCatastropheID=FCC.DimClaimEventCatastropheID

	INNER JOIN [Eclipse_MI].[DimCurrency] DSC
		ON [DSC].[DimCurrencyID] = FCC.[DimSettlementCurrencyID]

	INNER JOIN [Eclipse_MI].[DimCurrency] DOC
		ON DOC.[DimCurrencyID] = FCC.[DimOriginalCurrencyID]	
		INNER JOIN Eclipse_MI.DimGroupClass dgc
						ON FCC.DimGroupClassID = dgc.DimGroupClassID
					
	INNER JOIN [Eclipse_MI].[DimPolicyLine] DPL
		ON FCC.[DimPolicyLineID] = DPL.[DimPolicyLineID]
							INNER JOIN [Eclipse_MI].DimPolicyStatus DPS
		ON DPL.DimPolicyStatusID = dps.DimPolicyStatusID
	INNER JOIN (SELECT * FROM [Eclipse_EXT].[fn_LatestRITCBureauNonBureauSwitch]()) RF
			ON RF.DimBureauNonBureauSwitchCategoryID = FCC.DimBureauNonBureauSwitchCategoryID
	WHERE FCC.DimDataHistoryID = @int_DataHistoryId
		AND FCC.DimYOAID>=1993																	
		AND dps.PolicyActiveStatus ='Active'
	GROUP BY DimAdjustmentID,D.AdjustmentType,D.IsAdjusted,FCC.DimDWHAdjustmentID,
		FCC.DimProcessPeriodID / 100  ,
						( FCC.DimProcessPeriodID % 100 - 1 ) / 3 + 1   , 
						FCC.DimProcessPeriodID % 100,
		RF.[BureauNonBureauSwitch],
		DC.[First_DimclaimID],
		[DSC].[MasterDataCurrencyISOCode],
		[DOC].[MasterDataCurrencyISOCode] ,
		dgc.First_DimGroupClassID 
		, CASE WHEN FCC.DimPolicyYOAID =0 then FCC.DimYOAID ELSE FCC.DimPolicyYOAID END
		, DCE.First_DimClaimEventCatastropheID

		--HAVING
        --SUM(FCC.[PaidClaimSettCcy]) <> 0
		--OR SUM(FCC.[PaidClaimOrigCcy]) <> 0

    )T GROUP BY AdjustmentType