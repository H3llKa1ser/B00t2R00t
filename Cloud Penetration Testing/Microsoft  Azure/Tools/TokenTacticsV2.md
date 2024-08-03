# TokenTacticsV2 

## Link: https://github.com/f-bader/TokenTacticsV2

### Usage:

 - Invoke-RefreshToMSGraphToken -domain DOMAIN.CORP -refreshToken "REFRESH_TOKEN" ( Create an access token for Microsoft Graph from our refresh token.)

 - $MSGraphToken.access_token (This is the generated access token from the previous command)

 - Invoke-RefreshToAzureManagementToken -Domain DOMAIN.CORP -RefreshToken $refreshtoken -Device AndroidMobile -Browser Android (Specify the device and so we can again pretend to be an Android device, and successfully get an access token for the Azure Resource Management ARM API)

 - $AzureManagementToken.access_token (The ARM access token from the previous command)

