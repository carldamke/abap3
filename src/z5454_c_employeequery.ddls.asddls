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
      _Department.Description             as DepartmentDescription,
      //      _Department._Assistant.LastName          as AssistantName,
      @EndUserText.label: 'Assistant Full Name'
      concat_with_space(
            _Department._Assistant.FirstName,
            _Department._Assistant.FirstName,
            1
      )                                   as AssistantName,

      @EndUserText.label: 'Years Affiliated with the Company'
      division(
        dats_days_between(
          EntryDate,
          $session.system_date
        ),
        365,
        1
      )                                   as CompanyAffiliation,

      @EndUserText.label: 'Employee Role'
      case EmployeeId
        when _Department.HeadId      then 'H'
        when _Department.AssistantId then 'A'
        else ' '
      end                                 as EmployeeRole,

      @EndUserText.label: 'Annual salary converted to USD'
      @Semantics.amount.currencyCode: 'CurrencyCodeUSD'
      currency_conversion(
        amount => AnnualSalary,
        source_currency => CurrencyCode,
        target_currency => $projection.CurrencyCodeUSD,
        exchange_rate_date => $session.system_date
      )                                   as AnnualSalaryConverted,

      @EndUserText.label: 'Monthly Salary'
      @Semantics.amount.currencyCode: 'CurrencyCode'
      cast(
        cast( AnnualSalary as abap.dec(23,2) )
      / cast ( 12 as abap.dec(23,2) )
      as abap.dec(23,2))                  as MonthlySalary,
      
      @EndUserText.label: 'Monthly Salary converted to USD'
      @Semantics.amount.currencyCode: 'CurrencyCodeUSD'
      cast(
        cast( $projection.AnnualSalaryConverted as abap.dec(23,2) )
      / cast ( 12 as abap.dec(23,2) )
      as abap.dec(23,2))                  as MonthlySalaryConverted,

      CurrencyCode,
      cast( 'USD' as /dmo/currency_code ) as CurrencyCodeUSD,

      /* Associations */
      _Department
}
