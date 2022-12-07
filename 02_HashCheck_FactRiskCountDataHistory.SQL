DROP TABLE IF EXISTS QA.TR_FactRiskCountDataHistory;

With CTE_PRD as (
     SELECT [DimRiskCountID] as [DimRiskCountID25],[DimDataHistoryID] as [DimDataHistoryID25],[InsertWarehouseLoadID] as [InsertWarehouseLoadID25],[DimBrokerID] as [DimBrokerID25],[DimBureauNonBureauSwitchCategoryID] as [DimBureauNonBureauSwitchCategoryID25],[DimCodeID] as [DimCodeID25],[DimEclipseDeclarationSwitchCategoryID] as [DimEclipseDeclarationSwitchCategoryID25],[DimExpiryDateID] as [DimExpiryDateID25],[DimGroupClassID] as [DimGroupClassID25],[DimInceptionDateID] as [DimInceptionDateID25],[DimLeaderStatusID] as [DimLeaderStatusID25],[DimLegalEntityID] as [DimLegalEntityID25],[DimNewRenewalID] as [DimNewRenewalID25],[DimORIPlacementID] as [DimORIPlacementID25],[DimPlacingBasisID] as [DimPlacingBasisID25],[DimPolicyID] as [DimPolicyID25],[DimPolicyGranularDetailID] as [DimPolicyGranularDetailID25],[DimPolicyStatusID] as [DimPolicyStatusID25],[DimProgrammeID] as [DimProgrammeID25],[DimReassuredID] as [DimReassuredID25],[DimRegionID] as [DimRegionID25],[DimSourceSystemID] as [DimSourceSystemID25],[DimTerritoryID] as [DimTerritoryID25],[DimVelocityProductID] as [DimVelocityProductID25],[DimVelocityQuoteID] as [DimVelocityQuoteID25],[DimVelocitySubmissionID] as [DimVelocitySubmissionID25],[DimPolicyYOAID] as [DimPolicyYOAID25],[DimAssuredID] as [DimAssuredID25],[DimORIBrokerID] as [DimORIBrokerID25],[IncludeInCount] as [IncludeInCount25],[DimUnderwriterID] as [DimUnderwriterID25],[DimORILegatumFlagID] as [DimORILegatumFlagID25],[DimORIClaimSubEventID] as [DimORIClaimSubEventID25]
           --,HASHBYTES('SHA1',CONCAT([DimRiskCountID],'%',[DimDataHistoryID],'%',[InsertWarehouseLoadID],'%',[DimBrokerID],'%',[DimBureauNonBureauSwitchCategoryID],'%',[DimCodeID],'%',[DimEclipseDeclarationSwitchCategoryID],'%',[DimExpiryDateID],'%',[DimGroupClassID],'%',[DimInceptionDateID],'%',[DimLeaderStatusID],'%',[DimLegalEntityID],'%',[DimNewRenewalID],'%',[DimORIPlacementID],'%',[DimPlacingBasisID],'%',[DimPolicyID],'%',[DimPolicyGranularDetailID],'%',[DimPolicyStatusID],'%',[DimProgrammeID],'%',[DimReassuredID],'%',[DimRegionID],'%',[DimSourceSystemID],'%',[DimTerritoryID],'%',[DimVelocityProductID],'%',[DimVelocityQuoteID],'%',[DimVelocitySubmissionID],'%',[DimPolicyYOAID],'%',[DimAssuredID],'%',[DimORIBrokerID],'%',[IncludeInCount],'%',[DimUnderwriterID],'%',[DimORILegatumFlagID],'%',[DimORIClaimSubEventID]))as PRD_HashBytes
		   --Only DimDataHistoryId Removed from Hash
		   ,HASHBYTES('SHA1',CONCAT([DimRiskCountID],'%',[InsertWarehouseLoadID],'%',[DimBrokerID],'%',[DimBureauNonBureauSwitchCategoryID],'%',[DimCodeID],'%',[DimEclipseDeclarationSwitchCategoryID],'%',[DimExpiryDateID],'%',[DimGroupClassID],'%',[DimInceptionDateID],'%',[DimLeaderStatusID],'%',[DimLegalEntityID],'%',[DimNewRenewalID],'%',[DimORIPlacementID],'%',[DimPlacingBasisID],'%',[DimPolicyID],'%',[DimPolicyGranularDetailID],'%',[DimPolicyStatusID],'%',[DimProgrammeID],'%',[DimReassuredID],'%',[DimRegionID],'%',[DimSourceSystemID],'%',[DimTerritoryID],'%',[DimVelocityProductID],'%',[DimVelocityQuoteID],'%',[DimVelocitySubmissionID],'%',[DimPolicyYOAID],'%',[DimAssuredID],'%',[DimORIBrokerID],'%',[IncludeInCount],'%',[DimUnderwriterID],'%',[DimORILegatumFlagID],'%',[DimORIClaimSubEventID]))as PRD_HashBytes
       FROM [MYMI-TEST].[MyMI_DataWareHouse].DWH.FactRiskCountDataHistory with (NOLOCK)
      WHERE DimDataHistoryId = 3225
        AND DimSourceSystemId  = 14
)

