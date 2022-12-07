--Req 5.6  Hard-coded dimension for "adjusted policy"

--Output from table for adjusted hard-coded value (INW_RISK)
select reporting_flag,*  
  from [dim].[inw_risk]
 where full_uw_ref like '%adjusted%'

--Output from RS view shows only latest load as expected ( no duplicate records ) for adjusted hard-coded value  (INW_RISK)
 select reporting_flag, *  
  from [RS].[inw_risk]
 where full_uw_ref like '%adjusted%'

--Output from table for Unknown value - Inw_GroupClass
select * 
  from dim.inw_groupclass
 where Group_Class = 'UNKNOWN'

--Output from RS view for Unknown value ( no duplicates ) - INW_Group_Class
select * 
  from RS.inw_group_class
 where Group_Class = 'UNKNOWN'

--Output from table for Unknown value - Outw_GroupClass
select * 
  from dim.outw_groupclass 
 where Group_Class = 'UNKNOWN'

--Output from RS view for Unknown value ( no duplicates ) - OUT_Group_Class
select * 
  from RS.outw_group_class
 where Group_Class = 'UNKNOWN'