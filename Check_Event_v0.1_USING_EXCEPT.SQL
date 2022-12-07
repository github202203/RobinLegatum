

with CTE_Event_IMP as ( --33265
SELECT [EVENT] as IMP_Event
      ,[SUB_EVENT]
      ,[_DESC]
      ,[DESC2]
      ,[DATE_LOSS]
      ,[DATE_L_END]
      ,[DATE_CLAIM_MADE]
      ,[WAR_EVENT]
      ,[IX_EVENT]
      ,[IX_TYPE]
      ,[EXT_DESC]
      ,[MKT_LS_CCY]
      ,[TWO_RISK]
      ,[SINGL_RISK]
      ,[TOTAL_MKT]
      ,[_DUMMY]
      ,[ADD_CODE1]
      ,[ADD_CODE2]
      ,[ADD_CODE3]
      ,[ADD_CODE4]
      ,[ADD_CODE5]
      ,[CLOSED_IND]
      ,[CLOSED_DATE]
      ,[CAT_CODE]
      ,[DEADLY_SIN]
      ,[EV_AMT1]
      ,[EV_AMT2]
      ,[EV_AMT3]
      ,[EV_AMT4]
      ,[EV_AMT5]
      --,[unique_key] as IMP_unique_key
  FROM [XLPRO_TEST_210].[dbo].[EVENT_IMP]
  --WHERE Event = '210324'
 --WHERE unique_key = 1
 --WHERE unique_key = 822
)

,CTE_Event_Dev as (
SELECT [EVENT] as Dev_EVENT
      ,[SUB_EVENT]
      ,[_DESC]
      ,[DESC2]
      ,[DATE_LOSS]
      ,[DATE_L_END]
      ,[DATE_CLAIM_MADE]
      ,[WAR_EVENT]
      ,[IX_EVENT]
      ,[IX_TYPE]
      ,[EXT_DESC]
      ,[MKT_LS_CCY]
      ,[TWO_RISK]
      ,[SINGL_RISK]
      ,[TOTAL_MKT]
      ,[_DUMMY]
      ,[ADD_CODE1]
      ,[ADD_CODE2]
      ,[ADD_CODE3]
      ,[ADD_CODE4]
      ,[ADD_CODE5]
      ,[CLOSED_IND]
      ,[CLOSED_DATE]
      ,[CAT_CODE]
      ,[DEADLY_SIN]
      ,[EV_AMT1]
      ,[EV_AMT2]
      ,[EV_AMT3]
      ,[EV_AMT4]
      ,[EV_AMT5]
      --,[unique_key] as DEV_unique_key
  FROM [XLPRO_TEST_210].[dbo].[EVENT_IMP_Dev]
  --WHERE Event = '210324'
 --WHERE unique_key = 1
 --WHERE unique_key = 822
)

SELECT 
       
       imp.[Imp_EVENT]
      ,imp.[SUB_EVENT]
      ,imp.[_DESC]
      ,imp.[DESC2]
      ,imp.[DATE_LOSS]
      ,imp.[DATE_L_END]
      ,imp.[DATE_CLAIM_MADE]
      ,imp.[WAR_EVENT]
      ,imp.[IX_EVENT]
      ,imp.[IX_TYPE]
      ,imp.[EXT_DESC]
      ,imp.[MKT_LS_CCY]
      ,imp.[TWO_RISK]
      ,imp.[SINGL_RISK]
      ,imp.[TOTAL_MKT]
      ,imp.[_DUMMY]
      ,imp.[ADD_CODE1]
      ,imp.[ADD_CODE2]
      ,imp.[ADD_CODE3]
      ,imp.[ADD_CODE4]
      ,imp.[ADD_CODE5]
      --,imp.[CLOSED_IND]
      ,imp.[CLOSED_DATE]
      ,imp.[CAT_CODE]
      ,imp.[DEADLY_SIN]
      ,imp.[EV_AMT1]
      ,imp.[EV_AMT2]
      ,imp.[EV_AMT3]
      ,imp.[EV_AMT4]
      ,imp.[EV_AMT5] 
	  --,[IMP_unique_key]
	  ,HashBytes('SHA1',CONCAT([Imp_EVENT],'%',[SUB_EVENT],'%',[_DESC],'%',[DESC2],'%',[DATE_LOSS],'%',[DATE_L_END],'%',[DATE_CLAIM_MADE],'%',[WAR_EVENT],'%',[IX_EVENT],'%',[IX_TYPE],'%',[EXT_DESC],'%',[MKT_LS_CCY],'%',[TWO_RISK],'%',[SINGL_RISK],'%',[TOTAL_MKT],'%',[_DUMMY],'%',[ADD_CODE1],'%',[ADD_CODE2],'%',[ADD_CODE3],'%',[ADD_CODE4],'%',[ADD_CODE5],'%',[CLOSED_IND],'%',[CLOSED_DATE],'%',[CAT_CODE],'%',[DEADLY_SIN],'%',[EV_AMT1],'%',[EV_AMT2],'%',[EV_AMT3],'%',[EV_AMT4],'%',[EV_AMT5])) as Imp_HashValue
	  --,HashBytes('SHA1',CONCAT([Imp_EVENT],'%',[SUB_EVENT],'%',[_DESC],'%',[DESC2],'%',[DATE_LOSS],'%',[DATE_L_END],'%',[DATE_CLAIM_MADE],'%',[WAR_EVENT],'%',[IX_EVENT],'%',[IX_TYPE],'%',[EXT_DESC],'%',[MKT_LS_CCY],'%',[TWO_RISK],'%',[SINGL_RISK],'%',[TOTAL_MKT],'%',[_DUMMY],'%',[ADD_CODE1],'%',[ADD_CODE2],'%',[ADD_CODE3],'%',[ADD_CODE4],'%',[ADD_CODE5],'%',[CLOSED_DATE],'%',[CAT_CODE],'%',[DEADLY_SIN],'%',[EV_AMT1],'%',[EV_AMT2],'%',[EV_AMT3],'%',[EV_AMT4],'%',[EV_AMT5])) as Imp_HashValue
  FROM CTE_Event_Imp Imp

