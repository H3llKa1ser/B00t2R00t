# AWS Secrets Manager Credential Exfiltration

### If the user has access to Secret Manager, it can decrypt the secrets using the web, cli or API

 - aws iam list-attached-user-policies --user-name NAME (Listing policies attached to a user)

## Here we can see the permissions:

 - aws iam get-policy-version --policy-arn ARN --version-id ID (Retrieving information about a specific version of policy)

 - aws secretsmanager list-secrets (Listing secrets stored by Secrets Manager)

## Here we get the secret key ID to describe the secret

 - aws secretsmanager describe-secret --secret-id NAME (Listing information about a specific secret)

 - aws secretsmanager get-resource-policy --secret-id ID (Getting resource-based policy attached to an specific secret)

## Retrieves the actual value:

 - aws secretsmanager get-secret-value --secret-id ID (Getting the secret value)

# Key Management Service (KMS)

### If we compromised as an example an S3 with an encrypted file, we can decrypt it using the keys stored in KMS.

 - aws kms describe-key --key-id ID (Listing a specific key)

## Here we can see who can access the key, the description of it and so on:

 - aws kms list-key-policies --key-id ID (Listing policies attached to a specified key)

## TIP: Run the previous command in all keys to see who can access it

 - aws kms get-key-policy --policy-name NAME --key-id ID (Listing full information about a policy)

## Decrypt the secret using the key

 - aws kms decrypt --ciphertext-blob fileb://EncryptedFile --output text --query plaintext

### There is no need to specify the key information because this information is embbeded in the encrypted file
