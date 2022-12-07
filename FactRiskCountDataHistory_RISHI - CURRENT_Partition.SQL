/* ******* Attributes used for Hash as advised
[DimRiskCountID]
[DimSourceSystemID]
[DimPolicyYOAID]
[First_DimPolicyGranularDetailID]
[First_DimPolicyID]
[First_DimORIPlacementID]
[DimORILegatumFlagID]
[First_DimORIClaimSubEventID]
[DimCodeID]
[DimVelocitySubmissionID]
[DimVelocityQuoteID]

* ***********/
--Building Query based on Rishi's call

---------------------------------------------------------
----PRODTR_FactRiskCountDataHistory CURRENT Partition
---------------------------------------------------------

DROP TABLE IF EXISTS QA.PRODTR_FactRiskCountDataHistory;

With CTE_PRD as (
     SELECT [DimRiskCountID]   							as [DimRiskCountID25]
	       ,[DimDataHistoryID] 							as [DimDataHistoryID25]
		   ,F.[DimSourceSystemID] 						as [DimSourceSystemID25]
		   ,F.[DimPolicyYOAID] 							as [DimPolicyYOAID25]
		   ,DPG.[First_DimPolicyGranularDetailID] 		as [DimPolicyGranularDetailID25]
		   ,DPY.[First_DimPolicyID] 					as [DimPolicyID25]		   
		   ,DP.[First_DimORIPlacementID] 				as [DimORIPlacementID25]
		   ,F.[DimORILegatumFlagID] 					as [DimORILegatumFlagID25]
		   ,CS.[First_DimORIClaimSubEventID] 			as [DimORIClaimSubEventID25]
		   ,F.DimCodeID                    				as [DimCodeID25]		   
		   ,[DimVelocitySubmissionID] 					as [DimVelocitySubmissionID25]
		   ,[DimVelocityQuoteID] 						as [DimVelocityQuoteID25]
           ,HASHBYTES('SHA1',CONCAT([DimRiskCountID],'%',F.[DimSourceSystemID],'%',F.[DimPolicyYOAID],'%',DPG.[First_DimPolicyGranularDetailID],'%',DPY.[First_DimPolicyID],'%',DP.[First_DimORIPlacementID],'%',F.[DimORILegatumFlagID],'%',CS.[First_DimORIClaimSubEventID],'%',F.DimCodeID,'%',[DimVelocitySubmissionID],'%',[DimVelocityQuoteID])) as PRD_HashBytes
		   
       FROM [MYMI-PROD].[MyMI_DataWareHouse].DWH.FactRiskCountDataHistory F with (NOLOCK)
	   Left Join [MYMI-PROD].[MyMI_DataWareHouse].DWH.DimORIPlacement DP          on F.DimORIPlacementId = DP.DimORIPlacementId 
	   Left Join [MYMI-PROD].[MyMI_DataWareHouse].DWH.DimPolicy DPY               on F.DimPolicyID = DPY.DimPolicyID
	   Left Join [MYMI-PROD].[MyMI_DataWareHouse].DWH.DimPolicyGranularDetail DPG on F.DimPolicyGranularDetailID = DPG.DimPolicyGranularDetailID
	   Left Join [MYMI-PROD].[MyMI_DataWareHouse].DWH.DimORIClaimSubEvent CS      on F.DimORIClaimSubEventID = CS.DimORIClaimSubEventID 
      WHERE DimDataHistoryId = 3324 AND F.DimSourceSystemId  = 14 --AND DimRiskCountID = 5559325
)

, CTE_TEST as (
     SELECT [DimRiskCountID]   							as [DimRiskCountID210]
	       ,[DimDataHistoryID] 							as [DimDataHistoryID210]
		   ,F.[DimSourceSystemID] 						as [DimSourceSystemID210]
		   ,F.[DimPolicyYOAID] 							as [DimPolicyYOAID210]
		   ,DPG.[First_DimPolicyGranularDetailID] 		as [DimPolicyGranularDetailID210]
		   ,DPY.[First_DimPolicyID] 					as [DimPolicyID210]		   
		   ,DP.[First_DimORIPlacementID] 				as [DimORIPlacementID210]
		   ,F.[DimORILegatumFlagID] 					as [DimORILegatumFlagID210]
		   ,CS.[First_DimORIClaimSubEventID] 			as [DimORIClaimSubEventID210]
		   ,F.DimCodeID                    				as [DimCodeID210]		   
		   ,[DimVelocitySubmissionID] 					as [DimVelocitySubmissionID210]
		   ,[DimVelocityQuoteID] 						as [DimVelocityQuoteID210]
		   ,HASHBYTES('SHA1',CONCAT([DimRiskCountID],'%',F.[DimSourceSystemID],'%',F.[DimPolicyYOAID],'%',DPG.[First_DimPolicyGranularDetailID],'%',DPY.[First_DimPolicyID],'%',DP.[First_DimORIPlacementID],'%',F.[DimORILegatumFlagID],'%',CS.[First_DimORIClaimSubEventID],'%',F.DimCodeID,'%',[DimVelocitySubmissionID],'%',[DimVelocityQuoteID])) as TEST_HashBytes
       FROM DWH.FactRiskCountDataHistory F with (NOLOCK)
	   Left Join DWH.DimORIPlacement DP          on F.DimORIPlacementId = DP.DimORIPlacementId 
	   Left Join DWH.DimPolicy DPY               on F.DimPolicyID = DPY.DimPolicyID
	   Left Join DWH.DimPolicyGranularDetail DPG on F.DimPolicyGranularDetailID = DPG.DimPolicyGranularDetailID
	   Left Join DWH.DimORIClaimSubEvent CS      on F.DimORIClaimSubEventID = CS.DimORIClaimSubEventID 
      WHERE DimDataHistoryId = 3324 AND F.DimSourceSystemId  = 14 --AND DimRiskCountID = 55593210		   
	)
	
--SELECT * FROM CTE_PRD UNION ALL SELECT * FROM CTE_DEV

SELECT * 
  INTO QA.PRODTR_FactRiskCountDataHistory
  FROM (
     SELECT 'FactRiskCountDataHistory' as EntityName
           ,P.PRD_HashBytes as PRDHashBytes, D.DimDataHistoryId210 as TEST_DimDataHistory,D.TEST_HashBytes as TESTHashBytes
           ,Case WHEN P.PRD_HashBytes = D.TEST_HashBytes THEN 'Passed'
                 WHEN P.PRD_Hashbytes is NULL THEN 'Failed - Missing in 2.5'
                 WHEN D.TEST_HashBytes is NULL THEN 'Failed - Missing in 2.10'
                 ELSE 'Failed - MisMatch of Hash'
             End as TestResult
           ,GetDate() as TestedOn 
           ,P.*,D.*   
       FROM CTE_PRD P 
		FULL Join CTE_TEST D 
         on DimRiskCountID210 = DimRiskCountID25
)TMP

SELECT TestResult, COUNT(*) as Total FROM QA.PRODTR_FactRiskCountDataHistory group by TestResult;
SELECT TOP 10 * FROM QA.PRODTR_FactRiskCountDataHistory  WHERE TestResult = 'Failed - Missing in 2.10'