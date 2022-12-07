DROP TABLE IF EXISTS QA.TR_FactRiskCountDataHistory;

With CTE_PRD as (
     SELECT [DimRiskCountID] as [DimRiskCountID25],[DimDataHistoryID] as [DimDataHistoryID25]/*,[InsertWarehouseLoadID] as [InsertWarehouseLoadID25],F.[DimBrokerID] as [DimBrokerID25]*/,F.[DimBureauNonBureauSwitchCategoryID] as [DimBureauNonBureauSwitchCategoryID25]/*,[DimCodeID] as [DimCodeID25]*/,[DimEclipseDeclarationSwitchCategoryID] as [DimEclipseDeclarationSwitchCategoryID25]/*,[DimExpiryDateID] as [DimExpiryDateID25]*/,F.[DimGroupClassID] as [DimGroupClassID25]/*,[DimInceptionDateID] as [DimInceptionDateID25]*/,F.[DimLeaderStatusID] as [DimLeaderStatusID25],F.[DimLegalEntityID] as [DimLegalEntityID25]/*,[DimNewRenewalID] as [DimNewRenewalID25]*/,DP.[First_DimORIPlacementID] as [DimORIPlacementID25],F.[DimPlacingBasisID] as [DimPlacingBasisID25],DPY.[First_DimPolicyID] as [DimPolicyID25],DPG.[First_DimPolicyGranularDetailID] as [DimPolicyGranularDetailID25]/*,F.[DimPolicyStatusID] as [DimPolicyStatusID25]*/,F.[DimProgrammeID] as [DimProgrammeID25]/*,[DimReassuredID] as [DimReassuredID25]*/,[DimRegionID] as [DimRegionID25],F.[DimSourceSystemID] as [DimSourceSystemID25],[DimTerritoryID] as [DimTerritoryID25],F.[DimVelocityProductID] as [DimVelocityProductID25],[DimVelocityQuoteID] as [DimVelocityQuoteID25],[DimVelocitySubmissionID] as [DimVelocitySubmissionID25],F.[DimPolicyYOAID] as [DimPolicyYOAID25]/*,F.[DimAssuredID] as [DimAssuredID25]*/,F.[DimORIBrokerID] as [DimORIBrokerID25],[IncludeInCount] as [IncludeInCount25]/*,F.[DimUnderwriterID] as [DimUnderwriterID25],[DimORILegatumFlagID] as [DimORILegatumFlagID25]*/,CS.[First_DimORIClaimSubEventID] as [DimORIClaimSubEventID25]
		   ,HASHBYTES('SHA1',CONCAT([DimRiskCountID],'%'/*,[InsertWarehouseLoadID],'%',F.[DimBrokerID],'%'*/,F.[DimBureauNonBureauSwitchCategoryID],'%'/*,[DimCodeID],'%'*/,[DimEclipseDeclarationSwitchCategoryID],'%'/*,[DimExpiryDateID],'%'*/,F.[DimGroupClassID],'%'/*,[DimInceptionDateID],'%'*/,F.[DimLeaderStatusID],'%',F.[DimLegalEntityID],'%'/*,[DimNewRenewalID],'%'*/,DP.[First_DimORIPlacementID],'%',F.[DimPlacingBasisID],'%',DPY.[First_DimPolicyID],'%',DPG.[First_DimPolicyGranularDetailID],'%'/*,F.[DimPolicyStatusID],'%'*/,F.[DimProgrammeID],'%'/*,[DimReassuredID],'%'*/,[DimRegionID],'%',F.[DimSourceSystemID],'%',[DimTerritoryID],'%',F.[DimVelocityProductID],'%',[DimVelocityQuoteID],'%',[DimVelocitySubmissionID],'%',F.[DimPolicyYOAID],'%'/*,F.[DimAssuredID],'%'*/,F.[DimORIBrokerID],'%',[IncludeInCount],'%'/*,F.[DimUnderwriterID],'%',[DimORILegatumFlagID],'%'*/,CS.[First_DimORIClaimSubEventID]))as PRD_HashBytes
       FROM [MYMI-TEST].[MyMI_DataWareHouse].DWH.FactRiskCountDataHistory F with (NOLOCK)
	   Left Join [MYMI-TEST].[MyMI_DataWareHouse].DWH.DimORIPlacement DP          on F.DimORIPlacementId = DP.DimORIPlacementId 
	   Left Join [MYMI-TEST].[MyMI_DataWareHouse].DWH.DimPolicy DPY               on F.DimPolicyID = DPY.DimPolicyID
	   Left Join [MYMI-TEST].[MyMI_DataWareHouse].DWH.DimPolicyGranularDetail DPG on F.DimPolicyGranularDetailID = DPG.DimPolicyGranularDetailID
	   Left Join [MYMI-TEST].[MyMI_DataWareHouse].DWH.DimORIClaimSubEvent CS      on F.DimORIClaimSubEventID = CS.DimORIClaimSubEventID 
      WHERE DimDataHistoryId = 3225 AND F.DimSourceSystemId  = 14 AND DimRiskCountID = 5559325

)

