CLASS zcl_5454_ddic_obj_as_dattype DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_5454_ddic_obj_as_dattype IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


* Declarations
    DATA travel TYPE /dmo/travel_id. "elementary
    DATA travel_s  TYPE /dmo/s_travel_key. " structure
    DATA travel_t TYPE /dmo/travel. " structure because of table
    DATA travel_tt TYPE /dmo/t_travel. " actual table because of table type

* Assignments
    travel = '123'.                              "elementary
    travel_s = VALUE #(     travel_id = '123'   ). "structure
    travel_tt = VALUE #(  (  travel_id = '123' ) ). "table


  ENDMETHOD.
ENDCLASS.
