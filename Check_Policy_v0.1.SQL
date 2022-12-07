--Policy

with CTE_Policy_IMP as (
SELECT [POL_REF]
      ,[ENTITY_CD]
      ,[UW_REF]
      ,[POL_DESC]
      ,[CURRENCY]
      ,[S_LINE]
      ,[S_ORDER]
      ,[W_LINE]
      ,[W_ORDER]
      ,[E_LINE]
      ,[E_ORDER]
      ,[LIMIT_100]
      ,[LIMIT_NET]
      ,[EXCESS_100]
      ,[INC_DATE]
      ,[EXP_DATE]
      ,[DEDUCTIONS]
      ,[POL_YEAR]
      ,[ASSURED]
      ,[ORG_INS_NAME]
      ,[POL_STAT1]
      ,[POL_STAT2]
      ,[POL_STAT3]
      ,[POL_STAT4]
      ,[POL_STAT5]
      ,[POL_STAT6]
      ,[POL_STAT7]
      ,[POL_STAT8]
      ,[POL_STAT9]
      ,[POL_STAT10]
      ,[POL_AMT1]
      ,[POL_AMT2]
      ,[POL_AMT3]
      ,[POL_AMT4]
      ,[POL_AMT5]
      ,[POL_AMT6]
      ,[POL_AMT7]
      ,[POL_AMT8]
      ,[POL_AMT9]
      ,[POL_AMT10]
      ,[unique_key]
	  --Hash with all the columns
	  ,HashBytes('SHA1',CONCAT([POL_REF],'%',[ENTITY_CD],'%',[UW_REF],'%',[POL_DESC],'%',[CURRENCY],'%',[S_LINE],'%',[S_ORDER],'%',[W_LINE],'%',[W_ORDER],'%',[E_LINE],'%',[E_ORDER],'%',[LIMIT_100],'%',[LIMIT_NET],'%',[EXCESS_100],'%',[INC_DATE],'%',[EXP_DATE],'%',[DEDUCTIONS],'%',[POL_YEAR],'%',[ASSURED],'%',[ORG_INS_NAME],'%',[POL_STAT1],'%',[POL_STAT2],'%',[POL_STAT3],'%',[POL_STAT4],'%',[POL_STAT5],'%',[POL_STAT6],'%',[POL_STAT7],'%',[POL_STAT8],'%',[POL_STAT9],'%',[POL_STAT10],'%',[POL_AMT1],'%',[POL_AMT2],'%',[POL_AMT3],'%',[POL_AMT4],'%',[POL_AMT5],'%',[POL_AMT6],'%',[POL_AMT7],'%',[POL_AMT8],'%',[POL_AMT9],'%',[POL_AMT10])) as IMP_Hash
	  --Hash without W_ORDER column
	  --,HashBytes('SHA1',CONCAT([POL_REF],'%',[ENTITY_CD],'%',[UW_REF],'%',[POL_DESC],'%',[CURRENCY],'%',[S_LINE],'%',[S_ORDER],'%',[W_LINE],'%',[E_LINE],'%',[E_ORDER],'%',[LIMIT_100],'%',[LIMIT_NET],'%',[EXCESS_100],'%',[INC_DATE],'%',[EXP_DATE],'%',[DEDUCTIONS],'%',[POL_YEAR],'%',[ASSURED],'%',[ORG_INS_NAME],'%',[POL_STAT1],'%',[POL_STAT2],'%',[POL_STAT3],'%',[POL_STAT4],'%',[POL_STAT5],'%',[POL_STAT6],'%',[POL_STAT7],'%',[POL_STAT8],'%',[POL_STAT9],'%',[POL_STAT10],'%',[POL_AMT1],'%',[POL_AMT2],'%',[POL_AMT3],'%',[POL_AMT4],'%',[POL_AMT5],'%',[POL_AMT6],'%',[POL_AMT7],'%',[POL_AMT8],'%',[POL_AMT9],'%',[POL_AMT10])) as IMP_Hash
  FROM [XLPRO_TEST_210].[dbo].[POLICY_IMP] --where pol_ref = '400102'
  
  )


