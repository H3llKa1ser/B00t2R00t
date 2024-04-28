# Amazon Resource Name (ARN)

### In AWS, an ARN (Amazon Resource Name) is a unique identifier assigned to each AWS resource in a particular region. ARNs are used to uniquely identify resources across AWS services and are used extensively in IAM policies, Amazon CloudWatch alarms, Amazon S3 bucket policies, and many other AWS services.

### An ARN typically follows this format:

```
arn:partition:service:region:account-id:resource-id
```

- `partition`: Indicates the partition of AWS, such as `aws` for AWS Standard or `aws-cn` for AWS China. There are also other partitions for AWS GovCloud (`aws-us-gov`) and AWS China (`aws-cn`).

- `service`: Specifies the AWS service that the resource belongs to, such as `s3` for Amazon S3, `ec2` for Amazon EC2, `lambda` for AWS Lambda, etc.

- `region`: Specifies the AWS region where the resource is located, such as `us-east-1` for the US East (N. Virginia) region, `eu-west-1` for the EU (Ireland) region, etc. This part is optional and may not be present in all ARNs, especially for global services.

- `account-id`: Specifies the AWS account ID that owns the resource. This part is optional in some ARNs, depending on the context.

- `resource-id`: Specifies the unique identifier for the resource within the context of the service. The format of this part varies depending on the service and resource type.

### For example, the ARN for an S3 bucket in the US East (N. Virginia) region might look like this:

```
arn:aws:s3:::example-bucket
```

### And the ARN for an IAM user might look like this:

```
arn:aws:iam::123456789012:user/john.doe
```

### ARNs provide a standardized way to reference AWS resources across different AWS services and APIs.