--UNION ALL 

EXCEPT

  (
  SELECT 
       
       Dev.[Dev_EVENT]
      ,Dev.[SUB_EVENT]
      ,Dev.[_DESC]
      ,Dev.[DESC2]
      ,Dev.[DATE_LOSS]
      ,Dev.[DATE_L_END]
      ,Dev.[DATE_CLAIM_MADE]
      ,Dev.[WAR_EVENT]
      ,Dev.[IX_EVENT]
      ,Dev.[IX_TYPE]
      ,Dev.[EXT_DESC]
      ,Dev.[MKT_LS_CCY]
      ,Dev.[TWO_RISK]
      ,Dev.[SINGL_RISK]
      ,Dev.[TOTAL_MKT]
      ,Dev.[_DUMMY]
      ,Dev.[ADD_CODE1]
      ,Dev.[ADD_CODE2]
      ,Dev.[ADD_CODE3]
      ,Dev.[ADD_CODE4]
      ,Dev.[ADD_CODE5]
      --,Dev.[CLOSED_IND]
      ,Dev.[CLOSED_DATE]
      ,Dev.[CAT_CODE]
      ,Dev.[DEADLY_SIN]
      ,Dev.[EV_AMT1]
      ,Dev.[EV_AMT2]
      ,Dev.[EV_AMT3]
      ,Dev.[EV_AMT4]
      ,Dev.[EV_AMT5] 
	  --,[DEV_unique_key]
	  ,HashBytes('SHA1',CONCAT([Dev_EVENT],'%',[SUB_EVENT],'%',[_DESC],'%',[DESC2],'%',[DATE_LOSS],'%',[DATE_L_END],'%',[DATE_CLAIM_MADE],'%',[WAR_EVENT],'%',[IX_EVENT],'%',[IX_TYPE],'%',[EXT_DESC],'%',[MKT_LS_CCY],'%',[TWO_RISK],'%',[SINGL_RISK],'%',[TOTAL_MKT],'%',[_DUMMY],'%',[ADD_CODE1],'%',[ADD_CODE2],'%',[ADD_CODE3],'%',[ADD_CODE4],'%',[ADD_CODE5],'%',[CLOSED_IND],'%',[CLOSED_DATE],'%',[CAT_CODE],'%',[DEADLY_SIN],'%',[EV_AMT1],'%',[EV_AMT2],'%',[EV_AMT3],'%',[EV_AMT4],'%',[EV_AMT5])) as Dev_HashValue
	  --,HashBytes('SHA1',CONCAT([Dev_EVENT],'%',[SUB_EVENT],'%',[_DESC],'%',[DESC2],'%',[DATE_LOSS],'%',[DATE_L_END],'%',[DATE_CLAIM_MADE],'%',[WAR_EVENT],'%',[IX_EVENT],'%',[IX_TYPE],'%',[EXT_DESC],'%',[MKT_LS_CCY],'%',[TWO_RISK],'%',[SINGL_RISK],'%',[TOTAL_MKT],'%',[_DUMMY],'%',[ADD_CODE1],'%',[ADD_CODE2],'%',[ADD_CODE3],'%',[ADD_CODE4],'%',[ADD_CODE5],'%',[CLOSED_DATE],'%',[CAT_CODE],'%',[DEADLY_SIN],'%',[EV_AMT1],'%',[EV_AMT2],'%',[EV_AMT3],'%',[EV_AMT4],'%',[EV_AMT5])) as Dev_HashValue
  FROM CTE_Event_Dev Dev
  ) 

  


