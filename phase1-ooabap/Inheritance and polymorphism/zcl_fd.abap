CLASS zcl_fd DEFINITION
  PUBLIC
  INHERITING FROM zcl_account_27
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    DATA: draw_amount            TYPE wrbtr,
          maturity_date          TYPE d,
          force_early_withdrawal TYPE c.
    METHODS: constructor IMPORTING i_accno                  TYPE i
                                   i_name                   LIKE Name
                                   i_type                   LIKE account_type
                                   i_drawamount             TYPE wrbtr
                                   i_maturity               TYPE d OPTIONAL
                                   i_force_early_withdrawal TYPE c OPTIONAL,
      withdraw REDEFINITION.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_fd IMPLEMENTATION.
  METHOD constructor.
    super->constructor( i_accno = account_no
                        i_name = name
                        i_type = account_type ).
    draw_amount = i_drawamount.
    maturity_date = i_maturity.
    force_early_withdrawal = i_force_early_withdrawal.
  ENDMETHOD.

  METHOD withdraw.
    DATA: lv_penalty TYPE wrbtr.
    IF account_type = 'FD'.
      IF draw_amount > balance.
        out->write( |[ERROR] Insufficient funds. Current balance: { balance }| ).
        RETURN.
      ENDIF.
      IF cl_abap_context_info=>get_system_date(  ) < maturity_date.
        IF force_early_withdrawal = abap_false.
          out->write( |[ERROR] Cannot withdraw. FD matures on { maturity_date }.| ).
          out->write( |To proceed with a 10% penalty, pass i_force_early_withdrawal = 'X'.| ).
          RETURN.
        ENDIF.
        lv_penalty = draw_amount * '0.10'.
        IF ( draw_amount + lv_penalty ) > balance.
          out->write( |[ERROR] Insufficient funds to cover the amount + 10% penalty ({ lv_penalty }).| ).
          RETURN.

          balance = balance - ( draw_amount + lv_penalty ).
          out->write( |[WARNING] Early withdrawal processed with penalty!| ).
          out->write( |Withdrawn: { draw_amount } | ).
          out->write( |Penalty Deducted: { lv_penalty } | ).
          out->write( |Remaining Balance: { balance }| ).
        ENDIF.
      ELSE.
        balance = balance - draw_amount.
        out->write( |Amount { draw_amount } is deducted from your FD account: { account_no }| ).
      ENDIF.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
