### S3 Stands for Simple Storage Service

### URL Format: http://BUCKET_NAME.s3.DOMAIN.com or https://BUCKET_NAME.s3.DOMAIN.com

### http://s3.DOMAIN.com/BUCKET_NAME

### Tools: awscli

### Interaction: 

#### 1) aws --endpoint-url=http://s3.DOMAIN.com s3 ls (List contents inside S3 Bucket)

#### 2) aws --endpoint-url=http://s3.DOMAIN.com s3 ls s3://BUCKET_NAME (List contents inside the specified bucket)

#### 3) aws --endpoint-url=http://s3.DOMAIN.com s3 sync s3://BUCKET_NAME . (Downloads any files within the specified bucket)

### In order to interact in any way with a cloud service, first we have to authenticate with it.

### awscli looks for ~/.aws/credentials file to locate the keys in order to authenticate to the cloud services.

## TIP:

### In some cases, we can use any random credentials to authenticate by simply typing: aws configure
