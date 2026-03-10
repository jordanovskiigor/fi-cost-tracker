*----------------------------------------------------------------------*
***INCLUDE ZFI_COST_TRACKER_STATUS_020O01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0200 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0200 OUTPUT.
  SET PF-STATUS '200'.
  SET TITLEBAR '200'.

  IF go_container IS INITIAL.

    CREATE OBJECT go_container
      EXPORTING
        container_name = 'CC_ALV'.

    CREATE OBJECT go_alv
      EXPORTING
        i_parent = go_container.

    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name = 'ZSTR_COST_EXP_ALV'
      CHANGING
        ct_fieldcat      = gt_fcat.

    CLEAR gt_alv.

    SELECT
  cost_center_id,
  category,
  status,
  cost_center_name,
  total_expenses,
  currency
  FROM zi_cost_exp_analytics
  INTO CORRESPONDING FIELDS OF TABLE @gt_alv
  WHERE cost_center_id = @zcost_centers-cost_center_id.

    CALL METHOD go_alv->set_table_for_first_display
      CHANGING
        it_outtab       = gt_alv
        it_fieldcatalog = gt_fcat.

  ENDIF.
ENDMODULE.