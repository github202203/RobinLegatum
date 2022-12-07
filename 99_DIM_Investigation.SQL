 SELECT 'DROP TABLE IF EXISTS ' + NAME FROM SYS.tables WHERE schema_id = 31
 SELECT * FROM SYS.schemas

--TR_DimORIApplicablePremium ( difference could have been due to missing contract)
SELECT * FROM QA.TR_DimORIApplicablePremium WHERE TestResult <> 'Passed'

SELECT DISTINCT GXLPContractReference25 FROM QA.TR_DimORIApplicablePremium WHERE TestResult <> 'Passed'

SELECT TestResult, Count(*) as TotalRecords
  FROM QA.TR_DimORIApplicablePremium 
 WHERE TestResult <> 'Passed'
 GROUP BY TestResult

--TR_DimORICession (Some of the policy could have been missed from Accrual table
SELECT * FROM QA.TR_DimORICession WHERE TestResult <> 'Passed'

SELECT TestResult, Count(*) as TotalRecords
  FROM QA.TR_DimORICession 
 WHERE TestResult <> 'Passed'
 GROUP BY TestResult

 --TR_DimORIClaimSubEvent ( Further investigation to be done )
 SELECT * FROM QA.TR_DimORIClaimSubEvent 
  WHERE TestResult <> 'Passed'
    --WHERE TestResult = 'Failed - Missing in 2.5'

SELECT TestResult, Count(*) as TotalRecords
  FROM QA.TR_DimORIClaimSubEvent 
 WHERE TestResult <> 'Passed'
 GROUP BY TestResult

 SELECT * FROM DWH.DimORIClaimSubEvent --403 records missing in 2.5 due to timing issue like inserted/closed after 27th March
  WHERE DimORIClaimSubEventID in ( SELECT DimORIClaimSubEventID210 FROM QA.TR_DimORIClaimSubEvent WHERE TestResult = 'Failed - Missing in 2.5')

 SELECT * FROM [MYMI-TEST].[MyMI_DataWareHouse].DWH.DimORIClaimSubEvent -- 56 records missing in 2.10 becuase of timing issue inserted/updated after 27th March
  WHERE DimORIClaimSubEventID in ( SELECT DimORIClaimSubEventID25 FROM QA.TR_DimORIClaimSubEvent WHERE TestResult = 'Failed - Missing in 2.10')



 --TR_DimOriTransaction (difference can be ignored due to the record closed in May in PROD)

 --TR_DimORIClaimSubEvent ( Further investigation to be done )
 SELECT * FROM QA.TR_DimOriTransaction 
  WHERE TestResult <> 'Passed'
    --WHERE TestResult = 'Failed - Missing in 2.5'

SELECT TestResult, Count(*) as TotalRecords
  FROM QA.TR_DimOriTransaction 
 WHERE TestResult <> 'Passed'
 GROUP BY TestResult

 SELECT * FROM DWH.DimOriTransaction --219 records
  WHERE DimORITransactionID in ( SELECT DimORITransactionID210 FROM QA.TR_DimOriTransaction WHERE TestResult = 'Failed - Missing in 2.5')


 --TR_DimRiskCount

  SELECT * FROM QA.TR_DimRiskCount --2258 records in missing in 2.5
  WHERE TestResult <> 'Passed'
    --WHERE TestResult = 'Failed - Missing in 2.5'

SELECT TestResult, Count(*) as TotalRecords
  FROM QA.TR_DimRiskCount 
 WHERE TestResult <> 'Passed'
 GROUP BY TestResult

 SELECT * FROM DWH.DimRiskCount --2258 records closed / inserted in PROD after 27th March and can be ignored)
  WHERE DimRiskCountID in ( SELECT DimRiskCountID210 FROM QA.TR_DimRiskCount WHERE TestResult = 'Failed - Missing in 2.5' and CAST(InsertDateTime as DATE) > '2022-03-27' )
  
  
 SELECT * FROM DWH.DimORIProgramme --224 records missing in 2.5 due to timing issue like inserted/closed after 27th March
  WHERE DimORIProgrammeid in ( SELECT DimORIProgrammeid210 FROM QA.TR_DimORIProgramme WHERE TestResult = 'Failed - Missing in 2.5')

SELECT * FROM [MYMI-TEST].[MyMI_DataWareHouse].DWH.DimORIProgramme --9 records missing in 2.5 due to timing issue like inserted/closed after 27th March
  WHERE DimORIProgrammeid in ( SELECT DimORIProgrammeid25 FROM QA.TR_DimORIProgramme WHERE TestResult = 'Failed - Missing in 2.10')   