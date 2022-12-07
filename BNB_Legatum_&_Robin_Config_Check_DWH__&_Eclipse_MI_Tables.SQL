-- BNB flag Configuratiob Check for a single table testing
--CREATE or ALTER VIEW [QA].[BNB_Switch_Config_Check] AS
DROP TABLE IF EXISTS [QA].[BNB_Switch_Config_Check];

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
		          	   THEN 'RITC Legatum'
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
		          	   THEN 'RITC Robin'
					   --ELSE 'RITC Robin Failed'
	               End
			 THEN 'Passed'
			 ELSE 'Failed - or N/A for Legatum/Robin'
				   
		 End as  TestResult
  INTO [QA].[BNB_Switch_Config_Check]
  FROM (
  
  ---DWH_MI Table
        SELECT 'DWH_MI.LatestFactSignedTransaction' as TableName
		      ,'Legatum/Robin - ConfigCheck' as ConfigCheck
			  ,L.ExternalSyndicate
              ,BS.BureauNonBureauSwitch 
        	  ,DG.GroupClass
        	  ,MIN(DimYOAID) Min_YOA
        	  ,MAX(DImYOAID) Max_YOA
			  ,F.IsAdjusted
			  
        
          FROM DWH_MI.LatestFactSignedTransaction F
          JOIN DWH_MI.LatestBridgeBureauNonBureauSwitch BNBS ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
		  JOIN Eclipse_MI.DimLegalEntity L                   ON L.DimLegalEntityID = F.DimLegalEntityID
          JOIN DWH_MI.DimBureauNonBureauSwitch BS            ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
          JOIN DWH_MI.DimGroupClass DG                       ON DG.DimGroupClassID = F.DimGroupClassID
          JOIN DWH_MI.DimPolicy DP                           ON DP.DimPolicyID = F.DimPolicyID
		  JOIN DWH.DimPolicyStatus DPS                       ON DPS.DimPolicyStatusId = F.DimPolicyStatusId   -- Include only active policy status as advised by Roop on 4th Aug,2022
         WHERE BS.BureauNonBureauSwitch IN ('RITC Legatum','RITC Robin') AND DPS.PolicyActiveStatus = 'Active' AND DimYOAID >= 1993 --Included as advised by Roop on 4th Aug,2022
         GROUP BY ExternalSyndicate,BS.BureauNonBureauSwitch , DG.GroupClass, IsAdjusted

		UNION ALL

        SELECT 'DWH_MI.LatestFactAssuredCount'     as TableName
  	         ,'Legatum/Robin - ConfigCheck' as ConfigCheck
  	     	,L.ExternalSyndicate
               ,BS.BureauNonBureauSwitch 
               ,DG.GroupClass
               ,MIN(DimYOAID) Min_YOA
               ,MAX(DImYOAID) Max_YOA
			   ,0 as IsAdjusted
               
          FROM DWH_MI.LatestFactAssuredCount F
          JOIN DWH_MI.LatestBridgeBureauNonBureauSwitch BNBS ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
          JOIN Eclipse_MI.DimLegalEntity L                   ON L.DimLegalEntityID = F.DimLegalEntityID
          JOIN DWH_MI.DimBureauNonBureauSwitch BS            ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
                 JOIN DWH_MI.DimGroupClass DG                ON DG.DimGroupClassID = F.DimGroupClassID
                 JOIN DWH_MI.DimPolicy DP                    ON DP.DimPolicyID = F.DimPolicyID
		  JOIN DWH.DimPolicyStatus DPS                       ON DPS.DimPolicyStatusId = F.DimPolicyStatusId   -- Include only active policy status as advised by Roop on 4th Aug,2022
         WHERE BS.BureauNonBureauSwitch IN ('RITC Legatum','RITC Robin') AND DPS.PolicyActiveStatus = 'Active' AND DimYOAID >= 1993 --Included as advised by Roop on 4th Aug,2022
         GROUP BY ExternalSyndicate,BS.BureauNonBureauSwitch , DG.GroupClass--, IsAdjusted



        UNION ALL 

        SELECT 'DWH_MI.LatestFactClaimCount'          as TableName
        	    ,'Legatum/Robin - ConfigCheck' as ConfigCheck
        		,L.ExternalSyndicate
                ,BS.BureauNonBureauSwitch 
                ,DG.GroupClass
                ,MIN(DimYOAID) Min_YOA
                ,MAX(DImYOAID) Max_YOA
				,0 as IsAdjusted
        
           FROM DWH_MI.LatestFactClaimCount F
           JOIN DWH_MI.LatestBridgeBureauNonBureauSwitch BNBS        ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
           JOIN Eclipse_MI.DimLegalEntity L                          ON L.DimLegalEntityID = F.DimLegalEntityID
           JOIN DWH_MI.DimBureauNonBureauSwitch BS                   ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
                  JOIN DWH_MI.DimGroupClass DG                       ON DG.DimGroupClassID = F.DimGroupClassID
                  JOIN DWH_MI.DimPolicy DP                           ON DP.DimPolicyID = F.DimPolicyID
        		  JOIN DWH.DimPolicyStatus DPS                       ON DPS.DimPolicyStatusId = F.DimPolicyStatusId   -- Include only active policy status as advised by Roop on 4th Aug,2022
                 WHERE BS.BureauNonBureauSwitch IN ('RITC Legatum','RITC Robin') AND DPS.PolicyActiveStatus = 'Active' AND DimYOAID >= 1993 --Included as advised by Roop on 4th Aug,2022
                 GROUP BY ExternalSyndicate,BS.BureauNonBureauSwitch , DG.GroupClass --, IsAdjusted


        UNION ALL 
        
        SELECT 'DWH_MI.LatestFactClaimTransaction'    as TableName
        	    ,'Legatum/Robin - ConfigCheck' as ConfigCheck
        		,L.ExternalSyndicate
                ,BS.BureauNonBureauSwitch 
                ,DG.GroupClass
                ,MIN(DimYOAID) Min_YOA
                ,MAX(DImYOAID) Max_YOA
				,F.IsAdjusted
        
           FROM DWH_MI.LatestFactClaimTransaction F
           JOIN DWH_MI.LatestBridgeBureauNonBureauSwitch BNBS        ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
           JOIN Eclipse_MI.DimLegalEntity L                          ON L.DimLegalEntityID = F.DimLegalEntityID
           JOIN DWH_MI.DimBureauNonBureauSwitch BS                   ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
                  JOIN DWH_MI.DimGroupClass DG                       ON DG.DimGroupClassID = F.DimGroupClassID
                  JOIN DWH_MI.DimPolicy DP                           ON DP.DimPolicyID = F.DimPolicyID
        		  JOIN DWH.DimPolicyStatus DPS                       ON DPS.DimPolicyStatusId = F.DimPolicyStatusId   -- Include only active policy status as advised by Roop on 4th Aug,2022
                 WHERE BS.BureauNonBureauSwitch IN ('RITC Legatum','RITC Robin') AND DPS.PolicyActiveStatus = 'Active' AND DimYOAID >= 1993 --Included as advised by Roop on 4th Aug,2022
                 GROUP BY ExternalSyndicate,BS.BureauNonBureauSwitch , DG.GroupClass , IsAdjusted
        
        UNION ALL 
        
        SELECT 'DWH_MI.LatestFactClaimTransactionCount' as TableName
        	    ,'Legatum/Robin - ConfigCheck'   as ConfigCheck
        		,L.ExternalSyndicate
                ,BS.BureauNonBureauSwitch 
                ,DG.GroupClass
                ,MIN(DimYOAID) Min_YOA
                ,MAX(DImYOAID) Max_YOA
				,0 as IsAdjusted
        		
           FROM DWH_MI.LatestFactClaimTransactionCount F
           JOIN DWH_MI.LatestBridgeBureauNonBureauSwitch BNBS        ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
           JOIN Eclipse_MI.DimLegalEntity L                          ON L.DimLegalEntityID = F.DimLegalEntityID
           JOIN DWH_MI.DimBureauNonBureauSwitch BS                   ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
                  JOIN DWH_MI.DimGroupClass DG                       ON DG.DimGroupClassID = F.DimGroupClassID
                  JOIN DWH_MI.DimPolicy DP                           ON DP.DimPolicyID = F.DimPolicyID
        		  JOIN DWH.DimPolicyStatus DPS                       ON DPS.DimPolicyStatusId = F.DimPolicyStatusId   -- Include only active policy status as advised by Roop on 4th Aug,2022
                 WHERE BS.BureauNonBureauSwitch IN ('RITC Legatum','RITC Robin') AND DPS.PolicyActiveStatus = 'Active' AND DimYOAID >= 1993 --Included as advised by Roop on 4th Aug,2022
                 GROUP BY ExternalSyndicate,BS.BureauNonBureauSwitch , DG.GroupClass--, IsAdjusted
        
        UNION ALL 
        
        SELECT 'DWH_MI.LatestFactEarnedPremium'       as TableName
        	    ,'Legatum/Robin - ConfigCheck' as ConfigCheck
        		,L.ExternalSyndicate
                ,BS.BureauNonBureauSwitch 
                ,DG.GroupClass
                ,MIN(DimYOAID) Min_YOA
                ,MAX(DImYOAID) Max_YOA
				,F.IsAdjusted
                
           FROM DWH_MI.LatestFactEarnedPremium F
           JOIN DWH_MI.LatestBridgeBureauNonBureauSwitch BNBS        ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
           JOIN Eclipse_MI.DimLegalEntity L                          ON L.DimLegalEntityID = F.DimLegalEntityID
           JOIN DWH_MI.DimBureauNonBureauSwitch BS                   ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
                  JOIN DWH_MI.DimGroupClass DG                       ON DG.DimGroupClassID = F.DimGroupClassID
                  JOIN DWH_MI.DimPolicy DP                           ON DP.DimPolicyID = F.DimPolicyID
        		  JOIN DWH.DimPolicyStatus DPS                       ON DPS.DimPolicyStatusId = F.DimPolicyStatusId   -- Include only active policy status as advised by Roop on 4th Aug,2022
                 WHERE BS.BureauNonBureauSwitch IN ('RITC Legatum','RITC Robin') AND DPS.PolicyActiveStatus = 'Active' AND DimYOAID >= 1993 --Included as advised by Roop on 4th Aug,2022
                 GROUP BY ExternalSyndicate,BS.BureauNonBureauSwitch , DG.GroupClass , IsAdjusted
        
        UNION ALL 
        
        SELECT 'DWH_MI.LatestFactLimit'               as TableName
        	    ,'Legatum/Robin - ConfigCheck' as ConfigCheck
        		,L.ExternalSyndicate
                ,BS.BureauNonBureauSwitch 
                ,DG.GroupClass
                ,MIN(DimYOAID) Min_YOA
                ,MAX(DImYOAID) Max_YOA
				,F.IsAdjusted
                
           FROM DWH_MI.LatestFactLimit F
           JOIN DWH_MI.LatestBridgeBureauNonBureauSwitch BNBS        ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
           JOIN Eclipse_MI.DimLegalEntity L                          ON L.DimLegalEntityID = F.DimLegalEntityID
           JOIN DWH_MI.DimBureauNonBureauSwitch BS                   ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
                  JOIN DWH_MI.DimGroupClass DG                       ON DG.DimGroupClassID = F.DimGroupClassID
                  JOIN DWH_MI.DimPolicy DP                           ON DP.DimPolicyID = F.DimPolicyID
        		  JOIN DWH.DimPolicyStatus DPS                       ON DPS.DimPolicyStatusId = F.DimPolicyStatusId   -- Include only active policy status as advised by Roop on 4th Aug,2022
                 WHERE BS.BureauNonBureauSwitch IN ('RITC Legatum','RITC Robin') AND DPS.PolicyActiveStatus = 'Active' AND DimYOAID >= 1993 --Included as advised by Roop on 4th Aug,2022
                 GROUP BY ExternalSyndicate,BS.BureauNonBureauSwitch , DG.GroupClass , IsAdjusted
        
        UNION ALL 
        
        SELECT 'DWH_MI.LatestFactORIContractCount'    as TableName
        	    ,'Legatum/Robin - ConfigCheck' as ConfigCheck
        		,L.ExternalSyndicate
                ,BS.BureauNonBureauSwitch 
                ,DG.GroupClass
                ,MIN(DimYOAID) Min_YOA
                ,MAX(DImYOAID) Max_YOA
				,0 as IsAdjusted
                
           FROM DWH_MI.LatestFactORIContractCount F
           JOIN DWH_MI.LatestBridgeBureauNonBureauSwitch BNBS        ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
           JOIN Eclipse_MI.DimLegalEntity L                          ON L.DimLegalEntityID = F.DimLegalEntityID
           JOIN DWH_MI.DimBureauNonBureauSwitch BS                   ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
                  JOIN DWH_MI.DimGroupClass DG                       ON DG.DimGroupClassID = F.DimGroupClassID
                  JOIN DWH_MI.DimPolicy DP                           ON DP.DimPolicyID = F.DimPolicyID
        		  JOIN DWH.DimPolicyStatus DPS                       ON DPS.DimPolicyStatusId = F.DimPolicyStatusId   -- Include only active policy status as advised by Roop on 4th Aug,2022
                 WHERE BS.BureauNonBureauSwitch IN ('RITC Legatum','RITC Robin') AND DPS.PolicyActiveStatus = 'Active' AND DimYOAID >= 1993 --Included as advised by Roop on 4th Aug,2022
                 GROUP BY ExternalSyndicate,BS.BureauNonBureauSwitch , DG.GroupClass--, IsAdjusted
        
        UNION ALL 
        
        SELECT 'DWH_MI.LatestFactPolicyCount'         as TableName
        	    ,'Legatum/Robin - ConfigCheck' as ConfigCheck
        		,L.ExternalSyndicate
                ,BS.BureauNonBureauSwitch 
                ,DG.GroupClass
                ,MIN(DimYOAID) Min_YOA
                ,MAX(DImYOAID) Max_YOA
				,0 as IsAdjusted
                
           FROM DWH_MI.LatestFactPolicyCount F
           JOIN DWH_MI.LatestBridgeBureauNonBureauSwitch BNBS        ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
           JOIN Eclipse_MI.DimLegalEntity L                          ON L.DimLegalEntityID = F.DimLegalEntityID
           JOIN DWH_MI.DimBureauNonBureauSwitch BS                   ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
                  JOIN DWH_MI.DimGroupClass DG                       ON DG.DimGroupClassID = F.DimGroupClassID
                  JOIN DWH_MI.DimPolicy DP                           ON DP.DimPolicyID = F.DimPolicyID
        		  JOIN DWH.DimPolicyStatus DPS                       ON DPS.DimPolicyStatusId = F.DimPolicyStatusId   -- Include only active policy status as advised by Roop on 4th Aug,2022
                 WHERE BS.BureauNonBureauSwitch IN ('RITC Legatum','RITC Robin') AND DPS.PolicyActiveStatus = 'Active' AND DimYOAID >= 1993 --Included as advised by Roop on 4th Aug,2022
                 GROUP BY ExternalSyndicate,BS.BureauNonBureauSwitch , DG.GroupClass --, IsAdjusted
        
        UNION ALL
        
        SELECT 'DWH_MI.LatestFactPolicyProgrammeCount' as TableName
        	    ,'Legatum/Robin - ConfigCheck' as ConfigCheck
        		,L.ExternalSyndicate
                ,BS.BureauNonBureauSwitch 
                ,DG.GroupClass
                ,MIN(DimYOAID) Min_YOA
                ,MAX(DImYOAID) Max_YOA
				,0 as IsAdjusted
                
           FROM DWH_MI.LatestFactPolicyProgrammeCount F
           JOIN DWH_MI.LatestBridgeBureauNonBureauSwitch BNBS        ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
           JOIN Eclipse_MI.DimLegalEntity L                          ON L.DimLegalEntityID = F.DimLegalEntityID
           JOIN DWH_MI.DimBureauNonBureauSwitch BS                   ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
                  JOIN DWH_MI.DimGroupClass DG                       ON DG.DimGroupClassID = F.DimGroupClassID
                  JOIN DWH_MI.DimPolicy DP                           ON DP.DimPolicyID = F.DimPolicyID
        		  JOIN DWH.DimPolicyStatus DPS                       ON DPS.DimPolicyStatusId = F.DimPolicyStatusId   -- Include only active policy status as advised by Roop on 4th Aug,2022
                 WHERE BS.BureauNonBureauSwitch IN ('RITC Legatum','RITC Robin') AND DPS.PolicyActiveStatus = 'Active' AND DimYOAID >= 1993 --Included as advised by Roop on 4th Aug,2022
                 GROUP BY ExternalSyndicate,BS.BureauNonBureauSwitch , DG.GroupClass --, IsAdjusted
        
        UNION ALL
        
        SELECT 'DWH_MI.LatestFactPricing' as TableName
        	    ,'Legatum/Robin - ConfigCheck' as ConfigCheck
        		,L.ExternalSyndicate
                ,BS.BureauNonBureauSwitch 
                ,DG.GroupClass
                ,MIN(DimYOAID) Min_YOA
                ,MAX(DImYOAID) Max_YOA
				,F.IsAdjusted
                
           FROM DWH_MI.LatestFactPricing F
           JOIN DWH_MI.LatestBridgeBureauNonBureauSwitch BNBS        ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
           JOIN Eclipse_MI.DimLegalEntity L                          ON L.DimLegalEntityID = F.DimLegalEntityID
           JOIN DWH_MI.DimBureauNonBureauSwitch BS                   ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
                  JOIN DWH_MI.DimGroupClass DG                       ON DG.DimGroupClassID = F.DimGroupClassID
                  JOIN DWH_MI.DimPolicy DP                           ON DP.DimPolicyID = F.DimPolicyID
        		  JOIN DWH.DimPolicyStatus DPS                       ON DPS.DimPolicyStatusId = F.DimPolicyStatusId   -- Include only active policy status as advised by Roop on 4th Aug,2022
                 WHERE BS.BureauNonBureauSwitch IN ('RITC Legatum','RITC Robin') AND DPS.PolicyActiveStatus = 'Active' AND DimYOAID >= 1993 --Included as advised by Roop on 4th Aug,2022
                 GROUP BY ExternalSyndicate,BS.BureauNonBureauSwitch , DG.GroupClass , IsAdjusted
        
        UNION ALL
        
        SELECT 'DWH_MI.LatestFactQuoteCount'          as TableName
        	    ,'Legatum/Robin - ConfigCheck' as ConfigCheck
        		,L.ExternalSyndicate
                ,BS.BureauNonBureauSwitch 
                ,DG.GroupClass
                ,MIN(DimYOAID) Min_YOA
                ,MAX(DImYOAID) Max_YOA
				,0 as IsAdjusted
                
           FROM DWH_MI.LatestFactQuoteCount F
           JOIN DWH_MI.LatestBridgeBureauNonBureauSwitch BNBS        ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
           JOIN Eclipse_MI.DimLegalEntity L                          ON L.DimLegalEntityID = F.DimLegalEntityID
           JOIN DWH_MI.DimBureauNonBureauSwitch BS                   ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
                  JOIN DWH_MI.DimGroupClass DG                       ON DG.DimGroupClassID = F.DimGroupClassID
                  JOIN DWH_MI.DimPolicy DP                           ON DP.DimPolicyID = F.DimPolicyID
        		  JOIN DWH.DimPolicyStatus DPS                       ON DPS.DimPolicyStatusId = F.DimPolicyStatusId   -- Include only active policy status as advised by Roop on 4th Aug,2022
                 WHERE BS.BureauNonBureauSwitch IN ('RITC Legatum','RITC Robin') AND DPS.PolicyActiveStatus = 'Active' AND DimYOAID >= 1993 --Included as advised by Roop on 4th Aug,2022
                 GROUP BY ExternalSyndicate,BS.BureauNonBureauSwitch , DG.GroupClass --, IsAdjusted
        
        UNION ALL
        
        
        SELECT 'DWH_MI.LatestFactSettlementSchedule'  as TableName
        	    ,'Legatum/Robin - ConfigCheck' as ConfigCheck
        		,L.ExternalSyndicate
                ,BS.BureauNonBureauSwitch 
                ,DG.GroupClass
                ,MIN(DimYOAID) Min_YOA
                ,MAX(DImYOAID) Max_YOA
				,F.IsAdjusted
                
           FROM DWH_MI.LatestFactSettlementSchedule F
           JOIN DWH_MI.LatestBridgeBureauNonBureauSwitch BNBS        ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
           JOIN Eclipse_MI.DimLegalEntity L                          ON L.DimLegalEntityID = F.DimLegalEntityID
           JOIN DWH_MI.DimBureauNonBureauSwitch BS                   ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
                  JOIN DWH_MI.DimGroupClass DG                       ON DG.DimGroupClassID = F.DimGroupClassID
                  JOIN DWH_MI.DimPolicy DP                           ON DP.DimPolicyID = F.DimPolicyID
        		  JOIN DWH.DimPolicyStatus DPS                       ON DPS.DimPolicyStatusId = F.DimPolicyStatusId   -- Include only active policy status as advised by Roop on 4th Aug,2022
                 WHERE BS.BureauNonBureauSwitch IN ('RITC Legatum','RITC Robin') AND DPS.PolicyActiveStatus = 'Active' AND DimYOAID >= 1993 --Included as advised by Roop on 4th Aug,2022
                 GROUP BY ExternalSyndicate,BS.BureauNonBureauSwitch , DG.GroupClass, IsAdjusted
        
        UNION ALL
        
        SELECT 'DWH_MI.LatestFactSignedTransactionUnadjusted' as TableName
        	    ,'Legatum/Robin - ConfigCheck'         as ConfigCheck
        		,L.ExternalSyndicate
                ,BS.BureauNonBureauSwitch 
                ,DG.GroupClass
                ,MIN(DimYOAID) Min_YOA
                ,MAX(DImYOAID) Max_YOA
				,F.IsAdjusted
                
           FROM DWH_MI.LatestFactSignedTransactionUnadjusted F
           JOIN DWH_MI.LatestBridgeBureauNonBureauSwitch BNBS        ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
           JOIN Eclipse_MI.DimLegalEntity L                          ON L.DimLegalEntityID = F.DimLegalEntityID
           JOIN DWH_MI.DimBureauNonBureauSwitch BS                   ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
                  JOIN DWH_MI.DimGroupClass DG                       ON DG.DimGroupClassID = F.DimGroupClassID
                  JOIN DWH_MI.DimPolicy DP                           ON DP.DimPolicyID = F.DimPolicyID
        		  JOIN DWH.DimPolicyStatus DPS                       ON DPS.DimPolicyStatusId = F.DimPolicyStatusId   -- Include only active policy status as advised by Roop on 4th Aug,2022
                 WHERE BS.BureauNonBureauSwitch IN ('RITC Legatum','RITC Robin') AND DPS.PolicyActiveStatus = 'Active' AND DimYOAID >= 1993 --Included as advised by Roop on 4th Aug,2022
                 GROUP BY ExternalSyndicate,BS.BureauNonBureauSwitch , DG.GroupClass, IsAdjusted
        
        UNION ALL
        
        SELECT 'DWH_MI.LatestFactSubmissionCount'     as TableName
        	    ,'Legatum/Robin - ConfigCheck' as ConfigCheck
        		,L.ExternalSyndicate
                ,BS.BureauNonBureauSwitch 
                ,DG.GroupClass
                ,MIN(DimYOAID) Min_YOA
                ,MAX(DImYOAID) Max_YOA
				,0 as IsAdjusted
                
           FROM DWH_MI.LatestFactSubmissionCount F
           JOIN DWH_MI.LatestBridgeBureauNonBureauSwitch BNBS        ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
           JOIN Eclipse_MI.DimLegalEntity L                          ON L.DimLegalEntityID = F.DimLegalEntityID
           JOIN DWH_MI.DimBureauNonBureauSwitch BS                   ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
                  JOIN DWH_MI.DimGroupClass DG                       ON DG.DimGroupClassID = F.DimGroupClassID
                  JOIN DWH_MI.DimPolicy DP                           ON DP.DimPolicyID = F.DimPolicyID
        		  JOIN DWH.DimPolicyStatus DPS                       ON DPS.DimPolicyStatusId = F.DimPolicyStatusId   -- Include only active policy status as advised by Roop on 4th Aug,2022
                 WHERE BS.BureauNonBureauSwitch IN ('RITC Legatum','RITC Robin') AND DPS.PolicyActiveStatus = 'Active' AND DimYOAID >= 1993 --Included as advised by Roop on 4th Aug,2022
                 GROUP BY ExternalSyndicate,BS.BureauNonBureauSwitch , DG.GroupClass --, IsAdjusted
        
        UNION ALL
        
        SELECT 'DWH_MI.LatestFactWrittenPremium' as TableName
        	    ,'Legatum/Robin - ConfigCheck' as ConfigCheck
        		,L.ExternalSyndicate
                ,BS.BureauNonBureauSwitch 
                ,DG.GroupClass
                ,MIN(DimYOAID) Min_YOA
                ,MAX(DImYOAID) Max_YOA
				,F.IsAdjusted
                
           FROM DWH_MI.LatestFactWrittenPremium F
           JOIN DWH_MI.LatestBridgeBureauNonBureauSwitch BNBS        ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
           JOIN Eclipse_MI.DimLegalEntity L                          ON L.DimLegalEntityID = F.DimLegalEntityID
           JOIN DWH_MI.DimBureauNonBureauSwitch BS                   ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
                  JOIN DWH_MI.DimGroupClass DG                       ON DG.DimGroupClassID = F.DimGroupClassID
                  JOIN DWH_MI.DimPolicy DP                           ON DP.DimPolicyID = F.DimPolicyID
        		  JOIN DWH.DimPolicyStatus DPS                       ON DPS.DimPolicyStatusId = F.DimPolicyStatusId   -- Include only active policy status as advised by Roop on 4th Aug,2022
                 WHERE BS.BureauNonBureauSwitch IN ('RITC Legatum','RITC Robin') AND DPS.PolicyActiveStatus = 'Active' AND DimYOAID >= 1993 --Included as advised by Roop on 4th Aug,2022
                 GROUP BY ExternalSyndicate,BS.BureauNonBureauSwitch , DG.GroupClass , IsAdjusted

---Eclipse_MI Table

UNION ALL 

SELECT 'Eclipse_MI.LatestFactAssuredCount'     as TableName
  	         ,'Legatum/Robin - ConfigCheck' as ConfigCheck
  	     	,L.ExternalSyndicate
               ,BS.BureauNonBureauSwitch 
               ,DG.GroupClass
               ,MIN(DimYOAID) Min_YOA
               ,MAX(DImYOAID) Max_YOA
			   ,0 as IsAdjusted
               
          FROM Eclipse_MI.LatestFactAssuredCount F
          JOIN DWH_MI.LatestBridgeBureauNonBureauSwitch BNBS ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
          JOIN Eclipse_MI.DimLegalEntity L                   ON L.DimLegalEntityID = F.DimLegalEntityID
          JOIN DWH_MI.DimBureauNonBureauSwitch BS            ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
                 JOIN DWH_MI.DimGroupClass DG                ON DG.DimGroupClassID = F.DimGroupClassID
                 JOIN DWH_MI.DimPolicy DP                    ON DP.DimPolicyID = F.DimPolicyID
		  JOIN DWH.DimPolicyStatus DPS                       ON DPS.DimPolicyStatusId = F.DimPolicyStatusId   -- Include only active policy status as advised by Roop on 4th Aug,2022
         WHERE BS.BureauNonBureauSwitch IN ('RITC Legatum','RITC Robin') AND DPS.PolicyActiveStatus = 'Active' AND DimYOAID >= 1993 --Included as advised by Roop on 4th Aug,2022
         GROUP BY ExternalSyndicate,BS.BureauNonBureauSwitch , DG.GroupClass--, IsAdjusted

        UNION ALL 

        SELECT 'Eclipse_MI.LatestFactClaimCount'          as TableName
        	    ,'Legatum/Robin - ConfigCheck' as ConfigCheck
        		,L.ExternalSyndicate
                ,BS.BureauNonBureauSwitch 
                ,DG.GroupClass
                ,MIN(DimYOAID) Min_YOA
                ,MAX(DImYOAID) Max_YOA
				,0 as IsAdjusted
        
           FROM Eclipse_MI.LatestFactClaimCount F
           JOIN DWH_MI.LatestBridgeBureauNonBureauSwitch BNBS        ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
           JOIN Eclipse_MI.DimLegalEntity L                          ON L.DimLegalEntityID = F.DimLegalEntityID
           JOIN DWH_MI.DimBureauNonBureauSwitch BS                   ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
                  JOIN DWH_MI.DimGroupClass DG                       ON DG.DimGroupClassID = F.DimGroupClassID
                  JOIN DWH_MI.DimPolicy DP                           ON DP.DimPolicyID = F.DimPolicyID
        		  JOIN DWH.DimPolicyStatus DPS                       ON DPS.DimPolicyStatusId = F.DimPolicyStatusId   -- Include only active policy status as advised by Roop on 4th Aug,2022
                 WHERE BS.BureauNonBureauSwitch IN ('RITC Legatum','RITC Robin') AND DPS.PolicyActiveStatus = 'Active' AND DimYOAID >= 1993 --Included as advised by Roop on 4th Aug,2022
                 GROUP BY ExternalSyndicate,BS.BureauNonBureauSwitch , DG.GroupClass --, IsAdjusted

        UNION ALL 
        
        SELECT 'Eclipse_MI.LatestFactClaimTransaction'    as TableName
        	    ,'Legatum/Robin - ConfigCheck' as ConfigCheck
        		,L.ExternalSyndicate
                ,BS.BureauNonBureauSwitch 
                ,DG.GroupClass
                ,MIN(DimYOAID) Min_YOA
                ,MAX(DImYOAID) Max_YOA
				,F.IsAdjusted
        
           FROM Eclipse_MI.LatestFactClaimTransaction F
           JOIN DWH_MI.LatestBridgeBureauNonBureauSwitch BNBS        ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
           JOIN Eclipse_MI.DimLegalEntity L                          ON L.DimLegalEntityID = F.DimLegalEntityID
           JOIN DWH_MI.DimBureauNonBureauSwitch BS                   ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
                  JOIN DWH_MI.DimGroupClass DG                       ON DG.DimGroupClassID = F.DimGroupClassID
                  JOIN DWH_MI.DimPolicy DP                           ON DP.DimPolicyID = F.DimPolicyID
        		  JOIN DWH.DimPolicyStatus DPS                       ON DPS.DimPolicyStatusId = F.DimPolicyStatusId   -- Include only active policy status as advised by Roop on 4th Aug,2022
                 WHERE BS.BureauNonBureauSwitch IN ('RITC Legatum','RITC Robin') AND DPS.PolicyActiveStatus = 'Active' AND DimYOAID >= 1993 --Included as advised by Roop on 4th Aug,2022
                 GROUP BY ExternalSyndicate,BS.BureauNonBureauSwitch , DG.GroupClass , IsAdjusted

        UNION ALL 
        
        SELECT 'Eclipse_MI.LatestFactClaimTransaction100Pct'    as TableName
        	    ,'Legatum/Robin - ConfigCheck' as ConfigCheck
        		,L.ExternalSyndicate
                ,BS.BureauNonBureauSwitch 
                ,DG.GroupClass
                ,MIN(DimYOAID) Min_YOA
                ,MAX(DImYOAID) Max_YOA
				,F.IsAdjusted
        
           FROM Eclipse_MI.LatestFactClaimTransaction100Pct F
           JOIN DWH_MI.LatestBridgeBureauNonBureauSwitch BNBS        ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
           JOIN Eclipse_MI.DimLegalEntity L                          ON L.DimLegalEntityID = F.DimLegalEntityID
           JOIN DWH_MI.DimBureauNonBureauSwitch BS                   ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
                  JOIN DWH_MI.DimGroupClass DG                       ON DG.DimGroupClassID = F.DimGroupClassID
                  JOIN DWH_MI.DimPolicy DP                           ON DP.DimPolicyID = F.DimPolicyID
        		  JOIN DWH.DimPolicyStatus DPS                       ON DPS.DimPolicyStatusId = F.DimPolicyStatusId   -- Include only active policy status as advised by Roop on 4th Aug,2022
                 WHERE BS.BureauNonBureauSwitch IN ('RITC Legatum','RITC Robin') AND DPS.PolicyActiveStatus = 'Active' AND DimYOAID >= 1993 --Included as advised by Roop on 4th Aug,2022
                 GROUP BY ExternalSyndicate,BS.BureauNonBureauSwitch , DG.GroupClass , IsAdjusted

        UNION ALL 
        
        SELECT 'Eclipse_MI.LatestFactClaimTransactionCount'    as TableName
        	    ,'Legatum/Robin - ConfigCheck' as ConfigCheck
        		,L.ExternalSyndicate
                ,BS.BureauNonBureauSwitch 
                ,DG.GroupClass
                ,MIN(DimYOAID) Min_YOA
                ,MAX(DImYOAID) Max_YOA
				,0 as IsAdjusted
        
           FROM Eclipse_MI.LatestFactClaimTransactionCount F
           JOIN DWH_MI.LatestBridgeBureauNonBureauSwitch BNBS        ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
           JOIN Eclipse_MI.DimLegalEntity L                          ON L.DimLegalEntityID = F.DimLegalEntityID
           JOIN DWH_MI.DimBureauNonBureauSwitch BS                   ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
                  JOIN DWH_MI.DimGroupClass DG                       ON DG.DimGroupClassID = F.DimGroupClassID
                  JOIN DWH_MI.DimPolicy DP                           ON DP.DimPolicyID = F.DimPolicyID
        		  JOIN DWH.DimPolicyStatus DPS                       ON DPS.DimPolicyStatusId = F.DimPolicyStatusId   -- Include only active policy status as advised by Roop on 4th Aug,2022
                 WHERE BS.BureauNonBureauSwitch IN ('RITC Legatum','RITC Robin') AND DPS.PolicyActiveStatus = 'Active' AND DimYOAID >= 1993 --Included as advised by Roop on 4th Aug,2022
                 GROUP BY ExternalSyndicate,BS.BureauNonBureauSwitch , DG.GroupClass --, IsAdjusted

        UNION ALL 
        
        SELECT 'Eclipse_MI.LatestFactEarnedPremium'    as TableName
        	    ,'Legatum/Robin - ConfigCheck' as ConfigCheck
        		,L.ExternalSyndicate
                ,BS.BureauNonBureauSwitch 
                ,DG.GroupClass
                ,MIN(DimYOAID) Min_YOA
                ,MAX(DImYOAID) Max_YOA
				,F.IsAdjusted
        
           FROM Eclipse_MI.LatestFactEarnedPremium F
           JOIN DWH_MI.LatestBridgeBureauNonBureauSwitch BNBS        ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
           JOIN Eclipse_MI.DimLegalEntity L                          ON L.DimLegalEntityID = F.DimLegalEntityID
           JOIN DWH_MI.DimBureauNonBureauSwitch BS                   ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
                  JOIN DWH_MI.DimGroupClass DG                       ON DG.DimGroupClassID = F.DimGroupClassID
                  JOIN DWH_MI.DimPolicy DP                           ON DP.DimPolicyID = F.DimPolicyID
        		  JOIN DWH.DimPolicyStatus DPS                       ON DPS.DimPolicyStatusId = F.DimPolicyStatusId   -- Include only active policy status as advised by Roop on 4th Aug,2022
                 WHERE BS.BureauNonBureauSwitch IN ('RITC Legatum','RITC Robin') AND DPS.PolicyActiveStatus = 'Active' AND DimYOAID >= 1993 --Included as advised by Roop on 4th Aug,2022
                 GROUP BY ExternalSyndicate,BS.BureauNonBureauSwitch , DG.GroupClass , IsAdjusted

        UNION ALL 
        
        SELECT 'Eclipse_MI.LatestFactLedger'    as TableName
        	    ,'Legatum/Robin - ConfigCheck' as ConfigCheck
        		,L.ExternalSyndicate
                ,BS.BureauNonBureauSwitch 
                ,DG.GroupClass
                ,MIN(DimYOAID) Min_YOA
                ,MAX(DImYOAID) Max_YOA
				,F.IsAdjusted
        
           FROM Eclipse_MI.LatestFactLedger F
           JOIN DWH_MI.LatestBridgeBureauNonBureauSwitch BNBS        ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
           JOIN Eclipse_MI.DimLegalEntity L                          ON L.DimLegalEntityID = F.DimLegalEntityID
           JOIN DWH_MI.DimBureauNonBureauSwitch BS                   ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
                  JOIN DWH_MI.DimGroupClass DG                       ON DG.DimGroupClassID = F.DimGroupClassID
                  JOIN DWH_MI.DimPolicy DP                           ON DP.DimPolicyID = F.DimPolicyID
        		  JOIN DWH.DimPolicyStatus DPS                       ON DPS.DimPolicyStatusId = F.DimPolicyStatusId   -- Include only active policy status as advised by Roop on 4th Aug,2022
                 WHERE BS.BureauNonBureauSwitch IN ('RITC Legatum','RITC Robin') AND DPS.PolicyActiveStatus = 'Active' AND DimYOAID >= 1993 --Included as advised by Roop on 4th Aug,2022
                 GROUP BY ExternalSyndicate,BS.BureauNonBureauSwitch , DG.GroupClass , IsAdjusted

        UNION ALL 
        
        SELECT 'Eclipse_MI.LatestFactPolicyCount'    as TableName
        	    ,'Legatum/Robin - ConfigCheck' as ConfigCheck
        		,L.ExternalSyndicate
                ,BS.BureauNonBureauSwitch 
                ,DG.GroupClass
                ,MIN(DimYOAID) Min_YOA
                ,MAX(DImYOAID) Max_YOA
				,0 as IsAdjusted
        
           FROM Eclipse_MI.LatestFactPolicyCount F
           JOIN DWH_MI.LatestBridgeBureauNonBureauSwitch BNBS        ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
           JOIN Eclipse_MI.DimLegalEntity L                          ON L.DimLegalEntityID = F.DimLegalEntityID
           JOIN DWH_MI.DimBureauNonBureauSwitch BS                   ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
                  JOIN DWH_MI.DimGroupClass DG                       ON DG.DimGroupClassID = F.DimGroupClassID
                  JOIN DWH_MI.DimPolicy DP                           ON DP.DimPolicyID = F.DimPolicyID
        		  JOIN DWH.DimPolicyStatus DPS                       ON DPS.DimPolicyStatusId = F.DimPolicyStatusId   -- Include only active policy status as advised by Roop on 4th Aug,2022
                 WHERE BS.BureauNonBureauSwitch IN ('RITC Legatum','RITC Robin') AND DPS.PolicyActiveStatus = 'Active' AND DimYOAID >= 1993 --Included as advised by Roop on 4th Aug,2022
                 GROUP BY ExternalSyndicate,BS.BureauNonBureauSwitch , DG.GroupClass --, IsAdjusted

        UNION ALL 
        
        SELECT 'Eclipse_MI.LatestFactPolicyLimit'    as TableName
        	    ,'Legatum/Robin - ConfigCheck' as ConfigCheck
        		,L.ExternalSyndicate
                ,BS.BureauNonBureauSwitch 
                ,DG.GroupClass
                ,MIN(DimYOAID) Min_YOA
                ,MAX(DImYOAID) Max_YOA
				,F.IsAdjusted
        
           FROM Eclipse_MI.LatestFactPolicyLimit F
           JOIN DWH_MI.LatestBridgeBureauNonBureauSwitch BNBS        ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
           JOIN Eclipse_MI.DimLegalEntity L                          ON L.DimLegalEntityID = F.DimLegalEntityID
           JOIN DWH_MI.DimBureauNonBureauSwitch BS                   ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
                  JOIN DWH_MI.DimGroupClass DG                       ON DG.DimGroupClassID = F.DimGroupClassID
                  JOIN DWH_MI.DimPolicy DP                           ON DP.DimPolicyID = F.DimPolicyID
        		  JOIN DWH.DimPolicyStatus DPS                       ON DPS.DimPolicyStatusId = F.DimPolicyStatusId   -- Include only active policy status as advised by Roop on 4th Aug,2022
                 WHERE BS.BureauNonBureauSwitch IN ('RITC Legatum','RITC Robin') AND DPS.PolicyActiveStatus = 'Active' AND DimYOAID >= 1993 --Included as advised by Roop on 4th Aug,2022
                 GROUP BY ExternalSyndicate,BS.BureauNonBureauSwitch , DG.GroupClass , IsAdjusted

        UNION ALL 
        
        SELECT 'Eclipse_MI.LatestFactPolicyProgrammeCount'    as TableName
        	    ,'Legatum/Robin - ConfigCheck' as ConfigCheck
        		,L.ExternalSyndicate
                ,BS.BureauNonBureauSwitch 
                ,DG.GroupClass
                ,MIN(DimYOAID) Min_YOA
                ,MAX(DImYOAID) Max_YOA
				,0 as IsAdjusted
        
           FROM Eclipse_MI.LatestFactPolicyProgrammeCount F
           JOIN DWH_MI.LatestBridgeBureauNonBureauSwitch BNBS        ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
           JOIN Eclipse_MI.DimLegalEntity L                          ON L.DimLegalEntityID = F.DimLegalEntityID
           JOIN DWH_MI.DimBureauNonBureauSwitch BS                   ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
                  JOIN DWH_MI.DimGroupClass DG                       ON DG.DimGroupClassID = F.DimGroupClassID
                  JOIN DWH_MI.DimPolicy DP                           ON DP.DimPolicyID = F.DimPolicyID
        		  JOIN DWH.DimPolicyStatus DPS                       ON DPS.DimPolicyStatusId = F.DimPolicyStatusId   -- Include only active policy status as advised by Roop on 4th Aug,2022
                 WHERE BS.BureauNonBureauSwitch IN ('RITC Legatum','RITC Robin') AND DPS.PolicyActiveStatus = 'Active' AND DimYOAID >= 1993 --Included as advised by Roop on 4th Aug,2022
                 GROUP BY ExternalSyndicate,BS.BureauNonBureauSwitch , DG.GroupClass --, IsAdjusted


        UNION ALL 
        
        SELECT 'Eclipse_MI.LatestFactPricing'    as TableName
        	    ,'Legatum/Robin - ConfigCheck' as ConfigCheck
        		,L.ExternalSyndicate
                ,BS.BureauNonBureauSwitch 
                ,DG.GroupClass
                ,MIN(DimYOAID) Min_YOA
                ,MAX(DImYOAID) Max_YOA
				,F.IsAdjusted
        
           FROM Eclipse_MI.LatestFactPricing F
           JOIN DWH_MI.LatestBridgeBureauNonBureauSwitch BNBS        ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
           JOIN Eclipse_MI.DimLegalEntity L                          ON L.DimLegalEntityID = F.DimLegalEntityID
           JOIN DWH_MI.DimBureauNonBureauSwitch BS                   ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
                  JOIN DWH_MI.DimGroupClass DG                       ON DG.DimGroupClassID = F.DimGroupClassID
                  JOIN DWH_MI.DimPolicy DP                           ON DP.DimPolicyID = F.DimPolicyID
        		  JOIN DWH.DimPolicyStatus DPS                       ON DPS.DimPolicyStatusId = F.DimPolicyStatusId   -- Include only active policy status as advised by Roop on 4th Aug,2022
                 WHERE BS.BureauNonBureauSwitch IN ('RITC Legatum','RITC Robin') AND DPS.PolicyActiveStatus = 'Active' AND DimYOAID >= 1993 --Included as advised by Roop on 4th Aug,2022
                 GROUP BY ExternalSyndicate,BS.BureauNonBureauSwitch , DG.GroupClass , IsAdjusted


        UNION ALL 
        
        SELECT 'Eclipse_MI.LatestFactSettlementSchedule'    as TableName
        	    ,'Legatum/Robin - ConfigCheck' as ConfigCheck
        		,L.ExternalSyndicate
                ,BS.BureauNonBureauSwitch 
                ,DG.GroupClass
                ,MIN(DimYOAID) Min_YOA
                ,MAX(DImYOAID) Max_YOA
				,F.IsAdjusted
        
           FROM Eclipse_MI.LatestFactSettlementSchedule F
           JOIN DWH_MI.LatestBridgeBureauNonBureauSwitch BNBS        ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
           JOIN Eclipse_MI.DimLegalEntity L                          ON L.DimLegalEntityID = F.DimLegalEntityID
           JOIN DWH_MI.DimBureauNonBureauSwitch BS                   ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
                  JOIN DWH_MI.DimGroupClass DG                       ON DG.DimGroupClassID = F.DimGroupClassID
                  JOIN DWH_MI.DimPolicy DP                           ON DP.DimPolicyID = F.DimPolicyID
        		  JOIN DWH.DimPolicyStatus DPS                       ON DPS.DimPolicyStatusId = F.DimPolicyStatusId   -- Include only active policy status as advised by Roop on 4th Aug,2022
                 WHERE BS.BureauNonBureauSwitch IN ('RITC Legatum','RITC Robin') AND DPS.PolicyActiveStatus = 'Active' AND DimYOAID >= 1993 --Included as advised by Roop on 4th Aug,2022
                 GROUP BY ExternalSyndicate,BS.BureauNonBureauSwitch , DG.GroupClass , IsAdjusted


        UNION ALL 
        
        SELECT 'Eclipse_MI.LatestFactSignedTransaction'    as TableName
        	    ,'Legatum/Robin - ConfigCheck' as ConfigCheck
        		,L.ExternalSyndicate
                ,BS.BureauNonBureauSwitch 
                ,DG.GroupClass
                ,MIN(DimYOAID) Min_YOA
                ,MAX(DImYOAID) Max_YOA
				,F.IsAdjusted
        
           FROM Eclipse_MI.LatestFactSignedTransaction F
           JOIN DWH_MI.LatestBridgeBureauNonBureauSwitch BNBS        ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
           JOIN Eclipse_MI.DimLegalEntity L                          ON L.DimLegalEntityID = F.DimLegalEntityID
           JOIN DWH_MI.DimBureauNonBureauSwitch BS                   ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
                  JOIN DWH_MI.DimGroupClass DG                       ON DG.DimGroupClassID = F.DimGroupClassID
                  JOIN DWH_MI.DimPolicy DP                           ON DP.DimPolicyID = F.DimPolicyID
        		  JOIN DWH.DimPolicyStatus DPS                       ON DPS.DimPolicyStatusId = F.DimPolicyStatusId   -- Include only active policy status as advised by Roop on 4th Aug,2022
                 WHERE BS.BureauNonBureauSwitch IN ('RITC Legatum','RITC Robin') AND DPS.PolicyActiveStatus = 'Active' AND DimYOAID >= 1993 --Included as advised by Roop on 4th Aug,2022
                 GROUP BY ExternalSyndicate,BS.BureauNonBureauSwitch , DG.GroupClass , IsAdjusted



        UNION ALL 
        
        SELECT 'Eclipse_MI.LatestFactSignedTransactionUnadjusted'    as TableName
        	    ,'Legatum/Robin - ConfigCheck' as ConfigCheck
        		,L.ExternalSyndicate
                ,BS.BureauNonBureauSwitch 
                ,DG.GroupClass
                ,MIN(DimYOAID) Min_YOA
                ,MAX(DImYOAID) Max_YOA
				,F.IsAdjusted
        
           FROM Eclipse_MI.LatestFactSignedTransactionUnadjusted F
           JOIN DWH_MI.LatestBridgeBureauNonBureauSwitch BNBS        ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
           JOIN Eclipse_MI.DimLegalEntity L                          ON L.DimLegalEntityID = F.DimLegalEntityID
           JOIN DWH_MI.DimBureauNonBureauSwitch BS                   ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
                  JOIN DWH_MI.DimGroupClass DG                       ON DG.DimGroupClassID = F.DimGroupClassID
                  JOIN DWH_MI.DimPolicy DP                           ON DP.DimPolicyID = F.DimPolicyID
        		  JOIN DWH.DimPolicyStatus DPS                       ON DPS.DimPolicyStatusId = F.DimPolicyStatusId   -- Include only active policy status as advised by Roop on 4th Aug,2022
                 WHERE BS.BureauNonBureauSwitch IN ('RITC Legatum','RITC Robin') AND DPS.PolicyActiveStatus = 'Active' AND DimYOAID >= 1993 --Included as advised by Roop on 4th Aug,2022
                 GROUP BY ExternalSyndicate,BS.BureauNonBureauSwitch , DG.GroupClass , IsAdjusted


        UNION ALL 
        
        SELECT 'Eclipse_MI.LatestFactWrittenPremium'    as TableName
        	    ,'Legatum/Robin - ConfigCheck' as ConfigCheck
        		,L.ExternalSyndicate
                ,BS.BureauNonBureauSwitch 
                ,DG.GroupClass
                ,MIN(DimYOAID) Min_YOA
                ,MAX(DImYOAID) Max_YOA
				,F.IsAdjusted
        
           FROM Eclipse_MI.LatestFactWrittenPremium F
           JOIN DWH_MI.LatestBridgeBureauNonBureauSwitch BNBS        ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
           JOIN Eclipse_MI.DimLegalEntity L                          ON L.DimLegalEntityID = F.DimLegalEntityID
           JOIN DWH_MI.DimBureauNonBureauSwitch BS                   ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
                  JOIN DWH_MI.DimGroupClass DG                       ON DG.DimGroupClassID = F.DimGroupClassID
                  JOIN DWH_MI.DimPolicy DP                           ON DP.DimPolicyID = F.DimPolicyID
        		  JOIN DWH.DimPolicyStatus DPS                       ON DPS.DimPolicyStatusId = F.DimPolicyStatusId   -- Include only active policy status as advised by Roop on 4th Aug,2022
                 WHERE BS.BureauNonBureauSwitch IN ('RITC Legatum','RITC Robin') AND DPS.PolicyActiveStatus = 'Active' AND DimYOAID >= 1993 --Included as advised by Roop on 4th Aug,2022
                 GROUP BY ExternalSyndicate,BS.BureauNonBureauSwitch , DG.GroupClass , IsAdjusted


		)T


--SELECT * FROM Eclipse_MI.DimLegalEntity