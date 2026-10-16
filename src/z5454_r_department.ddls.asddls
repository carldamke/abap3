@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Department (Entity)'
@Metadata.ignorePropagatedAnnotations: true
define view entity Z5454_R_DEPARTMENT
  as select from z5454depment
  
  association [0..1] to Z5454_R_EMPLOYEE as _Head on _Head.EmployeeId = $projection.HeadId
  
  association [1..1] to Z5454_R_EMPLOYEE as _Assistant on _Assistant.EmployeeId = $projection.AssistantId
{
  key id                    as Id,
      description           as Description,
      head_id               as HeadId,
      assistant_id          as AssistantId,
      created_by            as CreatedBy,
      created_at            as CreatedAt,
      local_last_changed_by as LocalLastChangedBy,
      local_last_changed_at as LocalLastChangedAt,
      last_changed_at       as LastChangedAt,
      
      _Head,
      _Assistant
}
