### AWS Lambda functions

#### 1) aws --endpoint=url=http://ENDPOINT_URL.com lambda list-functions (List lambda functions on endpoint)

#### 2) aws --endpoint-url=http://ENDPOINT_URL.com lambda get-function --function-name=FUNCTION_NAME | jq .Code.Location (Gets the code location of the lambda function)

#### 3) wget http://ENDPOINT_URL/path/to/LAMBDA_FUNCTION/CODE && unzip CODE (Downloads and unzips the code of lambda function)
