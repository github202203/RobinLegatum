select getDate()
--EXEC QA.FactHashCheck 'DWH','FactORITransactionDataHistory','2022-03-28','C','Scenario-1'
EXEC QA.FactHashCheck 'DWH','FactORIPlacementDataHistory','2022-03-28','C','Scenario-1'
EXEC QA.FactHashCheck 'DWH','FactRiskCountDataHistory','2022-03-28','C','Scenario-1'
EXEC QA.FactHashCheck 'DWH','FactORICessionDataHistory','2022-03-28','C','Scenario-1'
EXEC QA.FactHashCheck 'DWH','FactORIApplicablePremiumDataHistory','2022-03-28','C','Scenario-1'
select getDate()
