# Hash Cracking

## Formats: LM , NTLM , NetNTLMv1 , NetNTLMv2 , Kerberos 5 TGS , Kerberos 5 TGS AES128 , Kerberos TGS AES256 , Kerberos ASREP , MsCache

## Tools: Hashcat , John The Ripper (JtR)

### Commands:

#### LM

 - john --format=lm HASH.TXT

 - hashcat -m 3000 -a 3 HASH.TXT

#### NTLM

 - john --format=nt HAHS.TXT

 - hashcat -m 1000 -a 3 HASH.TXT

#### NetNTLMv1

 - john --format=netntlm HASH.TXT

 - hashcat -m 5500 -a 3 HASH.TXT

#### NetNTLMv2

 - john --format=netntlmv2 HASH.TXT

 - hashcat -m 5600 -a 0 HASH.TXT WORDLIST.TXT

#### Kerberos 5 TGS

 - hashcat -m 13100 -a 0 SPN.TXT WORDLIST.TXT

 - john SPN.TXT --format=krb5tgs --wordlist=WORDLIST.TXT

#### Kerberos 5 TGS AES128

 - hashcat -m 19600 -a 0 SPN.TXT WORDLIST.TXT

#### Kerberos 5 TGS AES256

 - hashcat -m 19700 -a 0 SPN.TXT WORDLIST.TXT

#### Kerberos ASREP

 - hashcat -m 18200 -a 0 ASREP_ROAST_HASHES.TXT WORDLIST.TXT

#### MsCache 2 (Slow)

 - hashcat -m 2100 -a 0 MSCACHE-HASH.TXT WORDLIST.TXT
