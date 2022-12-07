With CTE_IMP as (
SELECT [EVENT]
      ,[SUB_EVENT]
      ,[AC_STAT1]
      ,[AC_STAT2]
      ,[AC_STAT3]
      ,[AC_STAT4]
      ,[AC_STAT5]
      ,[AC_STAT6]
      ,[AC_STAT7]
      ,[AC_STAT8]
      ,[AC_STAT9]
      ,[AC_STAT10]
      ,[ENTITY_CD]
      ,[TRUST_FUND]
      ,[RISK_CODE]
      ,[FIL_CODE]
      ,[AC_YEAR]
      ,[POL_REF]
      ,[INC_DATE]
      ,[ATT_DATE]
      ,[SETT_REF]
      ,[SETT_DATE]
      ,[CLM_REF]
      ,[CLM_DOL]
      ,[TRAN_CD]
      ,[TRANS_DATE]
      ,[ACCOUNT_DATE]
      ,[S_LINE]
      ,[S_ORDER]
      ,[CCY_ORG]
      ,[AMT_CCY_ORG]
      ,[CCY_SETT]
      ,[AMT_CCY_SETT]
      ,[CLM_TYPE]
      ,[RISK_ID]
      --,[unique_key]
	  --Hash with all the columns
     --,HashBytes('SHA1', CONCAT([EVENT],'%',[SUB_EVENT],'%',[AC_STAT1],'%',[AC_STAT2],'%',[AC_STAT3],'%',[AC_STAT4],'%',[AC_STAT5],'%',[AC_STAT6],'%',[AC_STAT7],'%',[AC_STAT8],'%',[AC_STAT9],'%',[AC_STAT10],'%',[ENTITY_CD],'%',[TRUST_FUND],'%',[RISK_CODE],'%',[FIL_CODE],'%',[AC_YEAR],'%',[POL_REF],'%',[INC_DATE],'%',[ATT_DATE],'%',[SETT_REF],'%',[SETT_DATE],'%',[CLM_REF],'%',[CLM_DOL],'%',[TRAN_CD],'%',[TRANS_DATE],'%',[ACCOUNT_DATE],'%',[S_LINE],'%',[S_ORDER],'%',[CCY_ORG],'%',[AMT_CCY_ORG],'%',[CCY_SETT],'%',[AMT_CCY_SETT],'%',[CLM_TYPE],'%',[RISK_ID]))  as IMP_Hash
	 --Hash without AC_STAT7 column & Account_Date
	 ,HashBytes('SHA1', CONCAT([EVENT],'%',[SUB_EVENT],'%',[AC_STAT1],'%',[AC_STAT2],'%',[AC_STAT3],'%',[AC_STAT4],'%',[AC_STAT5],'%',[AC_STAT6],'%',[AC_STAT8],'%',[AC_STAT9],'%',[AC_STAT10],'%',[ENTITY_CD],'%',[TRUST_FUND],'%',[RISK_CODE],'%',[FIL_CODE],'%',[AC_YEAR],'%',[POL_REF],'%',[INC_DATE],'%',[ATT_DATE],'%',[SETT_REF],'%',[SETT_DATE],'%',[CLM_REF],'%',[CLM_DOL],'%',[TRAN_CD],'%',[TRANS_DATE],'%',[S_LINE],'%',[S_ORDER],'%',[CCY_ORG],'%',[AMT_CCY_ORG],'%',[CCY_SETT],'%',[AMT_CCY_SETT],'%',[CLM_TYPE],'%',[RISK_ID]))  as IMP_Hash

  FROM [XLPRO_TEST_210].[dbo].[CLM_SETT_IMP] WHERE Pol_Ref = '1442623'
)

,CTE_DEV as (
SELECT [EVENT]
      ,[SUB_EVENT]
      ,[AC_STAT1]
      ,[AC_STAT2]
      ,[AC_STAT3]
      ,[AC_STAT4]
      ,[AC_STAT5]
      ,[AC_STAT6]
      ,[AC_STAT7]
      ,[AC_STAT8]
      ,[AC_STAT9]
      ,[AC_STAT10]
      ,[ENTITY_CD]
      ,[TRUST_FUND]
      ,[RISK_CODE]
      ,[FIL_CODE]
      ,[AC_YEAR]
      ,[POL_REF]
      ,[INC_DATE]
      ,[ATT_DATE]
      ,[SETT_REF]
      ,[SETT_DATE]
      ,[CLM_REF]
      ,[CLM_DOL]
      ,[TRAN_CD]
      ,[TRANS_DATE]
      ,[ACCOUNT_DATE]
      ,[S_LINE]
      ,[S_ORDER]
      ,[CCY_ORG]
      ,[AMT_CCY_ORG]
      ,[CCY_SETT]
      ,[AMT_CCY_SETT]
      ,[CLM_TYPE]
      ,[RISK_ID]
      --,[unique_key]
     --,HashBytes('SHA1', CONCAT([EVENT],'%',[SUB_EVENT],'%',[AC_STAT1],'%',[AC_STAT2],'%',[AC_STAT3],'%',[AC_STAT4],'%',[AC_STAT5],'%',[AC_STAT6],'%',[AC_STAT7],'%',[AC_STAT8],'%',[AC_STAT9],'%',[AC_STAT10],'%',[ENTITY_CD],'%',[TRUST_FUND],'%',[RISK_CODE],'%',[FIL_CODE],'%',[AC_YEAR],'%',[POL_REF],'%',[INC_DATE],'%',[ATT_DATE],'%',[SETT_REF],'%',[SETT_DATE],'%',[CLM_REF],'%',[CLM_DOL],'%',[TRAN_CD],'%',[TRANS_DATE],'%',[ACCOUNT_DATE],'%',[S_LINE],'%',[S_ORDER],'%',[CCY_ORG],'%',[AMT_CCY_ORG],'%',[CCY_SETT],'%',[AMT_CCY_SETT],'%',[CLM_TYPE],'%',[RISK_ID]))  as DEV_Hash
	 --Hash without AC_STAT7 column & Account_Date
	 ,HashBytes('SHA1', CONCAT([EVENT],'%',[SUB_EVENT],'%',[AC_STAT1],'%',[AC_STAT2],'%',[AC_STAT3],'%',[AC_STAT4],'%',[AC_STAT5],'%',[AC_STAT6],'%',[AC_STAT8],'%',[AC_STAT9],'%',[AC_STAT10],'%',[ENTITY_CD],'%',[TRUST_FUND],'%',[RISK_CODE],'%',[FIL_CODE],'%',[AC_YEAR],'%',[POL_REF],'%',[INC_DATE],'%',[ATT_DATE],'%',[SETT_REF],'%',[SETT_DATE],'%',[CLM_REF],'%',[CLM_DOL],'%',[TRAN_CD],'%',[TRANS_DATE],'%',[S_LINE],'%',[S_ORDER],'%',[CCY_ORG],'%',[AMT_CCY_ORG],'%',[CCY_SETT],'%',[AMT_CCY_SETT],'%',[CLM_TYPE],'%',[RISK_ID]))  as DEV_Hash

  FROM [XLPRO_TEST_210].[dbo].[CLM_SETT_IMP_Dev] WHERE Pol_Ref = '1442623'
)

       SELECT 'IMP' as Source,* FROM CTE_IMP 
	   UNION ALL
       SELECT 'DEV' as Source,* FROM CTE_DEV 
		

  