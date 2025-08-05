# cURL CLI browser

#### *Without the X flag, cURL sends a GET request

#### 1)  (Interacts with the target URL)*

    curl http://TARGET_URL

#### 2) Authenticates, then uploads a file to the webserver

    curl --upload-file ./FILE.TXT --user USER:PASSWORD http://TARGET_URL/TARGET_FOLDER/ 

#### 3) 

    curl -X HTTP_REQUEST http://TARGET_URL
