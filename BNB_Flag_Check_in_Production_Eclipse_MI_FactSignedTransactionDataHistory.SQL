--To Check thw BNB flag data in Production for Eclipse_MI.FactSignedTransaction
select @@SERVERNAME as ServerName,'Eclipse_MI.FactSignedTransaction' as TableName,  T1.* 
	  --Legatum Rules 
      ,Case WHEN (GroupClass = 'AVIATION BY' and MIN_YOA >= 2002  and MAX_YOA <= 2014 ) OR
	             (GroupClass = 'DISC 2400'	 and MIN_YOA >= 1993  and MAX_YOA <= 2014 ) OR
		         (GroupClass = 'DISC 800'	 and MIN_YOA >= 1993  and MAX_YOA <= 2001 ) OR 
		         (GroupClass = 'DISC UK'	 and MIN_YOA >= 2002  and MAX_YOA <= 2014 ) OR 
		         (GroupClass = 'PI NON US'	 and MIN_YOA >= 2002  and MAX_YOA <= 2017 ) OR 
		         (GroupClass = 'EL UK'		 and MIN_YOA >= 2002  and MAX_YOA <= 2014 ) OR 
		         (GroupClass = 'PL INT'	     and MIN_YOA >= 2004  and MAX_YOA <= 2004 ) OR 
		         (GroupClass = 'PL UK'		 and MIN_YOA >= 2002  and MAX_YOA <= 2014 ) OR 
		         (GroupClass = 'DISC 735'	 and MIN_YOA >= 1993  and MAX_YOA <= 2001 ) OR 
		         (GroupClass = 'DISC 250'	 and MIN_YOA >= 1993  and MAX_YOA <= 2001 ) OR 
				 (GroupClass = 'DISC 1202'	 and MIN_YOA >= 1993  and MAX_YOA <= 2001 ) OR 
		         (GroupClass = 'DISC 2040'	 and MIN_YOA >= 1993  and MAX_YOA <= 2014 ) 
		    THEN 'RITC Legatum'
					   --ELSE 'Retained'
	 --Robin Rules 
		    WHEN (GroupClass = 'BGSU CASUALTY RI LATAM'		 and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' ) OR
		         (GroupClass = 'BGSU ENGINEERING FAC LATAM'	 and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' ) OR 
		         (GroupClass = 'BGSU INLAND MARINE'			 and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' ) OR 
		         (GroupClass = 'BGSU LIABILITY ARP SC'		 and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' ) OR 
		         (GroupClass = 'BGSU LIABILITY PACKAGE CJSO' and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' ) OR 
		         (GroupClass = 'BGSU LIABILITY PACKAGE FD'	 and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' ) OR 
		         (GroupClass = 'BGSU PROPERTY FAC LATAM'	 and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' ) OR 
		         (GroupClass = 'BGSU PROPERTY PACKAGE CJSO'	 and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' ) OR 
		         (GroupClass = 'BGSU PROPERTY PACKAGE FD'	 and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' ) OR 
				 (GroupClass = 'BGSU PROGRAMS'				 and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' ) OR 
		         (GroupClass = 'BGS SINGAPORE'				 and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' ) OR 
				 (GroupClass = 'CHINA CONSTRUCTION'			 and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' ) OR 
				 (GroupClass = 'ENGINEERING & CPE'			 and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' ) OR 
				 (GroupClass = 'AEROSPACE LIABILITY'		 and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' ) OR 
				 (GroupClass = 'AIRLINES HULL'				 and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' ) OR 
				 (GroupClass = 'AIRLINES LIABILITY'			 and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' ) OR 
				 (GroupClass = 'AVIATION XL'				 and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' ) OR 
				 (GroupClass = 'GENERAL AVIATION HULL'		 and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' ) OR 
				 (GroupClass = 'GENERAL AVIATION LIABILITY'	 and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' ) OR 
				 (GroupClass = 'SCION CASUALTY'				 and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' ) OR 
				 (GroupClass = 'BGSU LIABILITY PACKAGE SIR'	 and MIN_YOA >= 2002 and MAX_YOA <= 2018 and ExternalSyndicate = '2987' ) OR --MAX_YOA changed to 2018 on 18th Aug
				 (GroupClass = 'BGSU PROPERTY PACKAGE SIR'	 and MIN_YOA >= 2002 and MAX_YOA <= 2018 and ExternalSyndicate = '2987' )    --MAX_YOA changed to 2018 on 18th Aug
		    THEN 'RITC Robin'
			ELSE 'Retained'
	    End as ExpedtedResult
			 

      ,Case WHEN BureauNonBureauSwitch = 
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
			 ELSE 'Failed'
				   
		End as  TestResult
  from (
  
        select ExternalSyndicate
              ,BureauNonBureauSwitch 
              ,GroupClass
              ,MIN(DimYOAID) Min_YOA
              ,MAX(DImYOAID) Max_YOA
        	  ,IsAdjusted
        	  ,DimPolicyID
        
          from (
                select  DimPolicyID, F.IsAdjusted,BS.BureauNonBureauSwitch, L.ExternalSyndicate,F.DimPolicyStatusID, PS.GroupPolicyStatus, PS.PolicyActiveStatus, DimYOAID, DimProcessPeriodID,F.DimGroupClassID,D.GroupClass
                  --from dwh.FactSignedTransactionDataHistory (nolock) F
				  from Eclipse_MI.FactSignedTransaction (nolock) F
                  join dwh_mi.DimGroupClass (nolock) D on F.DimGroupClassID = D.DimGroupClassID
                  join dwh.DimPolicyStatus (nolock) PS on F.DimPolicyStatusID = PS.DimPolicyStatusID
                  join dwh_mi.DimGroupClass (nolock) DG on DG.DimGroupClassID = F.DimGroupClassID
                  join dwh_mi.LatestBridgeBureauNonBureauSwitch (nolock) BNBS on BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
                  join dwh_mi.DimBureauNonBureauSwitch (nolock) BS on BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
	        	  join Eclipse_MI.DimLegalEntity L on L.DimLegalEntityID = F.DimLegalEntityID
                 where DimPolicyID in (
                                         9531330
                                        ,9680238
                                        ,9576184
                                        ,9532632
                                        ,9680240
                                        ,9880683
                                        ,9782097
                                        /*,9531330
                                        ,9680238
                                        ,9532632
                                        ,9576184
                                        ,9680240
                                        ,9782097
                                        ,9880683 */
                                        )
                )T 
         where BureauNonBureauSwitch IN ('Legatum','Robin') 
		   and PolicyActiveStatus = 'Active' 
		   and DimYOAID >= 1993 --Included as advised by Roop on 4th Aug,2022
         group By ExternalSyndicate,BureauNonBureauSwitch , GroupClass, IsAdjusted,DimPolicyID
        )T1