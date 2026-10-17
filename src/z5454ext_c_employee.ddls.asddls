extend view entity Z5454_C_EMPLOYEEQUERYP with

association [1..1] to I_Country as _ZZCountryZem on _ZZCountryZem.Country = $projection.ZZCountryZem
{
  Employee.ZZTitleZem,
  Employee.ZZCountryZem,

  concat_with_space( Employee.FirstName, Employee.LastName, 1 ) as ZZFullName,

  _ZZCountryZem.IsEuropeanUnionMember                           as ZZEUBasedZem
}
