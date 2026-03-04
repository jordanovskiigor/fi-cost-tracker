@EndUserText.label : 'Expense Records'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #ALLOWED
define table zexpenses {
  key client     : abap.clnt not null;
  key expense_id : abap.numc(10) not null;
  cost_center_id : zde_cost_center;
  category       : zde_exp_category;
  @Semantics.amount.currencyCode : 'zexpenses.currency'
  expense_amount : zde_expense_amount;
  currency       : waers;
  posting_date   : dats;
  description    : abap.char(100);
  status         : zde_exp_status;
  vendor         : abap.char(50);
  created_by     : uname;
  created_at     : dats;

}