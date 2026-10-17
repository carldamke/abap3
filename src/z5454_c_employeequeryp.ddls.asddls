@AbapCatalog: {
    dataMaintenance: #RESTRICTED,
    viewEnhancementCategory: [#PROJECTION_LIST],
    extensibility.dataSources: [ 'Employee' ],
    extensibility.elementSuffix: 'ZEM'
}
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee (Query)'
@Metadata.ignorePropagatedAnnotations: false
@Metadata.allowExtensions: true
define view entity Z5454_C_EMPLOYEEQUERYP
  with parameters
    p_target_curr : /dmo/currency_code,
    
    @Environment.systemField: #SYSTEM_DATE
    p_date        : abap.dats
  as select from Z5454_R_EMPLOYEE as Employee
{
  key EmployeeId,
      FirstName,
      LastName,

      DepartmentId,
      _Department.Description   as DepartmentDescription,
      //      _Department._Assistant.LastName          as AssistantName,
      
      concat_with_space(
            _Department._Assistant.FirstName,
            _Department._Assistant.FirstName,
            1
      )                         as AssistantName,

      
      division(
        dats_days_between(
          EntryDate,
          $parameters.p_date
        ),
        365,
        1
      )                         as CompanyAffiliation,

      
      case EmployeeId
        when _Department.HeadId      then 'H'
        when _Department.AssistantId then 'A'
        else ' '
      end                       as EmployeeRole,

      
      @Semantics.amount.currencyCode: 'CurrencyCode'
      currency_conversion(
        amount             => AnnualSalary,
        source_currency    => CurrencyCode,
        target_currency    => $parameters.p_target_curr,
        exchange_rate_date => $parameters.p_date,
        exchange_rate_type => 'M',
        error_handling     => 'SET_TO_NULL'
      )                         as AnnualSalaryConverted,

      
      @Semantics.amount.currencyCode: 'CurrencyCode'
      cast(
        cast( AnnualSalary as abap.dec(23,2) )
      / cast ( 12 as abap.dec(23,2) )
      as abap.dec(23,2))        as MonthlySalary,

      
      @Semantics.amount.currencyCode: 'CurrencyCode'
      cast(
        cast( $projection.AnnualSalaryConverted as abap.dec(23,2) )
      / cast ( 12 as abap.dec(23,2) )
      as abap.dec(23,2))        as MonthlySalaryConverted,

      //      CurrencyCode,
      //      cast( 'USD' as /dmo/currency_code ) as CurrencyCodeUSD,
      $parameters.p_target_curr as CurrencyCode,

      /* Associations */
      _Department
}
