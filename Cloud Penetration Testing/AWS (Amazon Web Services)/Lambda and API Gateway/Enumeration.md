# AWS Lambda Enumeration

## Commands:

#### 1) Listing all lambda functions

    aws lambda list-functions 

## This command enables us to download the source code of the lambda function:

#### 2) Listing information about a specific lambda function

    aws lambda get-function --function-name FUNCTION_NAME 

## We can get information like who can execute this function, ID and other information with this command:

#### 3) Listing policy information about the function

    aws lambda get-policy --function-name FUNCTION_NAME 

#### 4) Listing the event source mapping information about a lambda function

    aws lambda list-event-source-mappings --function-name FUNCTION_NAME 

#### 5) Listing Lambda Layers (Dependencies)

    aws lambda list-layers 

#### 6) 

    aws lambda get-layer-version --layer-name NAME --version-number VERSION_NUMBER

#### 7) Listing Rest APIs

    aws apigateway get-rest-apis 

#### 8) Listing information about endpoints

    aws apigateway get-rest-api --rest-api-id ID 

#### 9) Listing information about a specific endpoint

    aws apigateway get-resource --rest-api-id ID --resource-id ID 

#### 10) Listing method information for the endpoint (Test various methods to see if the API supports it)

    aws apigateway get-method --rest-api-id API_ID --resource-id ID --http-method METHOD 

#### 11) Listing all versions of a rest API

    aws apigateway get-stages --rest-api-id ID 

#### 12) Getting information about a specific version

    aws apigateway get-stage --res-api-id ID --stage-name NAME 

#### 13) Listing API keys

    aws apigateway get-api-keys --include-values 

#### 14) Getting information about a specific API Key

    aws apigateway get-api-key --api-key KEY 



