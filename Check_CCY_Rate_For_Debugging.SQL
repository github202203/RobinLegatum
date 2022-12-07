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


        SELECT 'IMP' as Source,[SET_ID] as IMP_Set_ID,[CURRENCY] as IMP_Currency,[AS_AT_DATE] as IMP_AS_AT_DATE,[ROE] as IMP_Roe,HASHBYTES('SHA1',CONCAT([SET_ID],'%',[CURRENCY],'%',[AS_AT_DATE],'%',[ROE])) as Imp_Hash 
          FROM CTE_CCY_RATE_IMP
		 WHERE CURRENCY = 'INR' and As_At_Date = '2000-01-01' --and Roe = 44.415000

 UNION ALL
 
       
        SELECT 'Dev' as Source,[SET_ID] as Dev_Set_ID,[CURRENCY] as Dev_Currency,[AS_AT_DATE] as Dev_AS_AT_DATE,[ROE] as Dev_Roe,HASHBYTES('SHA1',CONCAT([SET_ID],'%',[CURRENCY],'%',[AS_AT_DATE],'%',[ROE])) as Dev_Hash 
          FROM CTE_CCY_RATE_IMP_DEV
		 WHERE CURRENCY = 'INR' and As_At_Date = '2000-01-01' --and Roe = 44.415000

   

