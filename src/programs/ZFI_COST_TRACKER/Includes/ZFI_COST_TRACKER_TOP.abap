*&---------------------------------------------------------------------*
*& Include ZFI_COST_TRACKER_TOP                     - Module Pool      ZFI_COST_TRACKER
*&---------------------------------------------------------------------*
PROGRAM zfi_cost_tracker.

TABLES zcost_centers.
DATA ok_code LIKE sy-ucomm.

DATA go_container TYPE REF TO cl_gui_custom_container.
DATA go_alv       TYPE REF TO cl_gui_alv_grid.
DATA gv_alv_initialized TYPE abap_bool VALUE abap_false.

DATA gt_alv TYPE STANDARD TABLE OF zstr_cost_exp_alv WITH DEFAULT KEY.
DATA gt_fcat TYPE lvc_t_fcat.