,CTE_DEV as (
     SELECT [DimRiskCountID] as [DimRiskCountID210],[DimDataHistoryID] as [DimDataHistoryID210]/*,[InsertWarehouseLoadID] as [InsertWarehouseLoadID210],F.[DimBrokerID] as [DimBrokerID210]*/,F.[DimBureauNonBureauSwitchCategoryID] as [DimBureauNonBureauSwitchCategoryID210]/*,[DimCodeID] as [DimCodeID210]*/,[DimEclipseDeclarationSwitchCategoryID] as [DimEclipseDeclarationSwitchCategoryID210]/*,[DimExpiryDateID] as [DimExpiryDateID210]*/,F.[DimGroupClassID] as [DimGroupClassID210]/*,[DimInceptionDateID] as [DimInceptionDateID210]*/,F.[DimLeaderStatusID] as [DimLeaderStatusID210],F.[DimLegalEntityID] as [DimLegalEntityID210]/*,[DimNewRenewalID] as [DimNewRenewalID210]*/,DP.[First_DimORIPlacementID] as [DimORIPlacementID210],F.[DimPlacingBasisID] as [DimPlacingBasisID210],DPY.[First_DimPolicyID] as [DimPolicyID210],DPG.[First_DimPolicyGranularDetailID] as [DimPolicyGranularDetailID210]/*,F.[DimPolicyStatusID] as [DimPolicyStatusID210]*/,F.[DimProgrammeID] as [DimProgrammeID210]/*,[DimReassuredID] as [DimReassuredID210]*/,[DimRegionID] as [DimRegionID210],F.[DimSourceSystemID] as [DimSourceSystemID210],[DimTerritoryID] as [DimTerritoryID210],F.[DimVelocityProductID] as [DimVelocityProductID210],[DimVelocityQuoteID] as [DimVelocityQuoteID210],[DimVelocitySubmissionID] as [DimVelocitySubmissionID210],F.[DimPolicyYOAID] as [DimPolicyYOAID210]/*,F.[DimAssuredID] as [DimAssuredID210]*/,F.[DimORIBrokerID] as [DimORIBrokerID210],[IncludeInCount] as [IncludeInCount210]/*,F.[DimUnderwriterID] as [DimUnderwriterID210],[DimORILegatumFlagID] as [DimORILegatumFlagID210]*/,CS.[First_DimORIClaimSubEventID] as [DimORIClaimSubEventID210]
		   ,HASHBYTES('SHA1',CONCAT([DimRiskCountID],'%'/*,[InsertWarehouseLoadID],'%',F.[DimBrokerID],'%'*/,F.[DimBureauNonBureauSwitchCategoryID],'%'/*,[DimCodeID],'%'*/,[DimEclipseDeclarationSwitchCategoryID],'%'/*,[DimExpiryDateID],'%'*/,F.[DimGroupClassID],'%'/*,[DimInceptionDateID],'%'*/,F.[DimLeaderStatusID],'%',F.[DimLegalEntityID],'%'/*,[DimNewRenewalID],'%'*/,DP.[First_DimORIPlacementID],'%',F.[DimPlacingBasisID],'%',DPY.[First_DimPolicyID],'%',DPG.[First_DimPolicyGranularDetailID],'%'/*,F.[DimPolicyStatusID],'%'*/,F.[DimProgrammeID],'%'/*,[DimReassuredID],'%'*/,[DimRegionID],'%',F.[DimSourceSystemID],'%',[DimTerritoryID],'%',F.[DimVelocityProductID],'%',[DimVelocityQuoteID],'%',[DimVelocitySubmissionID],'%',F.[DimPolicyYOAID],'%'/*,F.[DimAssuredID],'%'*/,F.[DimORIBrokerID],'%',[IncludeInCount],'%'/*,F.[DimUnderwriterID],'%',[DimORILegatumFlagID],'%'*/,CS.[First_DimORIClaimSubEventID]))as DEV_HashBytes
       FROM DWH.FactRiskCountDataHistory F with (NOLOCK)
	   Left Join DWH.DimORIPlacement DP          on F.DimORIPlacementId = DP.DimORIPlacementId 
	   Left Join DWH.DimPolicy DPY               on F.DimPolicyID = DPY.DimPolicyID
	   Left Join DWH.DimPolicyGranularDetail DPG on F.DimPolicyGranularDetailID = DPG.DimPolicyGranularDetailID
	   Left Join DWH.DimORIClaimSubEvent CS      on F.DimORIClaimSubEventID = CS.DimORIClaimSubEventID 
      WHERE DimDataHistoryId = 3281 AND F.DimSourceSystemId  = 14 AND DimRiskCountID = 5559325
)

--SELECT * FROM CTE_PRD UNION ALL SELECT * FROM CTE_DEV

SELECT * INTO QA.TR_FactRiskCountDataHistory
  FROM (
     SELECT 'FactRiskCountDataHistory' as EntityName
           ,P.PRD_HashBytes as PRDHashBytes, D.DimDataHistoryId210 as DEV_DimDataHistory,D.Dev_HashBytes as DEVHashBytes
           ,Case WHEN P.PRD_HashBytes = D.Dev_HashBytes THEN 'Passed'
                 WHEN P.PRD_Hashbytes is NULL THEN 'Failed - Missing in 2.5'
                 WHEN D.Dev_HashBytes is NULL THEN 'Failed - Missing in 2.10'
                 ELSE 'Failed - MisMatch of Hash'
             End as TestResult
           ,GetDate() as TestedOn 
           ,P.*,D.*   
       FROM CTE_PRD P 
		FULL Join CTE_DEV D 
         on DimRiskCountID210 = DimRiskCountID25
)TMP

SELECT TestResult, COUNT(*) as Total FROM QA.TR_FactRiskCountDataHistory group by TestResult;

SELECT TOP 10 * FROM QA.TR_FactRiskCountDataHistory  WHERE TestResult = 'Failed - MisMatch of Hash'
