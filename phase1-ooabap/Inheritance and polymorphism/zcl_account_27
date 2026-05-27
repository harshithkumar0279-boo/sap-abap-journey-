CLASS zcl_account_27 DEFINITION ABSTRACT
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    DATA: account_no   TYPE i,
          Name         TYPE c LENGTH 20,
          account_type TYPE c LENGTH 7.
    DATA: balance TYPE wrbtr READ-ONLY.

    METHODS: constructor IMPORTING i_accno TYPE i
                                   i_name  LIKE Name
                                   i_type  LIKE account_type,

      deposit IMPORTING dep_amount TYPE wrbtr,
      withdraw ABSTRACT EXPORTING out TYPE REF TO if_oo_adt_classrun_out,
      get_balance IMPORTING i_account_no     TYPE i
                  RETURNING VALUE(e_balance) TYPE wrbtr.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_account_27 IMPLEMENTATION.
  METHOD constructor.
    account_no = i_accno.
    Name = i_name.
    account_type = i_type.
  ENDMETHOD.

  METHOD deposit.
    DATA: lv_balance TYPE wrbtr.
    lv_balance = balance.
    IF dep_amount IS NOT INITIAL
    AND dep_amount GT 0
    AND account_no IS NOT INITIAL.
      lv_balance = lv_balance + dep_amount.
      IF sy-subrc = 0.
        balance = balance + lv_balance.
      ENDIF.
    ENDIF.
  ENDMETHOD.

  METHOD get_balance.
    IF i_account_no IS NOT INITIAL.
      e_balance = balance.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
