---OUTW_FACTPaidClaim 
-- *******************************************************************
--Check Temporary Adjustment Data for Outward FACT_PaidClaim table 
--Input Parameter - DimDataHistoryId 
-- *******************************************************************

USE [MyMI_DataWarehouse]
GO


DROP TABLE IF EXISTS #UnAdjusted 
;

DECLARE @int_DataHistoryId AS INT
    SET @int_DataHistoryId = 3376 -- Change the DataHistoryId before run this query
;

-- Get unadjusted references
select dimadjustmentid, d.adjustmenttype, d.isadjusted,MDSAdjustmentReference
  into #unadjusted 
  from [dwh].[dimadjustment] d
 where d.isadjusted = 'Unadjusted' --UNADJUSTED DATA
       or 
      (D.AdjustmentType like '%Permanent%' AND D.DimEclipseAdjustmentID <> 0)
;

--select * from #unadjusted

--Display the results in Details with records

select 'OUTW_FACTPaidClaim' as TableName
      ,'84072 - Remove Temporary Adjustment from Outward Facts' as UserStory
      ,@INT_DataHistoryId   as DataHistoryId
	  ,T.*
      ,Case when UPPER(AdjustmentType) NOT LIKE '%TEMPORARY%'  then 'Passed' else 'Failed'	End as TestResult
  from (

--Display the results in Summary
/*
select 'OUTW_FACTPaidClaim' as TableName
      ,'84072 - Remove Temporary Adjustment from Outward Facts' as UserStory
      ,@INT_DataHistoryId   as DataHistoryId
      ,AdjustmentType
	  ,MDSAdjustmentReference
      ,count(*) as TotalRecords
	  ,GetDate() as TestedOn
      ,Case when UPPER(AdjustmentType) NOT LIKE '%TEMPORARY%'  then 'Passed' else 'Failed'	End as TestResult
  from (
*/  
  -- Code from RITX_EXT.OUTW_Fact_PaidClaim stored PROCEDURE
  
        select DISTINCT
                ft.[DimProcessPeriodID] / 100 AS [REPORTING_YEAR]
				,ft.DimORILegatumFlagID
				,ua.DimAdjustmentID  as UA_DimAdjustmentId
				,ft.DimAdjustmentID  as FT_DimAdjustmentId
		       ,ua.MDSAdjustmentReference
		       ,ua.AdjustmentType
               ,(ft.[DimProcessPeriodID] % 100 - 1) / 3 + 1 AS [REPORTING_QUARTER]
               ,'M' AS [PERIOD_TYPE]
               ,ft.[DimProcessPeriodID] % 100 AS [PERIOD_NUMBER]
               ,CAST(dd.Date AS DATE) AS [TRANSACTION_DATE]
               ,Case when op.DimORIContractID = -3 then -3 else op.[First_DimORIContractID]  End as [RI_CONTRACT_ID]
               ,Case when dce.First_DimORIClaimSubEventID = 0 then 0 else dce.First_DimORIClaimSubEventID+200000  end as [LOSS_EVENT_ID]
               ,dgc.First_DimGroupClassID AS [CLASS_ID]
               ,Case when ft.DimPolicyYOAID = 0 then ft.DimYOAID else ft.DimPolicyYOAID End AS [UW_YEAR]
               ,op.[ORIReinsurerCode] AS [LORS_CODE]
               ,dc.[LloydsRiskCode] AS [LLOYDS_RISK_CODE]
               ,dc.[TrustFundCode] AS [TRUST_FUND_CODE]
               ,'A' AS [ADVISED_OR_CASH]
               ,dsc.[MasterDataCurrencyISOCode] AS [SETT_CCY_CODE]
		       ,Case when op.[ORIContractType] IN ('FP','FX') then dp.[PolicyReference] else 'UNK' End AS [INWARDS_REFERENCE]
               ,SUM([FT].[ORIPaidClaimSettCcy]) AS [PAID_TOTAL_MVT]
               ,dlf.[ORILegatumFlag] AS [REPORTING_FLAG]
          from [DWH_MI].[FactORITransaction] ft
		 --inner join #UnAdjusted ua              on  ua.DimAdjustmentID = ft.DimAdjustmentID
		 Left join #UnAdjusted ua              on  ua.DimAdjustmentID = ft.DimAdjustmentID
		 inner join DWH_MI.DimDataHistory ddd   on  ft.DimDataHistoryID = ddd.DimDataHistoryID
		 inner join DWH.DimPolicy dp            on  dp.DimPolicyID = ft.DimPolicyID
         inner join DWH.DimORILegatumFlag dlf   on dlf.DimORILegatumFlagID = ft.DimORILegatumFlagID
         inner join DWH_MI.DimDate dd           on  dd.DimDateID = ft.DimTransactionDateID
               join DWH_MI.DimClaimEvent dce    on  ft.DimORIClaimSubEventID_DimClaimEventCatastropheID = dce.DimORIClaimSubEventID_DimClaimEventCatastropheID
               join DWH.DimGroupClass dgc       on  ft.DimGroupClassID = dgc.DimGroupClassID
          left join DWH_MI.[DimORIPlacement] op on  op.DimORIPlacementID = ft.DimORIPlacementID
          left join DWH_MI.[DimCode] DC         on  dc.DimCodeID = ft.DimCodeID
          left join DWH_MI.[DimCurrency] dsc    on dsc.DimCurrencyID = ft.DimSettlementCurrencyID
     where DLF.[ORILegatumFlag] <> 'Retained' AND FT.DimDataHistoryID = @int_DataHistoryId 
     group by ft.[DimProcessPeriodID] / 100
	        ,MDSAdjustmentReference
			,ft.DimAdjustmentID
			,ua.DimAdjustmentID
			,ft.DimORILegatumFlagID
	        ,AdjustmentType
            ,(ft.[DimProcessPeriodID] % 100 - 1) / 3 + 1
            ,ft.[DimProcessPeriodID] % 100
            ,dd.Date
            ,Case when OP.DimORIContractID = -3 then -3 else op.[First_DimORIContractID] End
            ,dlf.[ORILegatumFlag]
            ,op.[ORIReinsurerCode]
            ,dc.[LloydsRiskCode]
            ,dsc.[MasterDataCurrencyISOCode]
            ,dc.[TrustFundCode]
            ,case when dce.First_DimORIClaimSubEventID = 0 then 0 else dce.First_DimORIClaimSubEventID + 200000 end
            ,dgc.First_DimGroupClassID
            ,Case when ft.DimPolicyYOAID = 0 then ft.DimYOAID else ft.DimPolicyYOAID End
			,Case when op.[ORIContractType] IN ('FP','FX') then dp.[PolicyReference] else 'UNK' End
    having SUM([ft].[ORIPaidClaimSettCcy]) <> 0
	--) T group by adjustmenttype, MDSAdjustmentReference --Display the results in Summary
	) T --Display the results in Details


