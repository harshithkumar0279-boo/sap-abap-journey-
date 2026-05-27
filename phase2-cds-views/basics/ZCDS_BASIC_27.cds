@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic CDS view'
define view entity ZCDS_BASIC_27
  as select from /dmo/carrier
{
  key carrier_id as AirlineID,
      name       as AirlineName,
      case currency_code
           when 'USD' then 'Dollar'
           else 'Other'
           end   as CurrencyLabel,
      last_changed_at,
      local_created_by
}
where
  currency_code = 'USD';

