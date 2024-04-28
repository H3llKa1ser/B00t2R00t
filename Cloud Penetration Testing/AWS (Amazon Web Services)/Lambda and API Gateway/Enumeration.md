# AWS Lambda Enumeration

## Commands:

 - aws lambda list-functions (Listing all lambda functions)

 ## This command enables us to download the source code of the lambda function:

 - aws lambda get-function --function-name FUNCTION_NAME (Listing information about a specific lambda function)

## We can get informations like who can execute this functions, ID and other information with this command:

 - aws lambda get-policy --function-name FUNCTION_NAME (Listing policy information about the function)

 - aws lambda list-event-source-mappings --function-name FUNCTION_NAME (Listing the event source mapping information about a lambda function)

 - aws lambda list-layers (Listing Lambda Layers (Depedencies))

 - aws lambda get-layer-version --layer-name NAME --version-number VERSION_NUMBER

 - aws apigateway get-rest-apis (Listing Rest API'S)

 - aws apigateway get-rest-api --rest-api-id ID (Listing information about endpoints)

 - aws apigateway get-resource --rest-api-id ID --resource-id ID (Listing information about a specific endpoint)

 - aws apigateway get-method --rest-api-id API_ID --resource-id ID --http-method METHOD (Listing method information for the endpoint) (Test various methods to see if the API supports it)

 - aws apigateway get-stages --rest-api-id ID (Listing all versions of a rest API)

 - aws apigateway get-stage --res-api-id ID --stage-name NAME (Getting information about a specific version)

 - aws apigateway get-api-keys --include-values (Listing API keys)

 - aws apigateway get-api-key --api-key KEY (Getting information about a specific API Key)



