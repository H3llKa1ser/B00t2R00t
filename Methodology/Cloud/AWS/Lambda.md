# Lambda

### 1) Get function with URL

    aws lambda get-function --function-name arn:aws:lambda:REGION:AWS_ACCOUNT_ID:function:sample-lambda

### 2) Download

    curl "https://GENERATED_URL_FROM_PREVIOUS_COMMAND" --output lambda.zip

### 3) Unzip contents

    unzip lambda.zip
