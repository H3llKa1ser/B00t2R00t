# Multi-Factor Authentication Bypass Methods

## 1) OTP Leakage

### Steps:

#### 1) Try to log in with username and password credentials

#### 2) Open the inspect tool in firefox (or developer tools in chrome), and check the network tab

#### 3) Once you're on the MFA page, you will see an XHR request triggered by the application that is sent to the /token endpoint. Click on the response tab of the specific request to get the leaked MFA token

#### 4) Profit!



