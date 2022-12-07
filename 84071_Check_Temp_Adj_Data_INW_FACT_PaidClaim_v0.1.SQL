
USE MyMI_DataWarehouse
GO


DROP TABLE IF EXISTS #UnAdjusted 
;

DECLARE @int_DataHistoryId AS INT
    SET @int_DataHistoryId = 3308
;


-- Get unadjusted references
SELECT  DimAdjustmentID, D.AdjustmentType, D.IsAdjusted
 INTO #UnAdjusted 
 FROM DWH.DimAdjustment D
WHERE D.ISAdjusted = 'Unadjusted' --UNADJUSTED DATA
      OR (D.AdjustmentType like '%Permanent%' AND D.DimEclipseAdjustmentID<>0);

WITH CTE AS
(
    SELECT D.DimAdjustmentID, D.AdjustmentType, D.IsAdjusted,FCC.DimDWHAdjustmentID,
    	   FCC.DimProcessPeriodID/100 			AS REPORTING_YEAR
    	  ,(FCC.DimProcessPeriodID%100-1)/3+1 	AS REPORTING_QUARTER
    	  ,'M' 									AS PERIOD_TYPE
    	  ,FCC.DimProcessPeriodID%100 			AS PERIOD_NUMBER
    	  ,CAST(DD.date as Date)  				AS TRANSACTION_DATE
    	  ,DC.First_DimclaimID 					AS CLAIM_ID
    	  ,DCE.First_DimClaimEventCatastropheID AS LOSS_EVENT_ID  
    	  ,DPL.First_DimPolicyLineID 			AS RISK_ID
    	  ,dgc.First_DimGroupClassID 			AS CLASS_ID 
    	  ,CASE WHEN FCC.DimPolicyYOAID = 0 
		        THEN FCC.DimYOAID 
				ELSE FCC.DimPolicyYOAID 
			END 								AS UW_YEAR 
    	  ,DSC.MasterDataCurrencyISOCode        AS SETT_CCY_CODE
    	  ,DOC.MasterDataCurrencyISOCode        AS ORIG_CCY_CODE
    	  ,DCD.LloydsRiskCode 					AS LLOYDS_RISK_CODE
    	  ,DCD.TrustFundCode 					AS TRUST_FUND_CODE
    	  ,CASE WHEN FCC.PaidLossFundSettCcy = 0 
		        THEN 'Cash' 
				ELSE 'Trust Fund' 
			END AS PAYMENT_TYPE
    	  ,DCD.FILCode2                         AS FIL_CODE_2
    	  ,DCD.FILCode4                         AS FIL_CODE_4
    	  ,DCD.FILCode 							AS FIL_CODE
    	  ,SUM(FCC.ExpensePaidClaimSettCcy) 	AS PAID_FEES_MVT_SETT_CCY
    	  ,SUM(FCC.RecoveryPaidClaimSettCcy) 	AS PAID_RECOVERY_MVT_SETT_CCY
    	  ,SUM(FCC.IndemnityPaidClaimSettCcy) 	AS PAID_INDEMNITY_MVT_SETT_CCY
    	  ,SUM(FCC.PaidClaimSettCcy)		 	AS PAID_TOTAL_MVT_SETT_CCY
    	  ,SUM(FCC.ExpensePaidClaimOrigCcy) 	AS PAID_FEES_MVT_ORIG_CCY
    	  ,SUM(FCC.RecoveryPaidClaimOrigCcy) 	AS PAID_RECOVERY_MVT_ORIG_CCY
    	  ,SUM(FCC.IndemnityPaidClaimOrigCcy) 	AS PAID_INDEMNITY_MVT_ORIG_CCY
    	  ,SUM(FCC.PaidClaimOrigCcy) 			AS PAID_TOTAL_MVT_ORIG_CCY
    	  ,RF.BureauNonBureauSwitch 			AS REPORTING_FLAG
    	
      FROM  Eclipse_MI.FactClaimTransaction FCC
     INNER JOIN #UnAdjusted D ON D.DimAdjustmentID=FCC.DimDWHAdjustmentID
     INNER JOIN Eclipse_MI.DimClaim DC ON DC.DimclaimID = FCC.DimClaimID
     INNER JOIN	Eclipse_MI.DimPolicyLine DPL ON FCC.DimPolicyLineID = DPL.DimPolicyLineID
     INNER JOIN Eclipse_MI.DimCode DCD ON DCD.DimCodeID = FCC.DimCodeID
     INNER JOIN Eclipse_MI.DimCurrency DSC ON DSC.DimCurrencyID = FCC.DimSettlementCurrencyID
     INNER JOIN Eclipse_MI.DimCurrency DOC ON DOC.DimCurrencyID = FCC.DimOriginalCurrencyID
     INNER JOIN Eclipse_MI.DimClaimEvent DCE ON DCE.DimClaimEventCatastropheID=FCC.DimClaimEventCatastropheID
     INNER JOIN Eclipse_MI.dimdate DD ON DD.DimDateID=FCC.DimTransactionDateID
     INNER JOIN Eclipse_MI.DimGroupClass DGC ON DGC.DimGroupClassID = FCC.DimGroupClassID
   	 INNER JOIN Eclipse_MI.DimPolicyStatus DPS ON DPL.DimPolicyStatusID = dps.DimPolicyStatusID
     INNER JOIN (SELECT * FROM Eclipse_EXT.fn_LatestRITCBureauNonBureauSwitch()) RF
      	     ON RF.DimBureauNonBureauSwitchCategoryID = FCC.DimBureauNonBureauSwitchCategoryID
     WHERE FCC.DimDataHistoryID = @int_DataHistoryId 
       AND FCC.DimYOAID >= 1993
       AND dps.PolicyActiveStatus ='Active'
     GROUP BY DimAdjustmentID,D.AdjustmentType,D.IsAdjusted,FCC.DimDWHAdjustmentID,
    	   FCC.DimProcessPeriodID
    	  ,dd.Date
    	  ,DC.First_DimclaimID
    	  ,DPL.First_DimPolicyLineID
    	  ,DSC.MasterDataCurrencyISOCode
    	  ,DOC.MasterDataCurrencyISOCode
    	  ,DCD.LloydsRiskCode
    	  ,DCD.TrustFundCode
    	  ,CASE WHEN FCC.PaidLossFundSettCcy =0 THEN 'Cash' ELSE 'Trust Fund' END
    	  ,FCC.PaidLossFundSettCcy
    	  ,DCD.FILCode2
    	  ,DCD.FILCode4
    	  ,DCD.FILCode
    	  ,dgc.First_DimGroupClassID
    	  ,DCE.First_DimClaimEventCatastropheID
    	  ,CASE WHEN FCC.DimPolicyYOAID = 0 
		        THEN FCC.DimYOAID ELSE FCC.DimPolicyYOAID END
    	  ,RF.BureauNonBureauSwitch
	 
	 )
	 
	 
