# GPG file decryption

If you have both the PGP message (public key) and the PGP private key, you can decrypt the PGP message and check the contents inside.

### 1) Import private GPG key

    gpg --import private_key.gpg

### 2) Decrypt message

    gpg --decrypt encgpgmessage.gpg
