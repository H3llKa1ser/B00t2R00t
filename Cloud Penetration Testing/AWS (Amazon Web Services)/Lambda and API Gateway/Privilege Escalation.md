# AWS Lambda Privilege Escalation

### If we have a user with PassRole and CreateFunction roles and also AttachRolePolicy role in a Lambda Function, its possible to create a function with a code that changes the lambda role to admin then the user to Administrator.

 - aws lambda create-function --function-name MY_FUNCTION --runtime python3.7 --zip-file CODE.ZIP (Create a Lambda function and attach a role to it)

## Inside the function's code, we will add the administrator permission to the role and to the user

### Example code: See the function code section in this repo
