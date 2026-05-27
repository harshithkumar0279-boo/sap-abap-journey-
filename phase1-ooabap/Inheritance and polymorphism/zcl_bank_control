CLASS zcl_bank_control DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
    TYPES: BEGIN OF ty_account,
             account_no   TYPE i,
             Name         TYPE c LENGTH 20,
             account_type TYPE c LENGTH 7,
             draw_amount  TYPE wrbtr,
           END OF ty_account.
    DATA: t_account TYPE STANDARD TABLE OF ty_account,
          x_account LIKE LINE OF t_account.
    METHODS: populate_test_data EXPORTING out TYPE REF TO if_oo_adt_classrun_out.
ENDCLASS.

CLASS zcl_bank_control IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA:lo_saving  TYPE REF TO zcl_savings,
         lo_current TYPE REF TO zcl_current,
         lo_fd      TYPE REF TO zcl_fd.

    DATA: lo_finalobj TYPE REF TO zcl_account_27.

    populate_test_data(  ).
    out->write( '--- Starting Bank Simulation ---' ).

    LOOP AT t_account ASSIGNING FIELD-SYMBOL(<fs_account>).
      out->write( |Processing Account: { <fs_account>-account_no }, | &
                               | Name: { <fs_account>-name } | &
                               | Account type: { <fs_account>-account_type }| ).
      TRY.
          CASE <fs_account>-account_type.
            WHEN 'SAVINGS'.
              lo_finalobj =  NEW zcl_savings( i_accno = <fs_account>-account_no
                                                        i_name  = <fs_account>-name
                                                        i_type = <fs_account>-account_type
                                                        i_drawamount = <fs_account>-draw_amount ) .
            WHEN 'CURRENT' .
              lo_finalobj =  NEW zcl_current( i_accno = <fs_account>-account_no
                                                        i_name  = <fs_account>-name
                                                        i_type = <fs_account>-account_type
                                                        i_drawamount = <fs_account>-draw_amount ).
            WHEN 'FD'.
              lo_finalobj = NEW zcl_fd( i_accno = <fs_account>-account_no
                                                         i_name  = <fs_account>-name
                                                         i_type = <fs_account>-account_type
                                                         i_drawamount = <fs_account>-draw_amount ).
          ENDCASE.
          DATA(lv_current_balance) = lo_finalobj->get_balance( i_account_no = <fs_account>-account_no ).
          out->write( |Initial balance: { lv_current_balance }| ).

          lo_finalobj->withdraw(  ).

          out->write( |Current balance after withdrawal: { lo_finalobj->get_balance( i_account_no = <fs_account>-account_no ) }| ).

          lo_finalobj->deposit( dep_amount = '500.00'  ).

          out->write( |Balance after deposit 500 : { lo_finalobj->get_balance( i_account_no = <fs_account>-account_no ) }| ).

        CATCH cx_root INTO DATA(lx_error).
          out->write( |[TRANSACTION FAILED]: { lx_error->get_text( ) }| ).
      ENDTRY.
    ENDLOOP.

  ENDMETHOD.

  METHOD populate_test_data.
    t_account = VALUE #(
    " --- SAVINGS ACCOUNT TESTS ---
       " Use Case: Normal deposit & balance check
       ( account_no = 1001 Name = 'John Doe'   account_type = 'SAVINGS' draw_amount = '5000.00' )
       " Use Case: Test withdrawing more than available balance (Should fail/throw error)
       ( account_no = 1002 Name = 'Jane Smith' account_type = 'SAVINGS' draw_amount = '150.00' )

       " --- CURRENT ACCOUNT TESTS ---
       " Use Case: Standard business transactions
       ( account_no = 2001 Name = 'Acme Corp'  account_type = 'CURRENT' draw_amount = '25000.00' )
       " Use Case: Test Overdraft/Negative balance (Current accounts often allow this)
       ( account_no = 2002 Name = 'Tech Start' account_type = 'CURRENT' draw_amount = '0.00' )

       " --- FIXED DEPOSIT (FD) TESTS ---
       " Use Case: Standard FD holding a large balance
       ( account_no = 3001 Name = 'Bob Miller' account_type = 'FD'      draw_amount = '50000.00'   )
       " Use Case: Test rules preventing early/partial withdrawal on FD
       ( account_no = 3002 Name = 'Alice Ross' account_type = 'FD'      draw_amount = '10000.00' ) ).

    " Print initial state to console
*    out->write( |--- Initial Test Data Loaded ---| ).

  ENDMETHOD.
ENDCLASS.
