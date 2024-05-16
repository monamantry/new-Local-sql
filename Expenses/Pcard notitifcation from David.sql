SELECT EE.person_id,
          TO_CHAR(EE.receipt_amount,'999,999.99') ||' ' || receipt_currency_code "CHARGE AMOUNT",
       EE.merchant_name,
       EE.location,
       TRUNC(EE.start_date) "CHARGE DATE"       
FROM    EXM_EXPENSES EE
Where EE.person_id

SELECT EE.person_id,
       PAPF.person_number,
       EET.name "EXPENSE TYPE",
       TO_CHAR(EE.receipt_amount,'999,999.99') ||' ' || receipt_currency_code "CHARGE AMOUNT",
       EE.merchant_name,
       EE.location,
       TRUNC(EE.start_date) "CHARGE DATE",
       TRUNC(NVL(:date_posted_in_iO,SYSDATE)) "POSTED IN iO",
       PPNF.KNOWN_AS || ' ' || PPNF.LAST_NAME || ',' "SALUTATION",       
       SUBSTR(IC.ccnumber,9) "LAST 4"
FROM   IBY_CREDITCARD IC,
       EXM_CARDS EC,
       PER_PERSON_NAMES_F PPNF,
       PER_ALL_PEOPLE_F PAPF,
       EXM_EXPENSE_TYPES EET,
       EXM_EXPENSES EE
WHERE  IC.instrid = EC.card_reference_id
AND    EC.card_id  = EE.card_id
AND    PPNF.name_type = 'GLOBAL'
AND    PPNF.effective_end_date = TO_DATE('47121231','YYYYMMDD')
AND    PPNF.person_id = EE.person_id
AND    TRUNC(PAPF.effective_end_date) = TO_DATE('47121231','YYYYMMDD')
AND    PAPF.person_id = EE.person_id
AND    EET.expense_type_id = EE.expense_type_id
AND    EE.expense_creation_method_code = 'CCUPLOAD'
AND    TRUNC(EE.creation_date) = TRUNC(NVL(:date_posted_in_iO,sysdate))
AND    (:person_number IS NULL OR
        EE.person_id = (SELECT person_id 
                        FROM   PER_ALL_PEOPLE_F PAPF2
                        WHERE  PAPF2.person_number = :person_number
                        AND    TRUNC(PAPF2.EFFECTIVE_END_DATE) = TO_DATE('47121231','YYYYMMDD')))



ORDER  BY EE.person_id,
          SUBSTR(IC.ccnumber,9),
          EE.start_date



CASE WHEN :TEST_EMAIL_ADDRESS IS NOT NULL THEN
               :TEST_EMAIL_ADDRESS
            ELSE
               (SELECT NVL(pea.email_address,:TEST_EMAIL_ADDRESS)
                FROM   PER_EMAIL_ADDRESSES PEA
                WHERE  :TEST_EMAIL_ADDRESS IS NULL
                AND    PEA.email_type = 'W1'
                AND    PEA.person_id = EE.person_id) 
       END EMAIL,