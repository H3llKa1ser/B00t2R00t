# AWS Lambda Privilege Escalation

### If we have a user with PassRole and CreateFunction roles and also AttachRolePolicy role in a Lambda Function, its possible to create a function with a code that changes the lambda role to admin then the user to Administrator.

#### 1) Create a Lambda function and attach a role to it

    aws lambda create-function --function-name MY_FUNCTION --runtime python3.7 --zip-file CODE.ZIP 

## Inside the function's code, we will add the administrator permission to the role and to the user

### Example code: See the function code section in this repo (Admin.py)

#### 2) Invoke a lambda function

    aws lambda invoke --function-name NAME response.json --region REGION 

#### 3) Listing managed policies to see if the change worked

    aws iam list-attached-user-policies --user-name USER_NAME 