,CTE_DEV as (
     SELECT [DimRiskCountID] as [DimRiskCountID210],[DimDataHistoryID] as [DimDataHistoryID210],[InsertWarehouseLoadID] as [InsertWarehouseLoadID210],[DimBrokerID] as [DimBrokerID210],[DimBureauNonBureauSwitchCategoryID] as [DimBureauNonBureauSwitchCategoryID210],[DimCodeID] as [DimCodeID210],[DimEclipseDeclarationSwitchCategoryID] as [DimEclipseDeclarationSwitchCategoryID210],[DimExpiryDateID] as [DimExpiryDateID210],[DimGroupClassID] as [DimGroupClassID210],[DimInceptionDateID] as [DimInceptionDateID210],[DimLeaderStatusID] as [DimLeaderStatusID210],[DimLegalEntityID] as [DimLegalEntityID210],[DimNewRenewalID] as [DimNewRenewalID210],[DimORIPlacementID] as [DimORIPlacementID210],[DimPlacingBasisID] as [DimPlacingBasisID210],[DimPolicyID] as [DimPolicyID210],[DimPolicyGranularDetailID] as [DimPolicyGranularDetailID210],[DimPolicyStatusID] as [DimPolicyStatusID210],[DimProgrammeID] as [DimProgrammeID210],[DimReassuredID] as [DimReassuredID210],[DimRegionID] as [DimRegionID210],[DimSourceSystemID] as [DimSourceSystemID210],[DimTerritoryID] as [DimTerritoryID210],[DimVelocityProductID] as [DimVelocityProductID210],[DimVelocityQuoteID] as [DimVelocityQuoteID210],[DimVelocitySubmissionID] as [DimVelocitySubmissionID210],[DimPolicyYOAID] as [DimPolicyYOAID210],[DimAssuredID] as [DimAssuredID210],[DimORIBrokerID] as [DimORIBrokerID210],[IncludeInCount] as [IncludeInCount210],[DimUnderwriterID] as [DimUnderwriterID210],[DimORILegatumFlagID] as [DimORILegatumFlagID210],[DimORIClaimSubEventID] as [DimORIClaimSubEventID210]
           --,HASHBYTES('SHA1',CONCAT([DimRiskCountID],'%',[DimDataHistoryID],'%',[InsertWarehouseLoadID],'%',[DimBrokerID],'%',[DimBureauNonBureauSwitchCategoryID],'%',[DimCodeID],'%',[DimEclipseDeclarationSwitchCategoryID],'%',[DimExpiryDateID],'%',[DimGroupClassID],'%',[DimInceptionDateID],'%',[DimLeaderStatusID],'%',[DimLegalEntityID],'%',[DimNewRenewalID],'%',[DimORIPlacementID],'%',[DimPlacingBasisID],'%',[DimPolicyID],'%',[DimPolicyGranularDetailID],'%',[DimPolicyStatusID],'%',[DimProgrammeID],'%',[DimReassuredID],'%',[DimRegionID],'%',[DimSourceSystemID],'%',[DimTerritoryID],'%',[DimVelocityProductID],'%',[DimVelocityQuoteID],'%',[DimVelocitySubmissionID],'%',[DimPolicyYOAID],'%',[DimAssuredID],'%',[DimORIBrokerID],'%',[IncludeInCount],'%',[DimUnderwriterID],'%',[DimORILegatumFlagID],'%',[DimORIClaimSubEventID]))as DEV_HashBytes
		   --Only DimDataHistoryId Removed from Hash
		   ,HASHBYTES('SHA1',CONCAT([DimRiskCountID],'%',[InsertWarehouseLoadID],'%',[DimBrokerID],'%',[DimBureauNonBureauSwitchCategoryID],'%',[DimCodeID],'%',[DimEclipseDeclarationSwitchCategoryID],'%',[DimExpiryDateID],'%',[DimGroupClassID],'%',[DimInceptionDateID],'%',[DimLeaderStatusID],'%',[DimLegalEntityID],'%',[DimNewRenewalID],'%',[DimORIPlacementID],'%',[DimPlacingBasisID],'%',[DimPolicyID],'%',[DimPolicyGranularDetailID],'%',[DimPolicyStatusID],'%',[DimProgrammeID],'%',[DimReassuredID],'%',[DimRegionID],'%',[DimSourceSystemID],'%',[DimTerritoryID],'%',[DimVelocityProductID],'%',[DimVelocityQuoteID],'%',[DimVelocitySubmissionID],'%',[DimPolicyYOAID],'%',[DimAssuredID],'%',[DimORIBrokerID],'%',[IncludeInCount],'%',[DimUnderwriterID],'%',[DimORILegatumFlagID],'%',[DimORIClaimSubEventID]))as DEV_HashBytes
       FROM DWH.FactRiskCountDataHistory with (NOLOCK)
      WHERE DimDataHistoryId = 3281
        AND DimSourceSystemId  = 14
)

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
