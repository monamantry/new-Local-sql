
SELECT "Expense Report History"."Event Performer Name" FROM "Expenses - Expense Transactions Real Time"
where exists (SELECT 1
    FROM "OTBI HCM Prompts"
where  DESCRIPTOR_IDOF("OTBI HCM Prompts"."Assignment Manager List Unsecured"."Person Name")  = VALUEOF(NQ_SESSION.PERSON_ID_HCM) and
 "OTBI HCM Prompts"."Assignment Manager List Unsecured"."Person Number" = "Expense Report History"."Approver Person Number")




SELECT "Expense Report History"."Approver Person Number" FROM "Expenses - Expense Transactions Real Time"
where exists (SELECT 1
    FROM "OTBI HCM Prompts"
where  DESCRIPTOR_IDOF("OTBI HCM Prompts"."Assignment Manager List Unsecured"."Person Name")  = '300000013799489'
 and
 "OTBI HCM Prompts"."Assignment Manager List Unsecured"."Person Number" = "Expense Report History"."Approver Person Number")
  
SELECT "Expense Report History"."Approver Person Number" FROM "Expenses - Expense Transactions Real Time"
where exists (SELECT 1
    FROM "OTBI HCM Prompts"
where  DESCRIPTOR_IDOF("OTBI HCM Prompts"."Assignment Manager List Unsecured"."Person Name")  = '300000013799489'
 and
 "OTBI HCM Prompts"."Assignment Manager List Unsecured"."Person Number" = "Expense Report History"."Approver Person Number")



 SELECT "OTBI HCM Prompts"."Assignment Manager List Unsecured"."Person Number"
    FROM "OTBI HCM Prompts"
where  DESCRIPTOR_IDOF("OTBI HCM Prompts"."Assignment Manager List Unsecured"."Person Name")  = VALUEOF(NQ_SESSION.PERSON_ID_HCM)


 and

 "OTBI HCM Prompts"."Assignment Manager List Unsecured"."Person Number" = "Expense Report History"."Approver Person Number"

-------------------------
SELECT "Expense Report History"."Approver Person Number" FROM "Expenses - Expense Transactions Real Time"
where exists (SELECT 1
    FROM "OTBI HCM Prompts"
where  DESCRIPTOR_IDOF("OTBI HCM Prompts"."Assignment Manager List Unsecured"."Person Name")  = '300000013799489')
 and  "OTBI HCM Prompts"."Assignment Manager List Unsecured"."Person Number" = "Expense Report History"."Approver Person Number"
 --------------------------


 -- 609182 - Current user emplid - Mona Mantry
 
 SELECT "OTBI HCM Prompts"."Assignment Manager List Unsecured"."Person Number"
    FROM "OTBI HCM Prompts"
where  DESCRIPTOR_IDOF("OTBI HCM Prompts"."Assignment Manager List Unsecured"."Person Name")  = VALUEOF(NQ_SESSION.PERSON_ID_HCM)



-- 90970 Stephaine Post
 SELECT "OTBI HCM Prompts"."Assignment Manager List Unsecured"."Person Number"
    FROM "OTBI HCM Prompts"
where  DESCRIPTOR_IDOF("OTBI HCM Prompts"."Assignment Manager List Unsecured"."Person Name")  = '300000013799489'




SELECT "Expense Report History"."Approver Person Number" FROM "Expenses - Expense Transactions Real Time" 
Where "Expense Report History"."Approver Person Number" in (SELECT "OTBI HCM Prompts"."Assignment Manager List Unsecured"."Person Number"
    FROM "OTBI HCM Prompts"
where  DESCRIPTOR_IDOF("OTBI HCM Prompts"."Assignment Manager List Unsecured"."Person Name")  = VALUEOF(NQ_SESSION.PERSON_ID_HCM))


SELECT "Expense Report History"."Approver Person Number" FROM "Expenses - Expense Transactions Real Time" 
Where exists (SELECT 1
    FROM "OTBI HCM Prompts"
where  DESCRIPTOR_IDOF("OTBI HCM Prompts"."Assignment Manager List Unsecured"."Person Name")  = VALUEOF(NQ_SESSION.PERSON_ID_HCM)
and "OTBI HCM Prompts"."Assignment Manager List Unsecured"."Person Number" = "Expense Report History"."Approver Person Number")