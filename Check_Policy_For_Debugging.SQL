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

SELECT * FROM (
SELECT 'IMP' as Source, * FROM CTE_Policy_IMP WHERE Pol_Ref = 'CG071J17A003-1'
UNION ALL
SELECT 'Dev' as Source,* FROM CTE_Policy_DEV WHERE Pol_Ref = 'CG071J17A003-1'
)T ORDER BY Source, POL_REF

/*
SELECT 'IMP' as Source, * FROM CTE_Policy_IMP WHERE Pol_Ref = '400102'
UNION ALL
SELECT 'Dev' as Source,* FROM CTE_Policy_DEV WHERE Pol_Ref = '400102'
*/