, CTE_Policy_Dev as (
SELECT [POL_REF]
      ,[ENTITY_CD]
      ,[UW_REF]
      ,[POL_DESC]
      ,[CURRENCY]
      ,[S_LINE]
      ,[S_ORDER]
      ,[W_LINE]
      ,[W_ORDER]
      ,[E_LINE]
      ,[E_ORDER]
      ,[LIMIT_100]
      ,[LIMIT_NET]
      ,[EXCESS_100]
      ,[INC_DATE]
      ,[EXP_DATE]
      ,[DEDUCTIONS]
      ,[POL_YEAR]
      ,[ASSURED]
      ,[ORG_INS_NAME]
      ,[POL_STAT1]
      ,[POL_STAT2]
      ,[POL_STAT3]
      ,[POL_STAT4]
      ,[POL_STAT5]
      ,[POL_STAT6]
      ,[POL_STAT7]
      ,[POL_STAT8]
      ,[POL_STAT9]
      ,[POL_STAT10]
      ,[POL_AMT1]
      ,[POL_AMT2]
      ,[POL_AMT3]
      ,[POL_AMT4]
      ,[POL_AMT5]
      ,[POL_AMT6]
      ,[POL_AMT7]
      ,[POL_AMT8]
      ,[POL_AMT9]
      ,[POL_AMT10]
      ,[unique_key]
	  --Hash with all the columns
	  ,HashBytes('SHA1',CONCAT([POL_REF],'%',[ENTITY_CD],'%',[UW_REF],'%',[POL_DESC],'%',[CURRENCY],'%',[S_LINE],'%',[S_ORDER],'%',[W_LINE],'%',[W_ORDER],'%',[E_LINE],'%',[E_ORDER],'%',[LIMIT_100],'%',[LIMIT_NET],'%',[EXCESS_100],'%',[INC_DATE],'%',[EXP_DATE],'%',[DEDUCTIONS],'%',[POL_YEAR],'%',[ASSURED],'%',[ORG_INS_NAME],'%',[POL_STAT1],'%',[POL_STAT2],'%',[POL_STAT3],'%',[POL_STAT4],'%',[POL_STAT5],'%',[POL_STAT6],'%',[POL_STAT7],'%',[POL_STAT8],'%',[POL_STAT9],'%',[POL_STAT10],'%',[POL_AMT1],'%',[POL_AMT2],'%',[POL_AMT3],'%',[POL_AMT4],'%',[POL_AMT5],'%',[POL_AMT6],'%',[POL_AMT7],'%',[POL_AMT8],'%',[POL_AMT9],'%',[POL_AMT10])) as DEV_Hash
	  --hash without W_ORDER column
	  --,HashBytes('SHA1',CONCAT([POL_REF],'%',[ENTITY_CD],'%',[UW_REF],'%',[POL_DESC],'%',[CURRENCY],'%',[S_LINE],'%',[S_ORDER],'%',[W_LINE],'%',[E_LINE],'%',[E_ORDER],'%',[LIMIT_100],'%',[LIMIT_NET],'%',[EXCESS_100],'%',[INC_DATE],'%',[EXP_DATE],'%',[DEDUCTIONS],'%',[POL_YEAR],'%',[ASSURED],'%',[ORG_INS_NAME],'%',[POL_STAT1],'%',[POL_STAT2],'%',[POL_STAT3],'%',[POL_STAT4],'%',[POL_STAT5],'%',[POL_STAT6],'%',[POL_STAT7],'%',[POL_STAT8],'%',[POL_STAT9],'%',[POL_STAT10],'%',[POL_AMT1],'%',[POL_AMT2],'%',[POL_AMT3],'%',[POL_AMT4],'%',[POL_AMT5],'%',[POL_AMT6],'%',[POL_AMT7],'%',[POL_AMT8],'%',[POL_AMT9],'%',[POL_AMT10])) as DEV_Hash
  FROM [XLPRO_TEST_210].[dbo].[POLICY_IMP_Dev] --where pol_ref = '400102'
  
  )
