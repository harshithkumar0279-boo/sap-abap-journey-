@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Aggregation functions 1'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZCDS_aggr_ex1
  as select from /dmo/flight
{
  key carrier_id,
      currency_code,
      sum( seats_occupied )                                     as TotalSeatsOccupied,
      @Semantics.amount.currencyCode: 'Currency_code'
      sum( price )                                              as TotalRevenue,

      count(distinct seats_occupied)                            as occupied,
      count(distinct carrier_id)                                as flight,
      min(flight_date)                                          as early_flight,
      max(flight_date)                                          as last_fligh,

      avg( cast(price as abap.dec( 15, 3)) as abap.dec( 15, 3)) as AveragePrice


      //        sum(seats_occupied) as total_occupied
}
group by
  carrier_id,
  currency_code
