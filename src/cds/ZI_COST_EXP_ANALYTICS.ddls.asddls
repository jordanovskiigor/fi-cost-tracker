@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cost & Expense Analytics (Budget vs Expenses)'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_COST_EXP_ANALYTICS as select from zexpenses as exp
association [0..1] to zcost_centers as _CostCenter 
on exp.cost_center_id = _CostCenter.cost_center_id

{
   key exp.cost_center_id,
   key exp.category,
   key exp.status,
   
   _CostCenter.cost_center_name,
   _CostCenter.department,
   
   @Semantics.amount.currencyCode: 'currency'
   _CostCenter.budget_amount,
   
      @Semantics.amount.currencyCode: 'currency'
      sum( exp.expense_amount ) as total_expenses,

      count( * ) as expense_count,

      @Semantics.amount.currencyCode: 'currency'
      ( _CostCenter.budget_amount - sum( exp.expense_amount ) ) as remaining_budget,

     cast(
  (
    cast( sum( exp.expense_amount ) as abap.dec(15,2) )
    * 100
    / cast( _CostCenter.budget_amount as abap.dec(15,2) )
  )
  as abap.dec(5,2)
) as budget_utilization_pct,

      exp.currency as currency,

      _CostCenter
}
group by exp.cost_center_id,
         exp.category,
         exp.status,
         _CostCenter.cost_center_name,
         _CostCenter.department,
         _CostCenter.budget_amount,
         exp.currency
         
