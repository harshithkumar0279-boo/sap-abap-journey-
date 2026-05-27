CLASS zcl_savings DEFINITION
  PUBLIC
  INHERITING FROM zcl_account_27
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    DATA: draw_amount TYPE wrbtr.
    METHODS: constructor IMPORTING i_accno      TYPE i
                                   i_name       LIKE Name
                                   i_type       LIKE account_type
                                   i_drawamount TYPE wrbtr,
      withdraw REDEFINITION.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: min_bal TYPE p LENGTH 16 DECIMALS 2 VALUE '500.00'.
ENDCLASS.

CLASS zcl_savings IMPLEMENTATION.
  METHOD constructor.
    super->constructor( i_accno = account_no
                        i_name = name
                        i_type = account_type ).
    draw_amount = i_drawamount.
  ENDMETHOD.

  METHOD withdraw.
    IF account_type EQ 'SAVINGS'.
      IF balance GT min_bal AND account_no IS NOT INITIAL.
        balance = balance - draw_amount.
        out->write( |Amount { draw_amount } is deducted from your Savings account: { account_no }| ).
      ELSE.
        out->write( |Error: There is no suffient amount in your savings account: { account_no }| ).
      ENDIF.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
