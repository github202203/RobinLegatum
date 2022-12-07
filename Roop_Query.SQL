select DataHistoryName,MDSAdjustmentReference,DimProcessPeriodID,GroupClass
,AdjustmentType,l.ORILegatumFlag,F.DimDataHistoryID,
sum(ORIPaidClaimSettCcy) ORIPaidClaimSettCcy,
sum(ORIOutstandingClaimSettCcy) ORIOutstandingClaimSettCcy 
,sum(ORISignedPremiumPaidSettCcy) ORISignedPremiumPaidSettCcy
,sum(ORIPremiumOutstandingSettCcy) ORIPremiumOutstandingSettCcy
from MyMI_DataWarehouse.DWH_MI.FactORITransaction F
join MyMI_DataWarehouse.DWH_MI.DimDataHistory d
on f.DimDataHistoryID=d.DimDataHistoryID
join MyMI_DataWarehouse.DWH_MI.DimAdjustment da
on da.DimAdjustmentID=f.DimAdjustmentID
join MyMI_DataWarehouse.DWH_MI.DimORIPlacement dop
on dop.DimORIPlacementID=f.DimORIPlacementID
join MyMI_DataWarehouse.DWH_MI.DimGroupClass dgc
on dgc.DimGroupClassID=f.DimGroupClassID
join MyMI_DataWarehouse.DWH.DimORILegatumFlag l 
on l.DimORILegatumFlagID=f.DimORILegatumFlagID

where 1=1
and MDSAdjustmentReference like 'RS%'
AND F.DimDataHistoryID=3377
--and f.IsAdjusted=1
group by DataHistoryName,MDSAdjustmentReference,DimProcessPeriodID,GroupClass,AdjustmentType,l.ORILegatumFlag,F.DimDataHistoryID
order by 1,2,3


--STAGING TABLE--
SELECT *
  FROM [MyMI_Adjustment_Staging].[Extract].[ORIFinancialAdjustment] 
 -- where [Adjustment Reference] like'rsori%'
  order by 1 desc

--MYMI SQL LAYER--
select DataHistoryName,MDSAdjustmentReference,DimProcessPeriodID,GroupClass
,AdjustmentType,l.ORILegatumFlag,F.DimDataHistoryID,F.DimAdjustmentId,
sum(ORIPaidClaimSettCcy) ORIPaidClaimSettCcy,
sum(ORIOutstandingClaimSettCcy) ORIOutstandingClaimSettCcy 
,sum(ORISignedPremiumPaidSettCcy) ORISignedPremiumPaidSettCcy
,sum(ORIPremiumOutstandingSettCcy) ORIPremiumOutstandingSettCcy
from MyMI_DataWarehouse.DWH_MI.FactORITransaction F
join MyMI_DataWarehouse.DWH_MI.DimDataHistory d
on f.DimDataHistoryID=d.DimDataHistoryID
join MyMI_DataWarehouse.DWH_MI.DimAdjustment da
on da.DimAdjustmentID=f.DimAdjustmentID
join MyMI_DataWarehouse.DWH_MI.DimORIPlacement dop
on dop.DimORIPlacementID=f.DimORIPlacementID
join MyMI_DataWarehouse.DWH_MI.DimGroupClass dgc
on dgc.DimGroupClassID=f.DimGroupClassID
join MyMI_DataWarehouse.DWH.DimORILegatumFlag l 
on l.DimORILegatumFlagID=f.DimORILegatumFlagID

where 1=1
--and MDSAdjustmentReference ='Robin Check'
AND F.DimDataHistoryID=3377 and f.IsAdjusted=1
group by DataHistoryName,MDSAdjustmentReference,DimProcessPeriodID,GroupClass,AdjustmentType,l.ORILegatumFlag,F.DimDataHistoryID,F.DimAdjustmentId
order by 8 desc --order by 1,2,3

