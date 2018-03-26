# jq --slurpfile em_sync_pmo  em_sync_pmo.json \
#    --slurpfile litmos_users litmos_users.json \
#    -n -f ~/repos/gridu-jenkins/ansible/roles/get-litmos-users/files/em-sync.jq
def hashJoin(a1; a2; field):
  # hash phase:
  (reduce a1[] as $o ({};  . + { ($o | field): $o } )) as $h1
  | (reduce a2[] as $o ({};  . + { ($o | field): $o } )) as $h2
  # join phase:
  | reduce ($h1|keys[]) as $key
      ([]; if $h2|has($key) then . + [ $h1[$key] + $h2[$key] ] else . end) ;

[
([$litmos_users[][]
    | select(.Email | match("@griddynamics.com"))
]) as $litmos_users_gd
|
($litmos_users_gd[]
    | {
        "ManagerId": .Id,
        "ManagerName": .FullName
      }
) as $litmos_manager_id
|
([$em_sync_pmo[][]
    | {
        "Email": .email,
        "ManagerName": .emFullName
      }
]) as $em_sync_pmo
| (hashJoin($litmos_users_gd; $em_sync_pmo; .Email)
) as $em_sync
| $em_sync[]
| select($litmos_manager_id.ManagerName == .ManagerName)
| (
    {
        "Id": .Id,
        "UserName": .UserName,
        "FirstName": .FirstName,
        "LastName": .LastName,
        "FullName": .FullName,
        "Email": .Email,
        "AccessLevel": .AccessLevel,
        "DisableMessages": .DisableMessages,
        "Active": .Active,
        "LastLogin": .LastLogin,
        "LoginKey": .LoginKey,
        "IsCustomUsername": .IsCustomUsername,
        "SkipFirstLogin": .SkipFirstLogin,
        "TimeZone": .TimeZone,
        "ManagerId": $litmos_manager_id.ManagerId,
        "ManagerName": .ManagerName,
     }
  )
]