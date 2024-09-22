# Passpie password manager

### Files that might indicate passpie existence:

 - .passpie/ (Directory)

### Usage:

 - passpie list (List stored credentials in password manager)

 - passpie export creds.txt (Export stored credentials in plain text)

## TIP: REMEMBER THAT YOU NEED A PASSPHRASE FOR IT TO EXPORT CREDENTIALS

### Find the pgp keys of the passpie password manager

 - .keys (Example)

### Transfer them to our machine, then attempt to convert the pgp PRIVATE key to a hash for John The Ripper to crack

 - gpg2john private_key.txt > hash.txt

 - john hash.txt --wordlist=/usr/share/wordlists/rockyou.txt

