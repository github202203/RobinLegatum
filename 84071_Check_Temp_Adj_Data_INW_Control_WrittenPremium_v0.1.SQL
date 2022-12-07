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


SELECT 'INW_Control_WrittenPremium' as TableName, '84071 - Remove Temporary Adjustment from Inward Facts' as UserStory , @INT_DataHistoryId as DataHistoryId,AdjustmentType, COUNT(*) as TotalRecords, GetDate() as TestedOn
       ,Case WHEN UPPER(AdjustmentType) NOT LIKE '%TEMPORARAY%' 
	         THEN 'Passed' 
			 ELSE 'Failed'
		 End as TestResult
  FROM (	
--	WITH CTE AS

	SELECT DimAdjustmentID, AdjustmentType, IsAdjusted,DimDWHAdjustmentID,
	cte.REPORTING_YEAR,
	cte.REPORTING_QUARTER,cte.PERIOD_TYPE,cte.PERIOD_NUMBER,cte.RISK_ID,cte.CLASS_ID,cte.UW_YEAR,
	cte.SETT_CCY_CODE,cte.ORIG_CCY_CODE,
	sum(cte.PREM_TOTAL_ORIG_CCY) as PREM_TOTAL_ORIG_CCY,
	sum(cte.PREM_100PctTOTAL_ORIG_CCY) as PREM_100PctTOTAL_ORIG_CCY,
	sum(cte.PREM_TOTAL_SETT_CCY) as PREM_TOTAL_SETT_CCY,
	sum(cte.PREM_100PctTOTAL_SETT_CCY) as PREM_100PctTOTAL_SETT_CCY,
	cte.REPORTING_FLAG
	FROM 
	(
		SELECT DISTINCT D.DimAdjustmentID, D.AdjustmentType, D.IsAdjusted,FWP.DimDWHAdjustmentID,
			FWP.[DimProcessPeriodID]/100 AS [REPORTING_YEAR],
			(FWP.[DimProcessPeriodID]%100-1)/3+1 AS [REPORTING_QUARTER],
			'M' AS [PERIOD_TYPE],
			FWP.[DimProcessPeriodID]%100 AS [PERIOD_NUMBER],	
			DPL.[First_DimPolicyLineID] AS [RISK_ID],
			DGC.First_DimGroupClassID AS [CLASS_ID] ,
			CASE WHEN FWP.DimPolicyYOAID =0 then FWP.DimYOAID ELSE FWP.DimPolicyYOAID END AS [UW_YEAR],
			[DSC].[MasterDataCurrencyISOCode] AS [SETT_CCY_CODE],
			[DOC].[MasterDataCurrencyISOCode] AS [ORIG_CCY_CODE],	
			dc.LloydsRiskCode ,
			CAST(DD.date as Date)  AS [TRANSACTION_DATE], 
			SUM([FWP].GrossGrossWrittenPremiumOrigCcy) AS [PREM_TOTAL_ORIG_CCY],
			[FWP1].[GrossGrossWrittenPremium100PctOrigCcy] AS [PREM_100PctTOTAL_ORIG_CCY],
			SUM(Fwp.GrossGrossWrittenPremiumSettCcy) AS [PREM_TOTAL_SETT_CCY],
			FWP1.GrossGrossWrittenPremium100PctSettCcy AS [PREM_100PctTOTAL_SETT_CCY],
			--NULL AS [VALID_FROM_LOAD]
			RF.[BureauNonBureauSwitch] AS [REPORTING_FLAG]
		FROM Eclipse_MI.[FactWrittenPremium] FWP
		INNER JOIN #UnAdjusted D ON D.DimAdjustmentID=FWP.DimDWHAdjustmentID
		LEFT JOIN
		(	SELECT fct.DimPolicyID,DimProcessPeriodID,DimTransactionDateID,DimSettlementCurrencyID,DimOriginalCurrencyID,DimBureauNonBureauSwitchCategoryID
			,SUM(GrossGrossWrittenPremium100PctOrigCcy) AS [GrossGrossWrittenPremium100PctOrigCcy],SUM(GrossGrossWrittenPremium100PctSettCcy) AS [GrossGrossWrittenPremium100PctSettCcy]
			 FROM Eclipse_MI.[FactWrittenPremium100Pct] fct	
			 WHERE FCT.[DimDataHistoryID] = @int_DataHistoryId
			 GROUP BY fct.DimPolicyID,DimProcessPeriodID,DimTransactionDateID,DimSettlementCurrencyID,DimOriginalCurrencyID,DimBureauNonBureauSwitchCategoryID
		) fWP1 
		ON fWP.DimPolicyID=fWP1.DimPolicyID
			AND fwp.DimProcessPeriodID=fwp1.DimProcessPeriodID and fwp.DimTransactionDateID=fWP1.DimTransactionDateID and fwp.DimSettlementCurrencyID=fwp1.DimSettlementCurrencyID
			AND fwp.DimOriginalCurrencyID=fwp1.DimOriginalCurrencyID and fwp.DimBureauNonBureauSwitchCategoryID=fwp1.DimBureauNonBureauSwitchCategoryID

		INNER JOIN [Eclipse_MI].[DimPolicyLine] DPL
			ON FWP.[DimPolicyLineID] = DPL.[DimPolicyLineID]
	
		INNER JOIN [Eclipse_MI].[DimGroupClass] DGC ON
			[DGC].[DimGroupClassID] = [FWP].[DimGroupClassID]

		INNER JOIN [Eclipse_MI].[DimCode] DC
			ON DC.[DimCodeID] = FWP.[DimCodeID]
	
		INNER JOIN [Eclipse_MI].[DimCurrency] DSC
			ON [DSC].[DimCurrencyID] = [FWP].DimSettlementCurrencyID
	
		INNER JOIN [Eclipse_MI].[DimCurrency] DOC
			ON DOC.[DimCurrencyID] = [FWP].[DimOriginalCurrencyID]
	
		INNER JOIN [Eclipse_MI].DimPolicyStatus DPS
			ON DPL.DimPolicyStatusID = dps.DimPolicyStatusID

		INNER JOIN Eclipse_MI.DimDate DD
			ON DD.DimDateID=FWP.DimTransactionDateID 
		INNER JOIN (SELECT * FROM [Eclipse_EXT].[fn_LatestRITCBureauNonBureauSwitch]()) RF
			ON RF.DimBureauNonBureauSwitchCategoryID = FWP.DimBureauNonBureauSwitchCategoryID
		
		WHERE FWP.DimDataHistoryID = @int_DataHistoryId        -- and DPL.[First_DimPolicyLineID] = 52032                                       
		AND DPS.PolicyActiveStatus ='Active'
		GROUP BY D.DimAdjustmentID, D.AdjustmentType, D.IsAdjusted,FWP.DimDWHAdjustmentID,
			RF.[BureauNonBureauSwitch],
			FWP.[DimProcessPeriodID],	
			DPL.[First_DimPolicyLineID],
			[DSC].[MasterDataCurrencyISOCode],
			[DOC].[MasterDataCurrencyISOCode],
			 DGC.First_DimGroupClassID	
			 ,dc.LloydsRiskCode
			 ,FWP1.GrossGrossWrittenPremium100PctSettCcy
			,[FWP1].[GrossGrossWrittenPremium100PctOrigCcy]
			,DD.DATE
			, CASE WHEN FWP.DimPolicyYOAID =0 then FWP.DimYOAID ELSE FWP.DimPolicyYOAID END
	) CTE
	group by DimAdjustmentID, AdjustmentType, IsAdjusted,DimDWHAdjustmentID,
	cte.REPORTING_YEAR,
	cte.REPORTING_QUARTER,cte.PERIOD_TYPE,cte.PERIOD_NUMBER,cte.RISK_ID,cte.CLASS_ID,cte.UW_YEAR,
	cte.SETT_CCY_CODE,cte.ORIG_CCY_CODE,cte.REPORTING_FLAG
	having  sum(cte. [PREM_TOTAL_ORIG_CCY])<>0 or sum([PREM_100PctTOTAL_ORIG_CCY])<>0 or
	sum(cte. [PREM_TOTAL_SETT_CCY])<>0 or sum([PREM_100PctTOTAL_SETT_CCY])<>0	
)T GROUP By AdjustmentType
