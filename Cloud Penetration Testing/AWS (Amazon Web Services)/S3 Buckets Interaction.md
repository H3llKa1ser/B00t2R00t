### S3 Stands for Simple Storage Service

### URL Format: http://BUCKET_NAME.s3.DOMAIN.com or https://BUCKET_NAME.s3.DOMAIN.com

### http://s3.DOMAIN.com/BUCKET_NAME

### Tools: awscli

### Interaction: aws --endpoint-url=http://s3.DOMAIN.com s3 COMMAND

### In order to interact in any way with a cloud service, first we have to authenticate with it.

### awscli looks for ~/.aws/credentials file to locate the keys in order to authenticate to the cloud services.

## TIP:

### In some cases, we can use any random credentials to authenticate by simply typing: aws configure
