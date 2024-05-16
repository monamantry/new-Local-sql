SELECT
    AIA_.INVOICE_ID,
    COUNT(DISTINCT AIA_.INVOICE_ID)                                                                                                                     EVENT_COUNT,
    AIA_.LAST_UPDATE_DATE,
    AIA_.LAST_UPDATED_BY,
    PPNFV.DISPLAY_NAME                                                                                                                                  UPDATED_BY_DISPLAY_NAME,
    CASE
        WHEN INSTR(AIA_.LAST_UPDATED_BY, '@') > 0 THEN
            'Supplier Portal'
        WHEN INSTR(AIA_.LAST_UPDATED_BY, 'FIN_Scheduler_svc') > 0 THEN
            'FIN Scheduler'
        ELSE
            PPNFV.DISPLAY_NAME
    END                                                                                                                                                 AS UPDATED_BY_NAME,
    AIA_.VENDOR_ID,
    AIA_.INVOICE_NUM,
    AIA_.INVOICE_CURRENCY_CODE,
    AIA_.PAYMENT_CURRENCY_CODE,
    AIA_.INVOICE_AMOUNT,
    AIA_.INVOICE_DATE,
    AIA_.INVOICE_TYPE_LOOKUP_CODE,
    AIA_.AMOUNT_APPLICABLE_TO_DISCOUNT,
    AIA_.TERMS_ID,
    AIA_.TERMS_DATE,
    TO_DATE(NEW_TIME(AIA_.TERMS_DATE, 'GMT', 'CST'), 'YYYY-MM-DD')                                                                                      TERMS_DATE_UPDATED,
    AIA_.ACCTS_PAY_CODE_COMBINATION_ID,
    AIA_.PAYMENT_STATUS_FLAG,
    AIA_.CREATION_DATE,
    AIA_.CREATED_BY,
    PPNFV1.DISPLAY_NAME                                                                                                                                 CREATED_BY_DISPLAY_NAME,
    DECODE(AIA_.CREATED_BY, 'FIN_Scheduler_svc', 'FIN Scheduler', PPNFV1.DISPLAY_NAME)                                                                  CREATED_BY_NAME,
    AIA_.LAST_UPDATE_LOGIN,
    AIA_.PO_HEADER_ID,
    PHA.SEGMENT1                                                                                                                                        PO_NUM,
    AIA_.ORG_ID,
    AIA_.GL_DATE,
    AIA_.AUDIT_ACTION_TYPE_,
    DECODE (AIA_.AUDIT_ACTION_TYPE_, 'IMGINSTR', 'Image Upload', 'HISTORY', 'History', 'UPDATE', 'Update', 'DELETE', 'Delete', AIA_.AUDIT_ACTION_TYPE_) AUDIT_ACTION,
    AIA_.AUDIT_CHANGE_BIT_MAP_,
    AIA_.AMOUNT_PAID,
    AIA_.SOURCE,
    AIA_.PARTY_ID,
    AIA_.PARTY_SITE_ID
FROM
    AP_INVOICES_ALL_     AIA_
    LEFT JOIN PER_USERS PU
    ON AIA_.LAST_UPDATED_BY = PU.USERNAME
    LEFT JOIN PER_PERSON_NAMES_F_V PPNFV
    ON ( ( PU.PERSON_ID=PPNFV.PERSON_ID)
    AND ( SYSDATE BETWEEN PPNFV.EFFECTIVE_START_DATE
    AND PPNFV.EFFECTIVE_END_DATE)
    AND PPNFV.NAME_TYPE ='GLOBAL')
    LEFT JOIN PER_USERS PU1
    ON AIA_.CREATED_BY = PU1.USERNAME
    LEFT JOIN PER_PERSON_NAMES_F_V PPNFV1
    ON ( ( PU1.PERSON_ID=PPNFV1.PERSON_ID)
    AND ( SYSDATE BETWEEN PPNFV1.EFFECTIVE_START_DATE
    AND PPNFV1.EFFECTIVE_END_DATE)
    AND PPNFV1.NAME_TYPE ='GLOBAL')
    LEFT JOIN PO_HEADERS_ALL PHA
    ON AIA_.PO_HEADER_ID = PHA.PO_HEADER_ID
WHERE
    ( LEAST(:P_EVENT_DT_FROM) IS NULL
    OR TO_DATE(NEW_TIME(AIA_.LAST_UPDATE_DATE, 'GMT', 'CST'), 'YYYY-MM-DD HH24:MI:SS') >= (:P_EVENT_DT_FROM))
    AND ( LEAST(:P_EVENT_DT_TO) IS NULL
    OR TO_DATE(NEW_TIME(AIA_.LAST_UPDATE_DATE, 'GMT', 'CST'), 'YYYY-MM-DD HH24:MI:SS') <= (:P_EVENT_DT_TO))
 -- AND     INVOICE_NUM IN('000014')
GROUP BY
    AIA_.INVOICE_ID,
    AIA_.LAST_UPDATE_DATE,
    AIA_.LAST_UPDATED_BY,
    PPNFV.DISPLAY_NAME,
    AIA_.VENDOR_ID,
    AIA_.INVOICE_NUM,
    AIA_.INVOICE_CURRENCY_CODE,
    AIA_.PAYMENT_CURRENCY_CODE,
    AIA_.INVOICE_AMOUNT,
    AIA_.INVOICE_DATE,
    AIA_.INVOICE_TYPE_LOOKUP_CODE,
    AIA_.AMOUNT_APPLICABLE_TO_DISCOUNT,
    AIA_.TERMS_ID,
    AIA_.TERMS_DATE,
    AIA_.ACCTS_PAY_CODE_COMBINATION_ID,
    AIA_.PAYMENT_STATUS_FLAG,
    AIA_.CREATION_DATE,
    AIA_.CREATED_BY,
    PPNFV1.DISPLAY_NAME,
    AIA_.LAST_UPDATE_LOGIN,
    AIA_.PO_HEADER_ID,
    PHA.SEGMENT1,
    AIA_.ORG_ID,
    AIA_.GL_DATE,
    AIA_.AUDIT_ACTION_TYPE_,
    AIA_.AUDIT_CHANGE_BIT_MAP_,
    AIA_.AMOUNT_PAID,
    AIA_.SOURCE,
    AIA_.PARTY_ID,
    AIA_.PARTY_SITE_ID
ORDER BY
    AIA_.INVOICE_ID,
    AIA_.LAST_UPDATE_DATE DESC