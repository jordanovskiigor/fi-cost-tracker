@EndUserText.label : 'Cost Center Master Data'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #ALLOWED
define table zcost_centers {
  key client         : abap.clnt not null;
  key cost_center_id : zde_cost_center not null;
  cost_center_name   : abap.char(50);
  department         : abap.char(30);
  @Semantics.amount.currencyCode : 'zcost_centers.currency'
  budget_amount      : zde_budget_amount;
  currency           : waers;
  valid_from         : dats;
  valid_to           : dats;
  responsible        : abap.char(50);
  created_by         : uname;
  created_at         : dats;
}