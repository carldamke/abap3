CLASS zcl_5454_path_expr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_5454_PATH_EXPR IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    SELECT
    FROM Z5454_C_EmployeeQuery
    FIELDS employeeid,
           firstname,
           lastname,
           departmentid,
           departmentdescription,
           assistantname,

           \_Department\_Head-LastName AS headname
    INTO TABLE @DATA(result).

    out->write( result ).

  ENDMETHOD.
ENDCLASS.
