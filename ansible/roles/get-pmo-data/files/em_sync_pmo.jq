[
($people_employees[].data[]
    | {
        "employeeId": .username,
        "em": .engineerManagers[0].employee.username,
        "emFullName": (.engineerManagers[0].employee.firstName + " " + .engineerManagers[0].employee.lastName)
      }
    | select(.em != null)
) as $people_employees_filtered
|
($employee_active[][]
    | {
        "employeeId": .general.username,
        "email": .social.email,
        "gitHubContact": .social.gitHubContact
      }
) as $employee_active_filtered
| $employee_active_filtered
| select($people_employees_filtered.employeeId == .employeeId)
| (
  {
    "email": .email,
    "em": $people_employees_filtered.em,
    "emFullName": $people_employees_filtered.emFullName
   }
)
]
