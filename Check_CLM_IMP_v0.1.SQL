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

  FROM [XLPRO_TEST_210].[dbo].[CLM_SETT_IMP] --WHERE Pol_Ref = '1442623'
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

  FROM [XLPRO_TEST_210].[dbo].[CLM_SETT_IMP_Dev] --WHERE Pol_Ref = '1442623'
)

--SELECT TestResult, Count(*) as Total FROM (
SELECT * FROM (
SELECT IMP_POL_REf, IMP_Hash, Dev_Pol_Ref, Dev_Hash 
      ,Case when IMP_Hash = Dev_Hash then 'Passed' else 'Failed' End as TestResult
  FROM 
      (
       SELECT POL_Ref as IMP_Pol_Ref, IMP_Hash 
         FROM CTE_IMP 
		) I
   Join
      (     
       SELECT POL_Ref as DEV_Pol_Ref, DEV_Hash 
         FROM CTE_DEV 
		) D

  on IMP_Pol_ref = Dev_Pol_Ref
 and IMP_Hash = Dev_Hash
 )TT WHERE TestResult = 'Passed'--304181
 --)TT Group by TestResult

--SELECT COUNT(*) FROM XLPRO_TEST_210.dbo.CLM_SETT_IMP --304857
--SELECT COUNT(*) FROM XLPRO_TEST_210.dbo.CLM_SETT_IMP_DEV where Pol_Ref = '1389906'

--SELECT * FROM XLPRO_TEST_210.dbo.CLM_SETT_IMP I
 --WHERE EXISTS ( SELECT 1 FROM XLPRO_TEST_210.dbo.CLM_SETT_IMP_DEV D WHERE I.POL_REF = D.POL_REF)