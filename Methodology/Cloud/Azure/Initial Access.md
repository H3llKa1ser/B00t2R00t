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

