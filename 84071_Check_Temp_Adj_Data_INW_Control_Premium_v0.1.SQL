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

SELECT 'INW_Control_Premium' as TableName, '84071 - Remove Temporary Adjustment from Inward Facts' as UserStory , @INT_DataHistoryId as DataHistoryId,AdjustmentType, COUNT(*) as TotalRecords, GetDate() as TestedOn
       ,Case WHEN UPPER(AdjustmentType) NOT LIKE '%TEMPORARAY%' 
	         THEN 'Passed' 
			 ELSE 'Failed'
		 End as TestResult
  FROM (

    SELECT D.DimAdjustmentID, D.AdjustmentType, D.IsAdjusted,FSP.DimDWHAdjustmentID,
	       FSP.DimProcessPeriodID / 100 AS [REPORTING_YEAR],
           (FSP.DimProcessPeriodID % 100 - 1) / 3 + 1 AS [REPORTING_QUARTER],
           'M' AS [PERIOD_TYPE],
           FSP.DimProcessPeriodID % 100 AS [PERIOD_NUMBER],
           DPL.[First_DimPolicyLineID] AS [RISK_ID],
           dgc.First_DimGroupClassID AS CLASS_ID,
           CASE
               WHEN FSP.DimPolicyYOAID = 0 THEN
                   FSP.DimYOAID
               ELSE
                   FSP.DimPolicyYOAID
           END AS [UW_YEAR],
           [DSC].[MasterDataCurrencyISOCode] AS [SETT_CCY_CODE],
           [DOC].[MasterDataCurrencyISOCode] AS [ORIG_CCY_CODE],
           SUM([FSP].[GrossNetGrossSignedPremiumOrigCcy]) AS [PAID_TOTAL_ORIG_CCY],
           SUM([FSP].[GrossNetGrossSignedPremiumSettCcy]) AS [PAID_TOTAL_SETT_CCY],
           RF.[BureauNonBureauSwitch] AS REPORTING_FLAG
    FROM [Eclipse_MI].[FactSignedTransaction] FSP
	INNER JOIN #UnAdjusted D ON D.DimAdjustmentID=FSP.DimDWHAdjustmentID
        INNER JOIN [Eclipse_MI].[DimPolicyLine] DPL
            ON FSP.[DimPolicyLineID] = DPL.[DimPolicyLineID]
        INNER JOIN [Eclipse_MI].[DimCurrency] DSC
            ON [DSC].[DimCurrencyID] = [FSP].[DimSettlementCcyID]
        INNER JOIN [Eclipse_MI].[DimCurrency] DOC
            ON DOC.[DimCurrencyID] = [FSP].[DimOriginalCurrencyID]
        INNER JOIN Eclipse_MI.DimGroupClass dgc
            ON FSP.DimGroupClassID = dgc.DimGroupClassID
        INNER JOIN [Eclipse_MI].DimPolicyStatus DPS
            ON DPL.DimPolicyStatusID = DPS.DimPolicyStatusID
    INNER JOIN (SELECT * FROM [Eclipse_EXT].[fn_LatestRITCBureauNonBureauSwitch]()) RF
			ON RF.DimBureauNonBureauSwitchCategoryID = FSP.DimBureauNonBureauSwitchCategoryID
	WHERE FSP.DimDataHistoryID = @int_DataHistoryId                                                
          AND FSP.DimYOAID >= 1993
          AND DPS.PolicyActiveStatus = 'Active'
    GROUP BY D.DimAdjustmentID, D.AdjustmentType, D.IsAdjusted,FSP.DimDWHAdjustmentID,  
	        RF.[BureauNonBureauSwitch], 
			FSP.DimProcessPeriodID / 100,
             (FSP.DimProcessPeriodID % 100 - 1) / 3 + 1,
             FSP.DimProcessPeriodID % 100,
             DPL.[First_DimPolicyLineID],
             [DSC].[MasterDataCurrencyISOCode],
             [DOC].[MasterDataCurrencyISOCode],
             dgc.First_DimGroupClassID,
             CASE
                 WHEN FSP.DimPolicyYOAID = 0 THEN
                     FSP.DimYOAID
                 ELSE
                     FSP.DimPolicyYOAID
             END
    HAVING SUM([FSP].[GrossNetGrossSignedPremiumOrigCcy]) <> 0
           OR SUM([FSP].[GrossNetGrossSignedPremiumSettCcy]) <> 0
	) T GROUP BY AdjustmentType
