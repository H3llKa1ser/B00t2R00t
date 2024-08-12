# Bucket file searching

## Tools: Gcloud, ffuf, GCPBucketBrute

### Commands:

 - ffuf -w backup_files_only.txt -u https://storage.googleapis.com/BUCKET_ID/FUZZ -mc 200 -c (Fuzz for files within the bucket storage)

 - gsutil cp gs://BUCKET_ID/FILE.TXT . (Download the file)

 - curl -H "Authorization: Bearer $GOOGLE_ACCESS_TOKEN" "https://www.googleapis.com/storage/v1/b/BUCKET_NAME/o" (Authenticated request to a storage bucket using an Access Token, requesting the list of objects (o) within the bucket)

 - curl -H "Authorization: Bearer $GOOGLE_ACCESS_TOKEN" "https://www.googleapis.com/download/storage/v1/b/BUCKET_NAME/o/userdata%2Fuser_data.csv?generation=1703877006716190&alt=media" (Download an object by using the medialink link)


## TIP: You may view on page source code to check for possible bucket URLs being exposed.

## Alternate Method: GCPBucketBrute

### Link: https://github.com/RhinoSecurityLabs/GCPBucketBrute

### Example Usage:

 - python3 gcpbucketbrute.py -f /path/to/token.json -k WHATEVER (Do an authenticated brute-force attack to enumerate buckets by creating permutations based on the keyword WHATEVER)

 - python3 gcpbucketbrute.py -u -w /path/to/wordlist.txt (Do an unauthenticated dictionary attack)
