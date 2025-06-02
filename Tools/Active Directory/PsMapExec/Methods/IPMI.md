# IPMI

IPMI is now supported. This method will attempt to dump hashes to vulnerable IPMI servers. By default, a built in user list is used unless specified in which case a user list can be queried from the domain

Successful hash output is written to $PWD\PME\IPMI

### 1) Standard targeting user the built in user list

    PsMapExec -Targets [Targets] -Method IPMI

### 2) Using a list of domain users as a user list, targeting all domain joined systems

    PsMapExec -Targets All -Method IPMI -Option IPMI:DomainUsers

# Optional Parameters

### 1) Target domain to grab targets or a user list from

    -Domain domain.local

### 2) Shows only successful attempts to console

    -SuccessOnly

### 3) Uses domain users as a user list against IPMI targets

    -Option IPMI:DomainUsers

### 4) Specify a single username to try against IPMI targets

    -Option IPMI:admin 