/*
SELECT * FROM (
SELECT 'IMP' as Source, * FROM CTE_Policy_IMP WHERE Pol_Ref = 'UNK'
UNION ALL
SELECT 'Dev' as Source,* FROM CTE_Policy_DEV WHERE Pol_Ref = 'UNK'
)T ORDER BY Source, POL_REF
*/
/*
SELECT 'IMP' as Source, * FROM CTE_Policy_IMP WHERE Pol_Ref = '400102'
UNION ALL
SELECT 'Dev' as Source,* FROM CTE_Policy_DEV WHERE Pol_Ref = '400102'
*/


SELECT Policy_Test_Result, Count(*) as Total FROM (
--SELECT * FROM (
SELECT I.Pol_ref as Imp_Pol_Ref, I.Imp_hash as IMP_Hash, D.Pol_ref as Dev_Pol_Ref, D.DEV_Hash
      ,Case when I.Imp_hash = D.Dev_Hash then 'Passed' else 'Failed' End as Policy_Test_Result
  FROM CTE_Policy_Imp I
  Left JOIN CTE_Policy_Dev D
     on I.POL_REF = D.Pol_Ref 
	and I.Imp_hash = D.Dev_Hash 
	--) T WHERE Policy_Test_Result = 'Failed' --and Dev_HASH is not null
	--) T WHERE Policy_Test_Result = 'Passed' --and Dev_HASH is not null
	--) T WHERE Imp_Pol_Ref = 'UNK'
	) T1 Group by Policy_Test_Result
	
--To find the count of Passed/Failed Records
/*
SELECT TR, Count(*) as Total FROM (
SELECT Imp_Pol_Ref, Imp_Total, Dev_Pol_Ref, Dev_Total
      ,case when Imp_total = Dev_total then 'Passed' else 'Failed' End as TR
  FROM
(
  SELECT Pol_ref as Imp_Pol_Ref/*, Imp_hash*/,Count(*) as Imp_Total from CTE_Policy_Imp 
  GROUP BY Pol_ref --,Imp_hash
 )I

 Left Join

(
  SELECT Pol_ref as Dev_Pol_Ref/*, DEV_Hash*/,Count(*) as Dev_Total from CTE_Policy_Dev 
  GROUP BY Pol_ref --,Dev_hash
  )D 
  
   on I.Imp_POL_REF = Dev_Pol_Ref 
  --and I.Imp_hash = D.Dev_Hash 
  )T Group by TR

*/


--To find the Detail of Passed/Failed Records in terms of Policy Counts between IMP / DEV Table
/* ************
SELECT * FROM (

SELECT Imp_Pol_Ref, Imp_Total, Dev_Pol_Ref, Dev_Total
      ,case when Imp_total = Dev_total then 'Passed' else 'Failed' End as TR
  FROM
(
  SELECT Pol_ref as Imp_Pol_Ref/*, Imp_hash*/,Count(*) as Imp_Total from CTE_Policy_Imp 
  GROUP BY Pol_ref --,Imp_hash
 )I

 Left Join

(
  SELECT Pol_ref as Dev_Pol_Ref/*, DEV_Hash*/,Count(*) as Dev_Total from CTE_Policy_Dev 
  GROUP BY Pol_ref --,Dev_hash
  )D 
  
   on I.Imp_POL_REF = Dev_Pol_Ref 
  --and I.Imp_hash = D.Dev_Hash 
)T where imp_pol_ref = 'FF169Q19B000-1' --WHERE TR <> 'Failed'

order by 1 desc

*********** */
  
  --select 450145 + 335281 = 785426