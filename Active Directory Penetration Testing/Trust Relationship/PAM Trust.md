# Across Forest - PAM Trust

The goal is to compromise the bastion forest and pivot to the production forest to access to all the resources with a Shadow Security Principal mapped to a high priv group.

## Check if the current forest is a bastion forest

### 1) Enumerate trust properties

    Get-ADTrust -Filter {(ForestTransitive -eq $True) -and (SIDFilteringQuarantined -eq $False)}

### 2) Enumerate shadow security principals

    Get-ADObject -SearchBase ("CN=Shadow Principal Configuration,CN=Services," + (Get-ADRootDSE).configurationNamingContext) | select Name,member,msDS-ShadowPrincipalSid | fl

Explanation:

 - Name - Name of the shadow principal

 - member - Members from the bastion forest which are mapped to the shadow principal

 - msDS-ShadowPrincipalSid - The SID of the principal (user or group) in the user/production forest whose privileges are assigned to the shadow security principal. In our example, it is the Enterpise Admins group in the user forest

These users can access the production forest through the trust with classic workflow (PSRemoting, RDP, etc), or with SIDHistory injection since SIDFiltering is disabled in a PAM Trust.

## Check if the current forest is managed by a bastion forest

    Get-ADTrust -Filter {(ForestTransitive -eq $True)}

A trust attribute of 1096 is for PAM (0x00000400) + External Trust (0x00000040) + Forest Transitive (0x00000008).

