-- *******************************************************************
--Check Temporary Adjustment Data for Outward FACT_OSClaim table 
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
   --(D.AdjustmentType like '%Permanent%' AND D.DimEclipseAdjustmentID<>0)
   (D.AdjustmentType like '%Permanent%' AND D.DimORIAdjustmentID <> 0);
;

select @@ServerName as Server, 'OUTW_FACTOSClaim' as TableName,'84072 - Remove Temporary Adjustment from Outward Facts' as UserStory
      ,@INT_DataHistoryId as DataHistoryId
	  ,AdjustmentType
      ,count(*) as TotalRecords
	  ,GetDate() as TestedOn
      ,Case when UPPER(AdjustmentType) NOT LIKE '%TEMPORARAY%' 
      	    then 'Passed' 
      		ELSE 'Failed'
      	End as TestResult
  from (
  
  -- Code from RITX_EXT.OUTW_Fact_OSClaim stored PROCEDURE
        select distinct 
		       FT.[DimProcessPeriodID]/100                        as [REPORTING_YEAR]
			  ,UA.AdjustmentType                                  as AdjustmentType
        	  ,(FT.[DimProcessPeriodID]%100-1)/3+1                as [REPORTING_QUARTER]
        	  ,'M'                                                as [PERIOD_TYPE]
        	  ,FT.[DimProcessPeriodID]%100                        as [PERIOD_NUMBER]
        	  ,cast(dd.Date AS Date)                              as [TRANSACTION_DATE]
        	  ,case when op.DimORIContractID = -3 
			        then -3 
					else  OP.[First_DimORIContractID] 
				end                                               as [RI_CONTRACT_ID]
        	  ,case when dce.First_DimORIClaimSubEventID = 0 
			        then 0 
					else dce.First_DimORIClaimSubEventID + 200000 
				end                                               as [LOSS_EVENT_ID]
        	  ,dgc.First_DimGroupClassID                          as [CLASS_ID]
        	  ,case when ft.dimpolicyyoaid = 0 
			        then ft.dimyoaid 
					else ft.dimpolicyyoaid 
				end                                               as [uw_year]
        	  ,[op].[orireinsurercode]                            as [lors_code]
        	  ,dc.[lloydsriskcode]                                as [lloyds_risk_code]
        	  ,dc.[trustfundcode]                                 as [trust_fund_code]
        	  ,'A'                                                as [advised_or_cash]
        	  ,[dsc].[masterdatacurrencyisocode]                  as [sett_ccy_code]
        	  ,case when op.[oricontracttype] in ('FP','FX') 
			        then dp.[policyreference] 
					else 'UNK' 
				end                                               as [inwards_reference]
        	  ,sum([ft].[orioutstandingclaimsettccy])             as [os_total_mvt]
        	  ,dlf.[orilegatumflag]                               as [reporting_flag]
        		 
          from [dwh_mi].[factoritransaction] ft
        	   join #unadjusted ua 		                          on ua.dimadjustmentid = ft.dimadjustmentid
        	   join dwh.dimpolicy dp                              on dp.dimpolicyid = ft.dimpolicyid
        	   join dwh.dimorilegatumflag dlf                     on dlf.dimorilegatumflagid = ft.dimorilegatumflagid
        	   join dwh_mi.[dimoriplacement] op                   on op.[dimoriplacementid] = ft.[dimoriplacementid]
        	   join dwh_mi.dimdate dd                             on dd.dimdateid = ft.dimtransactiondateid
        	   join dwh_mi.dimclaimevent dce  	                  on ft.dimoriclaimsubeventid_dimclaimeventcatastropheid = dce.dimoriclaimsubeventid_dimclaimeventcatastropheid
        	   join dwh.dimgroupclass dgc                         on ft.dimgroupclassid = dgc.dimgroupclassid
          left join dwh_mi.[dimcode] dc                           on dc.[dimcodeid] = ft.[dimcodeid]
          left join dwh_mi.[dimcurrency] dsc                      on [dsc].[dimcurrencyid] = ft.[dimsettlementcurrencyid]
         where dlf.[orilegatumflag] <> 'Retained' 
		   and ft.dimdatahistoryid = @int_datahistoryid
      group by ft.[dimprocessperiodid]/100 
	          ,ua.AdjustmentType
        	  ,(ft.[dimprocessperiodid]%100-1)/3+1 
        	  ,ft.[dimprocessperiodid]%100
        	  ,dd.date
        	  ,case when op.dimoricontractid=-3 then -3 else  op.[first_dimoricontractid] end
        	  ,[op].[orireinsurercode]
        	  ,dc.[lloydsriskcode]
        	  ,[dsc].[masterdatacurrencyisocode]
        	  ,dc.[trustfundcode]
        	  ,case when dce.first_dimoriclaimsubeventid = 0 then 0 else dce.first_dimoriclaimsubeventid + 200000 end
        	  ,dgc.first_dimgroupclassid
        	  ,case when ft.dimpolicyyoaid=0 then ft.dimyoaid else ft.dimpolicyyoaid end
        	  ,dlf.[orilegatumflag]
        	  ,case when op.[oricontracttype] in ('FP','FX') then dp.[policyreference] else 'UNK' end
        	--HAVING SUM([FT].[ORIOutstandingClaimSettCcy])  <> 0
	) T group by adjustmenttype 