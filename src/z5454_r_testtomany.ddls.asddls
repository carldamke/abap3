@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Try It Out: Wrong & Correct Use to many'
@Metadata.ignorePropagatedAnnotations: true
define view entity Z5454_R_TestToMany
  as select from /DMO/I_Connection_R

  //{
  //  key AirlineID,
  //  key ConnectionID,
  //
  //       _Airline.CurrencyCode,
  //       _Flight.PlaneType, // will cause warning because of "to many" association
  //
  //      DepartureAirport,
  //      DestinationAirport
  //
  //}
  //where
  //      AirlineID    = 'LH'   // Only one connection
  //  and ConnectionID = '0400' // fulfills this filter
  //
  //
  // and _Airline.CurrencyCode = 'EUR'
  // and _Flight.PlaneType = '747-400' // will cause syntax error because of "to many" association

{
  key AirlineID,
  key ConnectionID,

//      _Flight.OccupiedSeats // will cause a warning
      sum(_Flight.OccupiedSeats) as TotalOccupiedSeats

}
where
      AirlineID    = 'LH'   // Only one connection
  and ConnectionID = '0400' // fulfills this condition

  group by
    AirlineID,
    ConnectionID
