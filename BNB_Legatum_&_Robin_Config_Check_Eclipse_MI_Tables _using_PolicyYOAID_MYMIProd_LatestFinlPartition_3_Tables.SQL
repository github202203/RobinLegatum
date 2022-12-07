-- BNB flag Configuratiob Check for a single table testing using PolicyYOAID in MYMIProd from the Latest Financial Partition( only below 3 tables 
--Latest FInancial Partition Id = 3393 


--Eclipse_MI.FactClaimTransaction
--Eclipse_MI.FactSignedTransaction
--Eclipse_MI.FactWrittenPremium

use MyMI_DataWarehouse;

--CREATE or ALTER VIEW [QA].[BNB_Switch_Config_Check] AS
DROP TABLE IF EXISTS [QA].[BNB_Switch_Config_Check_PolicyYOA_FinPartition_PROD];

SELECT T.*,
        --Legatum Rules 
		Case WHEN BureauNonBureauSwitch = 
		          --Legatum Rules 
                  Case WHEN (GroupClass = 'AVIATION BY' and MIN_YOA >= 2002  and MAX_YOA <= 2014 ) OR
	                        (GroupClass = 'DISC 2400'	and MIN_YOA >= 1993  and MAX_YOA <= 2014 ) OR
		          	        (GroupClass = 'DISC 800'	and MIN_YOA >= 1993  and MAX_YOA <= 2001 ) OR 
		          	        (GroupClass = 'DISC UK'	    and MIN_YOA >= 2002  and MAX_YOA <= 2014 ) OR 
		          	        (GroupClass = 'PI NON US'	and MIN_YOA >= 2002  and MAX_YOA <= 2017 ) OR 
		          	        (GroupClass = 'EL UK'		and MIN_YOA >= 2002  and MAX_YOA <= 2014 ) OR 
		          	        (GroupClass = 'PL INT'	    and MIN_YOA >= 2004  and MAX_YOA <= 2004 ) OR 
		          	        (GroupClass = 'PL UK'		and MIN_YOA >= 2002  and MAX_YOA <= 2014 ) OR 
		          	        (GroupClass = 'DISC 735'	and MIN_YOA >= 1993  and MAX_YOA <= 2001 ) OR 
		          	        (GroupClass = 'DISC 250'	and MIN_YOA >= 1993  and MAX_YOA <= 2001 ) OR 
							(GroupClass = 'DISC 1202'	and MIN_YOA >= 1993  and MAX_YOA <= 2001 ) OR 
		          	        (GroupClass = 'DISC 2040'	and MIN_YOA >= 1993  and MAX_YOA <= 2014 ) 
		          	   THEN 'Legatum'
					   --ELSE 'RITC Legatum Failed'
	               End 
		     THEN 'Passed' 

			 WHEN BureauNonBureauSwitch = 
			      --Robin Rules 
			      Case WHEN (GroupClass = 'BGSU CASUALTY RI LATAM'		and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' ) OR
		          	        (GroupClass = 'BGSU ENGINEERING FAC LATAM'	and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' ) OR 
		          	        (GroupClass = 'BGSU INLAND MARINE'			and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' ) OR 
		          	        (GroupClass = 'BGSU LIABILITY ARP SC'		and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' ) OR 
		          	        (GroupClass = 'BGSU LIABILITY PACKAGE CJSO'	and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' ) OR 
		          	        (GroupClass = 'BGSU LIABILITY PACKAGE FD'	and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' ) OR 
		          	        (GroupClass = 'BGSU PROPERTY FAC LATAM'		and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' ) OR 
		          	        (GroupClass = 'BGSU PROPERTY PACKAGE CJSO'	and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' ) OR 
		          	        (GroupClass = 'BGSU PROPERTY PACKAGE FD'	and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' ) OR 
							(GroupClass = 'BGSU PROGRAMS'				and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' ) OR 
		          	        (GroupClass = 'BGS SINGAPORE'				and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' ) OR 
							(GroupClass = 'CHINA CONSTRUCTION'			and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' ) OR 
							(GroupClass = 'ENGINEERING & CPE'			and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' ) OR 
							(GroupClass = 'AEROSPACE LIABILITY'			and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' ) OR 
							(GroupClass = 'AIRLINES HULL'				and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' ) OR 
							(GroupClass = 'AIRLINES LIABILITY'			and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' ) OR 
							(GroupClass = 'AVIATION XL'					and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' ) OR 
							(GroupClass = 'GENERAL AVIATION HULL'		and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' ) OR 
							(GroupClass = 'GENERAL AVIATION LIABILITY'	and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' ) OR 
							(GroupClass = 'SCION CASUALTY'				and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' ) OR 
							(GroupClass = 'BGSU LIABILITY PACKAGE SIR'	and MIN_YOA >= 2002 and MAX_YOA <= 2018 and ExternalSyndicate = '2987' ) OR --MAX_YOA changed to 2018 on 18th Aug
							(GroupClass = 'BGSU PROPERTY PACKAGE SIR'	and MIN_YOA >= 2002 and MAX_YOA <= 2018 and ExternalSyndicate = '2987' )    --MAX_YOA changed to 2018 on 18th Aug
		          	   THEN 'Robin'
					   --ELSE 'RITC Robin Failed'
	               End
			 THEN 'Passed'
			 ELSE 'Failed - or N/A for Legatum/Robin'
				   
		 End as  TestResult
  INTO [QA].[BNB_Switch_Config_Check_PolicyYOA_FinPartition_PROD]
  FROM (
  
  

---Eclipse_MI Table
        
        SELECT 'Eclipse_MI.FactClaimTransaction'    as TableName
        	    ,'Legatum/Robin - ConfigCheck' as ConfigCheck
        		,L.ExternalSyndicate
                ,BS.BureauNonBureauSwitch 
                ,DG.GroupClass
                ,MIN(DP.DimPolicyYOAID) Min_YOA
                ,MAX(DP.DimPolicyYOAID) Max_YOA
				,F.IsAdjusted
				,F.DimPolicyID
        
          FROM [MYMI-PROD].[MyMI_DataWarehouse].Eclipse_MI.FactClaimTransaction F (nolock)
          JOIN [MYMI-PROD].[MyMI_DataWarehouse].DWH_MI.BridgeBureauNonBureauSwitch BNBS (nolock)        ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
          JOIN [MYMI-PROD].[MyMI_DataWarehouse].Eclipse_MI.DimLegalEntity L (nolock)                          ON L.DimLegalEntityID = F.DimLegalEntityID
          JOIN [MYMI-PROD].[MyMI_DataWarehouse].DWH_MI.DimBureauNonBureauSwitch BS (nolock)                   ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
          JOIN [MYMI-PROD].[MyMI_DataWarehouse].DWH_MI.DimGroupClass DG (nolock)                       ON DG.DimGroupClassID = F.DimGroupClassID
          JOIN [MYMI-PROD].[MyMI_DataWarehouse].DWH_MI.DimPolicy DP (nolock)                           ON DP.DimPolicyID = F.DimPolicyID
          JOIN [MYMI-PROD].[MyMI_DataWarehouse].DWH.DimPolicyStatus DPS (nolock)                       ON DPS.DimPolicyStatusId = F.DimPolicyStatusId   -- Include only active policy status as advised by Roop on 4th Aug,2022
         WHERE F.DimDataHistoryID in (3393)
		 --WHERE F.DimDataHistoryID in (3393,3360,3316,3295,3264,3219,3197,3167,3120,3102,3070,3027,2975,2928,2832) --All Financial Partitions
		   AND BS.BureauNonBureauSwitch IN ('Legatum','Robin') AND DPS.PolicyActiveStatus = 'Active' AND DP.DimPolicyYOAID >= 1993 --Included as advised by Roop on 4th Aug,2022
         GROUP BY ExternalSyndicate,BS.BureauNonBureauSwitch , DG.GroupClass , IsAdjusted,F.DimPolicyID

        UNION ALL 


       
        SELECT 'Eclipse_MI.FactSignedTransaction'    as TableName
        	    ,'Legatum/Robin - ConfigCheck' as ConfigCheck
        		,L.ExternalSyndicate
                ,BS.BureauNonBureauSwitch 
                ,DG.GroupClass
                ,MIN(DP.DimPolicyYOAID) Min_YOA
                ,MAX(DP.DimPolicyYOAID) Max_YOA
				,F.IsAdjusted
				,F.DimPolicyID
        
          FROM [MYMI-PROD].[MyMI_DataWarehouse].Eclipse_MI.FactSignedTransaction F (nolock)
          JOIN [MYMI-PROD].[MyMI_DataWarehouse].DWH_MI.BridgeBureauNonBureauSwitch BNBS (nolock)        ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
          JOIN [MYMI-PROD].[MyMI_DataWarehouse].Eclipse_MI.DimLegalEntity L (nolock)                          ON L.DimLegalEntityID = F.DimLegalEntityID
          JOIN [MYMI-PROD].[MyMI_DataWarehouse].DWH_MI.DimBureauNonBureauSwitch BS (nolock)                   ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
          JOIN [MYMI-PROD].[MyMI_DataWarehouse].DWH_MI.DimGroupClass DG (nolock)                       ON DG.DimGroupClassID = F.DimGroupClassID
          JOIN [MYMI-PROD].[MyMI_DataWarehouse].DWH_MI.DimPolicy DP (nolock)                           ON DP.DimPolicyID = F.DimPolicyID
          JOIN [MYMI-PROD].[MyMI_DataWarehouse].DWH.DimPolicyStatus DPS (nolock)                       ON DPS.DimPolicyStatusId = F.DimPolicyStatusId   -- Include only active policy status as advised by Roop on 4th Aug,2022
         WHERE F.DimDataHistoryID in (3393)
		 --WHERE F.DimDataHistoryID in (3393,3360,3316,3295,3264,3219,3197,3167,3120,3102,3070,3027,2975,2928,2832) --All Financial Partitions
		   AND BS.BureauNonBureauSwitch IN ('Legatum','Robin') AND DPS.PolicyActiveStatus = 'Active' AND DP.DimPolicyYOAID >= 1993 --Included as advised by Roop on 4th Aug,2022
         GROUP BY ExternalSyndicate,BS.BureauNonBureauSwitch , DG.GroupClass , IsAdjusted,F.DimPolicyID



        UNION ALL 
        
        SELECT 'Eclipse_MI.FactWrittenPremium'    as TableName
        	    ,'Legatum/Robin - ConfigCheck' as ConfigCheck
        		,L.ExternalSyndicate
                ,BS.BureauNonBureauSwitch 
                ,DG.GroupClass
                ,MIN(DP.DimPolicyYOAID) Min_YOA
                ,MAX(DP.DimPolicyYOAID) Max_YOA
				,F.IsAdjusted
				,F.DimPolicyID
        
          FROM [MYMI-PROD].[MyMI_DataWarehouse].Eclipse_MI.FactWrittenPremium F (nolock)
          JOIN [MYMI-PROD].[MyMI_DataWarehouse].DWH_MI.BridgeBureauNonBureauSwitch BNBS (nolock)        ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
          JOIN [MYMI-PROD].[MyMI_DataWarehouse].Eclipse_MI.DimLegalEntity L (nolock)                          ON L.DimLegalEntityID = F.DimLegalEntityID
          JOIN [MYMI-PROD].[MyMI_DataWarehouse].DWH_MI.DimBureauNonBureauSwitch BS (nolock)                   ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
          JOIN [MYMI-PROD].[MyMI_DataWarehouse].DWH_MI.DimGroupClass DG (nolock)                       ON DG.DimGroupClassID = F.DimGroupClassID
          JOIN [MYMI-PROD].[MyMI_DataWarehouse].DWH_MI.DimPolicy DP (nolock)                           ON DP.DimPolicyID = F.DimPolicyID
          JOIN [MYMI-PROD].[MyMI_DataWarehouse].DWH.DimPolicyStatus DPS (nolock)                       ON DPS.DimPolicyStatusId = F.DimPolicyStatusId   -- Include only active policy status as advised by Roop on 4th Aug,2022
         WHERE F.DimDataHistoryID in (3393)
		 --WHERE F.DimDataHistoryID in (3393,3360,3316,3295,3264,3219,3197,3167,3120,3102,3070,3027,2975,2928,2832) --All Financial Partitions
		   AND BS.BureauNonBureauSwitch IN ('Legatum','Robin') AND DPS.PolicyActiveStatus = 'Active' AND DP.DimPolicyYOAID >= 1993 --Included as advised by Roop on 4th Aug,2022
         GROUP BY ExternalSyndicate,BS.BureauNonBureauSwitch , DG.GroupClass , IsAdjusted,F.DimPolicyID


		)T


