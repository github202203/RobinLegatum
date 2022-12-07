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

	-- select * from #UnAdjusted


WITH CTE AS
(
   SELECT DISTINCT D.DimAdjustmentID, D.AdjustmentType, D.IsAdjusted,FWP.DimDWHAdjustmentID,
   	      FWP.DimProcessPeriodID/100 					AS REPORTING_YEAR
   	     ,(FWP.DimProcessPeriodID%100-1)/3+1 			AS REPORTING_QUARTER
   	     ,'M' 											AS PERIOD_TYPE
   	     ,FWP.DimProcessPeriodID%100 					AS PERIOD_NUMBER
   	     ,CAST(DD.date as Date)  						AS TRANSACTION_DATE 
   	     ,DPL.First_DimPolicyLineID 					AS RISK_ID
   	     ,dgc.First_DimGroupClassID 					AS CLASS_ID 
   	     ,CASE WHEN FWP.DimPolicyYOAID = 0 
		       THEN FWP.DimYOAID 
			   ELSE FWP.DimPolicyYOAID 
		   END 											AS UW_YEAR
   	     ,DSC.MasterDataCurrencyISOCode 				AS SETT_CCY_CODE
   	     ,DOC.MasterDataCurrencyISOCode 				AS ORIG_CCY_CODE
   	     ,DC.LloydsRiskCode 							AS LLOYDS_RISK_CODE
   	     ,SUM(FWP.GrossGrossWrittenPremiumOrigCcy) 		AS PREM_TOTAL_ORIG_CCY
   	     ,FWP1.GrossGrossWrittenPremium100PctOrigCcy 	AS PREM_100PctTOTAL_ORIG_CCY
   	     ,SUM(Fwp.GrossGrossWrittenPremiumSettCcy) 		AS PREM_TOTAL_SETT_CCY
   	     ,FWP1.GrossGrossWrittenPremium100PctSettCcy 	AS PREM_100PctTOTAL_SETT_CCY
   	     ,RF.BureauNonBureauSwitch 						AS REPORTING_FLAG
   FROM Eclipse_MI.FactWrittenPremium FWP
   INNER JOIN #UnAdjusted D ON D.DimAdjustmentID=FWP.DimDWHAdjustmentID
    Left Join ( SELECT fct.DimPolicyID,DimProcessPeriodID,DimTransactionDateID,DimSettlementCurrencyID,DimOriginalCurrencyID,DimBureauNonBureauSwitchCategoryID
                      ,SUM(GrossGrossWrittenPremium100PctOrigCcy) AS GrossGrossWrittenPremium100PctOrigCcy
	 				  ,SUM(GrossGrossWrittenPremium100PctSettCcy) AS GrossGrossWrittenPremium100PctSettCcy
   	              FROM Eclipse_MI.FactWrittenPremium100Pct fct  
				 WHERE FCT.DimDataHistoryID = @int_DataHistoryId
   	             GROUP BY fct.DimPolicyID,DimProcessPeriodID,DimTransactionDateID,DimSettlementCurrencyID,DimOriginalCurrencyID,DimBureauNonBureauSwitchCategoryID
   	           ) fWP1 
		   on fWP.DimPolicyID=fWP1.DimPolicyID
   	      AND fwp.DimProcessPeriodID=fwp1.DimProcessPeriodID 
		  AND fwp.DimTransactionDateID=fWP1.DimTransactionDateID 
		  AND fwp.DimSettlementCurrencyID=fwp1.DimSettlementCurrencyID
   	      AND fwp.DimOriginalCurrencyID=fwp1.DimOriginalCurrencyID 
		  AND fwp.DimBureauNonBureauSwitchCategoryID=fwp1.DimBureauNonBureauSwitchCategoryID
   
   INNER JOIN Eclipse_MI.DimPolicyLine DPL   ON FWP.DimPolicyLineID = DPL.DimPolicyLineID
   INNER JOIN Eclipse_MI.DimGroupClass DGC   ON DGC.DimGroupClassID = FWP.DimGroupClassID
   INNER JOIN Eclipse_MI.DimCurrency DSC     ON DSC.DimCurrencyID = FWP.DimSettlementCurrencyID
   INNER JOIN Eclipse_MI.DimCurrency DOC   	 ON DOC.DimCurrencyID = FWP.DimOriginalCurrencyID
   INNER JOIN Eclipse_MI.DimPolicyStatus DPS ON DPS.DimPolicyStatusID = DPL.DimPolicyStatusID     
   INNER JOIN Eclipse_MI.DimCode DC    	     ON DC.DimCodeID = FWP.DimCodeID
   INNER JOIN Eclipse_MI.DimDate DD    	     ON DD.DimDateID=FWP.DimTransactionDateID 
   INNER JOIN (SELECT * FROM Eclipse_EXT.fn_LatestRITCBureauNonBureauSwitch()) RF
   	       ON RF.DimBureauNonBureauSwitchCategoryID = FWP.DimBureauNonBureauSwitchCategoryID
   
   WHERE 
        FWP.DimDataHistoryID = @int_DataHistoryId 
   	 and dps.PolicyActiveStatus='Active'
   GROUP BY DimAdjustmentID, AdjustmentType, D.IsAdjusted,DimDWHAdjustmentID
   	       ,FWP.DimProcessPeriodID
   	       ,DD.Date
   	       ,DPL.First_DimPolicyLineID
   	       ,DSC.MasterDataCurrencyISOCode
   	       ,DOC.MasterDataCurrencyISOCode
   	       ,DC.LloydsRiskCode 
   	       ,dgc.First_DimGroupClassID
   	       ,FWP1.GrossGrossWrittenPremium100PctSettCcy	
   	       ,FWP1.GrossGrossWrittenPremium100PctOrigCcy
   	       ,CASE WHEN FWP.DimPolicyYOAID = 0 THEN FWP.DimYOAID ELSE FWP.DimPolicyYOAID END
   	       ,RF.BureauNonBureauSwitch
)

SELECT 'INW_FACTWrittenPremium' as TableName,'84071 - Remove Temporary Adjustment from Inward Facts' as UserStory, @INT_DataHistoryId as DataHistoryId,AdjustmentType, COUNT(*) as TotalRecords, GetDate() as TestedOn
      ,Case WHEN UPPER(AdjustmentType) NOT LIKE '%TEMPORARAY%' 
      	         THEN 'Passed' 
      			 ELSE 'Failed'
      		 End as TestResult
  FROM (
        SELECT CTE.* 
          FROM CTE 
         WHERE CTE. PREM_TOTAL_ORIG_CCY <> 0 
                    or 
        			PREM_100PctTOTAL_ORIG_CCY <> 0 
        			or CTE.PREM_100PctTOTAL_SETT_CCY <> 0 
        			or PREM_TOTAL_SETT_CCY <> 0
        ) T GROUP By AdjustmentType 
