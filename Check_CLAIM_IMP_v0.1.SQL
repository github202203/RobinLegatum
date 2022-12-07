WITH CTE_Imp as (
SELECT [CLM_REF]
      ,[POL_REF]
      ,[INC_DATE]
      ,[ENTITY_CD]
      ,[CLM_DOL]
      ,[UCR]
      ,[LOSS_NAME]
      ,[INSURED]
      ,[REINSURED]
      ,[CLM_STAT1]
      ,[CLM_STAT2]
      ,[CLM_STAT3]
      ,[CLM_STAT4]
      ,[CLM_STAT5]
      ,[unique_key]
	  ,HASHBYTES('SHA1',CONCAT([CLM_REF],'%',[POL_REF],'%',[INC_DATE],'%',[ENTITY_CD],'%',[CLM_DOL],'%',[UCR],'%',[LOSS_NAME],'%',[INSURED],'%',[REINSURED],'%',[CLM_STAT1],'%',[CLM_STAT2],'%',[CLM_STAT3],'%',[CLM_STAT4],'%',[CLM_STAT5])) as IMP_Hash
  FROM [XLPRO_TEST_210].[dbo].[CLAIM_IMP]
  )
,CTE_Dev as (
SELECT [CLM_REF]
      ,[POL_REF]
      ,[INC_DATE]
      ,[ENTITY_CD]
      ,[CLM_DOL]
      ,[UCR]
      ,[LOSS_NAME]
      ,[INSURED]
      ,[REINSURED]
      ,[CLM_STAT1]
      ,[CLM_STAT2]
      ,[CLM_STAT3]
      ,[CLM_STAT4]
      ,[CLM_STAT5]
      ,[unique_key]
	  ,HASHBYTES('SHA1',CONCAT([CLM_REF],'%',[POL_REF],'%',[INC_DATE],'%',[ENTITY_CD],'%',[CLM_DOL],'%',[UCR],'%',[LOSS_NAME],'%',[INSURED],'%',[REINSURED],'%',[CLM_STAT1],'%',[CLM_STAT2],'%',[CLM_STAT3],'%',[CLM_STAT4],'%',[CLM_STAT5])) as DEV_Hash
  FROM [XLPRO_TEST_210].[dbo].[CLAIM_IMP_DEV]
  )

SELECT TestResult, Count(*) as TotalRecords from (
SELECT IMP_CLM_REF, IMP_Hash, DEV_CLM_REF, DEV_Hash
      ,Case when IMP_Hash = Dev_Hash then 'Passed' else 'Failed' End as TestResult
  FROM 
      (
       SELECT CLM_REF as IMP_CLM_REF ,IMP_Hash FROM CTE_IMP
       ) IMP

    --left join --To compare all the records from IMP table
    join -- to compare only matching records

      (
       SELECT CLM_REF as DEV_CLM_REF ,DEV_Hash FROM CTE_DEV
       ) DEV

      on IMP_CLM_REF = DEV_CLM_REF
     and IMP.IMP_HASH = DEV.DEV_Hash
   )T group by TestResult



/*
SELECT CLM_REF,IMP_HASH FROM CTE_IMP 
INTERSECT
SELECT CLM_REF,DEV_HASH FROM CTE_DEV 
*/
  
