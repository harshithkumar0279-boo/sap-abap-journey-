CLASS zcl_current DEFINITION
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
    DATA: l_odamount TYPE wrbtr VALUE '25000.00'.
ENDCLASS.

CLASS zcl_current IMPLEMENTATION.
  METHOD constructor.
    super->constructor( i_accno = account_no
                        i_name = name
                        i_type = account_type ).
    draw_amount = i_drawamount.
  ENDMETHOD.

  METHOD withdraw.
    IF account_type EQUIV 'CURRENT'.
      IF draw_amount LT l_odamount AND account_no IS NOT INITIAL.
        balance = balance - draw_amount.
        out->write( |Amount { draw_amount } is deducted from your Current account: { account_no }| ).
      ELSE.
        out->write( |Error: { draw_amount } is more than the over draft limit { draw_amount } on your current account: { account_no }| ).
      ENDIF.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
