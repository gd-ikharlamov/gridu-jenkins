# jq --slurpfile project_active   project_active.json \
#    --slurpfile people_accounts  people_accounts.json \
#    --slurpfile employee_active  employee_active.json \
#    -n -f ~/repos/gridu-jenkins/ansible/roles/get-pmo-data/files/gridu.jq

[
($project_active[][]
    | select(.account.name=="GridU Trainings")
    | {
        "ProjectName": .name,
        "shortName": .shortName,
      }
) as $project_active_filtered
|
($people_accounts[].rows[]
    | select(.account[] | contains("GridU Trainings"))
    | {
        "employeeId": .employeeId,
        "assignmentStart": .assignmentStart[.account | index("GridU Trainings")],
        "assignmentFinish": .assignmentFinish[.account | index("GridU Trainings")],
        "ProjectName": .project[.account | index("GridU Trainings")]
      }
) as $people_accounts_filtered
|
($employee_active[][]
    | {
        "employeeId": .general.username,
        "email": .social.email,
        "gitHubContact": .social.gitHubContact
      }
) as $employee_active_filtered
| $people_accounts_filtered
| select($project_active_filtered.ProjectName == .ProjectName)
| ({
    "ProjectName": $people_accounts_filtered.ProjectName,
    "shortName": $project_active_filtered.shortName,
    "assignmentStart": $people_accounts_filtered.assignmentStart,
    "assignmentFinish": $people_accounts_filtered.assignmentFinish,
    "employeeId": $people_accounts_filtered.employeeId
  }) as $tmp_pa_prja
| $tmp_pa_prja
| select($employee_active_filtered.employeeId == .employeeId)
| (
    {
      "ProjectName": $tmp_pa_prja.ProjectName,
      "shortName": $tmp_pa_prja.shortName,
      "assignmentStart": $tmp_pa_prja.assignmentStart,
      "assignmentFinish": $tmp_pa_prja.assignmentFinish,
      "employeeId": $tmp_pa_prja.employeeId,
      "email": $employee_active_filtered.email,
      "gitHubContact": $employee_active_filtered.gitHubContact
     }
  )
# fix for Search trainings project
| select(.ProjectName != "Search trainings" )
| select(.gitHubContact != null)
]
