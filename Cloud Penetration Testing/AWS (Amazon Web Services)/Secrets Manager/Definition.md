# AWS Secrets Manager

### AWS Secrets Manager is a fully managed service provided by Amazon Web Services (AWS) that enables you to securely store, manage, and retrieve sensitive information such as API keys, passwords, database credentials, and other secrets. It helps you protect your secrets from unauthorized access and provides robust management capabilities for maintaining their lifecycle.

### Key features of AWS Secrets Manager include:

1. **Secure Storage**: Secrets Manager provides a secure and encrypted repository for storing sensitive information. Secrets are encrypted at rest using AWS Key Management Service (KMS), and access to secrets is controlled using AWS Identity and Access Management (IAM) policies.

2. **Centralized Management**: You can centrally manage all your secrets in one place, making it easier to organize, search, and access them as needed. Secrets Manager supports versioning, allowing you to store multiple versions of a secret and retrieve the latest or specific versions when necessary.

3. **Automated Rotation**: Secrets Manager can automate the rotation of credentials for supported services, such as Amazon RDS, Amazon Redshift, and Amazon DocumentDB. Automated rotation helps improve security by regularly rotating credentials without manual intervention, reducing the risk of unauthorized access due to stale or compromised credentials.

4. **Integration with AWS Services**: Secrets Manager seamlessly integrates with various AWS services, allowing you to securely retrieve secrets directly from your applications or services without hardcoding credentials. You can easily access secrets from AWS Lambda functions, Amazon EC2 instances, AWS Fargate containers, and other AWS resources.

5. **Fine-Grained Access Control**: Secrets Manager provides granular access control using IAM policies, allowing you to define who can create, retrieve, update, and delete secrets. You can also restrict access based on specific tags or resource-level permissions.

6. **Auditing and Monitoring**: Secrets Manager logs all API calls and configuration changes using AWS CloudTrail, providing detailed audit trails for compliance and security purposes. You can monitor and analyze these logs to track access to your secrets and identify any unauthorized activities.

7. **Integration with AWS SDKs and Tools**: Secrets Manager is fully compatible with AWS SDKs, CLI, and third-party tools, making it easy to integrate secret retrieval into your existing workflows and applications. You can programmatically access secrets using the AWS SDKs for various programming languages.

### Overall, AWS Secrets Manager simplifies the management of sensitive information by providing a secure, centralized, and automated solution for storing and accessing secrets in your AWS environment. It helps you improve security posture, streamline operations, and comply with regulatory requirements related to secrets management.

## In simple terms:

#### 1) AWS Service that encrypts and store secrets

#### 2) Transparently decrypts and return in plaintext

#### 3) KMS used to store keys (AWS Key and Customer Managed Key)

#### 4) Asymmetric and Symmetric keys can be created using KMS
