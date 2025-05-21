# Ngrok

Link: https://github.com/NGROK https://dashboard.ngrok.com/signup

ngrok is a web service that allows tunneling and pivoting through their servers. This is a service that has become chargeable and requires registration, but which proved its worth when it was still free.

### 1) Log into the web service

    ./ngrok authtoken $TOKEN

### 2) Setup port forwarding on 443

    ./ngrok http 443
    ./ngrok tcp 443
