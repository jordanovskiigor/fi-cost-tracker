*----------------------------------------------------------------------*
***INCLUDE ZFI_COST_TRACKER_EXIT_COMMAI02.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  EXIT_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE exit_command_0200 INPUT.
  CASE sy-ucomm.
    WHEN 'BACK'.
      gv_alv_initialized = abap_false.
      IF go_container IS NOT INITIAL.
        CALL METHOD go_container->free.
      ENDIF.
      CLEAR go_container.
      CLEAR go_alv.
      CLEAR gt_fcat.
      SET SCREEN 100.
      LEAVE SCREEN.
  ENDCASE.
ENDMODULE.