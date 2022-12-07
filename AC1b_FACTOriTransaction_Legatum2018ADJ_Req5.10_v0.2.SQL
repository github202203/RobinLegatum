USE MYMI_Datawarehouse;

DROP TABLE IF EXISTS QA.TE_FOT_AC1b_Req510
;

SELECT 'MyMI_DataWarehouse.DWH_MI.FactORITransaction' as TableName, 'AC1b - Include Legatum2018ADJ' as AcceptanceCriteria, *, GetDate() as TestedOn
  INTO QA.TE_FOT_AC1b_Req510
  FROM (
SELECT T.*,
        --Legatum Rules 
		Case WHEN ORILegatumFlag = 
		          --Legatum Rules 
                  Case WHEN (GroupClass = 'AVIATION BY' and DimYOAID >= 2002  and DimYOAID <= 2014 ) OR
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
					   ELSE 'Retained'
					   
	               End 
		     THEN 'Passed' 

			 WHEN ORILegatumFlag = 
			      --Robin Rules 
			      Case WHEN (GroupClass = 'BGSU CASUALTY RI LATAM'		and DimYOAID >= 2002 and DimYOAID <= 2020 and ExternalSyndicate = '2987' ) OR
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
							(GroupClass = 'BGSU LIABILITY PACKAGE SIR'	and DimYOAID >= 2002 and DimYOAID <= 2020 and ExternalSyndicate = '2987' ) OR 
							(GroupClass = 'BGSU PROPERTY PACKAGE SIR'	and DimYOAID >= 2002 and DimYOAID <= 2020 and ExternalSyndicate = '2987' ) 
		          	   THEN 'RITC Robin'
					   --ELSE 'RITC Robin Failed'
	               End
			 THEN 'Passed'
			 ELSE CASE WHEN ORILegatumFlag = 'Retained' and ORIContractReference in ('LEGATUM2018','ROBIN2021','ROBIN2021C') THEN 'Passed' ELSE 'Failed' END 
				   
		 End as  TestResult
FROM (
SELECT F.DimDataHistoryID
	  ,G.GroupClass
	  ,IsAdjusted
      ,F.DimORILegatumFlagID
	  ,F.DimYOAID
	  ,L.ORILegatumFlag
	  ,P.ORIContractReference
	  ,S.ExternalSyndicate
	  ,S.Syndicate
	  ,DimProcessPeriodID
      ,SUM(ORISignedPremiumPaidSettCcy) AS ORISignedPremiumPaidSettCcy 
	  ,SUM(ORIPaidClaimSettCcy) AS ORIPaidClaimSettCcy
	  ,SUM(ORIOutstandingClaimSettCcy) AS ORIOutstandingClaimSettCcy
	  ,SUM(ORIPremiumOutstandingSettCcy) AS ORIPremiumOutstandingSettCcy

  FROM MyMI_DataWarehouse.DWH_MI.FactORITransaction F
  JOIN MyMI_DataWarehouse.DWH_MI.DimORIPlacement P ON P.DimORIPlacementID=F.DimORIPlacementID
  JOIN MyMI_DataWarehouse.DWH.DimORILegatumFlag L  ON L.DimORILegatumFlagID=F.DimORILegatumFlagID
  JOIN MyMI_DataWarehouse.DWH_MI.DimGroupClass G   ON G.DimGroupClassID=F.DimGroupClassID
  JOIN MyMI_DataWarehouse.DWH_MI.DimLegalEntity S  ON S.DimLegalEntityID=F.DimLegalEntityID
 WHERE 1=1
   AND F.DimDataHistoryID IN ( SELECT MAX(DimDataHistoryID) FROM MyMI_DataWarehouse.DWH_MI.DimDataHistory )
   --AND G.GroupClass='DISC 250'
   --AND IsAdjusted=1

 GROUP BY  G.GroupClass
	      ,IsAdjusted
          ,F.DimORILegatumFlagID
	      ,F.DimYOAID
	      ,L.ORILegatumFlag
	      ,P.ORIContractReference  
	      ,S.ExternalSyndicate,S.Syndicate
	      ,DimProcessPeriodID
	      ,F.DimDataHistoryID
		  )T
		  )F

WHERE ORIContractReference in ('LEGATUM2018ADJ') --Acceptance Criteria 1b

SELECT * FROM QA.TE_FOT_AC1b_Req510