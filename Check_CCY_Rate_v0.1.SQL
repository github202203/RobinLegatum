--[CCY_RATE_IMP]
with CTE_CCY_RATE_IMP as (
SELECT [SET_ID]
      ,[CURRENCY]
      ,[AS_AT_DATE]
      ,[ROE]
      ,[unique_key]
	  ,HASHBYTES('SHA1',CONCAT([SET_ID],'%',[CURRENCY],'%',[AS_AT_DATE],'%',[ROE])) as Imp_Hash
  FROM [XLPRO_TEST_210].[dbo].[CCY_RATE_IMP] --53572 (49346 failed / 4126 Passed)
  --WHERE CURRENCY = 'ADO'
  --ORDER BY AS_AT_DATE
  )

,CTE_CCY_RATE_IMP_DEV as (
SELECT [SET_ID]
      ,[CURRENCY]
      ,[AS_AT_DATE]
      ,[ROE]
      ,[unique_key]
	  ,HASHBYTES('SHA1',CONCAT([SET_ID],'%',[CURRENCY],'%',[AS_AT_DATE],'%',[ROE])) as Dev_Hash
  FROM [XLPRO_TEST_210].[dbo].[CCY_RATE_IMP_DEV]
  --WHERE CURRENCY = 'ADO'
  )

  --Test Result in Summary
SELECT TestResult, Count(*) as Total
FROM (
SELECT IMP_Set_Id,IMP_Currency,IMP_AS_AT_DATE,IMP_Roe
      ,DEV_Set_Id,DEV_Currency,DEV_AS_AT_DATE,DEV_Roe,Imp_Hash,DEV_Hash
	  ,Case when Imp_hash = Dev_Hash then 'Passed' else 'Failed' End as TestResult
  FROM (
        SELECT [SET_ID] as IMP_Set_ID,[CURRENCY] as IMP_Currency,[AS_AT_DATE] as IMP_AS_AT_DATE,[ROE] as IMP_Roe,HASHBYTES('SHA1',CONCAT([SET_ID],'%',[CURRENCY],'%',[AS_AT_DATE],'%',[ROE])) as Imp_Hash 
          FROM CTE_CCY_RATE_IMP) T1

 Left Join 
 
       (
        SELECT [SET_ID] as Dev_Set_ID,[CURRENCY] as Dev_Currency,[AS_AT_DATE] as Dev_AS_AT_DATE,[ROE] as Dev_Roe,HASHBYTES('SHA1',CONCAT([SET_ID],'%',[CURRENCY],'%',[AS_AT_DATE],'%',[ROE])) as Dev_Hash 
          FROM CTE_CCY_RATE_IMP_DEV
		  )T2 
   on Imp_Currency = Dev_Currency
  and IMP_AS_AT_DATE = Dev_AS_AT_DATE
  and IMP_Roe = Dev_Roe
  ) TT Group by TestResult

select 49346+4126