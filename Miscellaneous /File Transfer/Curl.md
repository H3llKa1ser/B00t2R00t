# Curl

### 1) Upload an image to the target web server

    curl -F myFile=@kali.jpg http://example.com/upload.php

### 2) Authenticated upload

Basic Auth

    curl -u username:password -F "image=@photo.jpg" http://example.com/upload.php

Bearer Token

    curl -H "Authorization: Bearer YOUR_TOKEN" -F "image=@photo.jpg" http://example.com/upload.php

API Key

    curl -H "X-API-Key: your_api_key" -F "image=@photo.jpg" http://example.com/upload.php

### 3) Raw binary upload

    curl -X PUT --data-binary "@file.bin" http://example.com/upload/file.bin

### 4) Follow redirects

    curl -L -F "file=@image.jpg" http://example.com/upload

