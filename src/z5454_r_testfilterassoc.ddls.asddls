@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Try It Out: Filtered Associations'
@Metadata.ignorePropagatedAnnotations: true
define view entity Z5454_R_TestFilterAssoc
  as select from /DMO/I_Connection_R

{
  key AirlineID,
  key ConnectionID,

//      _Airline._Currency._Text.CurrencyName // will put out many lines per connection with different languages

//      _Airline._Currency._Text[ Language = 'E' ].CurrencyName 
      // will only put out english description but compiler needs explicit cardinality - warning

      _Airline._Currency._Text[ 1: Language = 'E' ].CurrencyName // only english but no warning due to cardinality
}
where
      AirlineID    = 'AA'
  and ConnectionID = '0017'
