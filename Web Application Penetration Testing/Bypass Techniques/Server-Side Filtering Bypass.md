# Server-Side Filtering Bypass

## TIP:

#### We can use burpsuite intruder with an extensions wordlist to check which extensions are whitelisted for upload.

## Example:

#### If a server accepts JPEG files but not PHP, then we can upload file like: shell.jpg.php

## Magic numbers:

#### Use a magic number table for the acceptable file type.

#### Use hexedit on shell and edit the first 4 bytes of file.

#### Check with file command, then upload.
