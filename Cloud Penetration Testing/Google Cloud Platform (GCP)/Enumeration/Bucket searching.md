# Bucket file searching

## Tools: Gcloud, ffuf

### Commands:

 - ffuf -w backup_files_only.txt -u https://storage.googleapis.com/BUCKET_ID/FUZZ -mc 200 -c (Fuzz for files within the bucket storage)

 - gsutil cp gs://BUCKET_ID/FILE.TXT . (Download the file)

## TIP: You may view on page source code to check for possible bucket URLs being exposed.
