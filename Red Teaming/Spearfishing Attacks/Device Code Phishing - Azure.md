# Device Code Phishing - Microsoft Azure

## STEPS

#### 1) Enter a powershell session in Kali (or use windows instead)

      pwsh

### OR

      powershell.exe -ep bypass

#### 2) Use Az powershell module to generate a device code

      az login --use-device-code

### This command will generate a LEGIT microsoft page with the code needed to authenticate

      https://microsoft.com/devicelogin

#### 3) Send a spearphishing email to a target of your choice to make him click on the link and enter the code you generated earlier


#### 4) When the user authenticates, press the number that shows you in the console to successfully authenticate to the Azure account

#### 5) PROFIT!
