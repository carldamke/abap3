@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee (Query)'
@Metadata.ignorePropagatedAnnotations: false
define view entity Z5454_C_EmployeeQuery
  as select from Z5454_R_EMPLOYEE
{
  key EmployeeId,
      FirstName,
      LastName,

      DepartmentId,
      _Department.Description         as DepartmentDescription,
      _Department._Assistant.LastName as AssistantName,

      /* Associations */
      _Department
}
