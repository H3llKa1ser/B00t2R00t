### AWS Lambda functions

#### 1) List lambda functions on endpoint

    aws --endpoint=url=http://ENDPOINT_URL.com lambda list-functions 

#### 2) Gets the code location of the lambda function

    aws --endpoint-url=http://ENDPOINT_URL.com lambda get-function --function-name=FUNCTION_NAME | jq .Code.Location 

#### 3) Downloads and unzips the code of lambda function

    wget http://ENDPOINT_URL/path/to/LAMBDA_FUNCTION/CODE && unzip CODE 

    aws lambda list-functions --profile uploadcreds

    aws lambda get-function --function-name "LAMBDA-NAME-HERE-FROM-PREVIOUS-QUERY"

    wget -O lambda-function.zip url-from-previous-query --profile uploadcreds
