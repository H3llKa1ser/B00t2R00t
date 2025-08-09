# Bucket file searching

## Tools: Gcloud, ffuf, GCPBucketBrute

### Commands:

#### 1) Fuzz for files within the bucket storage

    ffuf -w backup_files_only.txt -u https://storage.googleapis.com/BUCKET_ID/FUZZ -mc 200 -c 

#### 2) Download the file

    gsutil cp gs://BUCKET_ID/FILE.TXT . 

#### 3) Authenticated request to a storage bucket using an Access Token, requesting the list of objects (o) within the bucket

    curl -H "Authorization: Bearer $GOOGLE_ACCESS_TOKEN" "https://www.googleapis.com/storage/v1/b/BUCKET_NAME/o" 

#### 4) Download an object by using the medialink link

    curl -H "Authorization: Bearer $GOOGLE_ACCESS_TOKEN" "https://www.googleapis.com/download/storage/v1/b/BUCKET_NAME/o/userdata%2Fuser_data.csv?generation=1703877006716190&alt=media" 

## TIP: You may view on page source code to check for possible bucket URLs being exposed.

## Alternate Method: GCPBucketBrute

### Link: https://github.com/RhinoSecurityLabs/GCPBucketBrute

### Example Usage:

#### 1) Do an authenticated brute-force attack to enumerate buckets by creating permutations based on the keyword WHATEVER

    python3 gcpbucketbrute.py -f /path/to/token.json -k WHATEVER 

#### 2) Do an unauthenticated dictionary attack

    python3 gcpbucketbrute.py -u -w /path/to/wordlist.txt 
