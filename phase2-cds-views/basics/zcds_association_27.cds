@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'View for association'

define view entity zcds_association_27
  as select from /dmo/connection as _con
  association [0..1] to /dmo/airport as _air on $projection.AirportFrom = _air.airport_id
{
  key connection_id   as ConnectionID,
  key carrier_id      as CarrierID,
      airport_from_id as AirportFrom,
      airport_to_id   as AirporTo,
      _air
};
