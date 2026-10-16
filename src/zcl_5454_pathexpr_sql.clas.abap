CLASS zcl_5454_pathexpr_sql DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_5454_pathexpr_sql IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


* Data selection
**********************************************************************

    SELECT FROM /dmo/i_connection_R
         FIELDS Airlineid,
                connectionid,

*                 _Airline.Name, " won't work due to the fact that abap sql uses backslash for associations
                \_Airline-Name, " right way
*                 _Airline-Name, " backslash required again
*                 _Airline~Name, " backslash required and hyphen as component selector
*                \_Airline~Name, " hyphen (-) as component selector required
*
*                \_Airline-_Currency-CurrencyISOCode, " all association components need to be addressed by \
*                \_Airline-\_Currency-CurrencyISOCode, " no hyphen allowed when addressing two associations
                \_Airline\_Currency-CurrencyISOCode, " right way
*                \_Airline~\_Currency~CurrencyISOCode, " no component selector required, also wrong component selector
*                \_Airline\_Currency~CurrencyISOCode, " we would need a different component selector (-)
*
*                \_Airline\_Currency\_Text[                     Language = 'E' ]-CurrencyShortName AS CurrencyNameEN,
                \_Airline\_Currency\_Text[   MANY TO ONE WHERE Language = 'D' ]-CurrencyShortName AS CurrencyNameDE,
                \_Airline\_Currency\_Text[                     Language = 'E' ]-CurrencyShortName AS CurrencyNameEN,
                " the following two wont work because they're addressing an association of another assoc with selectors
*                \_Airline-\_Currency-\_Text[ MANY TO ONE WHERE Language = 'D' ]-CurrencyShortName AS CurrencyNameDE,
*                \_Airline~\_Currency~\_Text[ 1:                Language = 'E' ]-CurrencyShortName AS CurrencyNameEN,
                DepartureAirport,
                DestinationAirport

         INTO TABLE @DATA(result).

* Output
**********************************************************************
    out->write(  data = result
                 name = 'Selection result').


  ENDMETHOD.
ENDCLASS.
