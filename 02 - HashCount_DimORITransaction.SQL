/*********************************************************************************************************

Purpose:- Script to compare the Records Row by Row using Hash
Table  :- [DWH].[DimORITransaction]

******************************************************************************************************** */
WITH 
 CTE_PRD as (
  SELECT [DimORITransactionID],[DimSourceSystemID],[ValidFromWarehouseLoadID],[ValidToWarehouseLoadID],[InsertDateTime],[LastUpdateDateTime],[IsDeleted],[ContractReference],[BrokerCode],[ReinsurerCode],[EventCode],[SubEventCode],[ExternalSyndicate],[GroupClassCode],[SubClassCode],[StatsMinorClassCode],[StatsMajorClassCode],[TrustFundCode],[LloydsRiskCode],[FILCode4],[StatsClassTypeCode],[InternalSyndicate],[AccountingYear],[EclipsePolicyID],[EclipsePolicyLineID],[ClaimReference],[IsElgar],[ProcessPeriod],[TransactionType],[CurrencyCode],[XLProPolicyReference]
        --,HASHBYTES('SHA1',CONCAT([DimORITransactionID],'%',[DimSourceSystemID],'%',[ValidFromWarehouseLoadID],'%',[ValidToWarehouseLoadID],'%',[InsertDateTime],'%',[LastUpdateDateTime],'%',[IsDeleted],'%',[ContractReference],'%',[BrokerCode],'%',[ReinsurerCode],'%',[EventCode],'%',[SubEventCode],'%',[ExternalSyndicate],'%',[GroupClassCode],'%',[SubClassCode],'%',[StatsMinorClassCode],'%',[StatsMajorClassCode],'%',[TrustFundCode],'%',[LloydsRiskCode],'%',[FILCode4],'%',[StatsClassTypeCode],'%',[InternalSyndicate],'%',[AccountingYear],'%',[EclipsePolicyID],'%',[EclipsePolicyLineID],'%',[ClaimReference],'%',[IsElgar],'%',[ProcessPeriod],'%',[TransactionType],'%',[CurrencyCode],'%',[XLProPolicyReference]))as Dev_HashBytes
        ,HASHBYTES('SHA1',CONCAT([DimSourceSystemID],'%',[ValidFromWarehouseLoadID],'%',[ValidToWarehouseLoadID],'%',[IsDeleted],'%',[ContractReference],'%',[BrokerCode],'%',[ReinsurerCode],'%',[EventCode],'%',[SubEventCode],'%',[ExternalSyndicate],'%',[GroupClassCode],'%',[SubClassCode],'%',[StatsMinorClassCode],'%',[StatsMajorClassCode],'%',[TrustFundCode],'%',[LloydsRiskCode],'%',[FILCode4],'%',[StatsClassTypeCode],'%',[InternalSyndicate],'%',[AccountingYear],'%',[EclipsePolicyID],'%',[EclipsePolicyLineID],'%',[ClaimReference],'%',[IsElgar],'%',[ProcessPeriod],'%',[TransactionType],'%',[CurrencyCode],'%',[XLProPolicyReference]))as PRD_HashBytes
    FROM [MYMI-PRD].[MyMI_DataWareHouse].[DWH].[DimORITransaction] with (NOLOCK)
 --WHERE processperiod = 202108 --and contractreference = 'ZA304C18A001' and ReinsurerCode ='L4472' and EclipsePolicyLineID = -504 and CurrencyCode = 'GBP'
   WHERE processperiod = 202011
)


,CTE_DEV as (
  SELECT [DimORITransactionID],[DimSourceSystemID],[ValidFromWarehouseLoadID],[ValidToWarehouseLoadID],[InsertDateTime],[LastUpdateDateTime],[IsDeleted],[ContractReference],[BrokerCode],[ReinsurerCode],[EventCode],[SubEventCode],[ExternalSyndicate],[GroupClassCode],[SubClassCode],[StatsMinorClassCode],[StatsMajorClassCode],[TrustFundCode],[LloydsRiskCode],[FILCode4],[StatsClassTypeCode],[InternalSyndicate],[AccountingYear],[EclipsePolicyID],[EclipsePolicyLineID],[ClaimReference],[IsElgar],[ProcessPeriod],[TransactionType],[CurrencyCode],[XLProPolicyReference]
        ,HASHBYTES('SHA1',CONCAT([DimSourceSystemID],'%',[ValidFromWarehouseLoadID],'%',[ValidToWarehouseLoadID],'%',[IsDeleted],'%',[ContractReference],'%',[BrokerCode],'%',[ReinsurerCode],'%',[EventCode],'%',[SubEventCode],'%',[ExternalSyndicate],'%',[GroupClassCode],'%',[SubClassCode],'%',[StatsMinorClassCode],'%',[StatsMajorClassCode],'%',[TrustFundCode],'%',[LloydsRiskCode],'%',[FILCode4],'%',[StatsClassTypeCode],'%',[InternalSyndicate],'%',[AccountingYear],'%',[EclipsePolicyID],'%',[EclipsePolicyLineID],'%',[ClaimReference],'%',[IsElgar],'%',[ProcessPeriod],'%',[TransactionType],'%',[CurrencyCode],'%',[XLProPolicyReference]))as Dev_HashBytes
    FROM [DWH].[DimORITransaction] with (NOLOCK)
 --WHERE processperiod = 202108 --and contractreference = 'ZA304C18A001' and ReinsurerCode ='L4472' and EclipsePolicyLineID = -504 and CurrencyCode = 'GBP'
   WHERE processperiod = 202011
)

SELECT P.ContractReference,P.PRD_HashBytes, D.ContractReference,D.Dev_HashBytes
       ,Case WHEN P.PRD_HashBytes = D.Dev_HashBytes 
	         THEN 'Passed' 
			 ELSE 'Failed' 
		 End as TestResult
  FROM CTE_PRD P
  Left Join CTE_Dev D
    On P.ContractReference = D.ContractReference
	and P.PRD_HashBytes = D.Dev_HashBytes