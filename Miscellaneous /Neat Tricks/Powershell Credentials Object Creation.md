### Commands:

#### 1) $SecPassword = ConvertTo-SecureString 'PASSWORD' -AsPlainText -Force

#### 2) $Cred = New-Object System.Management.Automation.PSCredential('DOMAIN.LOCAL\USERNAME', $SecPassword)

### Use case:

### When we have valid credentials on a domain joined user, but he has no access to RDP or/and WinRM (Remote Desktop Users and Remote Management Users)
