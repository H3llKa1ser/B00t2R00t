# QR Code scanning and generating in Kali Linux

## Tools: zbar-tools, qtqr, qrencode

### Usage:

#### 1) Generate QR code image with contents of our choosing

    qrencode -o qrcode.png 'Hello World!'

#### 2) Display contents of the QR code

    zbarimg QR.png 
