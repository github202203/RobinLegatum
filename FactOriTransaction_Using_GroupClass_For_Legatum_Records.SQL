--FactORITransaction
--Based on GroupClass
--Show only Failed Records from Legatum
--Can be ignored if SUM of all the measures from the failed records are 0

DECLARE @MaxHistoryId	INT;
    SET @MaxHistoryId = (SELECT MAX(DimDataHistoryID) FROM MyMI_DataWarehouse.DWH_MI.DimDataHistory);
	
SELECT --Display only failed records 
       'DWH_MI.FactORITransaction' as TableName
      ,'ORI Robin & Legatum Flag - Using GroupClass'  as Scenario 
	  ,F.*
      --SUM(ORISignedPremiumPaidSettCcy) as SUM_ORISignedPremiumPaidSettCcy ,SUM(ORIPaidClaimSettCcy) as SUM_ORIPaidClaimSettCcy  ,SUM(ORIOutstandingClaimSettCcy) as SUM_ORIOutstandingClaimSettCcy ,SUM(ORIPremiumOutstandingSettCcy) as SUM_ORIPremiumOutstandingSettCcy
  FROM (
SELECT T.*
      ,Case WHEN ORILegatumFlag = ExpectedFlag THEN 'Passed' Else 'Failed' End as TestResult
  FROM (

SELECT 'Basedon_GroupClass' as BasedOn  
      ,F.DimDataHistoryID
      ,F.DimSourceSystemID
	  ,SS.SourceSystemName
	  ,G.GroupClass
	  ,F.DimGroupClassID
	  ,G.DimORIClassID
	  ,IsAdjusted
      ,F.DimORILegatumFlagID
	  ,F.DimYOAID
	  ,L.ORILegatumFlag
	  ,P.ORIContractReference
	  ,S.ExternalSyndicate
	  ,S.Syndicate
	  ,DimProcessPeriodID
	  ,SUM(ORISignedPremiumPaidSettCcy)  AS ORISignedPremiumPaidSettCcy 
	  ,SUM(ORIPaidClaimSettCcy)          AS ORIPaidClaimSettCcy
	  ,SUM(ORIOutstandingClaimSettCcy)   AS ORIOutstandingClaimSettCcy
	  ,SUM(ORIPremiumOutstandingSettCcy) AS ORIPremiumOutstandingSettCcy
	  ,Case WHEN ORIContractReference in ('LEGATUM2018','ROBIN2021','ROBIN2021C') THEN 'Retained' 
	                   WHEN (GroupClass = 'AVIATION BY' and DimYOAID >= 2002  and DimYOAID <= 2014 ) OR
	                        (GroupClass = 'DISC 2400'	and DimYOAID >= 1993  and DimYOAID <= 2014 ) OR
		          	        (GroupClass = 'DISC 800'	and DimYOAID >= 1993  and DimYOAID <= 2001 ) OR 
		          	        (GroupClass = 'DISC UK'	    and DimYOAID >= 2002  and DimYOAID <= 2014 ) OR 
		          	        (GroupClass = 'PI NON US'	and DimYOAID >= 2002  and DimYOAID <= 2017 ) OR 
		          	        (GroupClass = 'EL UK'		and DimYOAID >= 2002  and DimYOAID <= 2014 ) OR 
		          	        (GroupClass = 'PL INT'	    and DimYOAID >= 2004  and DimYOAID <= 2004 ) OR 
		          	        (GroupClass = 'PL UK'		and DimYOAID >= 2002  and DimYOAID <= 2014 ) OR 
		          	        (GroupClass = 'DISC 735'	and DimYOAID >= 1993  and DimYOAID <= 2001 ) OR 
		          	        (GroupClass = 'DISC 250'	and DimYOAID >= 1993  and DimYOAID <= 2001 ) OR 
							(GroupClass = 'DISC 1202'	and DimYOAID >= 1993  and DimYOAID <= 2001 ) OR 
		          	        (GroupClass = 'DISC 2040'	and DimYOAID >= 1993  and DimYOAID <= 2014 ) 
		          	   THEN 'RITC Legatum'

					   WHEN (GroupClass = 'BGSU CASUALTY RI LATAM'		and DimYOAID >= 2002 and DimYOAID <= 2020 and ExternalSyndicate = '2987' ) OR
		          	        (GroupClass = 'BGSU ENGINEERING FAC LATAM'	and DimYOAID >= 2002 and DimYOAID <= 2020 and ExternalSyndicate = '2987' ) OR 
		          	        (GroupClass = 'BGSU INLAND MARINE'			and DimYOAID >= 2002 and DimYOAID <= 2020 and ExternalSyndicate = '2987' ) OR 
		          	        (GroupClass = 'BGSU LIABILITY ARP SC'		and DimYOAID >= 2002 and DimYOAID <= 2020 and ExternalSyndicate = '2987' ) OR 
		          	        (GroupClass = 'BGSU LIABILITY PACKAGE CJSO'	and DimYOAID >= 2002 and DimYOAID <= 2020 and ExternalSyndicate = '2987' ) OR 
		          	        (GroupClass = 'BGSU LIABILITY PACKAGE FD'	and DimYOAID >= 2002 and DimYOAID <= 2020 and ExternalSyndicate = '2987' ) OR 
		          	        (GroupClass = 'BGSU PROPERTY FAC LATAM'		and DimYOAID >= 2002 and DimYOAID <= 2020 and ExternalSyndicate = '2987' ) OR 
		          	        (GroupClass = 'BGSU PROPERTY PACKAGE CJSO'	and DimYOAID >= 2002 and DimYOAID <= 2020 and ExternalSyndicate = '2987' ) OR 
		          	        (GroupClass = 'BGSU PROPERTY PACKAGE FD'	and DimYOAID >= 2002 and DimYOAID <= 2020 and ExternalSyndicate = '2987' ) OR 
							(GroupClass = 'BGSU PROGRAMS'				and DimYOAID >= 2002 and DimYOAID <= 2020 and ExternalSyndicate = '2987' ) OR 
		          	        (GroupClass = 'BGS SINGAPORE'				and DimYOAID >= 2002 and DimYOAID <= 2020 and ExternalSyndicate = '2987' ) OR 
							(GroupClass = 'CHINA CONSTRUCTION'			and DimYOAID >= 2002 and DimYOAID <= 2020 and ExternalSyndicate = '2987' ) OR 
							(GroupClass = 'ENGINEERING & CPE'			and DimYOAID >= 2002 and DimYOAID <= 2020 and ExternalSyndicate = '2987' ) OR 
							(GroupClass = 'AEROSPACE LIABILITY'			and DimYOAID >= 2002 and DimYOAID <= 2020 and ExternalSyndicate = '2987' ) OR 
							(GroupClass = 'AIRLINES HULL'				and DimYOAID >= 2002 and DimYOAID <= 2020 and ExternalSyndicate = '2987' ) OR 
							(GroupClass = 'AIRLINES LIABILITY'			and DimYOAID >= 2002 and DimYOAID <= 2020 and ExternalSyndicate = '2987' ) OR 
							(GroupClass = 'AVIATION XL'					and DimYOAID >= 2002 and DimYOAID <= 2020 and ExternalSyndicate = '2987' ) OR 
							(GroupClass = 'GENERAL AVIATION HULL'		and DimYOAID >= 2002 and DimYOAID <= 2020 and ExternalSyndicate = '2987' ) OR 
							(GroupClass = 'GENERAL AVIATION LIABILITY'	and DimYOAID >= 2002 and DimYOAID <= 2020 and ExternalSyndicate = '2987' ) OR 
							(GroupClass = 'SCION CASUALTY'				and DimYOAID >= 2002 and DimYOAID <= 2020 and ExternalSyndicate = '2987' ) OR 
							(GroupClass = 'BGSU LIABILITY PACKAGE SIR'	and DimYOAID >= 2002 and DimYOAID <= 2018 and ExternalSyndicate = '2987' ) OR 
							(GroupClass = 'BGSU PROPERTY PACKAGE SIR'	and DimYOAID >= 2002 and DimYOAID <= 2018 and ExternalSyndicate = '2987' ) 
		          	   THEN 'RITC Robin'
					   ELSE 'Retained'
	               End as ExpectedFlag

  FROM MyMI_DataWarehouse.DWH_MI.FactORITransaction F
  JOIN MyMI_DataWarehouse.DWH_MI.DimSourceSystem   SS ON F.DimSourceSystemID = SS.DimSourceSystemID
  JOIN MyMI_DataWarehouse.DWH_MI.DimORIPlacement    P ON P.DimORIPlacementID = F.DimORIPlacementID
  JOIN MyMI_DataWarehouse.DWH.DimORILegatumFlag     L ON L.DimORILegatumFlagID = F.DimORILegatumFlagID
  JOIN MyMI_DataWarehouse.DWH_MI.DimGroupClass      G ON G.DimGroupClassID = F.DimGroupClassID -- Original query
  --JOIN MyMI_DataWarehouse.DWH_MI.DimGroupClass      G ON G.DimORIClassID = F.DimGroupClassID
  JOIN MyMI_DataWarehouse.DWH_MI.DimLegalEntity     S ON S.DimLegalEntityID = F.DimLegalEntityID
 WHERE 1=1
   --AND F.DimDataHistoryID IN ( SELECT MAX(DimDataHistoryID) FROM MyMI_DataWarehouse.DWH_MI.DimDataHistory )
   AND F.DimDataHistoryID = @MaxHistoryId
   AND GroupClass in 
                     (
                     'AVIATION BY' 
                    ,'DISC 2400'	
                    ,'DISC 800'	
                    ,'DISC UK'	    
                    ,'PI NON US'	
                    ,'EL UK'		
                    ,'PL INT'	    
                    ,'PL UK'		
                    ,'DISC 735'	
                    ,'DISC 250'	
                    ,'DISC 1202'	
                    ,'DISC 2040'	
                    ,'BGSU CASUALTY RI LATAM'		
                    ,'BGSU ENGINEERING FAC LATAM'	
                    ,'BGSU INLAND MARINE'			
                    ,'BGSU LIABILITY ARP SC'		
                    ,'BGSU LIABILITY PACKAGE CJSO'	
                    ,'BGSU LIABILITY PACKAGE FD'	
                    ,'BGSU PROPERTY FAC LATAM'		
                    ,'BGSU PROPERTY PACKAGE CJSO'	
                    ,'BGSU PROPERTY PACKAGE FD'	
                    ,'BGSU PROGRAMS'				
                    ,'BGS SINGAPORE'				
                    ,'CHINA CONSTRUCTION'			
                    ,'ENGINEERING & CPE'			
                    ,'AEROSPACE LIABILITY'			
                    ,'AIRLINES HULL'				
                    ,'AIRLINES LIABILITY'			
                    ,'AVIATION XL'					
                    ,'GENERAL AVIATION HULL'		
                    ,'GENERAL AVIATION LIABILITY'	
                    ,'SCION CASUALTY'				
                    ,'BGSU LIABILITY PACKAGE SIR'	
                    ,'BGSU PROPERTY PACKAGE SIR'	
                    )

GROUP BY F.DimDataHistoryID
      ,F.DimSourceSystemID
	  ,SS.SourceSystemName
	  ,G.GroupClass
	  ,F.DimGroupClassID
	  ,G.DimORIClassID
	  ,IsAdjusted
      ,F.DimORILegatumFlagID
	  ,F.DimYOAID
	  ,L.ORILegatumFlag
	  ,P.ORIContractReference
	  ,S.ExternalSyndicate
	  ,S.Syndicate
	  ,DimProcessPeriodID
)T 
)F 

WHERE  TestResult <>  'Passed'
  AND DimGroupClassID NOT in (1101,1128, 343) -- Included as advised by Rishi on 18th Aug, 2022

