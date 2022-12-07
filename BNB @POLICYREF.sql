SELECT 
--P.PolicyReference,
G.GroupClass,S.DimPolicyYOAID,S.DimYOAID, SUM( S.GrossNetGrossSignedPremiumSettCcy) AS GrossNetGrossSignedPremiumSettCcy
FROM MyMI_DataWarehouse.Eclipse_MI.FactSignedTransaction S
INNER JOIN MyMI_DataWarehouse.Eclipse_MI.DimPolicy P ON P.DimPolicyID=S.DimPolicyID
INNER JOIN MyMI_DataWarehouse.Eclipse_MI.DimLegalEntity L ON L.DimLegalEntityID=S.DimLegalEntityID
INNER JOIN MyMI_DataWarehouse.Eclipse_MI.DimGroupClass G ON G.DimGroupClassID=S.DimGroupClassID
WHERE S.DimDataHistoryID IN ( SELECT MAX(DimDataHistoryID) FROM MyMI_DataWarehouse.DWH_MI.DimDataHistory )  
  AND GroupClass='BGSU CASUALTY RI LATAM'
  AND S.DimBureauNonBureauSwitchCategoryID IN (SELECT DISTINCT DimBureauNonBureauSwitchCategoryID 
  FROM MyMI_DataWarehouse.DWH.BridgeBureauNonBureauSwitchDataHistory WHERE
DimDataHistoryID IN ( 
  SELECT MAX(DimDataHistoryID) FROM MyMI_DataWarehouse.DWH_MI.DimDataHistory )
  AND DimBureauNonBureauSwitchID=16)
GROUP BY G.GroupClass,S.DimPolicyYOAID,S.DimYOAID
ORDER BY 2
/*
SELECT DISTINCT DimBureauNonBureauSwitchCategoryID FROM MyMI_DataWarehouse.DWH.BridgeBureauNonBureauSwitchDataHistory WHERE
DimDataHistoryID IN ( 
  SELECT MAX(DimDataHistoryID) FROM MyMI_DataWarehouse.DWH_MI.DimDataHistory )
  AND DimBureauNonBureauSwitchID=16
SELECT * FROM MyMI_DataWarehouse.DWH.DimBureauNonBureauSwitch
*/