SELECT 'INW_FACTPaidClaim' as TableName, '84071 - Remove Temporary Adjustment from Inward Facts' as UserStory , @INT_DataHistoryId as DataHistoryId,AdjustmentType, COUNT(*) as TotalRecords, GetDate() as TestedOn
,Case WHEN UPPER(AdjustmentType) NOT LIKE '%TEMPORARAY%' 
	         THEN 'Passed' 
			 ELSE 'Failed'
		 End as TestResult
  FROM ( 
	    SELECT DimAdjustmentID, AdjustmentType, IsAdjusted,FCC.DimDWHAdjustmentID,
	           FCC.REPORTING_YEAR, FCC.REPORTING_QUARTER,FCC.PERIOD_TYPE,FCC.PERIOD_NUMBER
	          ,FCC.TRANSACTION_DATE,FCC.CLAIM_ID,FCC.LOSS_EVENT_ID,FCC.RISK_ID,FCC.CLASS_ID
	          ,FCC.UW_YEAR,FCC.SETT_CCY_CODE,FCC.ORIG_CCY_CODE,FCC.LLOYDS_RISK_CODE,FCC.TRUST_FUND_CODE
	          ,FCC.PAYMENT_TYPE,FCC.FIL_CODE_2,FCC.FIL_CODE_4,FCC.FIL_CODE,SUM(FCC.PAID_FEES_MVT_SETT_CCY) as PAID_FEES_MVT_SETT_CCY
	          ,SUM(FCC.PAID_RECOVERY_MVT_SETT_CCY) as PAID_RECOVERY_MVT_SETT_CCY
	          ,SUM(FCC.PAID_INDEMNITY_MVT_SETT_CCY) as PAID_INDEMNITY_MVT_SETT_CCY 
	          ,SUM(FCC.PAID_TOTAL_MVT_SETT_CCY) as PAID_TOTAL_MVT_SETT_CCY
	          ,SUM(FCC.PAID_FEES_MVT_ORIG_CCY) as PAID_FEES_MVT_ORIG_CCY
	          ,SUM(FCC.PAID_RECOVERY_MVT_ORIG_CCY) as PAID_RECOVERY_MVT_ORIG_CCY
	          ,SUM(FCC.PAID_INDEMNITY_MVT_ORIG_CCY) as PAID_INDEMNITY_MVT_ORIG_CCY
	          ,SUM(FCC.PAID_TOTAL_MVT_ORIG_CCY) as PAID_TOTAL_MVT_ORIG_CCY
	          ,FCC.REPORTING_FLAG
	   FROM CTE FCC 
	   group by DimAdjustmentID, AdjustmentType, IsAdjusted,FCC.DimDWHAdjustmentID,
	   FCC.REPORTING_YEAR, fcc.REPORTING_QUARTER,fcc.PERIOD_TYPE,fcc.PERIOD_NUMBER,
	   fcc.TRANSACTION_DATE,fcc.CLAIM_ID,fcc.LOSS_EVENT_ID,fcc.RISK_ID,fcc.CLASS_ID,
	   fcc.UW_YEAR,fcc.SETT_CCY_CODE,fcc.ORIG_CCY_CODE,fcc.LLOYDS_RISK_CODE,fcc.TRUST_FUND_CODE,
	   fcc.PAYMENT_TYPE,fcc.FIL_CODE_2,fcc.FIL_CODE_4,fcc.FIL_CODE,fcc.REPORTING_FLAG
	   
	   having 
	   sum(FCC.PAID_FEES_MVT_SETT_CCY)      <> 0 OR 
	   sum(FCC.PAID_RECOVERY_MVT_SETT_CCY)  <> 0 OR 
	   sum(FCC.PAID_INDEMNITY_MVT_SETT_CCY) <> 0 OR 
	   sum(FCC.PAID_TOTAL_MVT_SETT_CCY)     <> 0 OR 
	   sum(FCC.PAID_FEES_MVT_ORIG_CCY)      <> 0 OR 
	   sum(FCC.PAID_RECOVERY_MVT_ORIG_CCY)  <> 0 OR 
	   sum(FCC.PAID_INDEMNITY_MVT_ORIG_CCY) <> 0 OR 
	   sum(FCC.PAID_TOTAL_MVT_ORIG_CCY)     <> 0
	)T GROUP BY ADJUSTMENTTYPE