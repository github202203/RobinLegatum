--Check List For FACT Tables
--For Caledar Partition as at 27th March, 2022 created on 11/12th May, 2022
SELECT * FROM DWH.DimDataHistory WHERE CalendarAsAtDate = '2022-03-27' --3225

SELECT * FROM DWH.FactORIPlacementDataHistory WHERE DimDataHistoryId = 3225 --29898
SELECT * FROM DWH.FactORITransactionDataHistory WHERE DimDataHistoryId = 3225 and dimprocessperiodid = 202203 --198583
SELECT * FROM DWH.FactRiskCountDataHistory WHERE DimDataHistoryId = 3225 --3,317,128
SELECT * FROM DWH.FactORICessionDataHistory WHERE DimDataHistoryId = 3225 -- No data available as expected
SELECT * FROM DWH.FactORIApplicablePremiumDataHistory WHERE DimDataHistoryId = 3225 --47,158


--For Caledar Partition as at 21st March, 2022 created on 11/12th May, 2022
SELECT * FROM DWH.DimDataHistory WHERE CalendarAsAtDate = '2022-03-21' --3218(C) / 3219(F)

SELECT * FROM DWH.FactORIPlacementDataHistory WHERE DimDataHistoryId = 3218 --29842
SELECT * FROM DWH.FactORITransactionDataHistory WHERE DimDataHistoryId = 3218 and dimprocessperiodid = 202203 --198579
SELECT * FROM DWH.FactRiskCountDataHistory WHERE DimDataHistoryId = 3218 --3,314,275
SELECT * FROM DWH.FactORICessionDataHistory WHERE DimDataHistoryId = 3218 -- No data available 
SELECT * FROM DWH.FactORIApplicablePremiumDataHistory WHERE DimDataHistoryId = 3218 --47,102


--For Financial Partition as at 21st March, 2022 created on 11/12th May, 2022
SELECT * FROM DWH.DimDataHistory WHERE CalendarAsAtDate = '2022-03-21' --3219(F)

SELECT * FROM DWH.FactORIPlacementDataHistory WHERE DimDataHistoryId = 3219 --29842
SELECT * FROM DWH.FactORITransactionDataHistory WHERE DimDataHistoryId = 3219 and dimprocessperiodid = 202203 --202,960
SELECT * FROM DWH.FactRiskCountDataHistory WHERE DimDataHistoryId = 3219 --3,314,275
SELECT * FROM DWH.FactORICessionDataHistory WHERE DimDataHistoryId = 3219 -- No data available 
SELECT * FROM DWH.FactORIApplicablePremiumDataHistory WHERE DimDataHistoryId = 3219 --47,102