# 403 Forbidden Bypass

HTTP Headers to use:

    X-Forwarded-For: IP

## Burp Suite Settings trick

To bypass this restriction permanently, we need to add this header in the Match and Replace rule in "Options" tab under "Proxy" option in the "Burp Suite" which will add this header to every request.


<img width="449" height="257" alt="image" src="https://github.com/user-attachments/assets/d141f5da-9a23-47f3-b947-7c857659de56" />

You can also do this for response headers as well

<img width="449" height="257" alt="image" src="https://github.com/user-attachments/assets/6529a96c-c054-442e-85fb-e2c9b627bf1c" />
