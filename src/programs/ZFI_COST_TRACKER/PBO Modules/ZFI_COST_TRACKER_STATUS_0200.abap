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

  CLEAR gt_alv.
  SELECT cost_center_id, category, status,
         cost_center_name, total_expenses,
         currency, budget_utilization_pct
    FROM zi_cost_exp_analytics
    INTO CORRESPONDING FIELDS OF TABLE @gt_alv
    WHERE cost_center_id = @zcost_centers-cost_center_id.

  LOOP AT gt_alv ASSIGNING FIELD-SYMBOL(<fs_alv>).
    IF <fs_alv>-budget_utilization_pct >= 90.
      <fs_alv>-traffic_light = '@0A@'.
    ELSEIF <fs_alv>-budget_utilization_pct >= 70.
      <fs_alv>-traffic_light = '@09@'.
    ELSE.
      <fs_alv>-traffic_light = '@08@'.
    ENDIF.
  ENDLOOP.

  IF gv_alv_initialized = abap_false.

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

    DATA ls_fcat TYPE lvc_s_fcat.
    LOOP AT gt_fcat INTO ls_fcat.
      ls_fcat-col_opt = abap_true.
      CASE ls_fcat-fieldname.
        WHEN 'COST_CENTER_ID'.
          ls_fcat-outputlen = 15.
          ls_fcat-coltext   = 'Cost Center'.
        WHEN 'CATEGORY'.
          ls_fcat-outputlen = 20.
          ls_fcat-coltext   = 'Category'.
        WHEN 'STATUS'.
          ls_fcat-outputlen = 10.
          ls_fcat-coltext   = 'Status'.
        WHEN 'COST_CENTER_NAME'.
          ls_fcat-outputlen = 30.
          ls_fcat-coltext   = 'Cost Center Name'.
        WHEN 'TOTAL_EXPENSES'.
          ls_fcat-outputlen = 18.
          ls_fcat-coltext   = 'Total Expenses'.
        WHEN 'CURRENCY'.
          ls_fcat-outputlen = 8.
          ls_fcat-coltext   = 'Currency'.
        WHEN 'TRAFFIC_LIGHT'.
          ls_fcat-outputlen = 12.
          ls_fcat-coltext   = 'Budget Status'.
          ls_fcat-no_out    = ' '.
        WHEN 'BUDGET_UTILIZATION_PCT'.
          ls_fcat-no_out    = abap_true.
      ENDCASE.
      MODIFY gt_fcat FROM ls_fcat.
    ENDLOOP.

    DATA ls_layo TYPE lvc_s_layo.
    ls_layo-cwidth_opt = abap_true.

    CALL METHOD go_alv->set_table_for_first_display
      EXPORTING
        is_layout       = ls_layo
      CHANGING
        it_outtab       = gt_alv
        it_fieldcatalog = gt_fcat.
    gv_alv_initialized = abap_true.

  ELSE.

    CALL METHOD go_alv->refresh_table_display.

  ENDIF.

ENDMODULE.